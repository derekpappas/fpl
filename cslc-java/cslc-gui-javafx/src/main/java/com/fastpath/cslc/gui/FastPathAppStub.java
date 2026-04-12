package com.fastpath.cslc.gui;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Stage;

/**
 * Placeholder for FastPath / {@code gui_cslom} / {@code ide} port (JavaFX 21).
 */
public class FastPathAppStub extends Application {

    @Override
    public void start(Stage stage) {
        stage.setTitle("CSLC (Java port)");
        stage.setScene(new Scene(new Label("GUI shell — connect to compiler pipeline next."), 480, 120));
        stage.show();
    }
}
