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

#include <QtGui>
#include <QProcess>
#include <iostream>
#include "mainwindow.h"
#include "mainchild.h"
#include "highlighter.h"
#include "replace.h"
#include "ui_gotoline.h"

using namespace std;

// the mainWindow constructor defines the workspace, loads all the IDE settings and connects all the specific handlers
MainWindow::MainWindow(QWidget *parent) : QMainWindow(parent) {
  workspace = new QWorkspace;
  setCentralWidget(workspace);
  setWindowTitle(tr("CSLC IDE"));
  windowMapper = new QSignalMapper(this);
  tools = new Tools(this);
  createActions();
  createMenus();
  createToolBars();
  createStatusBar();
  createDockWindows();
  updateMenus();
  readSettings();
  setupCslc();
  setAutoIndent();
  setTabSpaces();
  setBrackets();
  setMatch();
  setWordWrap();
  setLineNumbers();

  m_backward = false;
  m_replaceOptions.wholeWords = false;
  m_replaceOptions.backwards = false;
  m_findWidget = new QWidget;
  uiFind.setupUi(m_findWidget);
  uiFind.labelWrapped->setVisible(false);
  autoHideTimer = new QTimer(this);
  autoHideTimer->setInterval(5000);
  autoHideTimer->setSingleShot(true);
  findWind->setWidget(m_findWidget);
  connect(autoHideTimer, SIGNAL(timeout()), findWind, SLOT(hide()));
  connect(uiFind.toolClose, SIGNAL(clicked()), findWind, SLOT(hide()));
  connect(uiFind.editFind, SIGNAL(textChanged(QString)), this, SLOT(slotFindWidget_textChanged(QString)));
  connect(uiFind.editFind, SIGNAL(returnPressed()), this, SLOT(slotFindNext()));
  connect(uiFind.toolPrevious, SIGNAL(clicked()), this, SLOT(slotFindPrevious()));
  connect(uiFind.toolNext, SIGNAL(clicked()), this, SLOT(slotFindNext()));
  connect(workspace, SIGNAL(windowActivated(QWidget *)), this, SLOT(updateMenus()));
  connect(windowMapper, SIGNAL(mapped(QWidget *)), workspace, SLOT(setActiveWindow(QWidget *)));
  connect(logList, SIGNAL(itemDoubleClicked(QListWidgetItem *)), this, SLOT(slotDoubleClickLogWind(QListWidgetItem *)));
}

// this function creates the docking windows inside the main Window: and sets the properties for each of them
void MainWindow::createDockWindows() {
  logWind = new QDockWidget(tr("Log Window"), this);
  logWind->setAllowedAreas(Qt::BottomDockWidgetArea);
  addDockWidget(Qt::BottomDockWidgetArea, logWind);
  viewMenu->addAction(logWind->toggleViewAction());
  logList = new QListWidget();
  logWind->setWidget(logList);

  findWind = new QDockWidget(tr("Find Window"), this);
  addDockWidget(Qt::TopDockWidgetArea, findWind);
  findWind->setFeatures(QDockWidget::NoDockWidgetFeatures);
  findWind->setWindowFlags(Qt::FramelessWindowHint);
  findWind->hide();

  treeWind = new QDockWidget(tr("InstanceTree Window"), this);
  treeWind->setAllowedAreas(Qt::LeftDockWidgetArea | Qt::RightDockWidgetArea);
  addDockWidget(Qt::LeftDockWidgetArea, treeWind);
  viewMenu->addAction(treeWind->toggleViewAction());
  childTreeWind = new TreeView();
  treeWind->setWidget(childTreeWind);
}

// this slot handles the double-click event on the warning/error line by setting the cursor at the specified position
void MainWindow::slotDoubleClickLogWind(QListWidgetItem *item) {
  QString textItem = item->text();
  if (!textItem.toLower().contains("error:") && !textItem.toLower().contains("warning:"))
    return;

  QRegExp rxFile("file '.*'");
  rxFile.indexIn(textItem);
  QString fileName = rxFile.cap(0).section("'", 1, 1);

  QRegExp rxLine("line '\\d+'");
  rxLine.indexIn(textItem);
  long lineNum = rxLine.cap(0).section("'", 1, 1).toInt();
  if (lineNum == 0)
    return;

  QRegExp rxCol("column '\\d+'");
  rxCol.indexIn(textItem);
  long colNum = rxCol.cap(0).section("'", 1, 1).toInt();

  open(fileName);
  activeMainChild()->gotoLine(lineNum, colNum);
}

