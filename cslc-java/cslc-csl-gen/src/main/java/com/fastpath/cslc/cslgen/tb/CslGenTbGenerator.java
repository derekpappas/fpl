package com.fastpath.cslc.cslgen.tb;

import java.util.ArrayList;
import java.util.List;
import java.util.random.RandomGenerator;

/**
 * Legacy {@code NSCslGen::CSLgenerator} ({@code trunk/cslc/trunk/csl_gen/cslGen_TB.h}, {@code cslGen_TB.cpp}).
 */
public final class CslGenTbGenerator {

    private final List<CslGenTbUnit> m_units = new ArrayList<>();
    private final StringBuilder m_out;
    private final RandomGenerator rng;

    public CslGenTbGenerator(StringBuilder out, RandomGenerator rng) {
        this.m_out = out;
        this.rng = rng;
    }

    public List<CslGenTbUnit> getUnits() {
        return m_units;
    }

    public StringBuilder getOut() {
        return m_out;
    }

    /** Legacy {@code CSLgenerator::randString()}. */
    public String randString() {
        char c = (char) ('A' + rng.nextInt('Z' - 'A'));
        StringBuilder str = new StringBuilder();
        str.append(c);
        for (int i = 1; i < CslGenTbConsts.NAME_SIZE; i++) {
            str.append((char) ('a' + rng.nextInt('z' - 'a')));
        }
        return str.toString();
    }

    public boolean unitNameIsValid(String name) {
        for (CslGenTbUnit u : m_units) {
            if (u.m_uName.equals(name)) {
                return false;
            }
        }
        return true;
    }

    public boolean newNameIsValid(String name, CslGenTbUnit unit) {
        for (CslGenTbBitrange b : unit.m_uDecl.m_dBitranges) {
            if (b.m_bName.equals(name)) {
                return false;
            }
        }
        for (CslGenTbSignal s : unit.m_uDecl.m_dSignals) {
            if (s.m_sName.equals(name)) {
                return false;
            }
        }
        for (CslGenTbPort p : unit.m_uDecl.m_dPorts) {
            if (p.m_pName != null && p.m_pName.equals(name)) {
                return false;
            }
        }
        return true;
    }

    public void addUnit() {
        String unitName = randString();
        if (unitNameIsValid(unitName)) {
            CslGenTbUnit newUnit = new CslGenTbUnit(unitName);
            printUnitBegin(unitName);

            addBitrange(newUnit);

            addSignal(newUnit);
            addSignal(newUnit);
            addSignal(newUnit);
            addSignal(newUnit);
            addSignal(newUnit);
            addSignal(newUnit);

            m_units.add(newUnit);
            printUnitEnd();
        }
    }

    public void addBitrange(CslGenTbUnit unit) {
        String bitrangeName = randString();
        if (newNameIsValid(bitrangeName, unit)) {
            CslGenTbBitrange newBitrange = new CslGenTbBitrange(bitrangeName);
            int addForm = rng.nextInt(3);
            switch (addForm) {
                case 0 -> {
                    newBitrange.m_bLower = 0;
                    newBitrange.m_bUpper = 1;
                    printBitrangeDeclEmpty(bitrangeName);
                }
                case 1 -> {
                    newBitrange.m_bLower = 0;
                    newBitrange.m_bUpper = (short) rng.nextInt(CslGenTbConsts.MAX_WIDTH);
                    printBitrangeDeclBegin(bitrangeName);
                    printBitrangeDeclWidth(newBitrange.m_bUpper);
                    printBitrangeDeclEnd();
                }
                case 2 -> {
                    newBitrange.m_bLower = (short) rng.nextInt(CslGenTbConsts.MAX_WIDTH / 2);
                    newBitrange.m_bUpper =
                            (short) (newBitrange.m_bLower + rng.nextInt(CslGenTbConsts.MAX_WIDTH / 2));
                    printBitrangeDeclBegin(bitrangeName);
                    printBitrangeDeclLower(newBitrange.m_bLower);
                    printComma();
                    printBitrangeDeclUpper(newBitrange.m_bUpper);
                    printBitrangeDeclEnd();
                }
                default -> throw new IllegalStateException();
            }
            unit.m_uDecl.m_dBitranges.add(newBitrange);
        }
    }

