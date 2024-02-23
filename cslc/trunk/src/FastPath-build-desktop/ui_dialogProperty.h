/********************************************************************************
** Form generated from reading UI file 'dialogProperty.ui'
**
** Created: Sat Dec 25 13:26:36 2010
**      by: Qt User Interface Compiler version 4.7.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_DIALOGPROPERTY_H
#define UI_DIALOGPROPERTY_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QHeaderView>

QT_BEGIN_NAMESPACE

class Ui_DialogProperty
{
public:
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *DialogProperty)
    {
        if (DialogProperty->objectName().isEmpty())
            DialogProperty->setObjectName(QString::fromUtf8("DialogProperty"));
        DialogProperty->resize(400, 300);
        buttonBox = new QDialogButtonBox(DialogProperty);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setGeometry(QRect(210, 260, 166, 32));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);

        retranslateUi(DialogProperty);
        QObject::connect(buttonBox, SIGNAL(accepted()), DialogProperty, SLOT(accept()));
        QObject::connect(buttonBox, SIGNAL(rejected()), DialogProperty, SLOT(reject()));

        QMetaObject::connectSlotsByName(DialogProperty);
    } // setupUi

    void retranslateUi(QDialog *DialogProperty)
    {
        DialogProperty->setWindowTitle(QApplication::translate("DialogProperty", "Dialog", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class DialogProperty: public Ui_DialogProperty {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_DIALOGPROPERTY_H
