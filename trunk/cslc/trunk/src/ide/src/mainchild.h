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

#ifndef MAINCHILD_H
#define MAINCHILD_H
#include <QTextEdit>
#include <QProcess>
#include <QtGui>
#include "mainwindow.h"
#include "highlighter.h"
#include "linenumbers.h"
#include "../../cslc/cslc_Support.h"
#include "../../cslc/new_cslc.h"
#include "../../autorouter/CSLOM_InstTreeVisitor.h"

class MainChild;
class QCompleter;
class LineNumbers;

class MainChild : public QTextEdit {
    Q_OBJECT
  public:
    MainChild(MainWindow*, QWidget *parent = NULL);
    ~MainChild();
    void newFile();
    bool loadFile(const QString &fileName);
    void openFile(QString file);
    bool launch();
    bool save();
    bool saveAs();
    bool print();
    bool printPdf();
    void printPreview();
    bool saveFile(const QString &fileName);
    bool checkFile(const QString &fileName);
    bool fileExists(const QString &fileName);
    bool saveFile(const QString &fileName, QString &output);
    bool isFileType(QString ext);
    long linesCount();
    long lineNumber(QTextCursor);
    long currentLineNumber();
    void setCurrentLineColor(QColor c);
    void selectLines(int start, int end);
    void setLineNumbers(LineNumbers*);
    void changeFont(QFont font);
    void updateLineNumbers(bool activated);
    QString fileChangeExtension(QString ext);
    QString userFriendlyCurrentFile();
    QString currentFile() { return curFile; }
    QString strippedName(const QString &fullFileName);
    QTextCursor getTextCursorForLine(long line) const;
    void setCompleter(QCompleter *c);
    void insertSpaces(QTextCursor &c, int &nbSpaces);
    void gotoMatchingBracket();
    bool inQuotations(int position, QString text);
    void clearMatch();
    void setWordWrapMode(bool mode);

  protected:
    void closeEvent(QCloseEvent *event);
    void keyPressEvent(QKeyEvent *e);
    void paintEvent(QPaintEvent *event);
    QAbstractItemModel *modelFromFile();
    QCompleter *completer;

  public slots:
    void readFromStdout();
    void setCursorChanged();
    void slotStopCslc();
    void gotoLine(long line, long column);
    void slotFind(Ui::FindWidget ui, QString ttf = 0,  QTextDocument::FindFlags options = 0, bool fromButton = false);
    void slotIndent(bool indent=true);
    void slotUnindent();

  private slots:
    void documentWasModified();
    void insertCompletion(const QString &completion);
    void slotAdjustSize();

signals:
        void message(QString, QString=0);

  private:
    MainWindow *mWindow;
    Highlighter *highlighter;
    bool maybeSave();
    void createStatusBar();
    void setCurrentFile(const QString &fileName);
    void autoIndent();
    void autoUnindent();
    void autoBrackets();
    void match();
    void deleteSpaces(QTextCursor &c, QTextBlock &bloc, int &nbSpaces);
 // TODO: FIXME DEP   void showInstanceTree(NSCslc::Cslc *cslc);
    QString textUnderCursor() const;
    QProcess *proc;
    QCompleter *c;
    QFontMetrics fm;
    QColor m_currentLineColour;
    QColor m_matchingColor;
    QString curFile;
    QString m_plainText;
    QPointer<LineNumbers> m_lineNumbers;
    //NSCslc::Cslc *cslc;
    long m_matchingBegin;
    long m_matchingEnd;
    int nrErrors;
    int nrWarnings;
    bool isUntitled;
    bool m_insertMode;
};

#endif
