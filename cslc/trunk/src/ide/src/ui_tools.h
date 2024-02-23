/********************************************************************************
** Form generated from reading ui file 'tools.ui'
**
** Created: Sat Nov 7 09:34:00 2009
**      by: Qt User Interface Compiler version 4.5.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_TOOLS_H
#define UI_TOOLS_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QCheckBox>
#include <QtGui/QDialog>
#include <QtGui/QGridLayout>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QPushButton>
#include <QtGui/QSpinBox>
#include <QtGui/QToolButton>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Tools
{
public:
    QToolButton *makeLocation;
    QLabel *label_8;
    QToolButton *cslcLocation;
    QLabel *label_9;
    QLabel *label_6;
    QToolButton *ctagsLocation;
    QToolButton *gdbLocation;
    QLabel *label_7;
    QWidget *gdbWidget;
    QGridLayout *gridLayout;
    QLineEdit *gdb;
    QLineEdit *args;
    QLineEdit *make;
    QLineEdit *ctags;
    QLineEdit *cslc;
    QLabel *label;
    QLabel *label_5;
    QWidget *layoutWidget;
    QGridLayout *gridLayout1;
    QGridLayout *gridLayout2;
    QSpinBox *tabSize;
    QLabel *label_10;
    QCheckBox *wordWrap;
    QCheckBox *enableAutoIndent;
    QCheckBox *showVerilogFile;
    QCheckBox *showDotFile;
    QCheckBox *tileAuto;
    QHBoxLayout *hboxLayout;
    QPushButton *okButton;
    QPushButton *cancelButton;
    QCheckBox *autoBrackets;
    QCheckBox *enableMatch;
    QCheckBox *enableLineNumbers;
    QCheckBox *enableTabSpaces;

    void setupUi(QDialog *Tools)
    {
        if (Tools->objectName().isEmpty())
            Tools->setObjectName(QString::fromUtf8("Tools"));
        Tools->resize(406, 399);
        makeLocation = new QToolButton(Tools);
        makeLocation->setObjectName(QString::fromUtf8("makeLocation"));
        makeLocation->setGeometry(QRect(375, 72, 26, 29));
        label_8 = new QLabel(Tools);
        label_8->setObjectName(QString::fromUtf8("label_8"));
        label_8->setGeometry(QRect(10, 142, 36, 29));
        cslcLocation = new QToolButton(Tools);
        cslcLocation->setObjectName(QString::fromUtf8("cslcLocation"));
        cslcLocation->setGeometry(QRect(375, 37, 26, 29));
        label_9 = new QLabel(Tools);
        label_9->setObjectName(QString::fromUtf8("label_9"));
        label_9->setGeometry(QRect(10, 180, 36, 29));
        label_6 = new QLabel(Tools);
        label_6->setObjectName(QString::fromUtf8("label_6"));
        label_6->setGeometry(QRect(10, 72, 36, 29));
        ctagsLocation = new QToolButton(Tools);
        ctagsLocation->setObjectName(QString::fromUtf8("ctagsLocation"));
        ctagsLocation->setGeometry(QRect(375, 142, 26, 29));
        gdbLocation = new QToolButton(Tools);
        gdbLocation->setObjectName(QString::fromUtf8("gdbLocation"));
        gdbLocation->setGeometry(QRect(375, 107, 26, 29));
        label_7 = new QLabel(Tools);
        label_7->setObjectName(QString::fromUtf8("label_7"));
        label_7->setGeometry(QRect(10, 107, 36, 29));
        gdbWidget = new QWidget(Tools);
        gdbWidget->setObjectName(QString::fromUtf8("gdbWidget"));
        gdbWidget->setGeometry(QRect(50, 40, 321, 171));
        gridLayout = new QGridLayout(gdbWidget);
#ifndef Q_OS_MAC
        gridLayout->setSpacing(6);
#endif
        gridLayout->setMargin(0);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        gridLayout->setContentsMargins(0, 0, 0, 0);
        gdb = new QLineEdit(gdbWidget);
        gdb->setObjectName(QString::fromUtf8("gdb"));
        gdb->setDragEnabled(true);
        gdb->setReadOnly(false);

        gridLayout->addWidget(gdb, 2, 0, 1, 1);

        args = new QLineEdit(gdbWidget);
        args->setObjectName(QString::fromUtf8("args"));
        args->setDragEnabled(true);
        args->setReadOnly(false);

        gridLayout->addWidget(args, 4, 0, 1, 1);

        make = new QLineEdit(gdbWidget);
        make->setObjectName(QString::fromUtf8("make"));
        make->setDragEnabled(true);
        make->setReadOnly(false);

        gridLayout->addWidget(make, 1, 0, 1, 1);

        ctags = new QLineEdit(gdbWidget);
        ctags->setObjectName(QString::fromUtf8("ctags"));
        ctags->setDragEnabled(true);
        ctags->setReadOnly(false);

        gridLayout->addWidget(ctags, 3, 0, 1, 1);

        cslc = new QLineEdit(gdbWidget);
        cslc->setObjectName(QString::fromUtf8("cslc"));
        cslc->setDragEnabled(true);
        cslc->setReadOnly(false);

        gridLayout->addWidget(cslc, 0, 0, 1, 1);

        label = new QLabel(Tools);
        label->setObjectName(QString::fromUtf8("label"));
        label->setGeometry(QRect(10, 10, 391, 21));
        label_5 = new QLabel(Tools);
        label_5->setObjectName(QString::fromUtf8("label_5"));
        label_5->setGeometry(QRect(10, 37, 36, 29));
        layoutWidget = new QWidget(Tools);
        layoutWidget->setObjectName(QString::fromUtf8("layoutWidget"));
        layoutWidget->setGeometry(QRect(50, 213, 312, 184));
        gridLayout1 = new QGridLayout(layoutWidget);
#ifndef Q_OS_MAC
        gridLayout1->setSpacing(6);
#endif
        gridLayout1->setMargin(0);
        gridLayout1->setObjectName(QString::fromUtf8("gridLayout1"));
        gridLayout1->setContentsMargins(0, 0, 0, 0);
        gridLayout2 = new QGridLayout();
#ifndef Q_OS_MAC
        gridLayout2->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        gridLayout2->setMargin(0);
#endif
        gridLayout2->setObjectName(QString::fromUtf8("gridLayout2"));
        tabSize = new QSpinBox(layoutWidget);
        tabSize->setObjectName(QString::fromUtf8("tabSize"));
        tabSize->setMaximum(16);
        tabSize->setMinimum(2);

        gridLayout2->addWidget(tabSize, 0, 1, 1, 1);

        label_10 = new QLabel(layoutWidget);
        label_10->setObjectName(QString::fromUtf8("label_10"));

        gridLayout2->addWidget(label_10, 0, 0, 1, 1);


        gridLayout1->addLayout(gridLayout2, 4, 1, 1, 1);

        wordWrap = new QCheckBox(layoutWidget);
        wordWrap->setObjectName(QString::fromUtf8("wordWrap"));

        gridLayout1->addWidget(wordWrap, 4, 0, 1, 1);

        enableAutoIndent = new QCheckBox(layoutWidget);
        enableAutoIndent->setObjectName(QString::fromUtf8("enableAutoIndent"));

        gridLayout1->addWidget(enableAutoIndent, 1, 1, 1, 1);

        showVerilogFile = new QCheckBox(layoutWidget);
        showVerilogFile->setObjectName(QString::fromUtf8("showVerilogFile"));

        gridLayout1->addWidget(showVerilogFile, 0, 1, 1, 1);

        showDotFile = new QCheckBox(layoutWidget);
        showDotFile->setObjectName(QString::fromUtf8("showDotFile"));

        gridLayout1->addWidget(showDotFile, 0, 0, 1, 1);

        tileAuto = new QCheckBox(layoutWidget);
        tileAuto->setObjectName(QString::fromUtf8("tileAuto"));

        gridLayout1->addWidget(tileAuto, 1, 0, 1, 1);

        hboxLayout = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout->setSpacing(6);
#endif
        hboxLayout->setMargin(0);
        hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
        okButton = new QPushButton(layoutWidget);
        okButton->setObjectName(QString::fromUtf8("okButton"));

        hboxLayout->addWidget(okButton);

        cancelButton = new QPushButton(layoutWidget);
        cancelButton->setObjectName(QString::fromUtf8("cancelButton"));

        hboxLayout->addWidget(cancelButton);


        gridLayout1->addLayout(hboxLayout, 5, 0, 1, 2);

        autoBrackets = new QCheckBox(layoutWidget);
        autoBrackets->setObjectName(QString::fromUtf8("autoBrackets"));

        gridLayout1->addWidget(autoBrackets, 3, 0, 1, 1);

        enableMatch = new QCheckBox(layoutWidget);
        enableMatch->setObjectName(QString::fromUtf8("enableMatch"));

        gridLayout1->addWidget(enableMatch, 2, 0, 1, 1);

        enableLineNumbers = new QCheckBox(layoutWidget);
        enableLineNumbers->setObjectName(QString::fromUtf8("enableLineNumbers"));

        gridLayout1->addWidget(enableLineNumbers, 3, 1, 1, 1);

        enableTabSpaces = new QCheckBox(layoutWidget);
        enableTabSpaces->setObjectName(QString::fromUtf8("enableTabSpaces"));

        gridLayout1->addWidget(enableTabSpaces, 2, 1, 1, 1);


        retranslateUi(Tools);
        QObject::connect(cancelButton, SIGNAL(clicked()), Tools, SLOT(reject()));

        QMetaObject::connectSlotsByName(Tools);
    } // setupUi

    void retranslateUi(QDialog *Tools)
    {
        Tools->setWindowTitle(QApplication::translate("Tools", "External Tools", 0, QApplication::UnicodeUTF8));
        makeLocation->setText(QApplication::translate("Tools", "...", 0, QApplication::UnicodeUTF8));
        label_8->setText(QApplication::translate("Tools", "ctags:", 0, QApplication::UnicodeUTF8));
        cslcLocation->setText(QApplication::translate("Tools", "...", 0, QApplication::UnicodeUTF8));
        label_9->setText(QApplication::translate("Tools", "args:", 0, QApplication::UnicodeUTF8));
        label_6->setText(QApplication::translate("Tools", "make:", 0, QApplication::UnicodeUTF8));
        ctagsLocation->setText(QApplication::translate("Tools", "...", 0, QApplication::UnicodeUTF8));
        gdbLocation->setText(QApplication::translate("Tools", "...", 0, QApplication::UnicodeUTF8));
        label_7->setText(QApplication::translate("Tools", "gdb:", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_WHATSTHIS
        args->setWhatsThis(QApplication::translate("Tools", "<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal; text-decoration:none;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" color:#0000ff;\">CSLC arguments</span></p></body></html>", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
#ifndef QT_NO_WHATSTHIS
        cslc->setWhatsThis(QApplication::translate("Tools", "<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal; text-decoration:none;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\">path to CSLC binary</p></body></html>", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_WHATSTHIS
        label->setText(QApplication::translate("Tools", "Please enter the path to the external programs:", 0, QApplication::UnicodeUTF8));
        label_5->setText(QApplication::translate("Tools", "CSLC:", 0, QApplication::UnicodeUTF8));
        label_10->setText(QApplication::translate("Tools", "Tab size:", 0, QApplication::UnicodeUTF8));
        wordWrap->setText(QApplication::translate("Tools", "Enable Word Wrap", 0, QApplication::UnicodeUTF8));
        enableAutoIndent->setText(QApplication::translate("Tools", "Enable autoIndent", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        showVerilogFile->setToolTip(QApplication::translate("Tools", "<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal; text-decoration:none;\">\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"></p></body></html>", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        showVerilogFile->setStyleSheet(QString());
        showVerilogFile->setText(QApplication::translate("Tools", "Show generated verilog", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        showDotFile->setToolTip(QApplication::translate("Tools", "<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:'Sans Serif'; font-size:9pt; font-weight:400; font-style:normal; text-decoration:none;\">\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"></p></body></html>", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        showDotFile->setStyleSheet(QString());
        showDotFile->setText(QApplication::translate("Tools", "Show generated dotfile", 0, QApplication::UnicodeUTF8));
        tileAuto->setText(QApplication::translate("Tools", "Tile Automatically", 0, QApplication::UnicodeUTF8));
        okButton->setText(QApplication::translate("Tools", "OK", 0, QApplication::UnicodeUTF8));
        cancelButton->setText(QApplication::translate("Tools", "Cancel", 0, QApplication::UnicodeUTF8));
        autoBrackets->setText(QApplication::translate("Tools", "Use Auto-Brackets", 0, QApplication::UnicodeUTF8));
        enableMatch->setText(QApplication::translate("Tools", "Matches ( { [", 0, QApplication::UnicodeUTF8));
        enableLineNumbers->setText(QApplication::translate("Tools", "Enable Line Numbers", 0, QApplication::UnicodeUTF8));
        enableTabSpaces->setText(QApplication::translate("Tools", "replace Tab with spaces", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(Tools);
    } // retranslateUi

};

namespace Ui {
    class Tools: public Ui_Tools {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_TOOLS_H