// this function handles the close event
void MainWindow::closeEvent(QCloseEvent *event) {
  QMessageBox::StandardButton ret;
  ret = QMessageBox::question(this, tr("CSLC IDE Exit"), tr("Do you really want to exit CSLC IDE?"),
                             QMessageBox::Yes | QMessageBox::No);
  if (ret == QMessageBox::Yes) {
    writeSettings();
    workspace->closeAllWindows();
    event->accept();
  } else {
    event->ignore();
  }
}

// this function is adding a new file at the workspace
void MainWindow::newFile() {
  MainChild *child = createMainChild();
  if (tools->tileAutoSel()) {
    workspace->tile();
  }
  child->show();
}

// this function is marking the specified file from the open dialog to be loaded using the loadFile(fileName) function
void MainWindow::open() {
  QString fileName = QFileDialog::getOpenFileName(this, m_workingDirectory, m_workingDirectory);
  if (!fileName.isEmpty()) {
    MainChild *existing = findMainChild(fileName);
    if (existing) {
      workspace->setActiveWindow(existing);
      return;
    }

    MainChild *child = createMainChild();
    if (child->loadFile(fileName)) {
      statusBar()->showMessage(tr("File loaded"), 2000);
      child->show();
    } else {
      child->close();
    }
  }
}

// this function opens the fileName specified as parameter
void MainWindow::open(const QString &fileName) {
  if (!fileName.isEmpty()) {
    MainChild *existing = findMainChild(fileName);
    if (existing) {
      workspace->setActiveWindow(existing);
      return;
    }

    MainChild *child = createMainChild();
    if (child->loadFile(fileName)) {
      statusBar()->showMessage(tr("File loaded"), 2000);
      child->show();
    } else {
      child->close();
    }
  }
}

// this function emits a signal to stop the CSLC tool execution
void MainWindow::slotStopCslc() {
  emit stopCslc();
}

// this function calls the save() function for the current child window
void MainWindow::save() {
  if (activeMainChild()->save())
    statusBar()->showMessage(tr("File saved"), 2000);
}

// this function calls the saveAs() function for the current child window
void MainWindow::saveAs() {
  if (activeMainChild()->saveAs())
    statusBar()->showMessage(tr("File saved"), 2000);
}

// this function calls the print() function for the current child window
void MainWindow::print() {
  if (activeMainChild()->print())
    statusBar()->showMessage(tr("File printed"), 2000);
}

// this function calls the printPdf() function for the current child window
void MainWindow::printPdf() {
  if (activeMainChild()->printPdf())
    statusBar()->showMessage(tr("File exported as PDF"), 2000);
}

// this function calls the printPreview() function for the current child window
void MainWindow::printPreview() {
  activeMainChild()->printPreview();
}

// this function opens the RecentFile
void MainWindow::openRecentFile() {
  QAction *action = qobject_cast<QAction *>(sender());
  if (action)
    open(action->data().toString());
}

// this function calls the undo() function for the current child window
void MainWindow::undo() {
  activeMainChild()->undo();
}

// this function calls the redo() function for the current child window
void MainWindow::redo() {
  activeMainChild()->redo();
}

// this function calls the cut() function for the current child window
void MainWindow::cut() {
  activeMainChild()->cut();
}

// this function calls the copy() function for the current child window
void MainWindow::copy() {
  activeMainChild()->copy();
}

// this function calls the paste() function for the current child window
void MainWindow::paste() {
  activeMainChild()->paste();
}

// this function calls the slotIndent() function for the current child window
void MainWindow::slotIndent() {
  activeMainChild()->slotIndent();
}

// this function calls the slotUnindent() function for the current child window
void MainWindow::slotUnindent() {
  activeMainChild()->slotUnindent();
}

// this function sets the current working directory specified inside the QFileDialog window
void MainWindow::setDir() {
  QString dir = QFileDialog::getExistingDirectory(this, tr("Open Directory"), m_workingDirectory,
                QFileDialog::ShowDirsOnly | QFileDialog::DontResolveSymlinks);
  m_workingDirectory = dir;
}