    public void addSignal(CslGenTbUnit unit) {
        String signalName = randString();
        if (!newNameIsValid(signalName, unit)) {
            return;
        }
        CslGenTbSignal newSignal = new CslGenTbSignal(signalName);
        int addForm = rng.nextInt(9);
        switch (addForm) {
            case 0 -> {
                newSignal.m_sType = "";
                newSignal.m_sAttr = "";
                newSignal.m_sLower = 0;
                newSignal.m_sUpper = 1;
                printSignalDeclBegin(signalName);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 1 -> {
                newSignal.m_sType = CslGenTbConsts.SIGNAL_TYPES[rng.nextInt(CslGenTbConsts.SIGNAL_TYPES.length)];
                newSignal.m_sAttr = "";
                newSignal.m_sLower = 0;
                newSignal.m_sUpper = 1;
                printSignalDeclBegin(signalName);
                printSignalDeclType(newSignal.m_sType);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 2 -> {
                newSignal.m_sType = "";
                newSignal.m_sAttr = "";
                newSignal.m_sLower = 0;
                newSignal.m_sUpper = (short) rng.nextInt(CslGenTbConsts.MAX_WIDTH);
                printSignalDeclBegin(signalName);
                printSignalDeclWidth(newSignal.m_sUpper);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 3 -> {
                newSignal.m_sType = CslGenTbConsts.SIGNAL_TYPES[rng.nextInt(CslGenTbConsts.SIGNAL_TYPES.length)];
                newSignal.m_sAttr = "";
                newSignal.m_sLower = 0;
                newSignal.m_sUpper = (short) rng.nextInt(CslGenTbConsts.MAX_WIDTH);
                printSignalDeclBegin(signalName);
                printSignalDeclType(newSignal.m_sType);
                printComma();
                printSignalDeclWidth(newSignal.m_sUpper);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 4 -> {
                newSignal.m_sType = CslGenTbConsts.SIGNAL_TYPES[rng.nextInt(CslGenTbConsts.SIGNAL_TYPES.length)];
                newSignal.m_sAttr = "";
                newSignal.m_sLower = (short) rng.nextInt(CslGenTbConsts.MAX_WIDTH / 2);
                newSignal.m_sUpper =
                        (short) (newSignal.m_sLower + rng.nextInt(CslGenTbConsts.MAX_WIDTH / 2));
                printSignalDeclBegin(signalName);
                printSignalDeclType(newSignal.m_sType);
                printComma();
                printSignalDeclLower(newSignal.m_sLower);
                printComma();
                printSignalDeclUpper(newSignal.m_sUpper);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 5 -> {
                newSignal.m_sType = "";
                newSignal.m_sAttr = "";
                newSignal.m_sLower = (short) rng.nextInt(CslGenTbConsts.MAX_WIDTH / 2);
                newSignal.m_sUpper =
                        (short) (newSignal.m_sLower + rng.nextInt(CslGenTbConsts.MAX_WIDTH / 2));
                printSignalDeclBegin(signalName);
                printSignalDeclLower(newSignal.m_sLower);
                printComma();
                printSignalDeclUpper(newSignal.m_sUpper);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 6 -> {
                newSignal.m_sBitrange = randSelBitrange(unit);
                if (newSignal.m_sBitrange == null) {
                    break;
                }
                newSignal.m_sType = CslGenTbConsts.SIGNAL_TYPES[rng.nextInt(CslGenTbConsts.SIGNAL_TYPES.length)];
                newSignal.m_sAttr = "";
                newSignal.m_sLower = newSignal.m_sBitrange.m_bLower;
                newSignal.m_sUpper = newSignal.m_sBitrange.m_bUpper;
                printSignalDeclBegin(signalName);
                printSignalDeclType(newSignal.m_sType);
                printComma();
                printSignalDeclBitr(newSignal.m_sBitrange.m_bName);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 7 -> {
                newSignal.m_sBitrange = randSelBitrange(unit);
                if (newSignal.m_sBitrange == null) {
                    break;
                }
                newSignal.m_sType = "";
                newSignal.m_sAttr = "";
                newSignal.m_sLower = newSignal.m_sBitrange.m_bLower;
                newSignal.m_sUpper = newSignal.m_sBitrange.m_bUpper;
                printSignalDeclBegin(signalName);
                printSignalDeclBitr(newSignal.m_sBitrange.m_bName);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            case 8 -> {
                newSignal.m_sCopyOf = randSelSignal(unit);
                if (newSignal.m_sCopyOf == null) {
                    break;
                }
                newSignal.m_sType = newSignal.m_sCopyOf.m_sType;
                newSignal.m_sAttr = newSignal.m_sCopyOf.m_sAttr;
                newSignal.m_sLower = newSignal.m_sCopyOf.m_sLower;
                newSignal.m_sUpper = newSignal.m_sCopyOf.m_sUpper;
                printSignalDeclBegin(signalName);
                printSignalDeclCopy(newSignal.m_sCopyOf.m_sName);
                printSignalDeclEnd();
                unit.m_uDecl.m_dSignals.add(newSignal);
            }
            default -> throw new IllegalStateException();
        }
    }

    /** Legacy {@code CSLgenerator::addPort(CSLunit*)} ({@code cslGen_TB.cpp}) — direction + type, mirrored from signal decl style. */
    public void addPort(CslGenTbUnit unit) {
        String portName = randString();
        if (!newNameIsValid(portName, unit)) {
            return;
        }
        CslGenTbPort newPort = new CslGenTbPort();
        newPort.m_pName = portName;
        newPort.m_pDir = CslGenTbConsts.PORT_DIRECTIONS[rng.nextInt(CslGenTbConsts.PORT_DIRECTIONS.length)];
        newPort.m_pType = CslGenTbConsts.SIGNAL_TYPES[rng.nextInt(CslGenTbConsts.SIGNAL_TYPES.length)];
        newPort.m_pAttr = "";
        newPort.m_pLower = 0;
        newPort.m_pUpper = 1;
        printPortDeclBegin(portName);
        m_out.append(newPort.m_pDir);
        printComma();
        m_out.append(newPort.m_pType);
        printPortDeclEnd();
        unit.m_uDecl.m_dPorts.add(newPort);
    }

    public CslGenTbBitrange randSelBitrange(CslGenTbUnit unit) {
        List<CslGenTbBitrange> br = unit.m_uDecl.m_dBitranges;
        if (br.isEmpty()) {
            return null;
        }
        return br.get(rng.nextInt(br.size()));
    }

    public CslGenTbSignal randSelSignal(CslGenTbUnit unit) {
        List<CslGenTbSignal> sg = unit.m_uDecl.m_dSignals;
        if (sg.isEmpty()) {
            return null;
        }
        return sg.get(rng.nextInt(sg.size()));
    }

    public void printComma() {
        m_out.append(", ");
    }

    public void printUnitBegin(String name) {
        m_out.append("csl_unit ").append(name).append(" {\n");
    }

    public void printUnitEnd() {
        m_out.append("};\n");
    }

    public void printBitrangeDeclEmpty(String name) {
        m_out.append("  csl_bitrange ").append(name).append(";\n");
    }

    public void printBitrangeDeclBegin(String name) {
        m_out.append("  csl_bitrange ").append(name).append("(");
    }

    public void printBitrangeDeclWidth(short width) {
        m_out.append(width);
    }

    public void printBitrangeDeclLower(short lower) {
        m_out.append(lower);
    }

    public void printBitrangeDeclUpper(short upper) {
        m_out.append(upper);
    }

    public void printBitrangeDeclEnd() {
        m_out.append(");\n");
    }

    public void printSignalDeclBegin(String name) {
        m_out.append("  csl_signal ").append(name).append("(");
    }

    public void printSignalDeclType(String type) {
        m_out.append(type);
    }

    public void printSignalDeclWidth(short width) {
        m_out.append(width);
    }

    public void printSignalDeclLower(short lower) {
        m_out.append(lower);
    }

    public void printSignalDeclUpper(short upper) {
        m_out.append(upper);
    }

    public void printSignalDeclBitr(String bitrName) {
        m_out.append(bitrName);
    }

    public void printSignalDeclCopy(String copyOf) {
        m_out.append(copyOf);
    }

    public void printSignalDeclEnd() {
        m_out.append(");\n");
    }

    public void printPortDeclBegin(String name) {
        m_out.append("  csl_port ").append(name).append("(");
    }

    public void printPortDeclEnd() {
        m_out.append(");\n");
    }

    /** Legacy {@code CSLgenerator::build()}. */
    public void build() {
        for (int i = 0; i < CslGenTbConsts.UNIT_MAX; i++) {
            addUnit();
        }
    }
}
