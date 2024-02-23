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
* This is a part of the  IDE
* Author: Codrin Pruteanu <codrin@fastpathlogic.ro>
* 2007
*/

#include "linenumbers.h"
#include <QTextEdit>
#include <QGridLayout>
#include <QScrollBar>
#include <QPainter>
#include <QAbstractTextDocumentLayout>
#include <QTextBlock>
#include <QDebug>

LineNumbers::LineNumbers(MainChild* edit)
    : QWidget((QWidget *)edit), m_textEdit(edit), fm(QFont("Monospace", 10)) {
  setObjectName("editorZone");
  connect(m_textEdit->document()->documentLayout(), SIGNAL(update(const QRectF&)), this, SLOT(update()));
  connect(m_textEdit->verticalScrollBar(), SIGNAL(valueChanged(int)), this, SLOT(update()));
  setDefaultProperties();
}

void LineNumbers::paintEvent(QPaintEvent*) {
  int contentsY = m_textEdit->verticalScrollBar()->value();
  qreal pageBottom = contentsY + m_textEdit->viewport()->height();
  setMinimumHeight(m_textEdit->size().height());
  int m_lineNumber = 1;
  const int ascent = fm.ascent() + 1;
  QPainter p(this);
  // need a hack to only browse the viewed block for big document
  for (QTextBlock block = m_textEdit->document()->begin(); block.isValid(); block = block.next(), ++m_lineNumber) {
    QTextLayout* layout = block.layout();
    const QRectF boundingRect = layout->boundingRect();
    QPointF position = layout->position();
    if (position.y() + boundingRect.height() < contentsY)
      continue;
    if (position.y() > pageBottom)
      break;
    const QString txt = QString::number(m_lineNumber);
    if (txt.size() > QString::number(m_lineNumber - 1).size()) {
      setDigitNumbers(txt.size() + 1);
    };
    p.drawText(width() - fm.width(txt) - 1, qRound(position.y()) - contentsY + ascent, txt);
  }
}

void LineNumbers::setDigitNumbers(int i) {
  if (i == mDigitNumbers)
    return;
  mDigitNumbers = i;
  setFixedWidth(fm.width(" ") *(i) + 1);
  emit digitNumbersChanged();
}

int LineNumbers::digitNumbers() const {
  return mDigitNumbers;
}

void LineNumbers::setTextColor(const QColor& c) {
  if (c == mTextColor)
    return;
  mTextColor = c;
  QPalette p(palette());
  p.setColor(foregroundRole(), mTextColor);
  setPalette(p);
  emit textColorChanged(mTextColor);
}

const QColor& LineNumbers::textColor() const {
  return mTextColor;
}

void LineNumbers::setDefaultProperties() {
  setAutoFillBackground(true);
  setMinimumHeight(m_textEdit->size().height());
  // Default properties
#ifdef WIN32
  setFont(QFont("MS Shell Dlg 2", 8));
#endif
  setBackgroundColor(QColor("#ffffd2"));
  setTextColor(QColor(Qt::black));
  mDigitNumbers = 0;
  setDigitNumbers(1);
}

void LineNumbers::mousePressEvent(QMouseEvent * event) {
  QTextCursor cursor = m_textEdit->cursorForPosition(event->pos());
  cursor.movePosition(QTextCursor::StartOfLine, QTextCursor::MoveAnchor);
  if (cursor.isNull()) {
    return;
  }
  if (event->button() == Qt::LeftButton) {
    m_textEdit->setTextCursor(cursor);
  }
}

void LineNumbers::setBackgroundColor(const QColor& c) {
  if (c == mBackgroundColor)
    return;
  mBackgroundColor = c;
  QPalette p(palette());
  p.setColor(backgroundRole(), mBackgroundColor);
  setPalette(p);
  emit backgroundColorChanged(mBackgroundColor);
}

const QColor& LineNumbers::backgroundColor() const {
  return mBackgroundColor;
}
