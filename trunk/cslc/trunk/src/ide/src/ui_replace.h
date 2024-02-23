/********************************************************************************
** Form generated from reading ui file 'replace.ui'
**
** Created: Sat Nov 7 09:34:00 2009
**      by: Qt User Interface Compiler version 4.5.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_REPLACE_H
#define UI_REPLACE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QCheckBox>
#include <QtGui/QComboBox>
#include <QtGui/QDialog>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_Replace
{
public:
    QGridLayout *gridLayout;
    QGroupBox *groupBox;
    QGridLayout *gridLayout1;
    QHBoxLayout *hboxLayout;
    QVBoxLayout *vboxLayout;
    QLabel *label;
    QLabel *label_2;
    QVBoxLayout *vboxLayout1;
    QComboBox *textFind;
    QComboBox *textReplace;
    QHBoxLayout *hboxLayout1;
    QSpacerItem *spacerItem;
    QPushButton *replace;
    QPushButton *close;
    QGroupBox *groupBox_3;
    QGridLayout *gridLayout2;
    QCheckBox *prompt;
    QCheckBox *wholeWords;
    QCheckBox *caseSensitive;
    QCheckBox *backwards;

    void setupUi(QDialog *Replace)
    {
        if (Replace->objectName().isEmpty())
            Replace->setObjectName(QString::fromUtf8("Replace"));
        Replace->resize(352, 246);
        gridLayout = new QGridLayout(Replace);
#ifndef Q_OS_MAC
        gridLayout->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        gridLayout->setMargin(9);
#endif
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        groupBox = new QGroupBox(Replace);
        groupBox->setObjectName(QString::fromUtf8("groupBox"));
        gridLayout1 = new QGridLayout(groupBox);
#ifndef Q_OS_MAC
        gridLayout1->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        gridLayout1->setMargin(9);
#endif
        gridLayout1->setObjectName(QString::fromUtf8("gridLayout1"));
        hboxLayout = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        hboxLayout->setMargin(0);
#endif
        hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
        vboxLayout = new QVBoxLayout();
#ifndef Q_OS_MAC
        vboxLayout->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        vboxLayout->setMargin(0);
#endif
        vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
        label = new QLabel(groupBox);
        label->setObjectName(QString::fromUtf8("label"));
        label->setAlignment(Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter);

        vboxLayout->addWidget(label);

        label_2 = new QLabel(groupBox);
        label_2->setObjectName(QString::fromUtf8("label_2"));
        label_2->setAlignment(Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter);

        vboxLayout->addWidget(label_2);


        hboxLayout->addLayout(vboxLayout);

        vboxLayout1 = new QVBoxLayout();
#ifndef Q_OS_MAC
        vboxLayout1->setSpacing(6);
#endif
        vboxLayout1->setMargin(0);
        vboxLayout1->setObjectName(QString::fromUtf8("vboxLayout1"));
        textFind = new QComboBox(groupBox);
        textFind->setObjectName(QString::fromUtf8("textFind"));
        QSizePolicy sizePolicy(static_cast<QSizePolicy::Policy>(3), static_cast<QSizePolicy::Policy>(0));
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(textFind->sizePolicy().hasHeightForWidth());
        textFind->setSizePolicy(sizePolicy);
        textFind->setMaximumSize(QSize(400, 16777215));
        textFind->setEditable(true);

        vboxLayout1->addWidget(textFind);

        textReplace = new QComboBox(groupBox);
        textReplace->setObjectName(QString::fromUtf8("textReplace"));
        sizePolicy.setHeightForWidth(textReplace->sizePolicy().hasHeightForWidth());
        textReplace->setSizePolicy(sizePolicy);
        textReplace->setMaximumSize(QSize(400, 16777215));
        textReplace->setEditable(true);

        vboxLayout1->addWidget(textReplace);


        hboxLayout->addLayout(vboxLayout1);


        gridLayout1->addLayout(hboxLayout, 0, 0, 1, 1);


        gridLayout->addWidget(groupBox, 0, 0, 1, 1);

        hboxLayout1 = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout1->setSpacing(6);
#endif
        hboxLayout1->setMargin(0);
        hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
        spacerItem = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        hboxLayout1->addItem(spacerItem);

        replace = new QPushButton(Replace);
        replace->setObjectName(QString::fromUtf8("replace"));

        hboxLayout1->addWidget(replace);

        close = new QPushButton(Replace);
        close->setObjectName(QString::fromUtf8("close"));

        hboxLayout1->addWidget(close);


        gridLayout->addLayout(hboxLayout1, 2, 0, 1, 1);

        groupBox_3 = new QGroupBox(Replace);
        groupBox_3->setObjectName(QString::fromUtf8("groupBox_3"));
        gridLayout2 = new QGridLayout(groupBox_3);
#ifndef Q_OS_MAC
        gridLayout2->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        gridLayout2->setMargin(9);
#endif
        gridLayout2->setObjectName(QString::fromUtf8("gridLayout2"));
        prompt = new QCheckBox(groupBox_3);
        prompt->setObjectName(QString::fromUtf8("prompt"));
        prompt->setChecked(true);

        gridLayout2->addWidget(prompt, 1, 1, 1, 1);

        wholeWords = new QCheckBox(groupBox_3);
        wholeWords->setObjectName(QString::fromUtf8("wholeWords"));

        gridLayout2->addWidget(wholeWords, 1, 0, 1, 1);

        caseSensitive = new QCheckBox(groupBox_3);
        caseSensitive->setObjectName(QString::fromUtf8("caseSensitive"));

        gridLayout2->addWidget(caseSensitive, 0, 0, 1, 1);

        backwards = new QCheckBox(groupBox_3);
        backwards->setObjectName(QString::fromUtf8("backwards"));

        gridLayout2->addWidget(backwards, 0, 1, 1, 1);


        gridLayout->addWidget(groupBox_3, 1, 0, 1, 1);


        retranslateUi(Replace);
        QObject::connect(close, SIGNAL(clicked()), Replace, SLOT(reject()));

        QMetaObject::connectSlotsByName(Replace);
    } // setupUi

    void retranslateUi(QDialog *Replace)
    {
        Replace->setWindowTitle(QApplication::translate("Replace", "Replace Text", 0, QApplication::UnicodeUTF8));
        groupBox->setTitle(QApplication::translate("Replace", "Find and Replace", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("Replace", "Text to find:", 0, QApplication::UnicodeUTF8));
        label_2->setText(QApplication::translate("Replace", "Replacement text:", 0, QApplication::UnicodeUTF8));
        replace->setText(QApplication::translate("Replace", "&Replace", 0, QApplication::UnicodeUTF8));
        close->setText(QApplication::translate("Replace", "&Close", 0, QApplication::UnicodeUTF8));
        groupBox_3->setTitle(QApplication::translate("Replace", "Options", 0, QApplication::UnicodeUTF8));
        prompt->setText(QApplication::translate("Replace", "Prompt on replace", 0, QApplication::UnicodeUTF8));
        wholeWords->setText(QApplication::translate("Replace", "Whole words only", 0, QApplication::UnicodeUTF8));
        caseSensitive->setText(QApplication::translate("Replace", "Case sensitive", 0, QApplication::UnicodeUTF8));
        backwards->setText(QApplication::translate("Replace", "Find backwards", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(Replace);
    } // retranslateUi

};

namespace Ui {
    class Replace: public Ui_Replace {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_REPLACE_H
