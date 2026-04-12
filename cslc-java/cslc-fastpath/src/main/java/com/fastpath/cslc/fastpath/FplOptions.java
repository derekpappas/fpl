package com.fastpath.cslc.fastpath;

/**
 * Port of {@code FplOptions} ({@code trunk/cslc/trunk/src/FastPath/fploptions.h} / {@code fploptions.cpp}).
 */
public final class FplOptions {

    private boolean netlisting;
    private boolean floorPlanning;
    private boolean addIncludes;
    private String stringDevice = "";

    public FplOptions() {
        this(false, false, false);
    }

    public FplOptions(boolean netlisting, boolean floorPlanning, boolean addIncludes) {
        this.netlisting = netlisting;
        this.floorPlanning = floorPlanning;
        this.addIncludes = addIncludes;
    }

    public boolean isNetlisting() {
        return netlisting;
    }

    public void setNetlisting(boolean netlisting) {
        this.netlisting = netlisting;
    }

    public boolean isFloorPlanning() {
        return floorPlanning;
    }

    public void setFloorPlanning(boolean floorPlanning) {
        this.floorPlanning = floorPlanning;
    }

    public boolean isAddIncludes() {
        return addIncludes;
    }

    public void setAddIncludes(boolean addIncludes) {
        this.addIncludes = addIncludes;
    }

    public String getStringDevice() {
        return stringDevice;
    }

    public void setStringDevice(String stringDevice) {
        this.stringDevice = stringDevice != null ? stringDevice : "";
    }
}
