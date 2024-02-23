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

#ifndef REPLACEIMPL_H
#define REPLACEIMPL_H

#include "mainchild.h"
#include "ui_replace.h"
#include "ui_promptreplace.h"

class ReplaceImpl;
class PromptReplaceImpl;

class ReplaceImpl : public QDialog, public Ui::Replace {
    Q_OBJECT
  public:
    ReplaceImpl(QWidget * parent, MainChild *textEdit, ReplaceOptions options);
    ReplaceOptions replaceOptions() { return m_replaceOptions;};
  private slots:
    void on_replace_clicked();
  protected:
  private:
    void saveReplaceOptions();
    MainChild *m_textEdit;
    ReplaceOptions m_replaceOptions;
};

class PromptReplaceImpl : public QDialog, public Ui::PromptReplace {
    Q_OBJECT
  public:
    PromptReplaceImpl(QWidget * parent = 0, Qt::WFlags f = 0);
    int choice() { return m_choice; };
  private slots:
    void on_replace_clicked();
    void on_replaceAll_clicked();
    void on_findNext_clicked();
    void on_close_clicked();
  private:
    int m_choice;
};
#endif
