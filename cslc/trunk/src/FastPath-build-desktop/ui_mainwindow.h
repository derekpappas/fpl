/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created: Sat Dec 25 13:26:36 2010
**      by: Qt User Interface Compiler version 4.7.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QGridLayout>
#include <QtGui/QGroupBox>
#include <QtGui/QHeaderView>
#include <QtGui/QMainWindow>
#include <QtGui/QMenu>
#include <QtGui/QMenuBar>
#include <QtGui/QSplitter>
#include <QtGui/QStatusBar>
#include <QtGui/QTableWidget>
#include <QtGui/QTreeWidget>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QAction *actionSave;
    QAction *actionOpen;
    QAction *actionNew;
    QAction *actionSaveAs;
    QAction *action;
    QAction *actionExit;
    QAction *actionExecuteCSL;
    QAction *actionOptions;
    QAction *actionRunCSLC;
    QAction *actionPreferences;
    QAction *actionGenerate_CSL;
    QAction *actionHelp_Contents;
    QAction *actionAbout;
    QWidget *centralWidget;
    QGridLayout *gridLayout_3;
    QSplitter *splitter_3;
    QSplitter *splitter_2;
    QSplitter *splitter;
    QGroupBox *groupBox_TreeList;
    QGridLayout *gridLayout;
    QTreeWidget *treeWidget;
    QGroupBox *groupBox_IfcLib;
    QGroupBox *groupBox_Table;
    QGridLayout *gridLayout_2;
    QTableWidget *tableWidget;
    QGroupBox *groupBox_Property;
    QMenuBar *menuBar;
    QMenu *menuFile;
    QMenu *menuCSL;
    QMenu *menuProject;
    QMenu *menuHelp;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(600, 400);
        actionSave = new QAction(MainWindow);
        actionSave->setObjectName(QString::fromUtf8("actionSave"));
        actionOpen = new QAction(MainWindow);
        actionOpen->setObjectName(QString::fromUtf8("actionOpen"));
        actionNew = new QAction(MainWindow);
        actionNew->setObjectName(QString::fromUtf8("actionNew"));
        actionSaveAs = new QAction(MainWindow);
        actionSaveAs->setObjectName(QString::fromUtf8("actionSaveAs"));
        action = new QAction(MainWindow);
        action->setObjectName(QString::fromUtf8("action"));
        actionExit = new QAction(MainWindow);
        actionExit->setObjectName(QString::fromUtf8("actionExit"));
        actionExecuteCSL = new QAction(MainWindow);
        actionExecuteCSL->setObjectName(QString::fromUtf8("actionExecuteCSL"));
        actionOptions = new QAction(MainWindow);
        actionOptions->setObjectName(QString::fromUtf8("actionOptions"));
        actionRunCSLC = new QAction(MainWindow);
        actionRunCSLC->setObjectName(QString::fromUtf8("actionRunCSLC"));
        actionPreferences = new QAction(MainWindow);
        actionPreferences->setObjectName(QString::fromUtf8("actionPreferences"));
        actionGenerate_CSL = new QAction(MainWindow);
        actionGenerate_CSL->setObjectName(QString::fromUtf8("actionGenerate_CSL"));
        actionHelp_Contents = new QAction(MainWindow);
        actionHelp_Contents->setObjectName(QString::fromUtf8("actionHelp_Contents"));
        actionAbout = new QAction(MainWindow);
        actionAbout->setObjectName(QString::fromUtf8("actionAbout"));
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        gridLayout_3 = new QGridLayout(centralWidget);
        gridLayout_3->setSpacing(6);
        gridLayout_3->setContentsMargins(11, 11, 11, 11);
        gridLayout_3->setObjectName(QString::fromUtf8("gridLayout_3"));
        splitter_3 = new QSplitter(centralWidget);
        splitter_3->setObjectName(QString::fromUtf8("splitter_3"));
        splitter_3->setOrientation(Qt::Horizontal);
        splitter_2 = new QSplitter(splitter_3);
        splitter_2->setObjectName(QString::fromUtf8("splitter_2"));
        splitter_2->setOrientation(Qt::Vertical);
        splitter = new QSplitter(splitter_2);
        splitter->setObjectName(QString::fromUtf8("splitter"));
        splitter->setOrientation(Qt::Horizontal);
        groupBox_TreeList = new QGroupBox(splitter);
        groupBox_TreeList->setObjectName(QString::fromUtf8("groupBox_TreeList"));
        gridLayout = new QGridLayout(groupBox_TreeList);
        gridLayout->setSpacing(6);
        gridLayout->setContentsMargins(11, 11, 11, 11);
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        treeWidget = new QTreeWidget(groupBox_TreeList);
        QTreeWidgetItem *__qtreewidgetitem = new QTreeWidgetItem();
        __qtreewidgetitem->setText(0, QString::fromUtf8("root"));
        treeWidget->setHeaderItem(__qtreewidgetitem);
        treeWidget->setObjectName(QString::fromUtf8("treeWidget"));

        gridLayout->addWidget(treeWidget, 0, 0, 1, 1);

        splitter->addWidget(groupBox_TreeList);
        groupBox_IfcLib = new QGroupBox(splitter);
        groupBox_IfcLib->setObjectName(QString::fromUtf8("groupBox_IfcLib"));
        splitter->addWidget(groupBox_IfcLib);
        groupBox_Table = new QGroupBox(splitter);
        groupBox_Table->setObjectName(QString::fromUtf8("groupBox_Table"));
        gridLayout_2 = new QGridLayout(groupBox_Table);
        gridLayout_2->setSpacing(6);
        gridLayout_2->setContentsMargins(11, 11, 11, 11);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        tableWidget = new QTableWidget(groupBox_Table);
        if (tableWidget->columnCount() < 8)
            tableWidget->setColumnCount(8);
        QTableWidgetItem *__qtablewidgetitem = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(0, __qtablewidgetitem);
        QTableWidgetItem *__qtablewidgetitem1 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(1, __qtablewidgetitem1);
        QTableWidgetItem *__qtablewidgetitem2 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(2, __qtablewidgetitem2);
        QTableWidgetItem *__qtablewidgetitem3 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(3, __qtablewidgetitem3);
        QTableWidgetItem *__qtablewidgetitem4 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(4, __qtablewidgetitem4);
        QTableWidgetItem *__qtablewidgetitem5 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(5, __qtablewidgetitem5);
        QTableWidgetItem *__qtablewidgetitem6 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(6, __qtablewidgetitem6);
        QTableWidgetItem *__qtablewidgetitem7 = new QTableWidgetItem();
        tableWidget->setHorizontalHeaderItem(7, __qtablewidgetitem7);
        tableWidget->setObjectName(QString::fromUtf8("tableWidget"));
        QSizePolicy sizePolicy(QSizePolicy::MinimumExpanding, QSizePolicy::MinimumExpanding);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(tableWidget->sizePolicy().hasHeightForWidth());
        tableWidget->setSizePolicy(sizePolicy);
        tableWidget->setAlternatingRowColors(true);
        tableWidget->setSelectionMode(QAbstractItemView::SingleSelection);
        tableWidget->setSortingEnabled(true);

        gridLayout_2->addWidget(tableWidget, 0, 0, 1, 1);

        splitter->addWidget(groupBox_Table);
        splitter_2->addWidget(splitter);
        splitter_3->addWidget(splitter_2);
        groupBox_Property = new QGroupBox(splitter_3);
        groupBox_Property->setObjectName(QString::fromUtf8("groupBox_Property"));
        splitter_3->addWidget(groupBox_Property);

        gridLayout_3->addWidget(splitter_3, 0, 0, 1, 1);

        MainWindow->setCentralWidget(centralWidget);
        menuBar = new QMenuBar(MainWindow);
        menuBar->setObjectName(QString::fromUtf8("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 600, 25));
        menuFile = new QMenu(menuBar);
        menuFile->setObjectName(QString::fromUtf8("menuFile"));
        menuCSL = new QMenu(menuBar);
        menuCSL->setObjectName(QString::fromUtf8("menuCSL"));
        menuProject = new QMenu(menuBar);
        menuProject->setObjectName(QString::fromUtf8("menuProject"));
        menuHelp = new QMenu(menuBar);
        menuHelp->setObjectName(QString::fromUtf8("menuHelp"));
        MainWindow->setMenuBar(menuBar);
        statusBar = new QStatusBar(MainWindow);
        statusBar->setObjectName(QString::fromUtf8("statusBar"));
        MainWindow->setStatusBar(statusBar);

        menuBar->addAction(menuFile->menuAction());
        menuBar->addAction(menuProject->menuAction());
        menuBar->addAction(menuCSL->menuAction());
        menuBar->addAction(menuHelp->menuAction());
        menuFile->addAction(actionNew);
        menuFile->addAction(actionOpen);
        menuFile->addAction(actionSave);
        menuFile->addAction(actionSaveAs);
        menuFile->addSeparator();
        menuFile->addAction(actionExit);
        menuCSL->addAction(actionExecuteCSL);
        menuCSL->addSeparator();
        menuCSL->addAction(actionOptions);
        menuProject->addAction(actionGenerate_CSL);
        menuProject->addSeparator();
        menuProject->addAction(actionPreferences);
        menuHelp->addAction(actionHelp_Contents);
        menuHelp->addSeparator();
        menuHelp->addAction(actionAbout);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", 0, QApplication::UnicodeUTF8));
        actionSave->setText(QApplication::translate("MainWindow", "&Save", 0, QApplication::UnicodeUTF8));
        actionSave->setShortcut(QApplication::translate("MainWindow", "Ctrl+S", 0, QApplication::UnicodeUTF8));
        actionOpen->setText(QApplication::translate("MainWindow", "&Open", 0, QApplication::UnicodeUTF8));
        actionOpen->setShortcut(QApplication::translate("MainWindow", "Ctrl+O", 0, QApplication::UnicodeUTF8));
        actionNew->setText(QApplication::translate("MainWindow", "&New", 0, QApplication::UnicodeUTF8));
        actionNew->setShortcut(QApplication::translate("MainWindow", "Ctrl+N", 0, QApplication::UnicodeUTF8));
        actionSaveAs->setText(QApplication::translate("MainWindow", "Save &As", 0, QApplication::UnicodeUTF8));
        actionSaveAs->setShortcut(QApplication::translate("MainWindow", "Ctrl+A", 0, QApplication::UnicodeUTF8));
        action->setText(QApplication::translate("MainWindow", "-", 0, QApplication::UnicodeUTF8));
        actionExit->setText(QApplication::translate("MainWindow", "E&xit", 0, QApplication::UnicodeUTF8));
        actionExecuteCSL->setText(QApplication::translate("MainWindow", "Compile CSL", 0, QApplication::UnicodeUTF8));
        actionExecuteCSL->setShortcut(QApplication::translate("MainWindow", "Ctrl+E", 0, QApplication::UnicodeUTF8));
        actionOptions->setText(QApplication::translate("MainWindow", "Options", 0, QApplication::UnicodeUTF8));
        actionRunCSLC->setText(QApplication::translate("MainWindow", "Run CSLC", 0, QApplication::UnicodeUTF8));
        actionPreferences->setText(QApplication::translate("MainWindow", "Preferences", 0, QApplication::UnicodeUTF8));
        actionGenerate_CSL->setText(QApplication::translate("MainWindow", "Generate CSL", 0, QApplication::UnicodeUTF8));
#ifndef QT_NO_TOOLTIP
        actionGenerate_CSL->setToolTip(QApplication::translate("MainWindow", "Generates the CSL code", 0, QApplication::UnicodeUTF8));
#endif // QT_NO_TOOLTIP
        actionHelp_Contents->setText(QApplication::translate("MainWindow", "Help Contents", 0, QApplication::UnicodeUTF8));
        actionAbout->setText(QApplication::translate("MainWindow", "About", 0, QApplication::UnicodeUTF8));
        groupBox_TreeList->setTitle(QApplication::translate("MainWindow", "Design Hierarchy", 0, QApplication::UnicodeUTF8));
        groupBox_IfcLib->setTitle(QApplication::translate("MainWindow", "Connectivity Library", 0, QApplication::UnicodeUTF8));
        groupBox_Table->setTitle(QApplication::translate("MainWindow", "Connection Table", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem = tableWidget->horizontalHeaderItem(0);
        ___qtablewidgetitem->setText(QApplication::translate("MainWindow", "Interface\n"
"Type", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem1 = tableWidget->horizontalHeaderItem(1);
        ___qtablewidgetitem1->setText(QApplication::translate("MainWindow", "Actual\n"
"Name", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem2 = tableWidget->horizontalHeaderItem(2);
        ___qtablewidgetitem2->setText(QApplication::translate("MainWindow", "Driver\n"
"Type", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem3 = tableWidget->horizontalHeaderItem(3);
        ___qtablewidgetitem3->setText(QApplication::translate("MainWindow", "Driver\n"
"Unit\n"
"Instance", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem4 = tableWidget->horizontalHeaderItem(4);
        ___qtablewidgetitem4->setText(QApplication::translate("MainWindow", "Driver\n"
"Connection\n"
"Instance", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem5 = tableWidget->horizontalHeaderItem(5);
        ___qtablewidgetitem5->setText(QApplication::translate("MainWindow", "Receiver\n"
"Type", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem6 = tableWidget->horizontalHeaderItem(6);
        ___qtablewidgetitem6->setText(QApplication::translate("MainWindow", "Receiver\n"
"Unit\n"
"Instance", 0, QApplication::UnicodeUTF8));
        QTableWidgetItem *___qtablewidgetitem7 = tableWidget->horizontalHeaderItem(7);
        ___qtablewidgetitem7->setText(QApplication::translate("MainWindow", "Receiver\n"
"Connection\n"
"Instance", 0, QApplication::UnicodeUTF8));
        groupBox_Property->setTitle(QApplication::translate("MainWindow", "Properties", 0, QApplication::UnicodeUTF8));
        menuFile->setTitle(QApplication::translate("MainWindow", "File", 0, QApplication::UnicodeUTF8));
        menuCSL->setTitle(QApplication::translate("MainWindow", "Tools", 0, QApplication::UnicodeUTF8));
        menuProject->setTitle(QApplication::translate("MainWindow", "Project", 0, QApplication::UnicodeUTF8));
        menuHelp->setTitle(QApplication::translate("MainWindow", "Help", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