// this function sets the font for the current active child window
void MainWindow::font() {
  bool ok;
  QFont font = QFontDialog::getFont(&ok, QFont("Helvetica [Cronyx]", 10), this);
  if (ok) {
    activeMainChild()->changeFont(font);
  }
}

// this function calls the replace dialog inside the main window
void MainWindow::replace() {
  ReplaceImpl *dialog = new ReplaceImpl(this, activeMainChild(), m_replaceOptions);
  dialog->exec();
  m_replaceOptions = dialog->replaceOptions();
  delete dialog;
}

// this function calls the find dialog inside the main window
void MainWindow::find() {
  autoHideTimer->stop();
  findWind->show();
  uiFind.editFind->setFocus(Qt::ShortcutFocusReason);
  if (activeMainChild()->textCursor().selectedText().length())
    uiFind.editFind->setText(activeMainChild()->textCursor().selectedText());
  uiFind.editFind->selectAll();
  autoHideTimer->start();
}

// this function calls the find continuation slot
void MainWindow::findContinue() {
  //slotFindWidget_textChanged(uiFind.editFind->text(), true);
  slotFindNext();
}

// this function calls the find next slot
void MainWindow::slotFindNext() {
  m_backward = false;
  slotFindWidget_textChanged(uiFind.editFind->text(), true);
}

// this function calls the find previous continuation slot
void MainWindow::findPrevious() {
  slotFindPrevious();
}

// this function calls the find previous slot
void MainWindow::slotFindPrevious() {
  m_backward = true;
  slotFindWidget_textChanged(uiFind.editFind->text(), true);
}

// this function sets the focus to the current child window
void MainWindow::setFocus() {
  m_findWidget->hide();
  activeMainChild()->setFocus(Qt::OtherFocusReason);
}

// this function enables the find slot for the current child window
void MainWindow::slotFindWidget_textChanged(QString text, bool fromButton) {
  int options = 0;
  if (m_backward)
    options |= QTextDocument::FindBackward;
  if (uiFind.checkWholeWords->isChecked())
    options |= QTextDocument::FindWholeWords;
  if (uiFind.checkCase->isChecked())
    options |= QTextDocument::FindCaseSensitively;
  activeMainChild()->slotFind(uiFind, text, (QTextDocument::FindFlags)options, fromButton);
  autoHideTimer->start();
}

// this function calls the goto line dialog
void MainWindow::GotoLine() {
  QDialog *dial = new QDialog;
  Ui::GotoLine ui;
  ui.setupUi(dial);
  ui.horizontalSlider->setMaximum(activeMainChild()->linesCount());
  ui.horizontalSlider->setPageStep((activeMainChild()->linesCount()) / 10);
  ui.spinBox->setMaximum(activeMainChild()->linesCount());
  ui.spinBox->setValue(activeMainChild()->currentLineNumber());
  ui.spinBox->selectAll();
  ui.spinBox->setFocus();
  if (dial->exec() == QDialog::Accepted)
    activeMainChild()->gotoLine(ui.spinBox->value(), 1);
  delete dial;
}

// this function calls the goto matching bracket function for the current main child window
void MainWindow::GotoMatch() {
  if (getMatch()) {
    activeMainChild()->gotoMatchingBracket();
  }
}

// this function shows the current revision number of the IDE
void MainWindow::about() {
  QMessageBox::about (this, tr("About CSLC IDE v2.0"),
                     tr("The <b>IDE</b> example writes multiple CSLC interface applications using Qt."));
}

// this function returns true if the child window list is empty
bool MainWindow::isEmpty() {
  return !activeMainChild();
}

// this function is calling the CSLC tool for the current child window
void MainWindow::runcsl() {
  activeMainChild()->launch();
}

// this function updates the line and column values
void MainWindow::updateLineNumbers() {
  foreach(QWidget *window, workspace->windowList()) {
    MainChild *mainChild = qobject_cast<MainChild *> (window);
    mainChild->updateLineNumbers(getLineNumbers());
    mainChild->setWordWrapMode(getWordWrap());
    mainChild->clearMatch();
  }
}

