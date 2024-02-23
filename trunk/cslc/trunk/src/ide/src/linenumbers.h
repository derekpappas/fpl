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

#ifndef LINENUMBERS_H
#define LINENUMBERS_H
#include <QWidget>
#include "mainchild.h"

class LineNumbers : public QWidget {
    Q_OBJECT
    Q_PROPERTY(int digitNumbers READ digitNumbers WRITE setDigitNumbers)
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor)

  public:
    LineNumbers(MainChild*);
    void setDigitNumbers(int);
    int digitNumbers() const;
    void setTextColor(const QColor&);
    const QColor& textColor() const;
    void setBackgroundColor(const QColor&);
    const QColor& backgroundColor() const;
  protected:
    virtual void paintEvent(QPaintEvent*);
    virtual void mousePressEvent(QMouseEvent *event);
  private:
    MainChild* m_textEdit;
    const QFontMetrics fm;
    int mDigitNumbers;
    QColor mTextColor;
    QColor mBackgroundColor;
  signals:
    void digitNumbersChanged();
    void textColorChanged(const QColor&);
    void backgroundColorChanged(const QColor&);
  public slots:
    void setDefaultProperties();
};
#endif
