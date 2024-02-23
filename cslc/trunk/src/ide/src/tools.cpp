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

#include <QSettings>
#include <QLibraryInfo>
#include <QProcess>
#include <QMessageBox>
#include <QFileDialog>
#include <QFile>
#include "tools.h"

Tools::Tools(QWidget * parent, Qt::WFlags f) : QDialog(parent, f) {
  QString suffix;
#ifdef Q_OS_WIN32
  suffix = ".exe";
  QChar dirDelimiter = '\\';
#else
  QChar dirDelimiter = '/';
#endif

  setupUi(this);
#ifdef Q_OS_WIN32
  QSettings settings(QDir::homePath() + "/Application Data/qdevelop.ini", QSettings::IniFormat);
#else
  QSettings settings;
#endif
  settings.beginGroup("Options");
#ifdef Q_OS_WIN32
  cslc->setText(settings.value("m_cslcName").toString());
  make->setText(settings.value("m_makeName").toString());
  gdb->setText(settings.value("m_gdbName").toString());
  ctags->setText(settings.value("m_ctagsName").toString());
#else
  cslc->setText(settings.value("m_cslcName", "/usr/bin/cslc").toString());
  make->setText(settings.value("m_makeName", "/usr/bin/make").toString());
  gdb->setText(settings.value("m_gdbName", "/usr/bin/gdb").toString());
  ctags->setText(settings.value("m_ctagsName", "/usr/bin/ctags").toString());
#endif
  args->setText(settings.value("m_argsName", "").toString());
  showDotFile->setChecked(settings.value("m_showDot", "").toBool());
  showVerilogFile->setChecked(settings.value("m_showVerilog", "").toBool());
  tileAuto->setChecked(settings.value("m_tileAuto", "").toBool());
  enableAutoIndent->setChecked(settings.value("m_enableIndent","").toBool());
  enableLineNumbers->setChecked(settings.value("m_enableLineNumbers").toBool());
  enableMatch->setChecked(settings.value("m_match").toBool());
  autoBrackets->setChecked(settings.value("m_brackets").toBool());
  wordWrap->setChecked(settings.value("m_wordWrap").toBool());
  enableTabSpaces->setChecked(settings.value("m_enableTabSpaces").toBool());
  if (tabSize->value() < 2) {
    tabSize->setValue(2);
  } else { 
    tabSize->setValue(settings.value("m_tabSize").toInt());
  }
  settings.endGroup();
}

void Tools::on_cslcLocation_clicked() {
  chooseLocation(cslc);
}

void Tools::on_makeLocation_clicked() {
  chooseLocation(make);
}

void Tools::on_gdbLocation_clicked() {
  chooseLocation(gdb);
}

void Tools::on_ctagsLocation_clicked() {
  chooseLocation(ctags);
}

void Tools::chooseLocation(QLineEdit *dest) {
  QString s = QFileDialog::getOpenFileName(this, tr("Please define the program"), QDir::cleanPath(dest->text()), "*");
  if (!s.isEmpty()) {
    dest->setText(s);
  }
}

int Tools::getTabSize() {
#ifdef Q_OS_WIN32
  QSettings settings(QDir::homePath() + "/Application Data/qdevelop.ini", QSettings::IniFormat);
#else
  QSettings settings;
#endif
  settings.beginGroup("Options");
  int mtabSize=settings.value("m_tabSize").toInt();
  settings.endGroup();
  return mtabSize;
}

void Tools::on_cancelButton_clicked() {
#ifdef Q_OS_WIN32
  QSettings settings(QDir::homePath() + "/Application Data/qdevelop.ini", QSettings::IniFormat);
#else
  QSettings settings;
#endif
  settings.beginGroup("Options");
  cslc->setText(settings.value("m_cslcName").toString());
  make->setText(settings.value("m_makeName").toString());
  gdb->setText(settings.value("m_gdbName").toString());
  ctags->setText(settings.value("m_ctagsName").toString());
  args->setText(settings.value("m_argsName").toString());
  showDotFile->setChecked(settings.value("m_showDot").toBool());
  showVerilogFile->setChecked(settings.value("m_showVerilog").toBool());
  tileAuto->setChecked(settings.value("m_tileAuto").toBool());
  enableAutoIndent->setChecked(settings.value("m_enableIndent").toBool());
  enableLineNumbers->setChecked(settings.value("m_enableLineNumbers").toBool());
  enableMatch->setChecked(settings.value("m_match").toBool());
  autoBrackets->setChecked(settings.value("m_brackets").toBool());
  wordWrap->setChecked(settings.value("m_wordWrap").toBool());
  enableTabSpaces->setChecked(settings.value("m_enableTabSpaces").toBool());
  if (tabSize->value() < 2) {
    tabSize->setValue(2);
  } else { 
    tabSize->setValue(settings.value("m_tabSize").toInt());
  }
  settings.endGroup();
  accept();
}

void Tools::on_okButton_clicked() {
#ifdef Q_OS_WIN32
  QSettings settings(QDir::homePath() + "/Application Data/qdevelop.ini", QSettings::IniFormat);
#else
  QSettings settings;
#endif
  settings.beginGroup("Options");
  settings.setValue("m_cslcName", cslcName());
  settings.setValue("m_makeName", makeName());
  settings.setValue("m_ctagsName", ctagsName());
  settings.setValue("m_argsName", argsName());
  settings.setValue("m_gdbName", gdbName());
  settings.setValue("m_showDot", showDot());
  settings.setValue("m_showVerilog", showVerilog());
  settings.setValue("m_tileAuto", tileAutoSel());
  settings.setValue("m_enableIndent", enAutoIndent());
  settings.setValue("m_enableLineNumbers", enLineNumbers());
  settings.setValue("m_enableTabSpaces", enTabSpaces());
  settings.setValue("m_match", getMatchBox());
  settings.setValue("m_brackets", getBrackets());
  settings.setValue("m_tabSize", setTabWidth());
  settings.setValue("m_wordWrap", getWordWrap());
  settings.endGroup();
  accept();
}