// this function is calling the main Options window
void MainWindow::runoptcsl() {
  bool lineNumbers = m_lineNumbers;
  tools->exec();
  setAutoIndent();
  setTabSpaces();
  setBrackets();
  setMatch();
  setWordWrap();
  setLineNumbers();
  gotoMatchAct->setEnabled(activeMainChild() && getMatch());
  if (!isEmpty()) {
    QFontMetrics fm(activeMainChild()->document()->defaultFont());
    activeMainChild()->setTabStopWidth(fm.width(" ") * tools->getTabSize());
    if (lineNumbers != m_lineNumbers) {
      updateLineNumbers();
    }
    activeMainChild()->viewport()->update();
  }
}

// this function is updating the mainWindow Menu
void MainWindow::updateMenus() {
  bool hasMainChild = (activeMainChild() != 0);
  saveAct->setEnabled(hasMainChild);
  saveAsAct->setEnabled(hasMainChild);
  printAct->setEnabled(hasMainChild);
  printPdfAct->setEnabled(hasMainChild);
  printPreviewAct->setEnabled(hasMainChild);
  pasteAct->setEnabled(hasMainChild);
  undoAct->setEnabled(hasMainChild);
  redoAct->setEnabled(hasMainChild);
  fontAct->setEnabled(hasMainChild);
  gotoAct->setEnabled(hasMainChild);
  gotoMatchAct->setEnabled(hasMainChild && getMatch());
  findAct->setEnabled(hasMainChild);
  replaceAct->setEnabled(hasMainChild);
  closeAct->setEnabled(hasMainChild);
  closeAllAct->setEnabled(hasMainChild);
  tileAct->setEnabled(hasMainChild);
  cascadeAct->setEnabled(hasMainChild);
  arrangeAct->setEnabled(hasMainChild);
  nextAct->setEnabled(hasMainChild);
  previousAct->setEnabled(hasMainChild);
  separatorAct->setVisible(hasMainChild);
  stopCslcAct->setEnabled(hasMainChild);
  runCslcAct->setEnabled(hasMainChild);
  indentAct->setEnabled(hasMainChild);
  unindentAct->setEnabled(hasMainChild);

  bool hasSelection = (activeMainChild() && activeMainChild()->textCursor().hasSelection());
  cutAct->setEnabled(hasSelection);
  copyAct->setEnabled(hasSelection);
}

// this function is updating the main Window Menu
void MainWindow::updateWindowMenu() {
  windowMenu->clear();
  windowMenu->addAction(closeAct);
  windowMenu->addAction(closeAllAct);
  windowMenu->addSeparator();
  windowMenu->addAction(tileAct);
  windowMenu->addAction(cascadeAct);
  windowMenu->addAction(arrangeAct);
  windowMenu->addSeparator();
  windowMenu->addAction(nextAct);
  windowMenu->addAction(previousAct);
  windowMenu->addAction(separatorAct);

  QList<QWidget *> windows = workspace->windowList();
  separatorAct->setVisible(!windows.isEmpty());

  for (int i = 0; i < windows.size(); ++i) {
    MainChild *child = qobject_cast<MainChild *> (windows.at(i));

    QString text;
    if (i < 9) {
      text = tr("&%1 %2").arg(i + 1).arg(child->userFriendlyCurrentFile());
    } else {
      text = tr("%1 %2").arg(i + 1).arg(child->userFriendlyCurrentFile());
    }
    QAction *action  = windowMenu->addAction(text);
    action->setCheckable(true);
    action ->setChecked(child == activeMainChild());
    connect(action, SIGNAL(triggered()), windowMapper, SLOT(map()));
    windowMapper->setMapping(action, child);
  }
}

// this function is setting up the paths to the keywords files
void MainWindow::setupCslc() {
  m_cslKeywords = getWords(":/lang/csl_list.txt");
  m_cppKeywords = getWords(":/lang/cpp_list.txt");
  m_verilogKeywords = getWords(":/lang/verilog_list.txt");
}

// this function builds the keywords list and returns it in a QStringList
QStringList MainWindow::getWords(QString readFile) {
  QFile file(readFile);
  QString keyword;
  QStringList keywordList;
  if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
    QList<QByteArray> listStr = file.readAll().split('\n');
    for (int i = 0; i < listStr.size(); ++i) {
      if (!listStr.at(i).isEmpty()) {
        QString keyword = "\\b";
        keyword.append(listStr.at(i));
        keyword.append("\\b");
        keywordList << keyword;
      }
    }
  }
  return keywordList;
}

