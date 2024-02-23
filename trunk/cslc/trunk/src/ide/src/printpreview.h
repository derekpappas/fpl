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

#ifndef PRINTPREVIEW_H
#define PRINTPREVIEW_H

#include <QMainWindow>
#include <QPrinter>

class PreviewView;
class QTextDocument;

class PrintPreview : public QMainWindow
{
    Q_OBJECT
public:
    PrintPreview(const QTextDocument *document, QWidget *parent);
    virtual ~PrintPreview();

private slots:
    void print();
    void pageSetup();

private:
    void setup();

    QTextDocument *doc;
    PreviewView *view;
    QPrinter printer;
};

#endif // PRINTPREVIEW_H
