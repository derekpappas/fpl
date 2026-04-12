package com.fastpath.cslc.csim;

import java.util.Optional;

/** Non-interactive stub until readline / stdin wiring exists. */
public final class CsimCmdLineStub implements CsimCmdLinePort {

    private String prompt = "csim> ";

    @Override
    public void setCmdPrompt(String prompt) {
        this.prompt = prompt != null ? prompt : "";
    }

    @Override
    public Optional<String> getNextCmd() {
        return Optional.empty();
    }

    @Override
    public void print(String out) {
        System.out.print(out);
    }

    public String getPrompt() {
        return prompt;
    }
}