// this function creates a MainChild object
MainChild *MainWindow::createMainChild() {
  MainChild *child = new MainChild(this);
  workspace->addWindow(child);
  connect(child, SIGNAL(copyAvailable(bool)), cutAct, SLOT(setEnabled(bool)));
  connect(child, SIGNAL(copyAvailable(bool)), copyAct, SLOT(setEnabled(bool)));
  return child;
}

// this function creates the list of actions for the menus
void MainWindow::createActions() {
  newAct = new QAction(QIcon(":/images/new.png"), tr("&New"), this);
  newAct->setShortcut(tr("Ctrl+N"));
  newAct->setStatusTip(tr("Create a new file"));
  connect(newAct, SIGNAL(triggered()), this, SLOT(newFile()));

  openAct = new QAction(QIcon(":/images/open.png"), tr("&Open..."), this);
  openAct->setShortcut(tr("Ctrl+O"));
  openAct->setStatusTip(tr("Open an existing file"));
  connect(openAct, SIGNAL(triggered()), this, SLOT(open()));

  saveAct = new QAction(QIcon(":/images/save.png"), tr("&Save"), this);
  saveAct->setShortcut(tr("Ctrl+S"));
  saveAct->setStatusTip(tr("Save the document to disk"));
  connect(saveAct, SIGNAL(triggered()), this, SLOT(save()));

  saveAsAct = new QAction(QIcon(":/images/saveas.png"), tr("Save &As..."), this);
  saveAsAct->setStatusTip(tr("Save the document under a new name"));
  connect(saveAsAct, SIGNAL(triggered()), this, SLOT(saveAs()));

  printAct = new QAction(QIcon(":/images/print.png"), tr("&Print"), this);
  printAct->setStatusTip(tr("Print the current file"));
  printAct->setShortcut(tr("Ctrl+P"));
  connect(printAct, SIGNAL(triggered()), this, SLOT(print()));

  printPdfAct = new QAction(QIcon(":/images/exportpdf.png"), tr("&Export Pdf"), this);
  printPdfAct->setStatusTip(tr("Export to PDF the current file"));
  connect(printPdfAct, SIGNAL(triggered()), this, SLOT(printPdf()));

  printPreviewAct = new QAction(QIcon(":/images/print.png"), tr("Print Pre&view"), this);
  printPreviewAct->setStatusTip(tr("Print Preview of current file"));
  connect(printPreviewAct, SIGNAL(triggered()), this, SLOT(printPreview()));

  setDirAct = new QAction(QIcon(":/images/dir.png"), tr("Set Working &Directory"), this);
  setDirAct->setStatusTip(tr("Set current working directory"));
  connect(setDirAct, SIGNAL(triggered()), this, SLOT(setDir()));

  exitAct = new QAction(QIcon(":/images/exit.png"), tr("E&xit"), this);
  exitAct->setShortcut(tr("Ctrl+Q"));
  exitAct->setStatusTip(tr("Exit the application"));
  connect(exitAct, SIGNAL(triggered()), qApp, SLOT(closeAllWindows()));

  undoAct = new QAction(QIcon(":/images/undo.png"), tr("&Undo"), this);
  undoAct->setShortcut(tr("Ctrl+Z"));
  undoAct->setStatusTip(tr("Undo the current changes"));
  connect(undoAct, SIGNAL(triggered()), this, SLOT(undo()));

  redoAct = new QAction(QIcon(":/images/redo.png"), tr("&Redo"), this);
  redoAct->setShortcut(tr("Ctrl+Shift+Z"));
  redoAct->setStatusTip(tr("Redo the current changes"));
  connect(redoAct, SIGNAL(triggered()), this, SLOT(redo()));

  cutAct = new QAction(QIcon(":/images/cut.png"), tr("Cu&t"), this);
  cutAct->setShortcut(tr("Ctrl+X"));
  cutAct->setStatusTip(tr("Cut the current selection's contents to the clipboard"));
  connect(cutAct, SIGNAL(triggered()), this, SLOT(cut()));

  copyAct = new QAction(QIcon(":/images/copy.png"), tr("&Copy"), this);
  copyAct->setShortcut(tr("Ctrl+C"));
  copyAct->setStatusTip(tr("Copy the current selection's contents to the clipboard"));
  connect(copyAct, SIGNAL(triggered()), this, SLOT(copy()));

  pasteAct = new QAction(QIcon(":/images/paste.png"), tr("&Paste"), this);
  pasteAct->setShortcut(tr("Ctrl+V"));
  pasteAct->setStatusTip(tr("Paste the clipboard's contents into the current selection"));
  connect(pasteAct, SIGNAL(triggered()), this, SLOT(paste()));

  indentAct = new QAction(QIcon(":/images/indent.png"), tr("&Indent"), this);
  indentAct->setShortcut(tr("Ctrl+I"));
  indentAct->setStatusTip(tr("Selection Indent"));
  connect(indentAct, SIGNAL(triggered()), this, SLOT(slotIndent()));

  unindentAct = new QAction(QIcon(":/images/unindent.png"), tr("&Unindent"), this);
  unindentAct->setShortcut(tr("Ctrl+Shift+I"));
  unindentAct->setStatusTip(tr("Selection Unindent"));
  connect(unindentAct, SIGNAL(triggered()), this, SLOT(slotUnindent()));

  fontAct = new QAction(QIcon(":/images/font.png"), tr("F&ont"), this);
  fontAct->setShortcut(tr("Ctrl+M"));
  fontAct->setStatusTip(tr("Sets the current Font"));
  connect(fontAct, SIGNAL(triggered()), this, SLOT(font()));

  gotoAct = new QAction(QIcon(":/images/goto.png"), tr("&Goto Line"), this);
  gotoAct->setShortcut(tr("Ctrl+G"));
  gotoAct->setStatusTip(tr("Goto specified Line"));
  connect(gotoAct, SIGNAL(triggered()), this, SLOT(GotoLine()));

  gotoMatchAct = new QAction(QIcon(":/images/bracket.png"), tr("Goto &Bracket"), this);
  gotoMatchAct->setShortcut(tr("Ctrl+["));
  gotoMatchAct->setStatusTip(tr("Goto Bracket"));
  connect(gotoMatchAct, SIGNAL(triggered()), this, SLOT(GotoMatch()));

  findAct = new QAction(QIcon(":/images/find.png"), tr("&Find text"), this);
  findAct->setShortcut(tr("Ctrl+F"));
  findAct->setStatusTip(tr("Find specified text"));
  connect(findAct, SIGNAL(triggered()), this, SLOT(find()));

  replaceAct = new QAction(QIcon(":/images/replace.png"), tr("&Replace text"), this);
  replaceAct->setShortcut(tr("Ctrl+R"));
  replaceAct->setStatusTip(tr("Replace specified text"));
  connect(replaceAct, SIGNAL(triggered()), this, SLOT(replace()));

  closeAct = new QAction(QIcon(":/images/close.png"), tr("Cl&ose"), this);
  closeAct->setShortcut(tr("Ctrl+F4"));
  closeAct->setStatusTip(tr("Close the active window"));
  connect(closeAct, SIGNAL(triggered()), workspace, SLOT(closeActiveWindow()));

  closeAllAct = new QAction(QIcon(":/images/closeall.png"), tr("Close &All"), this);
  closeAllAct->setStatusTip(tr("Close all the windows"));
  connect(closeAllAct, SIGNAL(triggered()), workspace, SLOT(closeAllWindows()));

  tileAct = new QAction(QIcon(":/images/tile.png"), tr("&Tile"), this);
  tileAct->setShortcut(tr("Ctrl+T"));
  tileAct->setStatusTip(tr("Tile the windows"));
  connect(tileAct, SIGNAL(triggered()), workspace, SLOT(tile()));

  cascadeAct = new QAction(QIcon(":/images/cascade.png"), tr("&Cascade"), this);
  cascadeAct->setStatusTip(tr("Cascade the windows"));
  connect(cascadeAct, SIGNAL(triggered()), workspace, SLOT(cascade()));

  arrangeAct = new QAction(tr("Arrange &icons"), this);
  arrangeAct->setStatusTip(tr("Arrange the icons"));
  connect(arrangeAct, SIGNAL(triggered()), workspace, SLOT(arrangeIcons()));

  nextAct = new QAction(QIcon(":/images/next.png"), tr("Ne&xt"), this);
  nextAct->setShortcut(tr("Ctrl+F6"));
  nextAct->setStatusTip(tr("Move the focus to the next window"));
  connect(nextAct, SIGNAL(triggered()), workspace, SLOT(activateNextWindow()));

  previousAct = new QAction(QIcon(":/images/previous.png"), tr("Pre&vious"), this);
  previousAct->setShortcut(tr("Ctrl+F5"));
  previousAct->setStatusTip(tr("Move the focus to the previous window"));
  connect(previousAct, SIGNAL(triggered()), workspace, SLOT(activatePreviousWindow()));

  separatorAct = new QAction(this);
  separatorAct->setSeparator(true);

  aboutAct = new QAction(QIcon(":/images/about.png"), tr("&About CSLC IDE"), this);
  aboutAct->setStatusTip(tr("Show the application's About box"));
  connect(aboutAct, SIGNAL(triggered()), this, SLOT(about()));

  aboutQtAct = new QAction(QIcon(":/images/qt.png"), tr("About &Qt"), this);
  aboutQtAct->setStatusTip(tr("Show the Qt library's About box"));
  connect(aboutQtAct, SIGNAL(triggered()), qApp, SLOT(aboutQt()));

  runoptCslc = new QAction(QIcon(":/images/options.png"), tr("&CSLC options"), this);
  runoptCslc->setShortcut(tr("Alt+O"));
  runoptCslc->setStatusTip(tr("CSLC run options"));
  connect(runoptCslc, SIGNAL(triggered()), this, SLOT(runoptcsl()));

  runCslcAct = new QAction(QIcon(":/images/run.png"), tr("&Run CSLC"), this);
  runCslcAct->setShortcut(tr("F8"));
  runCslcAct->setStatusTip(tr("Run the CSLC backend application"));
  connect(runCslcAct, SIGNAL(triggered()), this, SLOT(runcsl()));

  stopCslcAct = new QAction(QIcon(":/images/stop.png"), tr("&Stop CSLC"), this);
  stopCslcAct->setShortcut(tr("F10"));
  stopCslcAct->setStatusTip(tr("Stop the CSLC"));
  connect(stopCslcAct, SIGNAL(triggered()), this, SLOT(slotStopCslc()));

  for (int i = 0; i < MaxRecentFiles; ++i) {
    recentFileActs[i] = new QAction(this);
    recentFileActs[i]->setVisible(false);
    connect(recentFileActs[i], SIGNAL(triggered()), this, SLOT(openRecentFile()));
  }
}

