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

#ifndef HIGHLIGHTER_H
#define HIGHLIGHTER_H

#include <QSyntaxHighlighter>

#include <QtCore/QHash>
#include <QtGui/QTextCharFormat>
#include <QtCore/QFile>
#include "mainwindow.h"

class Highlighter;

class Highlighter : public QSyntaxHighlighter {
    Q_OBJECT

  public:
    Highlighter(MainWindow *mainParent = 0, QTextDocument *parent = 0, QString type = "");

  protected:
    void highlightBlock(const QString &text);

  private:
    struct HighlightingRule {
      QRegExp pattern;
      QTextCharFormat format;
    };
    QVector<HighlightingRule> highlightingRules;

    QRegExp commentStartExpression;
    QRegExp commentEndExpression;

    QTextCharFormat keywordFormat;
    QTextCharFormat classFormat;
    QTextCharFormat singleLineCommentFormat;
    QTextCharFormat multiLineCommentFormat;
    QTextCharFormat quotationFormat;
    QTextCharFormat functionFormat;
};

#endif
