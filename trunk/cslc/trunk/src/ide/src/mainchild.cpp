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

#include <iostream>
#include "mainchild.h"
#include "mainwindow.h"
#include "printpreview.h"

using namespace std;

// this class contains every child window inside the main IDE window
// the constructor initializes the properties and signals for each window
MainChild::MainChild(MainWindow *mainParent, QWidget *parent) : QTextEdit(parent), c(0), fm(QFont("Monospace", 10)) {
  mWindow = mainParent;
  newFile();
  setAttribute(Qt::WA_DeleteOnClose);
  isUntitled = true;
  document()->setDefaultFont(QFont("Monospace", 10));
  m_currentLineColour = QColor(215, 252, 255);

  m_matchingColor = Qt::red;
  setAcceptRichText(false);
  m_lineNumbers = NULL;
  m_insertMode = false;

  proc = new QProcess(this);
  //connect(proc, SIGNAL(finished(int , QProcess::ExitStatus)), this, SLOT(readFromStdout()));
  connect(mWindow, SIGNAL(stopCslc()), this, SLOT(slotStopCslc()));

  createStatusBar();
  setCursorChanged();
  connect(this, SIGNAL(cursorPositionChanged()), this, SLOT(setCursorChanged()));

  setTabStopWidth(fm.width(" ") * mWindow->tools->getTabSize());
  updateLineNumbers(mWindow->getLineNumbers());
  setWordWrapMode(mWindow->getWordWrap());
}

// this function enable/disable the word wrapping mode
void MainChild::setWordWrapMode(bool mode) {
    setLineWrapMode(mode ? QTextEdit::WidgetWidth : QTextEdit::NoWrap);
}

// this function enable/disable the line numbering by calling the setLineNumbers function
void MainChild::updateLineNumbers(bool activated) {
    setLineNumbers(activated ? new LineNumbers(this) : NULL);
}

// this function sets up the font for the current window
void MainChild::changeFont(QFont font) {
  setFont(font);
}

// this function enable/disable the line numbering for windows
void MainChild::setLineNumbers(LineNumbers* g) {
  if (g == m_lineNumbers) {
    return;
  }
  if (m_lineNumbers) {
     delete m_lineNumbers;
     //m_lineNumbers = NULL; // for debug purposes
  }
  m_lineNumbers = g;
  if (m_lineNumbers) {
    connect(m_lineNumbers, SIGNAL(digitNumbersChanged()), this, SLOT(slotAdjustSize()));
    setViewportMargins(m_lineNumbers->width(), 0, 0, 0);
    if (!m_lineNumbers->isVisible()) {
      m_lineNumbers->show();
    }
  } else {
    setViewportMargins(0, 0, 0, 0);
  }
}

// this function is automatically called the the lineNumber size is changing
void MainChild::slotAdjustSize() {
  int marginNumerotation = m_lineNumbers ? m_lineNumbers->width() : 0;
  setViewportMargins(marginNumerotation, 0, 0, 0);
}

// the destructor cleans up the lineNumbers and highlighter pointers
MainChild::~MainChild() {
  delete m_lineNumbers;
  if (!isUntitled && (isFileType("csl") || isFileType("cpp") || isFileType("cc") || isFileType("h"))) {
    delete highlighter;
    delete completer;
  }
}

// this function is called when the stop execution button is pressed
void MainChild::slotStopCslc() {
  //proc->kill();
  //cout << "Cslc stopped" << endl;
}

// this function creates the printPreview object and displays it
void MainChild::printPreview() {
  PrintPreview *preview = new PrintPreview(document(), this);
  preview->setWindowModality(Qt::WindowModal);
  preview->setAttribute(Qt::WA_DeleteOnClose);
  preview->show();
}

// this function creates the status bar at the bottom of the main window
void MainChild::createStatusBar() {
  mWindow->statusBar()->showMessage(tr("Ready"));
}

// this function returns the text cursor position for the current line
QTextCursor MainChild::getTextCursorForLine(long line) const { // line is 1 based (not 0 based)
  long count = 1;
  QTextBlock b;
  for (b = document()->begin(); count < line; b = b.next(), ++count);
  return QTextCursor(b);
}

// this function returns the line number for the current cursor position
long MainChild::lineNumber(QTextCursor cursor) { // line is 1 based (not 0 based)
  return cursor.blockNumber() + 1;
}

// this function returns the current line number
long MainChild::currentLineNumber() { // line is 1 based (not 0 based)
  return textCursor().blockNumber() + 1;
}

// this function returns the total number of lines in the current window
long MainChild::linesCount() {
  return document()->blockCount();
}

// this function calls the gotoLine widget
void MainChild::gotoLine(long line, long column) { // line is 1 based (not 0 based)
  setTextCursor(getTextCursorForLine(line));
  QTextCursor c = textCursor();
  c.movePosition(QTextCursor::Right, QTextCursor::MoveAnchor, column - 1);
  setTextCursor(c);
  ensureCursorVisible();
  setFocus(Qt::OtherFocusReason);
}

