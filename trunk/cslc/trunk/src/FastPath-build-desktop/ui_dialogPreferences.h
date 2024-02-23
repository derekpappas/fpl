/********************************************************************************
** Form generated from reading UI file 'dialogPreferences.ui'
**
** Created: Sat Dec 25 13:26:36 2010
**      by: Qt User Interface Compiler version 4.7.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_DIALOGPREFERENCES_H
#define UI_DIALOGPREFERENCES_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QDialog>
#include <QtGui/QDialogButtonBox>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QPushButton>
#include <QtGui/QSpacerItem>
#include <QtGui/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_DialogPreferences
{
public:
    QVBoxLayout *verticalLayout;
    QHBoxLayout *horizontalLayout;
    QLabel *label_2;
    QLineEdit *lineEditCslcLocation;
    QPushButton *pushButtonCslcLocation;
    QSpacerItem *verticalSpacer;
    QDialogButtonBox *buttonBox;

    void setupUi(QDialog *DialogPreferences)
    {
        if (DialogPreferences->objectName().isEmpty())
            DialogPreferences->setObjectName(QString::fromUtf8("DialogPreferences"));
        DialogPreferences->resize(400, 190);
        verticalLayout = new QVBoxLayout(DialogPreferences);
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName(QString::fromUtf8("horizontalLayout"));
        label_2 = new QLabel(DialogPreferences);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        horizontalLayout->addWidget(label_2);

        lineEditCslcLocation = new QLineEdit(DialogPreferences);
        lineEditCslcLocation->setObjectName(QString::fromUtf8("lineEditCslcLocation"));
        lineEditCslcLocation->setMinimumSize(QSize(160, 0));

        horizontalLayout->addWidget(lineEditCslcLocation);

        pushButtonCslcLocation = new QPushButton(DialogPreferences);
        pushButtonCslcLocation->setObjectName(QString::fromUtf8("pushButtonCslcLocation"));

        horizontalLayout->addWidget(pushButtonCslcLocation);


        verticalLayout->addLayout(horizontalLayout);

        verticalSpacer = new QSpacerItem(20, 65, QSizePolicy::Minimum, QSizePolicy::Expanding);

        verticalLayout->addItem(verticalSpacer);

        buttonBox = new QDialogButtonBox(DialogPreferences);
        buttonBox->setObjectName(QString::fromUtf8("buttonBox"));
        buttonBox->setOrientation(Qt::Horizontal);
        buttonBox->setStandardButtons(QDialogButtonBox::Cancel|QDialogButtonBox::Ok);

        verticalLayout->addWidget(buttonBox);


        retranslateUi(DialogPreferences);
        QObject::connect(buttonBox, SIGNAL(accepted()), DialogPreferences, SLOT(accept()));
        QObject::connect(buttonBox, SIGNAL(rejected()), DialogPreferences, SLOT(reject()));

        QMetaObject::connectSlotsByName(DialogPreferences);
    } // setupUi

    void retranslateUi(QDialog *DialogPreferences)
    {
        DialogPreferences->setWindowTitle(QApplication::translate("DialogPreferences", "Preferences", 0, QApplication::UnicodeUTF8));
        label_2->setText(QApplication::translate("DialogPreferences", "Cslc Location", 0, QApplication::UnicodeUTF8));
        pushButtonCslcLocation->setText(QApplication::translate("DialogPreferences", "...", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class DialogPreferences: public Ui_DialogPreferences {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_DIALOGPREFERENCES_H