// this function create the menus
void MainWindow::createMenus() {
  fileMenu = menuBar()->addMenu(tr("&File"));
  fileMenu->addAction(newAct);
  fileMenu->addAction(openAct);
  fileMenu->addAction(saveAct);
  fileMenu->addAction(saveAsAct);
  fileMenu->addAction(setDirAct);
  fileMenu->addSeparator();
  fileMenu->addAction(printAct);
  fileMenu->addAction(printPreviewAct);
  fileMenu->addAction(printPdfAct);
  fileMenu->addSeparator();
  QAction *action = fileMenu->addAction(QIcon(":/images/switch.png"), tr("Switch layout direction"));
  connect(action, SIGNAL(triggered()), this, SLOT(switchLayoutDirection()));
  fileMenu->addSeparator();
  for (int i = 0; i < MaxRecentFiles; ++i)
    fileMenu->addAction(recentFileActs[i]);
  fileMenu->addSeparator();
  updateRecentFileActions();
  fileMenu->addAction(exitAct);

  editMenu = menuBar()->addMenu(tr("&Edit"));
  editMenu->addAction(undoAct);
  editMenu->addAction(redoAct);
  editMenu->addSeparator();
  editMenu->addAction(cutAct);
  editMenu->addAction(copyAct);
  editMenu->addAction(pasteAct);
  editMenu->addAction(indentAct);
  editMenu->addAction(unindentAct);
  editMenu->addSeparator();
  editMenu->addAction(indentAct);
  editMenu->addAction(unindentAct);
  editMenu->addSeparator();
  editMenu->addAction(findAct);
  editMenu->addAction(replaceAct);
  editMenu->addSeparator();
  editMenu->addAction(gotoAct);
  editMenu->addAction(gotoMatchAct);
  editMenu->addSeparator();
  editMenu->addAction(fontAct);

  windowMenu = menuBar()->addMenu(tr("&Window"));
  updateWindowMenu();
  connect(windowMenu, SIGNAL(aboutToShow()), this, SLOT(updateWindowMenu()));
  menuBar()->addSeparator();

  viewMenu = menuBar()->addMenu(tr("&View"));

  runMenu = menuBar()->addMenu(tr("&Run"));
  runMenu->addAction(runCslcAct);
  runMenu->addAction(runoptCslc);
  runMenu->addAction(stopCslcAct);

  helpMenu = menuBar()->addMenu(tr("&Help"));
  helpMenu->addAction(aboutAct);
  helpMenu->addAction(aboutQtAct);
}