// this function tests if the file given as a function argument, exists and is readable
bool MainChild::fileExists(const QString &fileName) {
  QFile file(fileName);
  return (!file.open(QFile::ReadOnly | QFile::Text)) ? false : true;
}

// this function adds the parameters/handlers for a new window
void MainChild::newFile() {
  static int sequenceNumber = 1;
  isUntitled = true;
  curFile = tr("untitled%1").arg(sequenceNumber++);
  setWindowTitle(curFile + "[*]");
  connect(document(), SIGNAL(contentsChanged()), this, SLOT(documentWasModified()));
}

// this function is checking the read permissions for the specified file
bool MainChild:: checkFile(const QString &fileName) {
  QFileInfo file(fileName);
  if (!file.exists()) {
    QMessageBox::information(this, tr("Info"),
                             tr("Error opening CSLC Tool, executable not found ! Please check CSLC path from options menu."), QMessageBox::Ok);
    return false;
  }
  if (!file.isReadable()) {
    QMessageBox::warning(this, tr("CSCL IDE"), tr("Cannot read file %1 !").arg(fileName));
    return false;
  }
  else if (!file.isExecutable()) {
    QMessageBox::information(this, tr("Info"),
                             tr("Error: CSLC Tool is not executable! Please check permissions."), QMessageBox::Ok);
    return false;
  }
  return true;
}

// this function is opening the file specified as argument and is setting the highlighting dictionary depending of it's type
bool MainChild::loadFile(const QString &fileName) {
  QFile file(fileName);
  if (!file.open(QFile::ReadOnly | QFile::Text)) {
    QMessageBox::warning(this, tr("CSCL IDE"), tr("Cannot read file %1:\n%2.").arg(fileName).arg(file.errorString()));
    return false;
  }

  QTextStream in(&file);
  QApplication::setOverrideCursor(Qt::WaitCursor);
  setPlainText(in.readAll());
  QApplication::restoreOverrideCursor();
  setCurrentFile(fileName);

  connect(document(), SIGNAL(contentsChanged()), this, SLOT(documentWasModified()));
  QString fileType = (isFileType("csl")) ? "csl" : (isFileType("v")) ? "v"
                     : (isFileType("cpp") || isFileType("cc") || isFileType("h")) ? "cpp" : "";
  highlighter = new Highlighter(mWindow, document(), fileType);

  completer = new QCompleter(this);
  completer->setModel(modelFromFile());
  completer->setModelSorting(QCompleter::CaseInsensitivelySortedModel);
  completer->setCaseSensitivity(Qt::CaseInsensitive);
  setCompleter(completer);

  if (m_lineNumbers)
    m_lineNumbers->setDigitNumbers(QString::number(linesCount()).length());
  if (mWindow->tools->tileAutoSel()) {
    mWindow->workspace->tile();
  }
  return true;
}

// this function selects the file type to take the synthax highlight model from
QAbstractItemModel *MainChild::modelFromFile() {
  QString fileName = "";
  if (isFileType("csl")) {
    fileName = ":/lang/csl_list.txt";
  }
  if (isFileType("v") || isFileType("vh")) {
    fileName = ":/lang/verilog_list.txt";
  }
  if (isFileType("cpp") || isFileType("cc") || isFileType("h")) {
    fileName = ":/lang/cpp_list.txt";
  }
  QFile file(fileName);
  if (!file.open(QFile::ReadOnly))
    return new QStringListModel(completer);

  QApplication::setOverrideCursor(QCursor(Qt::WaitCursor));
  QStringList words;

  while (!file.atEnd()) {
    QByteArray line = file.readLine();
    if (!line.isEmpty())
      words << line.trimmed();
  }
  QApplication::restoreOverrideCursor();
  return new QStringListModel(words, completer);
}

// this function is called when the IDE is saving the current file
bool MainChild::save() {
  if (isUntitled) {
    bool ret = saveAs();
    if (ret) {
      QString fileType;
      if (isFileType("csl")) {
        fileType = "csl";
      } else if (isFileType("cpp") || isFileType("cc") || isFileType("h")) {
        fileType = "cpp";
      }
      highlighter = new Highlighter(mWindow, document(), fileType);
    }
    return ret;
  } else
    return saveFile(curFile);
}

// this function is saving a file with a different name which is specified by using getSaveFileName function
bool MainChild::saveAs() {
  QString fileName = QFileDialog::getSaveFileName(this, tr("Save As"), mWindow->getWorkingDirectory(),
                     tr("CSL File(*.csl);;C++ File (*.cpp *.cc *.h);;Text File (*.txt);;All Files (*.*)"));
  if (fileName.isEmpty()) {
    return false;
  }
  else if (QFileInfo(fileName).suffix().isEmpty()) {
    fileName.append(".csl");
  }
  return saveFile(fileName);
}

