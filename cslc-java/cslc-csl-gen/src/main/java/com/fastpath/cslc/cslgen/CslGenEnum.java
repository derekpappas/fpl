package com.fastpath.cslc.cslgen;

import java.util.ArrayList;
import java.util.List;
import java.util.random.RandomGenerator;

/**
 * Port of {@code NSCSLinterconnect::CSLenum} ({@code cslGenEnumFieldEM.cpp}).
 */
public final class CslGenEnum extends CslGenCslBase {

    public CslGenEnum(CslGenCslBase parent, String name) {
        super(CslGenCslType.CSL_ENUM, parent, name);
    }

    @Override
    public boolean buildDecl() {
        return buildDecl(RandomGenerator.getDefault());
    }

    public boolean buildDecl(RandomGenerator rng) {
        int c = rng.nextInt(2);
        int bound = rng.nextInt(50) + 5;
        for (int i = 1; i <= bound; i++) {
            String itemName = CslGenRandString.randString(rng);
            if (newNameIsValid(itemName)) {
                CslGenEnumItem item = new CslGenEnumItem(this, itemName);
                if (c == 0) {
                    item.buildDecl(rng);
                }
                addChild(item);
            }
        }
        return true;
    }

    @Override
    public void print() {
        StringBuilder out = printSink();
        if (out == null) {
            return;
        }
        out.append("csl_enum ").append(getName()).append(" {\n");
        List<CslGenCslBase> items = new ArrayList<>();
        for (CslGenCslBase ch : getChildren()) {
            if (ch.getType() == CslGenCslType.CSL_ENUM_ITEM) {
                items.add(ch);
            }
        }
        for (int i = 0; i < items.size(); i++) {
            items.get(i).print();
            if (i < items.size() - 1) {
                out.append(",\n");
            } else {
                out.append('\n');
            }
        }
        out.append("};\n");
    }

    public void appendPrintedCsl(StringBuilder out) {
        CslGenCslBase.runWithPrintSink(out, this::print);
    }
}
