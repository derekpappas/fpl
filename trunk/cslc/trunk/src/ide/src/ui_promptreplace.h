/********************************************************************************
** Form generated from reading ui file 'promptreplace.ui'
**
** Created: Sat Nov 7 09:34:00 2009
**      by: Qt User Interface Compiler version 4.5.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_PROMPTREPLACE_H
#define UI_PROMPTREPLACE_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QGridLayout>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QPushButton>
#include <QtGui/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_PromptReplace
{
public:
    QGridLayout *gridLayout;
    QVBoxLayout *vboxLayout;
    QLabel *label;
    QHBoxLayout *hboxLayout;
    QPushButton *replace;
    QPushButton *replaceAll;
    QPushButton *findNext;
    QPushButton *close;

    void setupUi(QDialog *PromptReplace)
    {
        if (PromptReplace->objectName().isEmpty())
            PromptReplace->setObjectName(QString::fromUtf8("PromptReplace"));
        PromptReplace->resize(388, 98);
        gridLayout = new QGridLayout(PromptReplace);
#ifndef Q_OS_MAC
        gridLayout->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        gridLayout->setMargin(9);
#endif
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        vboxLayout = new QVBoxLayout();
#ifndef Q_OS_MAC
        vboxLayout->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        vboxLayout->setMargin(0);
#endif
        vboxLayout->setObjectName(QString::fromUtf8("vboxLayout"));
        label = new QLabel(PromptReplace);
        label->setObjectName(QString::fromUtf8("label"));
        label->setAlignment(Qt::AlignCenter);

        vboxLayout->addWidget(label);

        hboxLayout = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout->setSpacing(6);
#endif
        hboxLayout->setMargin(0);
        hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
        replace = new QPushButton(PromptReplace);
        replace->setObjectName(QString::fromUtf8("replace"));

        hboxLayout->addWidget(replace);

        replaceAll = new QPushButton(PromptReplace);
        replaceAll->setObjectName(QString::fromUtf8("replaceAll"));

        hboxLayout->addWidget(replaceAll);

        findNext = new QPushButton(PromptReplace);
        findNext->setObjectName(QString::fromUtf8("findNext"));

        hboxLayout->addWidget(findNext);

        close = new QPushButton(PromptReplace);
        close->setObjectName(QString::fromUtf8("close"));

        hboxLayout->addWidget(close);


        vboxLayout->addLayout(hboxLayout);


        gridLayout->addLayout(vboxLayout, 0, 0, 1, 1);


        retranslateUi(PromptReplace);
        QObject::connect(close, SIGNAL(clicked()), PromptReplace, SLOT(reject()));

        QMetaObject::connectSlotsByName(PromptReplace);
    } // setupUi

    void retranslateUi(QDialog *PromptReplace)
    {
        PromptReplace->setWindowTitle(QApplication::translate("PromptReplace", "Confirmation", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("PromptReplace", "Found an occurence of your search term. What do you want to do?", 0, QApplication::UnicodeUTF8));
        replace->setText(QApplication::translate("PromptReplace", "&Replace", 0, QApplication::UnicodeUTF8));
        replaceAll->setText(QApplication::translate("PromptReplace", "Replace &All", 0, QApplication::UnicodeUTF8));
        findNext->setText(QApplication::translate("PromptReplace", "&Find Next", 0, QApplication::UnicodeUTF8));
        close->setText(QApplication::translate("PromptReplace", "&Close", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(PromptReplace);
    } // retranslateUi

};

namespace Ui {
    class PromptReplace: public Ui_PromptReplace {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_PROMPTREPLACE_H