// this function is writing the content of the current window to the specified file
bool MainChild::saveFile(const QString &fileName) {
  QFile file(fileName);
  if (!file.open(QFile::WriteOnly | QFile::Text)) {
    QMessageBox::warning(this, tr("Main"), tr("Cannot write file %1:\n%2.").arg(fileName).arg(file.errorString()));
    return false;
  }

  QTextStream out(&file);
  QApplication::setOverrideCursor(Qt::WaitCursor);
  out << toPlainText();
  QApplication::restoreOverrideCursor();

  setCurrentFile(fileName);
  return true;
}

// this function is saving the fileName to the specified output location
bool MainChild::saveFile(const QString &fileName, QString &output) {
  QFile file(fileName);
  if (!file.open(QFile::WriteOnly | QFile::Text)) {
    QMessageBox::warning(this, tr("Main"), tr("Cannot write file %1:\n%2.").arg(fileName).arg(file.errorString()));
    return false;
  }

  QTextStream out(&file);
  out << output;
  return true;
}

// this function returns true if the filename matches the specified extension
bool MainChild::isFileType(QString ext) {
  QStringList extList = curFile.split(".");
  QString extVal = extList.takeLast();
  return extVal == ext;
}

//this function is launching the CSLC tool as a background process
bool MainChild::launch() {
  bool launch = false;
  if (!isFileType("csl")) {
    return false;
  }
  if (isUntitled) {
    if (save()) {
      launch = true;
    }
  } else {
    if (maybeSave()) {
      launch = true;
    }
  }
  if (launch) {
    TreeModel model("");
    mWindow->childTreeWind->setModel(&model);
    QString cmd = mWindow->tools->cslcName();
    QString argStr = mWindow->tools->argsName();
    QStringList args;
    args << "ide";
    args << currentFile();
    if (!argStr.isEmpty()) {
      if (argStr.contains(" ", Qt::CaseInsensitive)) {
        args << argStr.split(" ");
      } else {
        args << argStr;
      }
    }
    if (checkFile(cmd)) {
      /*proc->setWorkingDirectory(mWindow->getWorkingDirectory());
      proc->start(cmd, args);*/

      int argc = args.size();
      char **argvar = new char*[argc];
      for (int i = 0; i < argc; ++i) {
        argvar[i] = strdup(const_cast <char*> (qPrintable(args[i])));
      }

// FIX      NSCslc::RefCSLcMain compiler = NSCslc::CSLcMain::getCompilerInstance(&std::cout);


      // FIX DEP   cslc->cslToVerilog(cslc->getInputFiles());
      //cslc->getCslParser();
   // FIX DEP   showInstanceTree(cslc);

      delete [] argvar;
    }
  }
  readFromStdout();
  return true;
}

/*
// TODO :: FIXME DEP 2010-01-15

// this function builds the Instance Tree
void MainChild::showInstanceTree(NSCslc::Cslc *cslc) {
  // FIX DEP NSCInstTree::RefCInstTreeNode instTreeRoot = cslc->getCslParser().getInstTreeRoot();
// FIX DEP  if (!instTreeRoot.get()) {
// FIX DEP    cout << "Warning: Instance Tree is not present ! IT will not be displayed !" << endl;
 // FIX DEP   return;
  // FIX DEP}
 // FIX DEP mWindow->childTreeWind->build(instTreeRoot);
}
*/

// this function is changing the file extension with the specified extension as a function argument
QString MainChild::fileChangeExtension(QString ext) {
  QStringList fileList = curFile.split(".");
  fileList.takeLast();
  fileList << ext;
  return fileList.join(".");
}

// this function opens a child file inside the mainWindow
void MainChild::openFile(QString file) {
    MainChild *existing = mWindow->findMainChild(file);
    if (existing) {
      mWindow->workspace->setActiveWindow(existing);
      mWindow->activeMainChild()->loadFile(file);
    } else {
      mWindow->open(file);
    }
}

