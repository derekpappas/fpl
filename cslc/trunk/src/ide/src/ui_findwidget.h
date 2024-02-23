/********************************************************************************
** Form generated from reading ui file 'findwidget.ui'
**
** Created: Fri Mar 12 01:13:31 2010
**      by: Qt User Interface Compiler version 4.5.2
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
********************************************************************************/

#ifndef UI_FINDWIDGET_H
#define UI_FINDWIDGET_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QCheckBox>
#include <QtGui/QFrame>
#include <QtGui/QGridLayout>
#include <QtGui/QHBoxLayout>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QSpacerItem>
#include <QtGui/QToolButton>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_FindWidget
{
public:
    QGridLayout *gridLayout;
    QHBoxLayout *hboxLayout;
    QToolButton *toolClose;
    QLineEdit *editFind;
    QToolButton *toolPrevious;
    QToolButton *toolNext;
    QCheckBox *checkCase;
    QCheckBox *checkWholeWords;
    QFrame *labelWrapped;
    QGridLayout *gridLayout1;
    QHBoxLayout *hboxLayout1;
    QLabel *label;
    QLabel *label_2;
    QSpacerItem *spacerItem;

    void setupUi(QWidget *FindWidget)
    {
        if (FindWidget->objectName().isEmpty())
            FindWidget->setObjectName(QString::fromUtf8("FindWidget"));
        FindWidget->resize(772, 27);
        gridLayout = new QGridLayout(FindWidget);
        gridLayout->setSpacing(0);
        gridLayout->setMargin(0);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        hboxLayout = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        hboxLayout->setMargin(0);
#endif
        hboxLayout->setObjectName(QString::fromUtf8("hboxLayout"));
        toolClose = new QToolButton(FindWidget);
        toolClose->setObjectName(QString::fromUtf8("toolClose"));
        const QIcon icon = QIcon(QString::fromUtf8(":/images/cross.png"));
        toolClose->setIcon(icon);
        toolClose->setAutoRaise(true);

        hboxLayout->addWidget(toolClose);

        editFind = new QLineEdit(FindWidget);
        editFind->setObjectName(QString::fromUtf8("editFind"));
        QSizePolicy sizePolicy(static_cast<QSizePolicy::Policy>(0), static_cast<QSizePolicy::Policy>(0));
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(editFind->sizePolicy().hasHeightForWidth());
        editFind->setSizePolicy(sizePolicy);
        editFind->setMinimumSize(QSize(150, 0));

        hboxLayout->addWidget(editFind);

        toolPrevious = new QToolButton(FindWidget);
        toolPrevious->setObjectName(QString::fromUtf8("toolPrevious"));
        const QIcon icon1 = QIcon(QString::fromUtf8(":/images/previous.png"));
        toolPrevious->setIcon(icon1);
        toolPrevious->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);
        toolPrevious->setAutoRaise(true);

        hboxLayout->addWidget(toolPrevious);

        toolNext = new QToolButton(FindWidget);
        toolNext->setObjectName(QString::fromUtf8("toolNext"));
        toolNext->setMinimumSize(QSize(0, 0));
        const QIcon icon2 = QIcon(QString::fromUtf8(":/images/next.png"));
        toolNext->setIcon(icon2);
        toolNext->setToolButtonStyle(Qt::ToolButtonTextBesideIcon);
        toolNext->setAutoRaise(true);
        toolNext->setArrowType(Qt::NoArrow);

        hboxLayout->addWidget(toolNext);

        checkCase = new QCheckBox(FindWidget);
        checkCase->setObjectName(QString::fromUtf8("checkCase"));

        hboxLayout->addWidget(checkCase);

        checkWholeWords = new QCheckBox(FindWidget);
        checkWholeWords->setObjectName(QString::fromUtf8("checkWholeWords"));

        hboxLayout->addWidget(checkWholeWords);

        labelWrapped = new QFrame(FindWidget);
        labelWrapped->setObjectName(QString::fromUtf8("labelWrapped"));
        labelWrapped->setFrameShape(QFrame::Box);
        labelWrapped->setFrameShadow(QFrame::Raised);
        labelWrapped->setLineWidth(0);
        gridLayout1 = new QGridLayout(labelWrapped);
        gridLayout1->setSpacing(0);
        gridLayout1->setMargin(0);
        gridLayout1->setObjectName(QString::fromUtf8("gridLayout1"));
        hboxLayout1 = new QHBoxLayout();
#ifndef Q_OS_MAC
        hboxLayout1->setSpacing(6);
#endif
#ifndef Q_OS_MAC
        hboxLayout1->setMargin(0);
#endif
        hboxLayout1->setObjectName(QString::fromUtf8("hboxLayout1"));
        label = new QLabel(labelWrapped);
        label->setObjectName(QString::fromUtf8("label"));
        label->setPixmap(QPixmap(QString::fromUtf8(":/images/wrap.png")));

        hboxLayout1->addWidget(label);

        label_2 = new QLabel(labelWrapped);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        hboxLayout1->addWidget(label_2);


        gridLayout1->addLayout(hboxLayout1, 0, 0, 1, 1);


        hboxLayout->addWidget(labelWrapped);

        spacerItem = new QSpacerItem(41, 21, QSizePolicy::Expanding, QSizePolicy::Minimum);

        hboxLayout->addItem(spacerItem);


        gridLayout->addLayout(hboxLayout, 0, 0, 1, 1);


        retranslateUi(FindWidget);

        QMetaObject::connectSlotsByName(FindWidget);
    } // setupUi

    void retranslateUi(QWidget *FindWidget)
    {
        FindWidget->setWindowTitle(QApplication::translate("FindWidget", "Form", 0, QApplication::UnicodeUTF8));
        toolClose->setText(QString());
        toolPrevious->setText(QApplication::translate("FindWidget", "Previous", 0, QApplication::UnicodeUTF8));
        toolNext->setText(QApplication::translate("FindWidget", "Next", 0, QApplication::UnicodeUTF8));
        checkCase->setText(QApplication::translate("FindWidget", "Case Sensitive", 0, QApplication::UnicodeUTF8));
        checkWholeWords->setText(QApplication::translate("FindWidget", "Whole words", 0, QApplication::UnicodeUTF8));
        label->setText(QString());
        label_2->setText(QApplication::translate("FindWidget", "Reached end of page, continued from top", 0, QApplication::UnicodeUTF8));
        Q_UNUSED(FindWidget);
    } // retranslateUi

};

namespace Ui {
    class FindWidget: public Ui_FindWidget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FINDWIDGET_H
