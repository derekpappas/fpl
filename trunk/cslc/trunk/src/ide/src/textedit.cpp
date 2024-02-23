/****************************************************************************
**
** Copyright (C) 2006-2007 Trolltech ASA. All rights reserved.
**
** This file is part of the example classes of the Qt Toolkit.
**
** This file may be used under the terms of the GNU General Public
** License version 2.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of
** this file.  Please review the following information to ensure GNU
** General Public Licensing requirements will be met:
** http://www.trolltech.com/products/qt/opensource.html
**
** If you are unsure which license is appropriate for your use, please
** review the following information:
** http://www.trolltech.com/products/qt/licensing.html or contact the
** sales department at sales@trolltech.com.
**
** This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING THE
** WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
**
****************************************************************************/

#include "textedit.h"
#include <QCompleter>
#include <QKeyEvent>
#include <QAbstractItemView>
#include <QtDebug>
#include <QApplication>
#include <QModelIndex>
#include <QAbstractItemModel>
#include <QScrollBar>

TextEdit::TextEdit(QWidget *parent) : QTextEdit(parent), c(0) {
  setPlainText(tr("This TextEdit provides autocompletions for words that have more than"
                  " 3 characters. You can trigger autocompletion using ") +
               QKeySequence("Ctrl+E").toString(QKeySequence::NativeText));
}

TextEdit::~TextEdit() {}

void TextEdit::setCompleter(QCompleter *completer) {
  if (c)
    QObject::disconnect(c, 0, this, 0);

  c = completer;

  if (!c)
    return;

  c->setWidget(this);
  c->setCompletionMode(QCompleter::PopupCompletion);
  c->setCaseSensitivity(Qt::CaseInsensitive);
  QObject::connect(completer, SIGNAL(activated(const QString&)),
                   this, SLOT(insertCompletion(const QString&)));
}

QCompleter *TextEdit::completer() const {
  return c;
}

void TextEdit::insertCompletion(const QString& completion) {
  QTextCursor tc = textCursor();
  int extra = completion.length() - c->completionPrefix().length();
  tc.movePosition(QTextCursor::Left);
  tc.movePosition(QTextCursor::EndOfWord);
  tc.insertText(completion.right(extra));
  setTextCursor(tc);
}

QString TextEdit::textUnderCursor() const {
  QTextCursor tc = textCursor();
  tc.select(QTextCursor::WordUnderCursor);
  return tc.selectedText();
}

void TextEdit::keyPressEvent(QKeyEvent *e) {
  if (c && c->popup()->isVisible()) {
    // The following keys are forwarded by the completer to the widget
    switch (e->key()) {
      case Qt::Key_Enter:
      case Qt::Key_Return:
      case Qt::Key_Escape:
      case Qt::Key_Tab:
      case Qt::Key_Backtab:
        e->ignore();
        return; // let the completer do default behavior
      default:
        break;
    }
  }

  bool isShortcut = ((e->modifiers() & Qt::ControlModifier) && e->key() == Qt::Key_E); // CTRL+E
  if (!c || !isShortcut) // dont process the shortcut when we have a completer
    QTextEdit::keyPressEvent(e);

  const bool ctrlOrShift = e->modifiers() & (Qt::ControlModifier | Qt::ShiftModifier);
  if (!c || (ctrlOrShift && e->text().isEmpty()))
    return;

  static QString eow("~!@#$%^&*()_+{}|:\"<>?,./;'[]\\-="); // end of word
  bool hasModifier = (e->modifiers() != Qt::NoModifier) && !ctrlOrShift;
  QString completionPrefix = textUnderCursor();

  if (!isShortcut && (hasModifier || e->text().isEmpty() || completionPrefix.length() < 3
                      || eow.contains(e->text().right(1)))) {
    c->popup()->hide();
    return;
  }

  if (completionPrefix != c->completionPrefix()) {
    c->setCompletionPrefix(completionPrefix);
    c->popup()->setCurrentIndex(c->completionModel()->index(0, 0));
  }
  QRect cr = cursorRect();
  cr.setWidth(c->popup()->sizeHintForColumn(0)
              + c->popup()->verticalScrollBar()->sizeHint().width());
  c->complete(cr); // popup it up!
}