// this function creates the tool bars
void MainWindow::createToolBars() {
  fileToolBar = addToolBar(tr("File"));
  fileToolBar->addAction(newAct);
  fileToolBar->addAction(openAct);
  fileToolBar->addAction(saveAct);
  fileToolBar->addAction(saveAsAct);
  fileToolBar->addAction(printAct);
  fileToolBar->addAction(printPdfAct);

  editToolBar = addToolBar(tr("Edit"));
  editToolBar->addAction(undoAct);
  editToolBar->addAction(redoAct);
  editToolBar->addAction(cutAct);
  editToolBar->addAction(copyAct);
  editToolBar->addAction(pasteAct);
  editToolBar->addAction(indentAct);
  editToolBar->addAction(unindentAct);
  editToolBar->addAction(findAct);
  editToolBar->addAction(replaceAct);
  editToolBar->addAction(gotoAct);
  editToolBar->addAction(gotoMatchAct);
  editToolBar->addAction(fontAct);

  runToolBar = addToolBar(tr("Run"));
  runToolBar->addAction(runoptCslc);
  runToolBar->addAction(runCslcAct);
  runToolBar->addAction(stopCslcAct);
}

// this function creates the status bar
void MainWindow::createStatusBar() {
  statusBar()->showMessage(tr("Ready"));
}

