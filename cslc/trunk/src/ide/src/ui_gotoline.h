/********************************************************************************
** Form generated from reading ui file 'gotoline.ui'
**
** Created: Sat Nov 7 09:34:00 2009
**      by: Qt User Interface Compiler version 4.5.0
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_GOTOLINE_H
#define UI_GOTOLINE_H

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
#include <QtGui/QSlider>
#include <QtGui/QSpacerItem>
#include <QtGui/QSpinBox>
#include <QtGui/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_GotoLine
{
public:
    QGridLayout *gridLayout;
    QVBoxLayout *vboxLayout;
    QLabel *label;
    QHBoxLayout *hboxLayout;
    QSlider *horizontalSlider;
    QSpinBox *spinBox;
    QHBoxLayout *hboxLayout1;
    QSpacerItem *spacerItem;
    QPushButton *okButton;
    QPushButton *cancelButton;
    QSpacerItem *spacerItem1;

    void setupUi(QDialog *GotoLine)
    {
        if (GotoLine->objectName().isEmpty())
            GotoLine->setObjectName(QString::fromUtf8("GotoLine"));
        GotoLine->resize(245, 119);
        gridLayout = new QGridLayout(GotoLine);
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
        label = new QLabel(GotoLine);
        label->setObjectName(QString::fromUtf8("label"));

        vboxLayout->addWidget(label);

        hboxLayout = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout->setSpacing(6);
#endif
        hboxLayout->setMargin(0);
        hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
        horizontalSlider = new QSlider(GotoLine);
        horizontalSlider->setObjectName(QString::fromUtf8("horizontalSlider"));
        horizontalSlider->setMinimum(1);
        horizontalSlider->setMaximum(99999);
        horizontalSlider->setValue(1);
        horizontalSlider->setOrientation(Qt::Horizontal);

        hboxLayout->addWidget(horizontalSlider);

        spinBox = new QSpinBox(GotoLine);
        spinBox->setObjectName(QString::fromUtf8("spinBox"));
        QSizePolicy sizePolicy(static_cast<QSizePolicy::Policy>(1), static_cast<QSizePolicy::Policy>(0));
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(spinBox->sizePolicy().hasHeightForWidth());
        spinBox->setSizePolicy(sizePolicy);
        spinBox->setMaximum(99999);
        spinBox->setMinimum(1);

        hboxLayout->addWidget(spinBox);


        vboxLayout->addLayout(hboxLayout);


        gridLayout->addLayout(vboxLayout, 0, 0, 1, 1);

        hboxLayout1 = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout1->setSpacing(6);
#endif
        hboxLayout1->setMargin(0);
        hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
        spacerItem = new QSpacerItem(131, 31, QSizePolicy::Expanding, QSizePolicy::Minimum);

        hboxLayout1->addItem(spacerItem);

        okButton = new QPushButton(GotoLine);
        okButton->setObjectName(QString::fromUtf8("okButton"));

        hboxLayout1->addWidget(okButton);

        cancelButton = new QPushButton(GotoLine);
        cancelButton->setObjectName(QString::fromUtf8("cancelButton"));

        hboxLayout1->addWidget(cancelButton);


        gridLayout->addLayout(hboxLayout1, 2, 0, 1, 1);

        spacerItem1 = new QSpacerItem(20, 40, QSizePolicy::Minimum, QSizePolicy::Expanding);

        gridLayout->addItem(spacerItem1, 1, 0, 1, 1);


        retranslateUi(GotoLine);
        QObject::connect(okButton, SIGNAL(clicked()), GotoLine, SLOT(accept()));
        QObject::connect(cancelButton, SIGNAL(clicked()), GotoLine, SLOT(reject()));
        QObject::connect(horizontalSlider, SIGNAL(valueChanged(int)), spinBox, SLOT(setValue(int)));
        QObject::connect(spinBox, SIGNAL(valueChanged(int)), horizontalSlider, SLOT(setValue(int)));

        QMetaObject::connectSlotsByName(GotoLine);
    } // setupUi

    void retranslateUi(QDialog *GotoLine)
    {
        GotoLine->setWindowTitle(QApplication::translate("GotoLine", "Goto Line", 0, QApplication::UnicodeUTF8));
        label->setText(QApplication::translate("GotoLine", "<html><head><meta name=\"qrichtext\" content=\"1\" /></head><body style=\" white-space: pre-wrap; font-family:Sans Serif; font-size:9pt; font-weight:400; font-style:normal; text-decoration:none;\"><p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-size:12pt;\">Goto Line:</span></p></body></html>", 0, QApplication::UnicodeUTF8));
        okButton->setText(QApplication::translate("GotoLine", "OK", 0, QApplication::UnicodeUTF8));
        cancelButton->setText(QApplication::translate("GotoLine", "Cancel", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(GotoLine);
    } // retranslateUi

};

namespace Ui {
    class GotoLine: public Ui_GotoLine {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_GOTOLINE_H
