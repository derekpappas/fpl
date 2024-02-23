//----------------------------------------------------------------------
// Copyright (c) 2005-2007 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/*
 * This is a part of the CSL IDE
 * Author: Codrin Pruteanu <codrin@fastpathlogic.ro>
 * 2007
 */

#ifndef TOOLS_H
#define TOOLS_H

#include "ui_tools.h"

class Tools : public QDialog, public Ui::Tools {
    Q_OBJECT
  public:
    Tools(QWidget * parent = 0, Qt::WFlags f = 0);
    QString cslcName() { return cslc->text(); };
    QString makeName() { return make->text(); };
    QString gdbName() { return gdb->text(); };
    QString ctagsName() { return ctags->text(); };
    QString argsName() { return args->text(); };
    bool showDot() { return showDotFile->isChecked(); };
    bool showVerilog() { return showVerilogFile->isChecked(); };
    bool tileAutoSel() { return tileAuto->isChecked(); };
    bool enAutoIndent() { return enableAutoIndent->isChecked(); };
    bool enTabSpaces() { return enableTabSpaces->isChecked(); };
    bool enLineNumbers() { return enableLineNumbers->isChecked(); };
    bool getMatchBox() { return enableMatch->isChecked(); };
    bool getBrackets() { return autoBrackets->isChecked(); };
    bool getWordWrap() { return wordWrap->isChecked(); };
    int setTabWidth() { return tabSize->value(); };
    int getTabSize();
  private slots:
    void on_okButton_clicked();
    void on_cancelButton_clicked();
    void on_cslcLocation_clicked();
    void on_makeLocation_clicked();
    void on_gdbLocation_clicked();
    void on_ctagsLocation_clicked();
    void chooseLocation(QLineEdit *dest);
  private:
    int m_tabSize;
    bool m_showDot;
    bool m_tileAuto;
    bool m_showVerilog;
    bool m_enableIndent;
    bool m_match;
    bool m_enable;
    bool m_brackets;
    bool m_wordWrap;
};
#endif