// this function reads the setings for the IDE
void MainWindow::readSettings() {
  QSettings settings("CSLC", "IDE Interface");
  QPoint pos = settings.value("pos", QPoint(200, 200)).toPoint();
  QSize size = settings.value("size", QSize(400, 400)).toSize();
  m_workingDirectory = settings.value("m_workingDirectory").toString();
  move(pos);
  resize(size);
}

// this function writes the setting for the IDE
void MainWindow::writeSettings() {
  QSettings settings("CSLC", "IDE Interface");
  settings.setValue("pos", pos());
  settings.setValue("size", size());
  settings.setValue("m_workingDirectory", m_workingDirectory);
}

// this function returns the active child window
MainChild *MainWindow::activeMainChild() {
  return qobject_cast<MainChild *> (workspace->activeWindow());
}

// this function returns a pointer to the window which contains the specified fileName
MainChild *MainWindow::findMainChild(const QString &fileName) {
  QString canonicalFilePath = QFileInfo(fileName).canonicalFilePath();

  foreach(QWidget *window, workspace->windowList()) {
    MainChild *mainChild = qobject_cast<MainChild *> (window);
    if (mainChild->currentFile() == canonicalFilePath) {
      //mainChild->setCursorChanged();
      return mainChild;
    }
  }
  return 0;
}

// this function revers the layout direction of the menus
void MainWindow::switchLayoutDirection() {
  if (layoutDirection() == Qt::LeftToRight)
    qApp->setLayoutDirection(Qt::RightToLeft);
  else
    qApp->setLayoutDirection(Qt::LeftToRight);
}

// this function updates the list of the recently opened files
void MainWindow::updateRecentFileActions() {
  QSettings settings("Trolltech", "");
  QStringList files = settings.value("recentFileList").toStringList();
  MainChild *child = NULL;
  int numRecentFiles = qMin(files.size(), (int)MaxRecentFiles);

  for (int i = 0; i < numRecentFiles; ++i) {
    QString text = tr("&%1 %2").arg(i + 1).arg(child->strippedName(files[i]));
    recentFileActs[i]->setText(text);
    recentFileActs[i]->setData(files[i]);
    recentFileActs[i]->setVisible(true);
  }
  for (int j = numRecentFiles; j < MaxRecentFiles; ++j)
    recentFileActs[j]->setVisible(false);

  separatorAct->setVisible(numRecentFiles > 0);
}
