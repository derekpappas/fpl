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

#include <QtCore/QFile>
#include "highlighter.h"

Highlighter::Highlighter(MainWindow *mainParent, QTextDocument *parent, QString type) : QSyntaxHighlighter(parent) {
  HighlightingRule rule;

  keywordFormat.setForeground(Qt::darkBlue);
  keywordFormat.setFontWeight(QFont::Bold);
  QStringList keywordPatterns;

  if (type == "csl") {
    keywordPatterns << mainParent->getCslKeywords();
  }
  if (type == "v" || type == "vh") {
    keywordPatterns << mainParent->getVerilogKeywords();
  }
  if (type == "cpp" || type == "cc" || type == "h") {
    keywordPatterns << mainParent->getCppKeywords();
  }

  foreach(QString pattern, keywordPatterns) {
    rule.pattern = QRegExp(pattern);
    rule.format = keywordFormat;
    highlightingRules.append(rule);
  }

  classFormat.setFontWeight(QFont::Bold);
  classFormat.setForeground(Qt::darkMagenta);
  rule.pattern = QRegExp("\\bQ[A-Za-z]+\\b");
  rule.format = classFormat;
  highlightingRules.append(rule);

  singleLineCommentFormat.setForeground(Qt::gray);
  rule.pattern = QRegExp("//[^\n]*");
  rule.format = singleLineCommentFormat;
  highlightingRules.append(rule);

  multiLineCommentFormat.setForeground(Qt::gray);

  quotationFormat.setForeground(Qt::darkGreen);
  rule.pattern = QRegExp("\".*\"");
  rule.format = quotationFormat;
  highlightingRules.append(rule);

  functionFormat.setFontItalic(true);
  functionFormat.setForeground(Qt::blue);
  rule.pattern = QRegExp("\\b[A-Za-z0-9_]+(?=\\()");
  rule.format = functionFormat;
  highlightingRules.append(rule);

  commentStartExpression = QRegExp("/\\*");
  commentEndExpression = QRegExp("\\*/");
}

void Highlighter::highlightBlock(const QString &text) {
  foreach(HighlightingRule rule, highlightingRules) {
    QRegExp expression(rule.pattern);
    int index = text.indexOf(expression);
    while (index >= 0) {
      int length = expression.matchedLength();
      setFormat(index, length, rule.format);
      index = text.indexOf(expression, index + length);
    }
  }
  setCurrentBlockState(0);

  int startIndex = 0;
  if (previousBlockState() != 1)
    startIndex = text.indexOf(commentStartExpression);

  while (startIndex >= 0) {
    int endIndex = text.indexOf(commentEndExpression, startIndex);
    int commentLength;
    if (endIndex == -1) {
      setCurrentBlockState(1);
      commentLength = text.length() - startIndex;
    } else {
      commentLength = endIndex - startIndex + commentEndExpression.matchedLength();
    }
    setFormat(startIndex, commentLength, multiLineCommentFormat);
    startIndex = text.indexOf(commentStartExpression, startIndex + commentLength);
  }
}
