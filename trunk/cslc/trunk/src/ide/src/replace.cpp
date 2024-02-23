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

#include <QMessageBox>
#include <QLineEdit>
#include "replace.h"

ReplaceImpl::ReplaceImpl(QWidget * parent, MainChild *textEdit, ReplaceOptions options)
    : QDialog(parent), m_textEdit(textEdit), m_replaceOptions(options) {
  setupUi(this);
  if (m_textEdit->textCursor().selectedText().length()) {
    textFind->insertItem(0, m_textEdit->textCursor().selectedText());
    textFind->lineEdit()->selectAll();
  }
  textFind->insertItems(0, m_replaceOptions.textFind);
  textReplace->insertItems(0, m_replaceOptions.textReplace);
  backwards->setChecked(m_replaceOptions.backwards);
  caseSensitive->setChecked(m_replaceOptions.caseSensitive);
  prompt->setChecked(m_replaceOptions.prompt);
  wholeWords->setChecked(m_replaceOptions.wholeWords);
}

void ReplaceImpl::on_replace_clicked() {
  PromptReplaceImpl *promptReplace = new PromptReplaceImpl(0);
  QTextDocument::FindFlags options = 0;
  if (backwards->isChecked())
    options |= QTextDocument::FindBackward;
  if (wholeWords->isChecked())
    options |= QTextDocument::FindWholeWords;
  if (caseSensitive->isChecked())
    options |= QTextDocument::FindCaseSensitively;
  hide();
  saveReplaceOptions();
  if (m_textEdit->textCursor().hasSelection()) {
    QTextCursor cursor = m_textEdit->textCursor();
    cursor.movePosition(QTextCursor::PreviousCharacter, QTextCursor::MoveAnchor, m_textEdit->textCursor().selectedText().length());
    m_textEdit->setTextCursor(cursor);
  }
  int nbFound = 0;
  int choice = 0;
  bool found;
  do {
    found = m_textEdit->find(textFind->currentText(), options);
    if (found) {
      if (prompt->isChecked() && choice != 1) {
        promptReplace->exec();
        choice = promptReplace->choice();
      }
      if (choice == 0 || choice == 1)  // Replace, Replace All
      {
        m_textEdit->textCursor().removeSelectedText();
        m_textEdit->textCursor().insertText(textReplace->currentText());
        nbFound++;
      }
    } else {
      QString message;
      if (backwards->isChecked())
        message = tr("Beginning of document reached.") + "\n" + tr("Continue from the end") + "?";
      else
        message = tr("End of document reached.") + "\n" + tr("Continue from the beginning") + "?";
      int rep = QMessageBox::question(this, tr("Replace"),
                                      QString::number(nbFound) + " " + tr("replacement(s) made.") + "\n" + message,
                                      tr("&Continue"), tr("&Stop"), QString(), 0, 1);
      if (rep == 0) {
        QTextCursor cursor = m_textEdit->textCursor();
        if (backwards->isChecked())
          cursor.movePosition(QTextCursor::End, QTextCursor::MoveAnchor);
        else
          cursor.movePosition(QTextCursor::Start, QTextCursor::MoveAnchor);
        m_textEdit->setTextCursor(cursor);
        found = true;
        nbFound = 0;
      }
    }
  } while (found && choice != 3);
  delete promptReplace;
}

void ReplaceImpl::saveReplaceOptions() {
  QStringList items;
  items << textFind->currentText();
  for (int i = 0; i < textFind->count(); i++)
    items << textFind->itemText(i);
  m_replaceOptions.textFind = items;
  items.clear();
  items << textReplace->currentText();
  for (int i = 0; i < textReplace->count(); i++)
    items << textReplace->itemText(i);
  m_replaceOptions.textReplace = items;
  m_replaceOptions.backwards = backwards->isChecked();
  m_replaceOptions.prompt = prompt->isChecked();
  m_replaceOptions.caseSensitive = caseSensitive->isChecked();
  m_replaceOptions.wholeWords = wholeWords->isChecked();
}

PromptReplaceImpl::PromptReplaceImpl(QWidget * parent, Qt::WFlags f) : QDialog(parent, f) {
  setupUi(this);
  m_choice = 3;
}

void PromptReplaceImpl::on_replace_clicked() {
  m_choice = 0;
  accept();
}

void PromptReplaceImpl::on_replaceAll_clicked() {
  m_choice = 1;
  accept();
}

void PromptReplaceImpl::on_findNext_clicked() {
  m_choice = 2;
  accept();
}

void PromptReplaceImpl::on_close_clicked() {
  m_choice = 3;
  accept();
}