// this function is reading the CSLC tool output message and is converting it into a results list
// the function counts and displays the no. of warn/errors and points to the location where they are located into the source code
void MainChild::readFromStdout() {
  QString dotFile = fileChangeExtension("dot");
  QString logFile = fileChangeExtension("log");
  QString verilogFile = fileChangeExtension("v");
  QString output = proc->readAll();
  //QProcess::pid();
  //QByteArray test = proc->readAll();
  //saveFile(logFile, output);

  //cout << "done: " << output.size() << "|" << proc->pid() << endl;
  //exit(0);

  nrErrors = 0;
  nrWarnings = 0;

  // temporary block. this should be deleted
  if (!nrErrors && fileExists(dotFile) && mWindow->tools->showDot()) {
    openFile(dotFile);
  }
  if (!nrErrors && fileExists(verilogFile) && mWindow->tools->showVerilog()) {
    openFile(verilogFile);
  }

  if (mWindow->tools->tileAutoSel()) {
    mWindow->workspace->tile();
  }
  return;
  // delete until here

  QListWidgetItem *item = 0;
  QListWidget *logList = mWindow->logList;
  logList->clear();
  foreach(QString message, output.split("\n")) {
    if (!message.isEmpty()) {
      message.remove("\r");
      logList->addItem(message);
      item = logList->item(logList->count() - 1);
      if (message.toLower().contains("error:")) {
        item->setTextColor(Qt::red);
        ++nrErrors;
      } else if (message.toLower().contains("warning:")) {
        item->setTextColor(Qt::blue);
        ++nrWarnings;
      }
    }
  }

  if (!nrErrors && fileExists(dotFile) && mWindow->tools->showDot()) {
    openFile(dotFile);
  }
  if (!nrErrors && fileExists(verilogFile) && mWindow->tools->showVerilog()) {
    openFile(verilogFile);
  }

  if (mWindow->tools->tileAutoSel()) {
    mWindow->workspace->tile();
  }

  if (!nrErrors && !nrWarnings) {
    //showInstanceTree(NSCslc::Cslc cslc);
    logList->addItem("---------- Cslc successfully finished! ----------");
    item = logList->item(logList->count() - 1);
    item->setTextColor(Qt::darkGreen);
  } else {
    QString successMessage;
    QTextStream(&successMessage) << "---------- Cslc finished with " << nrErrors << " errors and "
    << nrWarnings << " warnings! ----------";
    logList->addItem(successMessage);
    item = logList->item(logList->count() - 1);
    item->setTextColor(Qt::darkRed);
  }
}

// this function is printing the contents of the current file
bool MainChild::print() {
#ifndef QT_NO_PRINTER
  bool printed = false;
  QPrinter printer(QPrinter::HighResolution);
  printer.setFullPage(true);
  QPrintDialog *dlg = new QPrintDialog(&printer, this);
  dlg->setWindowTitle(tr("Print Document"));
  if (dlg->exec() == QDialog::Accepted) {
    document()->print(&printer);
    printed = true;
  }
  delete dlg;
  return printed;
#endif
}

