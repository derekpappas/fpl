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

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QFile>
#include <QListWidget>
#include <QTreeWidget>
#include <signal.h>

#include "tools.h"
#include "instancetree.h"
#include "ui_findwidget.h"
#include "../../cslc/cslc_Platform.h"
#include "../../cslc/new_cslc.h"
#include "../../support/cli/cslcCLI_Typedef.h"
#include "../../support/cli/cslcCLI_Support.h"

class QAction;
class QMenu;
class QWorkspace;
class MainChild;
class QSignalMapper;
class QAbstractItemModel;

typedef struct ReplaceOptions {
  QStringList textFind;
  QStringList textReplace;
  bool caseSensitive;
  bool backwards;
  bool wholeWords;
  bool prompt;
};

class MainWindow : public QMainWindow {
    Q_OBJECT
    friend class MainChild;
  public:
    MainWindow(QWidget *parent = 0);
    QStringList getCslKeywords() { return m_cslKeywords; };
    QStringList getVerilogKeywords() { return m_verilogKeywords; };
    QStringList getCppKeywords() { return m_cppKeywords; };
    QString getWorkingDirectory() { return m_workingDirectory; };
    void setTabSpaces() { m_tabSpaces = tools->enTabSpaces(); };
    void setMatch() { m_match = tools->getMatchBox(); };
    void setBrackets() { m_brackets = tools->getBrackets(); };
    void setAutoIndent() { m_indent = tools->enAutoIndent(); };
    void setLineNumbers() { m_lineNumbers = tools->enLineNumbers(); };
    void setWordWrap() { m_wordWrap = tools->getWordWrap(); };
    bool getTabSpaces() { return m_tabSpaces; };
    bool getAutoIndent() { return m_indent; };
    bool getLineNumbers() { return m_lineNumbers; };
    bool getBrackets() { return m_brackets; };
    bool getMatch() { return m_match; };
    bool getWordWrap() { return m_wordWrap; };

  protected:
    enum { MaxRecentFiles = 6 };
    QAction *recentFileActs[MaxRecentFiles];
    void closeEvent(QCloseEvent *event);

  private slots:
    bool isEmpty();
    void newFile();
    void open();
    void open(const QString &fileName);
    void save();
    void saveAs();
    void print();
    void printPdf();
    void printPreview();
    void openRecentFile();
    void undo();
    void redo();
    void cut();
    void copy();
    void paste();
    void font();
    void setDir();
    void replace();
    void find();
    void findContinue();
    void slotFindNext();
    void findPrevious();
    void slotFindPrevious();
    void setFocus();
    void slotFindWidget_textChanged(QString text = "", bool fromButton = false);
    void slotDoubleClickLogWind(QListWidgetItem *item);
    void slotStopCslc();
    void about();
    void runcsl();
    void runoptcsl();
    void GotoLine();
    void GotoMatch();
    void setupCslc();
    void slotIndent();
    void slotUnindent();
    void updateMenus();
    void updateWindowMenu();
    void switchLayoutDirection();
    MainChild *createMainChild();

  private:
    void createActions();
    void createMenus();
    void createToolBars();
    void createDockWindows();
    void createStatusBar();
    void readSettings();
    void writeSettings();
    void updateRecentFileActions();
    void updateLineNumbers();
    MainChild *activeMainChild();
    MainChild *findMainChild(const QString &fileName);
    ReplaceOptions m_replaceOptions;
    QString m_workingDirectory;
    QString m_cslcName;
    QStringList m_cslKeywords;
    QStringList m_verilogKeywords;
    QStringList m_cppKeywords;
    QStringList getWords(QString readFile);
    QDockWidget *logWind;
    QDockWidget *findWind;
    QDockWidget *treeWind;
    TreeView *childTreeWind;
    QListWidget *logList;
    Tools *tools;

    QWorkspace *workspace;
    QSignalMapper *windowMapper;
    QWidget *m_findWidget;
    QTimer *autoHideTimer;
    Ui::FindWidget uiFind;
    bool m_backward;
    bool m_tabSpaces;
    bool m_brackets;
    bool m_lineNumbers;
    bool m_indent;
    bool m_match;
    bool m_wordWrap;

    QMenu *fileMenu;
    QMenu *editMenu;
    QMenu *windowMenu;
    QMenu *viewMenu;
    QMenu *runMenu;
    QMenu *helpMenu;
    QMenu *recentFilesMenu;
    QToolBar *fileToolBar;
    QToolBar *editToolBar;
    QToolBar *runToolBar;
    QAction *newAct;
    QAction *openAct;
    QAction *saveAct;
    QAction *saveAsAct;
    QAction *printAct;
    QAction *printPdfAct;
    QAction *printPreviewAct;
    QAction *setDirAct;
    QAction *exitAct;
    QAction *undoAct;
    QAction *redoAct;
    QAction *cutAct;
    QAction *copyAct;
    QAction *pasteAct;
    QAction *indentAct;
    QAction *unindentAct;
    QAction *fontAct;
    QAction *gotoAct;
    QAction *gotoMatchAct;
    QAction *findAct;
    QAction *replaceAct;
    QAction *closeAct;
    QAction *closeAllAct;
    QAction *tileAct;
    QAction *cascadeAct;
    QAction *arrangeAct;
    QAction *nextAct;
    QAction *previousAct;
    QAction *separatorAct;
    QAction *aboutAct;
    QAction *runoptCslc;
    QAction *stopCslcAct;
    QAction *runCslcAct;
    QAction *aboutQtAct;

signals:
    void stopCslc();
};
#endif