// this function exports the current file as a pdf
bool MainChild::printPdf() {
#ifndef QT_NO_PRINTER
  bool printed = false;
  QString fileName = QFileDialog::getSaveFileName(this, "Export PDF", QString(), "*.pdf");
  if (!fileName.isEmpty()) {
    if (QFileInfo(fileName).suffix().isEmpty()) {
      fileName.append(".pdf");
    }
    QPrinter printer(QPrinter::HighResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName(fileName);
    document()->print(&printer);
    printed = true;
  }
  return printed;
#endif
}

//this function returns the current file name without the fulll path of that file
QString MainChild::userFriendlyCurrentFile() {
  return strippedName(curFile);
}

// this function handles the close events
void MainChild::closeEvent(QCloseEvent *event) {
  if (maybeSave()) {
    event->accept();
  } else {
    event->ignore();
  }
}

// this function returns true if the current file has been modified
void MainChild::documentWasModified() {
  setWindowModified(document()->isModified());
}

// this function checks if the current file needs to be saved
bool MainChild::maybeSave() {
  if (document()->isModified()) {
    QMessageBox::StandardButton ret;
    ret = QMessageBox::warning(this, tr("CSLC IDE"), tr("'%1' has been modified.\nDo you want to save your changes?")
                               .arg(userFriendlyCurrentFile()), QMessageBox::Save | QMessageBox::Discard | QMessageBox::Cancel);
    if (ret == QMessageBox::Save) {
      return save();
    } else if (ret == QMessageBox::Cancel) {
      return false;
    }
  }
  return true;
}

// this function sets the current file properties
void MainChild::setCurrentFile(const QString &fileName) {
  curFile = QFileInfo(fileName).canonicalFilePath();
  isUntitled = false;
  document()->setModified(false);
  setWindowModified(false);
  setWindowTitle(userFriendlyCurrentFile() + "[*]");
  QSettings settings("Trolltech", "");
  QStringList files = settings.value("recentFileList").toStringList();
  files.removeAll(fileName);
  files.prepend(fileName);
  while (files.size() > mWindow->MaxRecentFiles) {
    files.removeLast();
  }
  settings.setValue("recentFileList", files);

  foreach(QWidget *widget, QApplication::topLevelWidgets()) {
    MainWindow *mainWin = qobject_cast<MainWindow *>(widget);
    if (mainWin) {
      mainWin->updateRecentFileActions();
    }
  }
}

// this function returns the stripped name of the specified file
QString MainChild::strippedName(const QString &fullFileName) {
  return QFileInfo(fullFileName).fileName();
}

// this function enable/disable the autocompleter
void MainChild::setCompleter(QCompleter *completer) {
  if (c) {
    QObject::disconnect(c, 0, this, 0);
  }
  c = completer;

  if (!c) {} else {
    c->setWidget(this);
    c->setCompletionMode(QCompleter::PopupCompletion);
    c->setCaseSensitivity(Qt::CaseInsensitive);
    QObject::connect(completer, SIGNAL(activated(const QString&)), this, SLOT(insertCompletion(const QString&)));
  }
}

// this function is automatically called by the completer and defines the completion window position
void MainChild::insertCompletion(const QString& completion) {
  QTextCursor tc = textCursor();
  int extra = completion.length() - c->completionPrefix().length();
  tc.movePosition(QTextCursor::Left);
  tc.movePosition(QTextCursor::EndOfWord);
  tc.insertText(completion.right(extra));
  setTextCursor(tc);
}

// this function return the fist match of the completion text under cursor
QString MainChild::textUnderCursor() const {
  QTextCursor tc = textCursor();
  tc.select(QTextCursor::WordUnderCursor);
  return tc.selectedText();
}

// this function is handling the key press event for specific cases
void MainChild::keyPressEvent(QKeyEvent *e) {
  bool eventProcessed = false;
  bool ret = false;
  switch (e->key()) {
    case (Qt::Key_Tab):
            slotIndent(!(e->modifiers() == Qt::ControlModifier));
      ret = true;
      break;
    case (Qt::Key_Backtab):
            slotUnindent();
      ret = true;
      break;
    case (Qt::Key_Insert):
            setOverwriteMode(m_insertMode = !m_insertMode);
      break;
    case (Qt::Key_Enter):
          case (Qt::Key_Return):
              eventProcessed = true;
      if (mWindow->getAutoIndent()) {
       if (!c || (c && c->popup()->isHidden())) {
         QTextEdit::keyPressEvent(e);
         autoIndent();
       }
      } else {
        QTextEdit::keyPressEvent(e);
      }
      break;
    case Qt::Key_Delete:
    case Qt::Key_Backspace:
      if (m_matchingBegin != -1 && m_matchingEnd != -1) {
        clearMatch();
        QTextEdit::keyPressEvent(e);
        eventProcessed = true;
        match();
      }
      break;
    case ('{'):
    case ('}'):
          if (mWindow->getAutoIndent()) {
            autoUnindent();
          }
          if (mWindow->getBrackets() && e->key() == '{') {
            QTextEdit::keyPressEvent(e);
            eventProcessed = true;
            autoBrackets();
          }
      break;
    default:
      break;
  }

  if (!ret) {
    if (c && c->popup()->isVisible()) {
      switch (e->key()) {
        case (Qt::Key_Return):
              case (Qt::Key_Enter):
              case (Qt::Key_Escape): case (Qt::Key_Tab):
                    case (Qt::Key_Backtab):
                        e->ignore();
          ret = true;
        default:
          break;
      }
    }

    if (!ret) {
      bool isShortcut = ((e->modifiers() & Qt::ControlModifier) && e->key() == Qt::Key_E); // CTRL+E
      if ((!c || !isShortcut) && !eventProcessed) { // dont process the shortcut when we have a completer
        QTextEdit::keyPressEvent(e);
      }
      const bool ctrlOrShift = e->modifiers() & (Qt::ControlModifier | Qt::ShiftModifier);
      if (!c || (ctrlOrShift && e->text().isEmpty())) {
        ret = true;
      }
      if (!ret) {
        static QString eow("~!@#$%^&*()_+{}|:\"<>?,./;'[]\\-="); // end of word
        bool hasModifier = (e->modifiers() != Qt::NoModifier) && !ctrlOrShift;
        QString completionPrefix = textUnderCursor();

        if (!isShortcut && (hasModifier || e->text().isEmpty() || completionPrefix.length() < 3
                            || eow.contains(e->text().right(1)))) {
          c->popup()->hide();
          ret = true;
        }
        if (!ret) {
          if (completionPrefix != c->completionPrefix()) {
            c->setCompletionPrefix(completionPrefix);
            c->popup()->setCurrentIndex(c->completionModel()->index(0, 0));
          }
          QRect cr = cursorRect();
          cr.setWidth(c->popup()->sizeHintForColumn(0)
                      + c->popup()->verticalScrollBar()->sizeHint().width());
          c->complete(cr); // popup it up!
        }
      }
    }
  }
}

// this function is handling the auto Indentation
void MainChild::autoIndent() {
  QTextBlock blocAIndenter;
  QTextBlock b = textCursor().block();
  if (b.previous().isValid() && !b.previous().text().isEmpty()) {
    blocAIndenter = b;
  } else {
    return;
  }
  QTextBlock blocBefore = blocAIndenter.previous();
  if (!blocBefore.isValid()) {
    return;
  }
  QString simple = blocBefore.text().simplified();
  int nbSpaces = tabStopWidth() / fm.width(" ");
  QString blanc;
  for (int i = 0; i < blocBefore.text().length(); i++) {
    if (blocBefore.text().at(i) == ' ' || blocBefore.text().at(i) == '\t') {
      QString s = blocBefore.text().at(i);
      if (mWindow->getTabSpaces()) {
        QString spaces;
        for (int i = 0; i < nbSpaces; i++) {
          spaces += " ";
        }
        s.replace("\t", spaces);
      }
      blanc += s;
    } else
      break;
  }
  if (simple.simplified().length() && ((simple.contains("(") && simple.contains(")")
                                        && QString("if:while:do:switch:foreach").contains(simple.section("(", 0, 0).simplified()))
                                       || QString("else:case:default").indexOf(simple.simplified()) == 0
                                       || simple.simplified().at(0) == '{' || simple.simplified().at(simple.simplified().length() - 1) == '{')) {
    if (mWindow->getTabSpaces()) {
      for (int i = 0; i < nbSpaces; i++)
        blanc +=  " ";
    } else
      blanc += "\t";
  }
  textCursor().insertText(blanc);
  return;
}

// this function is taking care of the auto Unindent
void MainChild::autoUnindent() {
  QTextBlock b = textCursor().block();
  if (!b.previous().isValid() || b.previous().text().isEmpty()) {
    return;
  }
  QString caract = b.text().simplified();
  if (caract != "{" && caract != "}") {
    return;
  }
  QTextBlock blocBefore = b.previous();
  if (!blocBefore.isValid()) {
    return;
  }
  QString blanc;
  for (int i = 0; i < blocBefore.text().length(); i++) {
    if (blocBefore.text().at(i) == ' ' || blocBefore.text().at(i) == '\t') {
      blanc += blocBefore.text().at(i);
    } else {
        break;
      }
  }
  if (blanc.length() && caract == "}" && blocBefore.text().simplified() != "{") {
    if (mWindow->getTabSpaces()) {
      int nbSpaces = tabStopWidth() / fm.width(" ");
      for (int i = 0; i < nbSpaces; i++)
        if (blanc.at(0) == ' ') {
          blanc.remove(0, 1);
        }
    } else
      blanc.remove(0, 1);
  }
  QTextCursor cursor = textCursor();
  cursor.movePosition(QTextCursor::StartOfLine, QTextCursor::MoveAnchor);
  cursor.movePosition(QTextCursor::EndOfLine, QTextCursor::KeepAnchor);
  if (currentLineNumber() < linesCount()) cursor.removeSelectedText();
  cursor.insertText(blanc + caract);
  setTextCursor(cursor);
}

// this function sets the current line color
void MainChild::setCurrentLineColor(QColor c) {
  if (c != m_currentLineColour) {
    m_currentLineColour = c;
    viewport()->update();
  }
}

// this function is automatically called by Qt and takes care of the paint Events
void MainChild::paintEvent(QPaintEvent *event) {
  QPainter painter(viewport());
  if (m_currentLineColour.isValid()) {
    QRect r = cursorRect();
    r.setX(0);
    r.setWidth(viewport()->width());
    painter.fillRect(r, QBrush(m_currentLineColour));
  }
  painter.end();
  QTextEdit::paintEvent(event);
  if (mWindow->getMatch() && m_matchingBegin != -1 && m_matchingEnd != -1) {
    painter.begin(viewport());
    QFont f(document()->defaultFont());
    f.setBold(true);
    painter.setFont(f);
    painter.setPen(m_matchingColor);
    QTextCursor cursor = textCursor();
    cursor.setPosition(m_matchingBegin + 1, QTextCursor::MoveAnchor);
    QRect r = cursorRect(cursor);
    painter.drawText(r.x() - 2, r.y(), r.width(), r.height(), Qt::AlignLeft | Qt::AlignVCenter, m_plainText.at(m_matchingBegin));
    cursor.setPosition(m_matchingEnd + 1, QTextCursor::MoveAnchor);
    r = cursorRect(cursor);
    painter.drawText(r.x() - 2, r.y(), r.width(), r.height(), Qt::AlignLeft | Qt::AlignVCenter, m_plainText.at(m_matchingEnd));
    painter.end();
  }
}

// this function displays the current line and column number
void MainChild::setCursorChanged() {
  //QMessageBox::information(this, tr("Info"), tr("cursor ").arg(userFriendlyCurrentFile()), QMessageBox::Ok);
  //mWindow->statusBar()->showMessage(tr("Line:%1 Column:%2").arg(lineNumber(textCursor())).arg(textCursor().columnNumber()));
  mWindow->statusBar()->showMessage(tr("Line:%1 Column:%2").arg(textCursor().blockNumber()+1).arg(textCursor().columnNumber()));

  if (m_currentLineColour.isValid()) {
    viewport()->update();
  }
  if (mWindow->getMatch()) {
    match();
  }
}

// this function inserts a specified number of spaces or Tab
void MainChild::insertSpaces(QTextCursor &c, int &nbSpaces) {
  if (mWindow->getTabSpaces()) {
    for (int i = 0; i < nbSpaces; i++)
      c.insertText(" ");
  } else
    c.insertText("\t");
}

// this funcion deletes a specified number of spaces or Tab
void MainChild::deleteSpaces(QTextCursor &c, QTextBlock &bloc, int &nbSpaces) {
  if (bloc.text().count() && bloc.text().at(0) == '\t') {
    c.deleteChar();
  } else {
    for (int i = 0; i < nbSpaces; i++) {
      if (bloc.text().count() && bloc.text().at(0) == ' ') {
        c.deleteChar();
      } else break;
    }
  }
}

// this function handles the auto Indent and Unindent
void MainChild::slotIndent(bool indenter) {
  int nbSpaces = tabStopWidth() / fm.width(" ");
  QTextCursor curCursor = textCursor();
  QTextCursor c = textCursor();
  QTextBlock bloc;
  if (indenter && c.selectedText().isEmpty()) {
    insertSpaces(c, nbSpaces);
  } else {
    int start = c.selectionStart();
    int end = c.selectionEnd();
    c.clearSelection();

    c.setPosition(start, QTextCursor::MoveAnchor);
    QTextBlock blocStart = c.block();

    c.setPosition(end, QTextCursor::MoveAnchor);
    if (curCursor.columnNumber() && start != end) c.movePosition(QTextCursor::Down, QTextCursor::MoveAnchor);
    QTextBlock blocEnd = c.block();
    if (start == end) {
      bloc = c.block();
      if (!c.columnNumber()) {
        deleteSpaces(c, bloc, nbSpaces);
      } else {
        if (bloc.text().at(c.columnNumber() - 1) == '\t') {
          c.deletePreviousChar();
        } else if (!c.atBlockEnd() && bloc.text().at(c.columnNumber()) == '\t') {
          c.deleteChar();
        } else {
          for (int i = 0; i < nbSpaces; i++) {
            if (c.columnNumber() && bloc.text().at(c.columnNumber() - 1) == ' ') {
              c.deletePreviousChar();
            } else if (!c.atBlockEnd() && bloc.text().at(c.columnNumber()) == ' ') {
              c.deleteChar();
            } else break;
          }
        }
      }
      setTextCursor(c);
    } else {
      int lineStart = 1;
      for (QTextBlock block = document()->begin(); block.isValid() && block != blocStart; block = block.next(), lineStart++);
      int lineEnd = lineStart - 1;
      bloc = blocStart;
      do {
        c.setPosition(bloc.position(), QTextCursor::MoveAnchor);
        if (!indenter) {
          deleteSpaces(c, bloc, nbSpaces);
        } else {
          insertSpaces(c, nbSpaces);
        }
        setTextCursor(c);
        lineEnd++;
        bloc = bloc.next();
      } while (bloc.isValid() && bloc != blocEnd);
      selectLines(lineStart, lineEnd);
    }
  }
}

// this function is calling the auto Unindent with slotIndent(false)
void MainChild::slotUnindent() {
  slotIndent(false);
}

// this function selects the lines between the start and end position
void MainChild::selectLines(int start, int end) {
  if (start > end) {
    qSwap(start, end);
  }
  QTextCursor c = textCursor();
  c.movePosition(QTextCursor::Start);
  c.movePosition(QTextCursor::Down, QTextCursor::MoveAnchor, start - 1);
  c.movePosition(QTextCursor::Down, QTextCursor::KeepAnchor, end - start + 1);
  setTextCursor(c);
  ensureCursorVisible();
}

// this function automatically inserts brackets
void MainChild::autoBrackets() {
  textCursor().insertText("\n");
  if (mWindow->getAutoIndent()) {
    autoIndent();
  }
  textCursor().insertText("\n}");
  if (mWindow->getAutoIndent()) {
    autoUnindent();
  }
  setTextCursor(getTextCursorForLine(currentLineNumber() - 1));
  QTextCursor cursor = textCursor();
  cursor.movePosition(QTextCursor::EndOfLine);
  setTextCursor(cursor);
}

// this function moves the cursor to the pair of the current highlighted bracket
void MainChild::gotoMatchingBracket() {
  int pos;
  QTextCursor cursor = textCursor();
  if (cursor.position() == m_matchingBegin) {
    pos = m_matchingEnd;
  } else {
      pos = m_matchingBegin;
    }
  if (pos != -1) {
    cursor.setPosition(pos, QTextCursor::MoveAnchor);
    setTextCursor(cursor);
  }
}

// this function calls the Find slot
void MainChild::slotFind(Ui::FindWidget ui, QString ttf, QTextDocument::FindFlags options, bool fromButton) {
  QTextDocument *doc = document();
  QString oldText = ui.editFind->text();
  QTextCursor c = textCursor();
  QPalette p = ui.editFind->palette();
  p.setColor(QPalette::Active, QPalette::Base, Qt::white);

  if (c.hasSelection()) {
    if (fromButton) {
      if (options & QTextDocument::FindBackward) {
        c.setPosition(c.anchor(), QTextCursor::MoveAnchor);
      } else {
        c.setPosition(c.position(), QTextCursor::MoveAnchor);
      }
    }
  }

  QTextCursor newCursor = c;

  if (!ttf.isEmpty()) {
    newCursor = doc->find(ttf, c, options);
    ui.labelWrapped->hide();

    if (newCursor.isNull()) {
      QTextCursor ac(doc);
      ac.movePosition(options & QTextDocument::FindBackward
                      ? QTextCursor::End : QTextCursor::Start);
      newCursor = doc->find(ttf, ac, options);
      if (newCursor.isNull()) {
        p.setColor(QPalette::Active, QPalette::Base, QColor(255, 102, 102));
        newCursor = c;
      } else {
        ui.labelWrapped->show();
      }
    }
  }

  setTextCursor(newCursor);
  ui.editFind->setPalette(p);
}

// this function resets the matching coordinates
void MainChild::clearMatch() {
  m_matchingBegin = -1;
  m_matchingEnd = -1;
}

// this function matches and highlights the {[( characters
void MainChild::match() {
  clearMatch();
  m_plainText = toPlainText();
  if (m_plainText.isEmpty()) {
    return;
  }
  QTextCursor cursor = textCursor();
  int pos = cursor.position();
  QChar car;
  pos = cursor.atEnd() ? pos - 1 : pos;
  car = m_plainText.at(pos);
  bool secondPass = false;
  while (true) {
    if (QString("[({").contains(car) && !inQuotations(pos, m_plainText)) {
      // First match
      m_matchingBegin = pos;
      // Second match
      QChar match = (car == '{') ? '}' : (car == '[') ? ']' : ')';
      int nb = 0;
      for (int i = pos + 1;  i < m_plainText.size(); ++i) {
        if (m_plainText.at(i) == car && !inQuotations(i, m_plainText)) {
          nb++;
        } else if (m_plainText.at(i) == match && !inQuotations(i, m_plainText)) {
          if (nb == 0) {
            m_matchingEnd = i;
            break;
          } else {
            nb--;
          }
        }
      }
      break;
    } else if (QString("])}").contains(car) && !inQuotations(pos, m_plainText)) {
      // First match
      m_matchingEnd = pos;
      // Second match
      QChar match = (car == '}') ? '{' : (car == ']') ? '[' : '(';
      int nb = 0;
      for (int i = pos - 1;  i >= 0; --i) {
        if (m_plainText.at(i) == car && !inQuotations(i, m_plainText)) {
          nb++;
        } else if (m_plainText.at(i) == match && !inQuotations(i, m_plainText)) {
          if (nb == 0) {
            m_matchingBegin = i;
            break;
          } else {
            nb--;
          }
        }
      }
      break;
    } else if (secondPass) {
      break;
    } else {
      secondPass = true;
      --pos;
      if (pos < 0) {
        break;
      }
      car = m_plainText.at(pos);
    }
  }
}

// this function is searching if the special characters {[( are outside the quotes
bool MainChild::inQuotations(int position, QString text) {
  int startQuote = 0, endQuote;
  bool realBegin = false;
  do {
    do {
      startQuote = text.indexOf("\"", startQuote);
      if (startQuote > 0 && (text.at(startQuote - 1) == '\\' || text.at(startQuote - 1) == '\'')) {
        startQuote++;
        realBegin = false;
      } else {
        realBegin = true;
      }
    } while (!realBegin);
    endQuote = -1;
    if (startQuote != -1) {
      endQuote = startQuote + 1;
      bool realEnd = false;
      do {
        endQuote = text.indexOf("\"", endQuote);
        if (endQuote > 0 && text.at(endQuote - 1) == '\\') {
          endQuote++;
          realEnd = false;
        } else {
          realEnd = true;
        }
      } while (!realEnd);
    }
    if (startQuote != -1 && endQuote != -1) {
      if (position > startQuote && position < endQuote) {
        return true;
      }
    }
    startQuote = endQuote + 1;
  } while (startQuote != -1 && endQuote != -1);
  startQuote = 0, endQuote = 0;
  realBegin = false;
  do {
    do {
      startQuote = text.indexOf('\'', startQuote);
      if (startQuote > 0 && (text.at(startQuote - 1) == '\\' || text.at(startQuote - 1) == '\"')) {
        startQuote++;
        realBegin = false;
      } else {
        realBegin = true;
      }
    } while (!realBegin);
    endQuote = -1;
    if (startQuote != -1) {
      endQuote = startQuote + 1;
      bool realEnd = false;
      do {
        endQuote = text.indexOf('\'', endQuote);
        if (endQuote > 0 && (text.at(endQuote - 1) == '\\' || text.at(endQuote - 1) == '\"')) {
          endQuote++;
          realEnd = false;
        } else {
          realEnd = true;
        }
      } while (!realEnd);
    }
    if (startQuote != -1 && endQuote != -1) {
      if (position > startQuote && position < endQuote) {
        return true;
      }
    }
    startQuote = endQuote + 1;
  } while (startQuote != -1 && endQuote != -1);
  return false;
}
