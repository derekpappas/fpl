#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QContextMenuEvent>
#include <QString>
#include <QPushButton>
#include <QTextTable>
#include <QDialog>
#include <QMessageBox>
#include <QFileDialog>
#include <QFile>
#include <QTextStream>
#include <QXmlStreamReader>
#include <QXmlStreamWriter>
#include <QXmlSimpleReader>
#include <QDateTime>
#include <QDebug> // remove for production
#include <algorithm>
#include <string>
#include <map>

#include "comboboxeditorfactory.h"
#include "unit.h"
#include "interface.h"
#include "connectivity.h"
#include "propertydialog.h"
#include "interfaceconnectiondialog.h"
#include "driverconnectiondialog.h"
#include "fplxmlhandler.h"
#include "preferencedialog.h"
#include "optiondialog.h"

#define GET_PARENT_NAMES(pItem) \
std::vector<std::string> vectorParentNames; \
        QTreeWidgetItem* pParentItem = pItem; \
                                       while (pParentItem) \
                                       { \
                                         std::string stringText = pParentItem->text(0).toStdString(); \
                                                                  TInt iLeft = stringText.find('('); \
                                                                               TInt iRight = stringText.find(')'); \
                                                                                             std::string stringName = stringText.substr(iLeft + 1, iRight - iLeft - 1); \
                                                                                                                      vectorParentNames.push_back(stringName); \
                                                                                                                      pParentItem = pParentItem->parent(); \
                                                                                                                                };

#define GET_PARENT_BROWSER_NAMES(pItem) \
std::vector<std::string> vectorParentNames; \
        QtBrowserItem* pParentItem = pItem; \
                                     while (pParentItem) \
                                     { \
                                       std::string stringText = pParentItem->property()->propertyName().toStdString(); \
                                                                TInt iLeft = stringText.find('('); \
                                                                             TInt iRight = stringText.find(')'); \
                                                                                           std::string stringName = stringText.substr(iLeft + 1, iRight - iLeft - 1); \
                                                                                                                    vectorParentNames.push_back(stringName); \
                                                                                                                    pParentItem = pParentItem->parent(); \
                                                                                                                              };


MainWindow::MainWindow(int argc, char *argv[], QWidget *parent)
        : QMainWindow(parent),
        ui(new Ui::MainWindow),
        iTreeItemCount(0),
        iInterfaceCount(0),
        bInSlotPropertyChanged(false),
        bUpdated(false),
        cmdLineXmlFileOn(false),
        logDirOn(false),
        cmdLineXmlFileName("not_defined"),
        batchModeOn(false),
        logDirectoryName("not_defined")
{
    ui->setupUi(this);

    loadPreferences();


    if ( argc > 2 ) {
        for (TInt loop=1; loop <= argc-1; loop++ ) {
            qDebug() << "argv[" << loop << "]" << " = " << argv[loop] << endl;
            if ( !strcmp(argv[loop],"-xml") ) { // FIX should be able to open n files
                loop++;
                qDebug() << "argv[" << loop << "]" << " = " << argv[loop] << endl;
                cmdLineXmlFileOn = true;
                cmdLineXmlFileName = argv[loop];
                qDebug() << "cmdLineXmlFileName = " << cmdLineXmlFileName.c_str() << endl;
            }
            else if ( !strcmp(argv[loop],"-logdir") ) {
                loop++;
                qDebug() << "argv[" << loop << "]" << " = " << argv[loop] << endl;
                logDirOn         = true;
                logDirectoryName = argv[loop];
                qDebug() << "cmdLineXmlFileName = " << cmdLineXmlFileName.c_str() << endl;
            }
            else if ( !strcmp(argv[loop],"-batch") ) { // operate in batch mode
                batchModeOn = true;
                qDebug() << "batchModeOn = " << batchModeOn << endl;
            }
        }
    }

    connect(ui->actionNew           , SIGNAL(triggered()), this, SLOT(slotFileNew           ()));
    connect(ui->actionOpen          , SIGNAL(triggered()), this, SLOT(slotFileOpen          ()));
    connect(ui->actionSave          , SIGNAL(triggered()), this, SLOT(slotFileSave          ()));
    connect(ui->actionSaveAs        , SIGNAL(triggered()), this, SLOT(slotFileSaveAs        ()));
    connect(ui->actionExit          , SIGNAL(triggered()), this, SLOT(close                 ()));
    connect(ui->actionExecuteCSL    , SIGNAL(triggered()), this, SLOT(slotExecuteCSL        ()));
    connect(ui->actionOptions       , SIGNAL(triggered()), this, SLOT(slotOptions           ()));
    connect(ui->actionPreferences   , SIGNAL(triggered()), this, SLOT(slotActionPreferences ()));
    connect(ui->actionGenerate_CSL  , SIGNAL(triggered()), this, SLOT(slotGenerateCSL       ()));
    connect(ui->actionHelp_Contents , SIGNAL(triggered()), this, SLOT(slotHelpContents      ()));
    connect(ui->actionAbout         , SIGNAL(triggered()), this, SLOT(slotHelpAbout         ()));

    setWindowTitle("FastPath Generator -- [Untitled]");

    ui->groupBox_Property->setVisible(false);

    QtVariantPropertyManager *variantManager = new QtVariantPropertyManager(this);
    QtVariantProperty *pUnitType = variantManager->addProperty(QtVariantPropertyManager::enumTypeId(), "Port Type");
    QStringList unitTypes;
    unitTypes << "Input" << "Output" ;
    pUnitType->setAttribute("enumNames", unitTypes);
    pUnitType->setValue(1); // current value will be "Suggestion"

    QtVariantProperty *pProperty = variantManager->addProperty(QtVariantPropertyManager::groupTypeId(), "Interface 1");
    pProperty->addSubProperty(pUnitType);

    QGridLayout* pLayoutProp = new QGridLayout(ui->groupBox_Property);
    pLayoutProp->setSpacing(6);
    pLayoutProp->setMargin(11);
    browser = new QtTreePropertyBrowser(ui->groupBox_Property);
    pLayoutProp->addWidget(browser);

    
    QtVariantEditorFactory *variantFactory = new QtVariantEditorFactory(this);
    browser->setFactoryForManager(variantManager, variantFactory);
    browser->addProperty(pProperty);


    ui->treeWidget->setHeaderHidden(true);
    ui->treeWidget->viewport()->installEventFilter(this);
    ui->tableWidget->viewport()->installEventFilter(this);

    QGridLayout* pLayout = new QGridLayout(ui->groupBox_IfcLib);
    pLayout->setSpacing(6);
    pLayout->setMargin(11);
    propertyConnectivity = new QtTreePropertyBrowser(ui->groupBox_IfcLib);
    pLayout->addWidget(propertyConnectivity);
    managerConnectivity = new QtVariantPropertyManager(this);
    QtVariantEditorFactory *variantFactoryIfc = new QtVariantEditorFactory(this);
    propertyConnectivity->setFactoryForManager(managerConnectivity, variantFactoryIfc);
    propertyConnectivity->installEventFilter(this);

    InterfaceTypeFactory::initialize();
    InterfaceObjectContainer::initialize();
    UnitTypeFactory::initialize();
    UnitObjectContainer::initialize();
    ConnectivityContainer::initialize();

    if (cmdLineXmlFileOn) { // batch mode - open up the xml file on the command line
        QString* xmlFileName= new QString(cmdLineXmlFileName.c_str());
        fileOpen(*xmlFileName); // first open the XML file passed in on the cmd line
        fileSave();             // then save the .csl file
        executeCSL();           // then execute the cslc
        exit(0);
    }

}

// release in reverse order that the Containers were initialized
MainWindow::~MainWindow()
{
    delete ui;
    ConnectivityContainer::release();
    UnitObjectContainer::release();
    UnitTypeFactory::release();
    InterfaceObjectContainer::release();
    InterfaceTypeFactory::release();
}

enum CONNECTION_TABLE_COLUMNS
{
    CONNECTION_TABLE_COLUMN_INTERFACE,
    CONNECTION_TABLE_COLUMN_ACTUAL_NAME,
    CONNECTION_TABLE_COLUMN_DRIVER_TYPE,
    CONNECTION_TABLE_COLUMN_DRIVER,
    CONNECTION_TABLE_COLUMN_DRIVER_INTERFACE_NAME,
    CONNECTION_TABLE_COLUMN_RECEIVER_TYPE,
    CONNECTION_TABLE_COLUMN_RECEIVER,
    CONNECTION_TABLE_COLUMN_RECEIVER_INTERFACE_NAME,
    CONNECTION_TABLE_COLUMN_COUNT,
};

bool MainWindow::eventFilter(QObject* pObj, QEvent* pEvent)
{
    if (pEvent->type() == QEvent::ContextMenu)
    {
        QContextMenuEvent* pContextMenuEvent = (QContextMenuEvent*)pEvent;
        if (pObj == ui->treeWidget->viewport())
        {
            pItem = ui->treeWidget->currentItem();

            QAction addUnit("Add New Unit", this);
            //addUnit.setShortcut(tr("Ctrl+U"));
            connect(&addUnit, SIGNAL(triggered()),this, SLOT(slotTreeContextMenu()));

            QAction addSubUnit("Add Unit Instance", this);
            addSubUnit.setShortcut(tr("Ctrl+T"));

            QAction editUnit("Edit Unit", this);

            QAction deleteUnit("Delete Unit", this);

            QMenu menu(this);
            menu.addAction(&addUnit);
            if (pItem)
            {
                menu.addAction(&addSubUnit);
                connect(&addSubUnit, SIGNAL(triggered()),this, SLOT(slotTreeContextMenu()));
                menu.addAction(&editUnit);
                connect(&editUnit,   SIGNAL(triggered()),this, SLOT(slotTreeContextMenu()));
                menu.addAction(&deleteUnit);
                connect(&deleteUnit, SIGNAL(triggered()),this, SLOT(slotTreeContextMenu()));
            }
            menu.exec(pContextMenuEvent->globalPos());
        }
        else if (pObj == ui->tableWidget->viewport())
        {
            pConnection = ui->tableWidget->itemAt(ui->tableWidget->viewport()->mapFromGlobal(pContextMenuEvent->globalPos()));

            if ((pConnection && (pConnection->column() == 0)) || !pConnection)
            {
                QMenu menu(this);

                menu.addAction("Add Connection", this, SLOT(slotTableContextMenu()));
                if (pConnection)
                {
                    menu.addAction("Edit Connection", this, SLOT(slotTableContextMenu()));
                    menu.addAction("Delete Connection", this, SLOT(slotTableContextMenu()));
                }
                menu.exec(pContextMenuEvent->globalPos());
            }
            else if (pConnection->column() == CONNECTION_TABLE_COLUMN_DRIVER ||
                     pConnection->column() == CONNECTION_TABLE_COLUMN_DRIVER_INTERFACE_NAME)
            {
                QMenu menu(this);
                TInt iRow = pConnection->row();
                std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
                bool bAllInput = true;
                if (pairConnectivity.first != -1)
                {
                    ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
                    InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(connectivity->interface, NULL);
                    if (interface.get())
                        bAllInput = interface->isAllInput();
                    else
                        bAllInput = false;
                    if (connectivity->vectorUnits.size() == 0)
                        bAllInput = true;
                }

                QAction addDriver("Add Driver", this);
                if (bAllInput)
                {
                    menu.addAction(&addDriver);
                    connect(&addDriver, SIGNAL(triggered()),this, SLOT(slotTableContextMenu()));
                }
                if (pairConnectivity.second != -1)
                {
                    std::string unit = ConnectivityContainer::getInstance()->getDriver(pairConnectivity.first, pairConnectivity.second);
                    if (unit.size())
                    {
                        QAction setDriver("Edit Driver", this);
                        menu.addAction(&setDriver);
                        connect(&setDriver, SIGNAL(triggered()),this, SLOT(slotTableContextMenu()));
                        QAction deleteDriver("Delete Driver", this);
                        menu.addAction(&deleteDriver);
                        connect(&deleteDriver, SIGNAL(triggered()),this, SLOT(slotTableContextMenu()));
                        menu.exec(pContextMenuEvent->globalPos());
                    }
                    else
                    {    menu.exec(pContextMenuEvent->globalPos()); }
                }
                else
                {    menu.exec(pContextMenuEvent->globalPos()); }
            }
            else if (pConnection->column() == CONNECTION_TABLE_COLUMN_RECEIVER ||
                     pConnection->column() == CONNECTION_TABLE_COLUMN_RECEIVER_INTERFACE_NAME)
            {
                TInt iRow = pConnection->row();
                std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
                if (pairConnectivity.second != -1)
                {
                    QMenu menu(this);
                    bool bAllOutput = true;
                    if (pairConnectivity.first != -1)
                    {
                        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
                        InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(connectivity->interface, NULL);
                        if (interface.get())
                            bAllOutput = interface->isAllOutput();
                        else
                            bAllOutput = false;
                    }
                    std::string unit = ConnectivityContainer::getInstance()->getReceiver(pairConnectivity.first, pairConnectivity.second);
                    if (unit.size() == 0)
                        bAllOutput = true;
                    QAction addReceiver("Add Receiver", this);
                    if (bAllOutput)
                    {
                        menu.addAction(&addReceiver);
                        connect(&addReceiver, SIGNAL(triggered()),this, SLOT(slotTableContextMenu()));
                    }
                    if (unit.size())
                    {
                        QAction setReceiver("Edit Receiver", this);
                        menu.addAction(&setReceiver);
                        connect(&setReceiver, SIGNAL(triggered()),this, SLOT(slotTableContextMenu()));
                        QAction deleteReceiver("Delete Receiver", this);
                        menu.addAction(&deleteReceiver);
                        connect(&deleteReceiver, SIGNAL(triggered()),this, SLOT(slotTableContextMenu()));
                        menu.exec(pContextMenuEvent->globalPos());
                    }
                    else
                    {    menu.exec(pContextMenuEvent->globalPos()); }
                }
            }
        }
        else if (pObj == propertyConnectivity)
        {
            pBrowserItem = propertyConnectivity->currentItemFromPos(pContextMenuEvent->globalPos());
            if (pBrowserItem && !propertyConnectivity->isItemVisible(pBrowserItem))
                pBrowserItem = NULL;
            QMenu menu(this);
            QMenu* pSubmenu = NULL;
            QAction addNewInterface("New Interface", this);
            QAction addNewSignalGroup("New Signal Group", this);
            QAction addInterface("Interface Instance", this);
            QAction addSignalGroup("New Signal Group Instance", this);
            QAction deleteConnectivity("Delete", this);
            QAction editConnectivity("Edit", this);
            QAction addPort("Port", this);
            QAction addSignal("Signal", this);

            if (pBrowserItem)
            {
                GET_PARENT_BROWSER_NAMES(pBrowserItem);
                InterfaceObjectRef pParentObject, pObject;
                pObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                if (!pParentObject.get())
                {
                    if (pBrowserItem->property()->valueText() == "Interface")
                    {
                        pSubmenu = menu.addMenu("Add");
                        pSubmenu->addAction(&addNewInterface);
                        connect(&addNewInterface, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addNewSignalGroup);
                        connect(&addNewSignalGroup, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addInterface);
                        connect(&addInterface, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addPort);
                        connect(&addPort, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                    }
                    else if (pBrowserItem->property()->valueText() == "Signal Group")
                    {
                        pSubmenu = menu.addMenu("Add");
                        pSubmenu->addAction(&addNewInterface);
                        connect(&addNewInterface, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addNewSignalGroup);
                        connect(&addNewSignalGroup, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addSignalGroup);
                        connect(&addSignalGroup, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addSignal);
                        connect(&addSignal, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                    }
                    else
                    {
                        pSubmenu = menu.addMenu("Add");
                        pSubmenu->addAction(&addNewInterface);
                        connect(&addNewInterface, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                        pSubmenu->addAction(&addNewSignalGroup);
                        connect(&addNewSignalGroup, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                    }
                }
                else
                {
                    pSubmenu = menu.addMenu("Add");
                    pSubmenu->addAction(&addNewInterface);
                    connect(&addNewInterface, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                    pSubmenu->addAction(&addNewSignalGroup);
                    connect(&addNewSignalGroup, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                }
                if (!pParentObject.get() || InterfaceObjectContainer::getInstance()->isTopLevelObject(pParentObject))
                {
                    menu.addAction(&editConnectivity);
                    connect(&editConnectivity, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                    menu.addAction(&deleteConnectivity);
                    connect(&deleteConnectivity, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));

                    if (!pParentObject.get() && ConnectivityContainer::getInstance()->hasInterfaceReferenced(pObject))
                    {
                        editConnectivity.setEnabled(false);
                        editConnectivity.setText("Unable to edit (used)");
                        deleteConnectivity.setEnabled(false);
                        deleteConnectivity.setText("Unable to delete (used)");
                    }
                }
            }
            else
            {
                pSubmenu = menu.addMenu("Add");
                pSubmenu->addAction(&addNewInterface);
                connect(&addNewInterface, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
                pSubmenu->addAction(&addNewSignalGroup);
                connect(&addNewSignalGroup, SIGNAL(triggered()),this, SLOT(slotIfcContextMenu()));
            }
            menu.exec(pContextMenuEvent->globalPos());
        }
    } else {
        if (pEvent->type() == QEvent::WindowActivate) {
            if (allowReload) {
                allowReload = false;
                checkProjectFiles();
                allowReload = true;
            };
            return true;
        }
    }
    return false;
}
/**
  This function checks if the project files were modified externally, or do not exist anymore etc and informs the user about it.
  @returns true if everything is OK, else false
  **/
bool MainWindow::checkProjectFiles() {
    if (projectFileName.isEmpty()) { return true;}
    QFileInfo qf(projectFileName);
    if (qf.exists()) {
        if (qf.isReadable()) {
            if (!projectLastModified.isNull() and qf.lastModified() != projectLastModified) {
                if( QMessageBox::question(this, "Project Changed",
                                      "The project has changed since last save. Reload the project?",
                                      QMessageBox::Yes, QMessageBox::No) == QMessageBox::Yes) {
                    fileOpen(projectFileName);
                    qDebug() << " checkProjectFiles()::Project last modified: " << projectLastModified.toString();
                } else {
                    projectLastModified = qf.lastModified();
                    bUpdated = true;
                }
            }
        } else {
            QMessageBox::warning( this, "Project Unreadable",
                                  "The project file can not be read. Please save your project to avoid losing data!",
                                  QMessageBox::Ok);
            return false;
        }
    } else {
        QMessageBox::warning( this, "Missing Project",
                              "The project file does not exist. Please save your project to avoid losing data!",
                              QMessageBox::Ok);
        return false;
    };
    return true;
}
/**
  Displays the About information
  **/
void MainWindow::slotHelpAbout() {
    QMessageBox::information(this, "About", "FastPath Inc. CSLC GUI", QMessageBox::Ok);
}

/**
  Displays the Help Contents. Currently NYI
  **/
void MainWindow::slotHelpContents() {
    QMessageBox::information(this, "Help", "Feature not yet implemented", QMessageBox::Ok);
}

/**
  Slot to perform the actions on the context menu during right click in the Design Hierarchy (Units) Area.
  **/
void MainWindow::slotTreeContextMenu()
{
    QAction* pAction = (QAction*)sender();
    //QTreeWidgetItem* pTreeItemParent = NULL;
    //if (pItem && pItem->parent()) {  pTreeItemParent = pItem->parent(); }

    if      (pAction->text() == "Add New Unit"    ) { popUpUnitPropertyBox(ADDUNIT   ); }
    else if (pAction->text() == "Add Unit Instance") { popUpUnitPropertyBox(ADDSUBUNIT); }
    else if (pAction->text() == "Edit Unit" && pItem) {    popUpUnitPropertyBox(EDITUNIT); }
    else if (pAction->text() == "Delete Unit" && pItem) {
        int ret = QMessageBox::question(this, "Delete Unit", "Are you sure you want to delete this unit?", QMessageBox::Yes, QMessageBox::No);
        switch (ret)
        {
        case QMessageBox::Yes:
            {
                QString stringUnit = pItem->text(0);
                if (stringUnit.size() != 0)
                {
                    TInt iPos = stringUnit.indexOf('(');
                    sUnitName = stringUnit.mid(0, iPos).toAscii().data();
                    sInstanceName = stringUnit.mid(iPos + 1, stringUnit.size() - 1 - iPos - 1).toAscii().data();

                    GET_PARENT_NAMES(pItem);
                    UnitObjectRef pParentObject = NULL;
                    UnitObjectRef pObject = UnitObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                    if (ConnectivityContainer::getInstance()->hasUnitReferenced(pObject))
                    {
                        if (QMessageBox::warning(this, "Warning", "This unit is referenced in connection table. Deleting it will cause "
                                                 "the corresponding connection item to be updated. Are you sure you want to delete"
                                                 " it?", QMessageBox::Yes, QMessageBox::No) == QMessageBox::No)
                            return;
                        ConnectivityContainer::getInstance()->updateReferencedUnit(pObject, std::string());
                    }
                    if (pObject.get())
                    {
                        if (pParentObject.get())
                        {    pParentObject->removeChild(pObject->unitObjectName); }
                        else
                        {    UnitObjectContainer::getInstance()->removeObject(sInstanceName); }
                    }
                    updateModifiedUnitItems(pParentObject, NULL, stringUnit.toStdString());
                    updateTableSpan();
                    bUpdated = true;
                    break;
                }
            }
        default:
            break;
        }
    } else {
        QMessageBox::critical(this, "Error", "No unit was selected!", QMessageBox::Ok);
    }
}

/**
  Slot to perform the actions on the context menu during right click in the Connectivity Library (Interfaces) Area.
  **/
void MainWindow::slotIfcContextMenu()
{
    QAction* pAction = (QAction*)sender();

    if (pAction->text() == "New Interface")
    {
        pBrowserItem = NULL;
        popUpIfcPropertyBox(IFC_INTERFACE);
    }
    else if (pAction->text() == "Interface Instance")
    {
        popUpIfcPropertyBox(IFC_INTERFACE);
    }
    else if (pAction->text() == "Port")
    {
        popUpIfcPropertyBox(IFC_PORT);
    }
    else if (pAction->text() == "New Signal Group")
    {
        pBrowserItem = NULL;
        popUpIfcPropertyBox(IFC_SIGNALGROUP);
    }
    else if (pAction->text() == "Signal Group Instance")
    {
        popUpIfcPropertyBox(IFC_SIGNALGROUP);
    }
    else if (pAction->text() == "Signal")
    {
        popUpIfcPropertyBox(IFC_SIGNAL);
    }
    else if (pAction->text() == "Delete")
    {
        TInt ret = QMessageBox::question(this, "Delete Connectivity", "Are you sure you want to delete this connectivity item?",
                                         QMessageBox::Yes, QMessageBox::No);
        switch (ret)
        {
        case QMessageBox::Yes:
            {
                GET_PARENT_BROWSER_NAMES(pBrowserItem);
                InterfaceObjectRef pParentObject, pObject;
                pObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                InterfaceObjectContainer::getInstance()->removeObject(pObject, pParentObject);
                updateModifiedInterfaceItems(pParentObject, NULL, pObject->makeDisplayName());
                break;
            }
        default:
            break;
        }
    }
    else if (pAction->text() == "Edit")
    {
        if (pBrowserItem)
        {
            if (pBrowserItem->property()->valueText() == "Interface")
            {   popUpIfcPropertyBox(EDIT_INTERFACE); }
            else if (pBrowserItem->property()->valueText() == "Port")
            {    popUpIfcPropertyBox(EDIT_PORT); }
            else if (pBrowserItem->property()->valueText() == "Signal")
            {    popUpIfcPropertyBox(EDIT_SIGNAL); }
            else if (pBrowserItem->property()->valueText() == "Signal Group")
            {    popUpIfcPropertyBox(EDIT_SIGNALGROUP); }
        }
    }
}
/**
  Slot to perform the actions on the context menu during right click in the Connection Table Area.
  **/
void MainWindow::slotTableContextMenu()
{
    TInt i;
    QAction* pAction = (QAction*)sender();

    if (pAction->text() == "Add Connection")
    {
        InterfaceConnectionDialog dialog(this);
        if (dialog.exec() == QDialog::Accepted)
        {
            TInt iRow = ui->tableWidget->rowCount();
            ui->tableWidget->insertRow(iRow);
            std::string stringType = dialog.getPropertyValue("Connection Type").toString().toStdString();
            if (stringType == "Interface")
            {
                QString libraryInterface = dialog.getPropertyValue("Library Interface").toString().trimmed();
                ConnectivityRef connectivity = ConnectivityContainer::getInstance()->addObject(libraryInterface.toStdString(), Connectivity::CONNECTIVITY_TYPE_INTERFACE);
                connectivity->actualName = dialog.getPropertyValue("Actual Name").toString().trimmed().toStdString();
            }
            else if (stringType == "Wire")
            {
                ConnectivityRef connectivity = ConnectivityContainer::getInstance()->addObject("", Connectivity::CONNECTIVITY_TYPE_WIRE);
                connectivity->actualName = dialog.getPropertyValue("Actual Name").toString().trimmed().toStdString();
            }
            else if (stringType == "SubInterface")
            {
                ConnectivityRef connectivity = ConnectivityContainer::getInstance()->addObject("", Connectivity::CONNECTIVITY_TYPE_SUBINTERFACE);
                connectivity->actualName = dialog.getPropertyValue("Actual Name").toString().trimmed().toStdString();
            }
            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Edit Connection"){
        TInt iRow = pConnection->row();
        std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
        InterfaceConnectionDialog dialog(this);
        dialog.setPropertyValue("Actual Name", connectivity->actualName.c_str());
        dialog.setPropertyValue("Connection Type", connectivity->connectivityTypeName().c_str());
        dialog.setPropertyReadOnly("Connection Type", true);
        if (connectivity->interface.size())
            dialog.setPropertyValue("Library Interface", connectivity->interface.c_str());
        if (dialog.exec() == QDialog::Accepted){
            connectivity->actualName = dialog.getPropertyValue("Actual Name").toString().trimmed().toStdString();
            if (connectivity->interface.size())
            {
                QString libraryInterface = dialog.getPropertyValue("Library Interface").toString().trimmed();
                InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(libraryInterface.toStdString());
                bool bNeedClear = (interface->pType->interfaceCategory == InterfaceType::CATEGORY_PORT || interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNAL);
                connectivity->interface = libraryInterface.toStdString();
                if (bNeedClear) {
                    for (TInt i = 0; i < (int)connectivity->vectorCslInterfaces.size(); i++){
                        connectivity->vectorCslInterfaces[i].first.clear();
                        connectivity->vectorCslInterfaces[i].second.clear();
                    }
                }
            }
            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Delete Connection")
    {
        if ( QMessageBox::question(this, "Delete Connection", "Are you sure you want to delete the connection?",
                                   QMessageBox::No, QMessageBox::Yes) == QMessageBox::Yes) {
            TInt iRow = pConnection->row();
            std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
            ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
            TInt iStartRow = ConnectivityContainer::getInstance()->indexToRow(pairConnectivity.first - 1);
            TInt iEndRow = ConnectivityContainer::getInstance()->indexToRow(pairConnectivity.first + 1, 0) - 1;
            for (i = iEndRow; i >= iStartRow; i--)
            {   ui->tableWidget->removeRow(i); }
            ConnectivityContainer::getInstance()->removeObject(pairConnectivity.first);
            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Add Driver")
    {
        TInt iRow = pConnection->row();
        std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
        DriverConnectionDialog dialog(this, connectivity->interface, true, connectivity, connectivity->vectorUnits.size());
        if (dialog.exec() == QDialog::Accepted)
        {
            std::string stringUnit = dialog.getAssociatedUnitObject();
            if (ConnectivityContainer::getInstance()->hasDriver(pairConnectivity.first, stringUnit))
            {
                QMessageBox::critical(this, "Error", "The driver is already added to current connection!", QMessageBox::Ok);
                return;
            }
            std::pair<ConnectivityRef, TInt> pairConnection = ConnectivityContainer::getInstance()->addDriver(pairConnectivity.first, pairConnectivity.second);
            ConnectivityContainer::getInstance()->setDriver(pairConnectivity.first, pairConnection.second, stringUnit);
            ConnectivityContainer::getInstance()->setDriverInterface(pairConnectivity.first, pairConnection.second, dialog.getAssociatedInterfaceObject());

            if (pairConnection.second != 0)
            {
                //need to minus 1 because the connectivity is already added
                iRow = ConnectivityContainer::getInstance()->indexToRow(pairConnectivity.first, pairConnection.second);
                ui->tableWidget->insertRow(iRow);

                pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
            }

            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Edit Driver")
    {
        TInt iRow = pConnection->row();
        std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
        DriverConnectionDialog dialog(this, connectivity->interface, true, connectivity, pairConnectivity.second);
        std::string unit = ConnectivityContainer::getInstance()->getDriver(pairConnectivity.first, pairConnectivity.second);
        std::string interface = ConnectivityContainer::getInstance()->getDriverInterface(pairConnectivity.first, pairConnectivity.second);
        dialog.setAssociatedUnitObject(unit);
        dialog.setAssociatedInterfaceObject(interface);
        if (dialog.exec() == QDialog::Accepted)
        {
            ConnectivityContainer::getInstance()->setDriver(pairConnectivity.first, pairConnectivity.second, dialog.getAssociatedUnitObject());
            ConnectivityContainer::getInstance()->setDriverInterface(pairConnectivity.first, pairConnectivity.second, dialog.getAssociatedInterfaceObject());
            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Delete Driver")
    {
        if ( QMessageBox::question(this, "Delete Driver", "Are you sure you want to delete this driver?",
                                   QMessageBox::No, QMessageBox::Yes)==QMessageBox::Yes) {
            TInt iRow = pConnection->row();
            std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
            ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
            std::pair<TInt, TInt> removedConnectivity = ConnectivityContainer::getInstance()->removeDriver(pairConnectivity.first, pairConnectivity.second);
            TInt i;
            iRow = ConnectivityContainer::getInstance()->indexToRow(pairConnectivity.first, removedConnectivity.first);
            if (removedConnectivity.first == 0)
            {
                if (connectivity->vectorUnits.size())
                {
                    for (i = 1; i < removedConnectivity.second; i++)
                    {    ui->tableWidget->removeRow(iRow + 1); }
                    ui->tableWidget->removeRow(iRow + 1);
                }
                else
                {
                    for (i = 1; i < removedConnectivity.second; i++)
                    {   ui->tableWidget->removeRow(iRow + 1); }
                }
            }
            else
            {
                for (i = 0; i < removedConnectivity.second; i++)
                {    ui->tableWidget->removeRow(iRow); }
            }
            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Add Receiver")
    {
        TInt iRow = pConnection->row();
        std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
        DriverConnectionDialog dialog(this, connectivity->interface, false, connectivity, pairConnectivity.second);
        if (dialog.exec() == QDialog::Accepted)
        {
            std::string stringUnit = dialog.getAssociatedUnitObject();
            if (ConnectivityContainer::getInstance()->hasReceiver(pairConnectivity.first, pairConnectivity.second, stringUnit))
            {
                QMessageBox::critical(this, "Error", "The receiver is already added to current connection!", QMessageBox::Ok);
                return;
            }
            stringUnit = ConnectivityContainer::getInstance()->getReceiver(pairConnectivity.first, pairConnectivity.second);
            if (stringUnit.size())
            {
                ConnectivityContainer::getInstance()->addReceiver(pairConnectivity.first, pairConnectivity.second);
                pairConnectivity.second++;
                ui->tableWidget->insertRow(iRow + 1);
                iRow ++;
            }
            stringUnit = dialog.getAssociatedUnitObject();
            ConnectivityContainer::getInstance()->setReceiver(pairConnectivity.first, pairConnectivity.second, stringUnit);
            if (!dialog.getPropertyValue("Use Driver Interface").toBool())
                ConnectivityContainer::getInstance()->setReceiverInterface(pairConnectivity.first, pairConnectivity.second, dialog.getAssociatedInterfaceObject());
            else if (pairConnectivity.second != -1)
                ConnectivityContainer::getInstance()->setReceiverInterface(pairConnectivity.first, pairConnectivity.second, connectivity->vectorCslInterfaces[pairConnectivity.second].first);

            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Edit Receiver")
    {
        TInt iRow = pConnection->row();
        std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
        DriverConnectionDialog dialog(this, connectivity->interface, false, connectivity, pairConnectivity.second);
        std::string unit = ConnectivityContainer::getInstance()->getReceiver(pairConnectivity.first, pairConnectivity.second);
        std::string interface = ConnectivityContainer::getInstance()->getReceiverInterface(pairConnectivity.first, pairConnectivity.second);
        bool bUseDriverInterface = (ConnectivityContainer::getInstance()->getDriverInterface(pairConnectivity.first, pairConnectivity.second) == interface);
        if (bUseDriverInterface)
            dialog.setPropertyValue("Use Driver Interface", true);
        dialog.setAssociatedUnitObject(unit);
        if (!bUseDriverInterface)
            dialog.setAssociatedInterfaceObject(interface);
        if (dialog.exec() == QDialog::Accepted)
        {
            ConnectivityContainer::getInstance()->setReceiver(pairConnectivity.first, pairConnectivity.second, dialog.getAssociatedUnitObject());
            if (!dialog.getPropertyValue("Use Driver Interface").toBool())
                ConnectivityContainer::getInstance()->setReceiverInterface(pairConnectivity.first, pairConnectivity.second, dialog.getAssociatedInterfaceObject());
            else if (pairConnectivity.second != -1)
                ConnectivityContainer::getInstance()->setReceiverInterface(pairConnectivity.first, pairConnectivity.second, connectivity->vectorCslInterfaces[pairConnectivity.second].first);
            bUpdated = true;
            updateTableSpan();
        }
    }
    else if (pAction->text() == "Delete Receiver")
    {
        if (QMessageBox::question(this, "Delete Receiver", "Are you sure you want to delete this receiver?",
                                  QMessageBox::No, QMessageBox::Yes) == QMessageBox::Yes) {
            TInt iRow = pConnection->row();
            std::pair<TInt, TInt> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(iRow);
            ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
            TInt removedIndex = ConnectivityContainer::getInstance()->removeReceiver(pairConnectivity.first, pairConnectivity.second);
            if (removedIndex != -1)
            {
                if (removedIndex == pairConnectivity.second)
                {    ui->tableWidget->removeRow(iRow); }
                else
                {    ui->tableWidget->removeRow(iRow + 1); }
            }
            bUpdated = true;
            updateTableSpan();
        }
    }
}

void MainWindow::popUpUnitPropertyBox(eUnitPopupMode eMode)
{
    int iLevel = 0;
    QTreeWidgetItem* pCurrentItem = pItem;
    while(pCurrentItem)
    {
        iLevel++;
        pCurrentItem = pCurrentItem->parent();
    }
    if (iLevel == 0)
    {   iLevel = 1; }
    if (eMode == ADDSUBUNIT)
    {    iLevel ++; }

    PropertyDialog dialog(this);

    dialog.addProperty(QtVariantPropertyManager::groupTypeId(), "Unit");

    if (iLevel > 1)
    {
        dialog.addProperty(QtVariantPropertyManager::comboboxTypeId(), "Unit Name", "Unit");
        dialog.setPropertyRequired("Unit Name", true);

        QStringList unitTypes;
        std::map<std::string, UnitTypeRef>::iterator iteratorUnitTypeMap;
        for (iteratorUnitTypeMap = UnitTypeFactory::getInstance()->mapUnitTypes.begin(); iteratorUnitTypeMap != UnitTypeFactory::getInstance()->mapUnitTypes.end(); iteratorUnitTypeMap++)
        {
            std::string sTypeName = iteratorUnitTypeMap->first;
            unitTypes << tr(sTypeName.c_str());
        }

        dialog.setPropertyAttribute("Unit Name", "comboboxNames", unitTypes);
    }
    dialog.addProperty(QVariant::String, "Instance Name", "Unit");
    dialog.setPropertyAttribute("Instance Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
    dialog.setPropertyRequired("Instance Name", true);

    dialog.addProperty(QVariant::String, "Unit Abbreviation", "Unit");
    dialog.setPropertyAttribute("Unit Abbreviation", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));

    dialog.addProperty(QVariant::String, "Unit Description", "Unit");
    dialog.setPropertyAttribute("Unit Description", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));

    // -----------------------------------------
    // used to control the hierarchical netlisting
    // -----------------------------------------

    if (fplOptions.bFloorPlanning && fplOptions.bNetlisting)
    {
        dialog.addProperty(QtVariantPropertyManager::groupTypeId(), "Floor Planning", "Unit");
        dialog.addProperty(QVariant::Bool, "Division Point", "Floor Planning");
            GET_PARENT_NAMES(pItem);
            UnitObjectRef pObject = UnitObjectContainer::getInstance()->getObject(vectorParentNames);
            dialog.setPropertyValue("Division Point", pObject->pType->getColorUnitFloorPlanning() == UnitType::DIVISION_POINT);
    }

    // -----------------------------------------
    // used to select the library to pull the unit models from
    // -----------------------------------------

    if (fplOptions.bNetlisting)
    {
        dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "Unit Libraries", "Unit");
        QStringList unitLibraryTypes;
        unitLibraryTypes
                << "NORMAL_LIBRARIES"
                << "ASIC_LIBRARIES"
                << "FPGA_LIBRARIES";
        dialog.setPropertyAttribute("Unit Libraries", "enumNames", unitLibraryTypes);
    }

    dialog.addProperty(QVariant::Int, "Hierarchy Level", "Unit");
    dialog.setPropertyReadOnly("Hierarchy Level", true);
    dialog.setWindowTitle("Unit Property Editor");

    UnitObjectRef pUnitObject = NULL;
    UnitObjectRef pParentObject = NULL;
    dialog.setPropertyValue("Hierarchy Level", iLevel);
    if (eMode == EDITUNIT)
    {
        GET_PARENT_NAMES(pItem);
        UnitObjectRef pObject = UnitObjectContainer::getInstance()->getObject(vectorParentNames);
        if (pObject.get())
        {
            if (iLevel > 1)
            {
                dialog.setPropertyValue("Unit Name", pObject->pType->unitType.c_str());
            }
            dialog.setPropertyValue("Instance Name", pObject->unitObjectName.c_str());
            dialog.setPropertyValue("Unit Abbreviation", pObject->pType->unitAbbreviation.c_str());
            dialog.setPropertyValue("Unit Description", pObject->pType->unitDescription.c_str());
            if (fplOptions.bNetlisting)
                pObject->pType->setColorUnitLibraries((UnitType::ETreeColorUnitLibraries) dialog.getPropertyValue("Unit Libraries").toInt());
            if (fplOptions.bFloorPlanning)
                pObject->pType->setColorUnitFloorPlanning(dialog.getPropertyValue("Division Point").toBool() ? UnitType::DIVISION_POINT : UnitType::NORMAL);
        }
    }
    if(dialog.exec() == QDialog::Accepted)
    {
        if (eMode != EDITUNIT)
        {
            sInstanceName = dialog.getPropertyValue("Instance Name").toString().trimmed().toStdString();
            if (iLevel > 1)
            {
                sUnitName = dialog.getPropertyValue("Unit Name").toString().trimmed().toStdString();
            }
            else
            {
                sUnitName = sInstanceName;
            }

            GET_PARENT_NAMES(pItem);
            if (eMode == ADDSUBUNIT)
            {    pParentObject = UnitObjectContainer::getInstance()->getObject(vectorParentNames); }
            else
            {    UnitObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject); }
            if (!pParentObject.get() && UnitObjectContainer::getInstance()->mapUnitObjects.size())
            {
                QMessageBox::critical(this, tr("Error"), QString("Only one root unit is allowed!"), QMessageBox::Ok);
                return;
            }
            pUnitObject = UnitObjectContainer::getInstance()->createObject(sUnitName, sInstanceName, pParentObject);

            if (!pUnitObject.get())
            {
                QMessageBox::critical(this, tr("Error"), QString("Object \"%1\" Circular Reference Or duplicated child name!").arg(sInstanceName.c_str()), QMessageBox::Ok);
                return;
            }

            pUnitObject->pType->unitAbbreviation = dialog.getPropertyValue("Unit Abbreviation").toString().trimmed().toAscii().data();
            pUnitObject->pType->unitDescription = dialog.getPropertyValue("Unit Description").toString().trimmed().toAscii().data();
            if (fplOptions.bNetlisting)
                pUnitObject->pType->setColorUnitLibraries((UnitType::ETreeColorUnitLibraries) dialog.getPropertyValue("Unit Libraries").toInt());
            if (fplOptions.bFloorPlanning)
                pUnitObject->pType->setColorUnitFloorPlanning(dialog.getPropertyValue("Division Point").toBool() ? UnitType::DIVISION_POINT : UnitType::NORMAL);
            pUnitObject->unitObjectName = sInstanceName;
            bUpdated = true;
            updateModifiedUnitItems(pParentObject, pUnitObject, std::string());
        }
        else
        {
            GET_PARENT_NAMES(pItem);
            pUnitObject = UnitObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
            if (pUnitObject.get())
            {
                std::string stringNewUnitName;
                std::string stringNewInstanceName = dialog.getPropertyValue("Instance Name").toString().trimmed().toStdString();
                if (iLevel > 1)
                {
                    stringNewUnitName = dialog.getPropertyValue("Unit Name").toString().trimmed().toStdString();
                }
                else
                {
                    stringNewUnitName = stringNewInstanceName;
                }
                if (pUnitObject->unitObjectName != stringNewInstanceName || pUnitObject->pType->unitType != stringNewUnitName)
                {
                    if (pUnitObject->unitObjectName != stringNewInstanceName && UnitObjectContainer::getInstance()->getObject(stringNewInstanceName, pParentObject).get())
                    {
                        QMessageBox::critical(this, "Error", "Duplicated Instance Name, Operation Failed");
                        return;
                    }
                    if (ConnectivityContainer::getInstance()->hasUnitReferenced(pUnitObject))
                    {
                        if (QMessageBox::question(this, "Change Unit Name", "The unit name/type name has been changed, "
                                                  "the correspondent connection will be changed too. Are you willing to proceed?", QMessageBox::Yes, QMessageBox::No) == QMessageBox::No)
                            return;
                        ConnectivityContainer::getInstance()->updateReferencedUnit(pUnitObject, UnitObject::makeDisplayName(stringNewInstanceName, stringNewUnitName));
                    }
                    std::string stringOldString = pUnitObject->makeDisplayName();
                    if (pUnitObject->pType->unitType != stringNewUnitName)
                    {
                        ConnectivityContainer::getInstance()->updateReferencedUnit(pUnitObject, UnitObject::makeDisplayName(stringNewInstanceName, stringNewUnitName));
                        UnitObjectContainer::getInstance()->removeObject(pUnitObject, pParentObject);
                        UnitObjectRef pNewObject = UnitObjectContainer::getInstance()->createObject(stringNewUnitName, stringNewInstanceName, pParentObject);
                        pNewObject->userComments = pUnitObject->userComments;
                        if (pNewObject->pType->vectorChildObject.size() == 0 && !pUnitObject->pType->hasChildType(pNewObject->pType->unitType))
                        {
                            pNewObject->pType->vectorChildObject.swap(pUnitObject->pType->vectorChildObject);
                        }
                        pUnitObject = pNewObject;
                    }

                    if (pUnitObject->unitObjectName != stringNewInstanceName)
                    {
                        pUnitObject->unitObjectName = stringNewInstanceName;
                        if (pParentObject == NULL)
                        {    UnitObjectContainer::getInstance()->updateObjectMap(stringOldString, pUnitObject); }
                    }
                    updateModifiedUnitItems(pParentObject, pUnitObject, stringOldString);
                    updateTableSpan();
                }
                pUnitObject->pType->unitDescription = dialog.getPropertyValue("Unit Description").toString().trimmed().toStdString();
                pUnitObject->pType->unitAbbreviation = dialog.getPropertyValue("Unit Abbreviation").toString().trimmed().toStdString();
                if (fplOptions.bNetlisting)
                    pUnitObject->pType->setColorUnitLibraries((UnitType::ETreeColorUnitLibraries) dialog.getPropertyValue("Unit Libraries").toInt());
                if (fplOptions.bFloorPlanning)
                {
                    pUnitObject->pType->setColorUnitFloorPlanning(dialog.getPropertyValue("Division Point").toBool() ? UnitType::DIVISION_POINT : UnitType::NORMAL);
                    // BEGIN Added by AB 2010-02-02
                    dialog.getPropertyValue("Division Point").toBool() ? colorSubHierarchy(pUnitObject, UnitObject::RED) : colorSubHierarchy(pUnitObject, UnitObject::GREEN);
                    // END Added by AB 2010-02-02
                }
                bUpdated = true;
            }
        }
    }
}

//---------------------------------------------------
// interface property box
//---------------------------------------------------

void MainWindow::popUpIfcPropertyBox(eIfcMode eMode)
{
    PropertyDialog dialog(this);

    bool bHasObjectName = true;
    if (eMode == IFC_PORT || eMode == EDIT_PORT)
    {
        dialog.addProperty(QtVariantPropertyManager::groupTypeId(), "Port");
        dialog.addProperty(QVariant::String, "Name", "Port");
        dialog.setPropertyAttribute("Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
        dialog.setPropertyRequired("Name", true);

        bHasObjectName = false;

        dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "Direction", "Port");
        QStringList portDirections;
        portDirections << "" << "Input" << "Output" << "InOut";
        dialog.setPropertyAttribute("Direction", "enumNames", portDirections);
        dialog.setPropertyRequired("Direction", true);

        dialog.addProperty(QVariant::Int, "Width", "Port");
        dialog.setPropertyRequired("Width", true);
        dialog.setPropertyAttribute("Width", "minimum", 1);
        dialog.addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", "Port");
        dialog.setPropertyRequired("Bit Range", true);
        connect(dialog.pPropertyManager, SIGNAL(valueChanged(QtProperty*,QVariant)), this, SLOT(slotPropertyValueChanged(QtProperty*, QVariant)));

        dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "RTL Type", "Port");
        QStringList wireTypes;
        wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
        dialog.setPropertyAttribute("RTL Type", "enumNames", wireTypes);
        dialog.setPropertyValue("RTL Type", 1);

        dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", "Port");
        QStringList logicTypes;
        logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
        dialog.setPropertyAttribute("Logic Type", "enumNames", logicTypes);

        // -----------------------------------------
        // used to select the type of signals to use in the generated netlist
        // -----------------------------------------

        if (fplOptions.bNetlisting)
        {
            dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "Conditional Include", "Port");
            QStringList conditionalIncludeTypes;
            conditionalIncludeTypes
                    << "NORMAL"
                    << "ASIC_POWER_RAILS"
                    << "FPGA_POWER_RAILS";
            dialog.setPropertyAttribute("Conditional Include", "enumNames", conditionalIncludeTypes);
        }

        dialog.setWindowTitle("Port Property Editor");
        if (eMode == EDIT_PORT)
        {
            if (pBrowserItem)
            {
                InterfaceObjectRef pParentObject, pInterfaceObject;
                GET_PARENT_BROWSER_NAMES(pBrowserItem);
                pInterfaceObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                if (pInterfaceObject.get())
                {
                    dialog.setPropertyValue("Name", QString(pInterfaceObject->interfaceObjectName.c_str()));
                    dialog.setPropertyValue("Direction", pInterfaceObject->pType->portDirection);
                    dialog.setPropertyValue("Width", pInterfaceObject->pType->iWidth);
                    dialog.setPropertyValue("RTL Type", pInterfaceObject->pType->wireType);
                    dialog.setPropertyValue("Logic Type", pInterfaceObject->pType->logicalType);
                    dialog.setPropertyValue("Conditional Include", pInterfaceObject->pType->colorConnectivity);
                    char szBuffer[256];
                    sprintf(szBuffer, "[%d:%d]", pInterfaceObject->pType->iLowerLimitBit, pInterfaceObject->pType->iUpperLimitBit);
                    dialog.setPropertyValue("Bit Range", szBuffer);
                }
            }
        }
    }
    else if (eMode == IFC_INTERFACE || eMode == EDIT_INTERFACE)
    {
        dialog.addProperty(QtVariantPropertyManager::groupTypeId(), "Interface");
        if ((pBrowserItem && (eMode == IFC_INTERFACE))
            || (pBrowserItem && pBrowserItem->parent() && (eMode == EDIT_INTERFACE)))
            {
            dialog.addProperty(QtVariantPropertyManager::comboboxTypeId(), "Name", "Interface");
            dialog.setPropertyAttribute("Name", "comboboxEditable", false);
            std::vector<InterfaceObjectRef> vectorInterfaces;
            InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);
            GET_PARENT_BROWSER_NAMES(pBrowserItem);
            InterfaceObjectRef pParentObject, pInterfaceObject;
            pInterfaceObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
            QStringList interfaceTypes;
            int i;
            for (i = 0; i < (int)vectorInterfaces.size(); i++)
                if (pInterfaceObject != vectorInterfaces[i] && vectorInterfaces[i]->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE)
                    interfaceTypes << vectorInterfaces[i]->interfaceObjectName.c_str();
            if (interfaceTypes.size() == 0) {
                QMessageBox::critical(this, "Interface", "There is no interface to perform the action on. Please add a new interface.",
                                      QMessageBox::Ok);
                return;
            };
            dialog.setPropertyAttribute("Name", "comboboxNames", interfaceTypes);

            dialog.addProperty(QVariant::String, "Instance Name", "Interface");
            dialog.setPropertyAttribute("Instance Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
            dialog.setPropertyRequired("Instance Name", true);
        }
        else
        {
            dialog.addProperty(QVariant::String, "Name", "Interface");
            dialog.setPropertyAttribute("Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
            dialog.setPropertyRequired("Name", true);
            bHasObjectName = false;
        }
        dialog.setWindowTitle("Interface Property Editor");

        if (eMode == EDIT_INTERFACE)
        {
            if (pBrowserItem)
            {
                InterfaceObjectRef pParentObject, pInterfaceObject;
                GET_PARENT_BROWSER_NAMES(pBrowserItem);
                pInterfaceObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                if (pInterfaceObject.get())
                {
                    dialog.setPropertyValue("Name", QString(pInterfaceObject->pType->interfaceType.c_str()));
                    dialog.setPropertyValue("Instance Name", QString(pInterfaceObject->interfaceObjectName.c_str()));
                }
            }
        }
    }
    else if (eMode == IFC_SIGNAL || eMode == EDIT_SIGNAL)
    {
        dialog.addProperty(QtVariantPropertyManager::groupTypeId(), "Signal");
        dialog.addProperty(QVariant::String, "Name", "Signal");
        dialog.setPropertyAttribute("Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
        dialog.setPropertyRequired("Name", true);
        bHasObjectName = false;
        dialog.addProperty(QVariant::Int, "Width", "Signal");
        dialog.setPropertyRequired("Width", true);
        dialog.setPropertyAttribute("Width", "minimum", 1);
        dialog.addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", "Signal");
        dialog.setPropertyRequired("Bit Range", true);
        connect(dialog.pPropertyManager, SIGNAL(valueChanged(QtProperty*,QVariant)), this, SLOT(slotPropertyValueChanged(QtProperty*, QVariant)));

        dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "RTL Type", "Signal");
        QStringList wireTypes;
        wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
        dialog.setPropertyAttribute("RTL Type", "enumNames", wireTypes);
        dialog.setPropertyValue("RTL Type", 1);

        dialog.addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", "Signal");
        QStringList logicTypes;
        logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
        dialog.setPropertyAttribute("Logic Type", "enumNames", logicTypes);

        dialog.setWindowTitle("Signal Property Editor");
        if (eMode == EDIT_SIGNAL)
        {
            if (pBrowserItem)
            {
                InterfaceObjectRef pParentObject, pInterfaceObject;
                GET_PARENT_BROWSER_NAMES(pBrowserItem);
                pInterfaceObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                if (pInterfaceObject.get())
                {
                    dialog.setPropertyValue("Name", QString(pInterfaceObject->interfaceObjectName.c_str()));
                    dialog.setPropertyValue("Width", pInterfaceObject->pType->iWidth);
                    dialog.setPropertyValue("RTL Type", pInterfaceObject->pType->wireType);
                    char szBuffer[256];
                    sprintf(szBuffer, "[%d:%d]", pInterfaceObject->pType->iLowerLimitBit, pInterfaceObject->pType->iUpperLimitBit);
                    dialog.setPropertyValue("Bit Range", szBuffer);
                }
            }
        }
    }
    else if (eMode == IFC_SIGNALGROUP || eMode == EDIT_SIGNALGROUP)
    {
        dialog.addProperty(QtVariantPropertyManager::groupTypeId(), "Signal Group");
        if ((pBrowserItem && (eMode == IFC_SIGNALGROUP))
            || (pBrowserItem && pBrowserItem->parent() && (eMode == EDIT_SIGNALGROUP)))
            {
            dialog.addProperty(QtVariantPropertyManager::comboboxTypeId(), "Name", "Signal Group");
            dialog.setPropertyAttribute("Name", "comboboxEditable", false);
            std::vector<InterfaceObjectRef> vectorInterfaces;
            InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);
            QStringList interfaceTypes;
            int i;
            for (i = 0; i < (int)vectorInterfaces.size(); i++)
                if (vectorInterfaces[i]->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP)
                    interfaceTypes << vectorInterfaces[i]->interfaceObjectName.c_str();
            if (interfaceTypes.size() == 0)
                return;
            dialog.setPropertyAttribute("Name", "comboboxNames", interfaceTypes);

            dialog.addProperty(QVariant::String, "Instance Name", "Signal Group");
            dialog.setPropertyAttribute("Instance Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
            dialog.setPropertyRequired("Instance Name", true);
        }
        else
        {
            dialog.addProperty(QVariant::String, "Name", "Signal Group");
            dialog.setPropertyAttribute("Name", "regExp", QRegExp("^[a-zA-Z_][a-zA-Z0-9_]*$"));
            dialog.setPropertyRequired("Name", true);
            bHasObjectName = false;
        }
        dialog.setWindowTitle("Signal Group Property Editor");
        if (eMode == EDIT_SIGNALGROUP)
        {
            if (pBrowserItem)
            {
                InterfaceObjectRef pParentObject, pInterfaceObject;
                GET_PARENT_BROWSER_NAMES(pBrowserItem);
                pInterfaceObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
                if (pInterfaceObject.get())
                {
                    dialog.setPropertyValue("Name", QString(pInterfaceObject->pType->interfaceType.c_str()));
                    dialog.setPropertyValue("Instance Name", QString(pInterfaceObject->interfaceObjectName.c_str()));
                }
            }
        }
    }
    if(dialog.exec() == QDialog::Accepted)
    {
        sIfcName = dialog.getPropertyValue("Name").toString().trimmed().toAscii().data();
        if (bHasObjectName)
            sIfcObjectName = dialog.getPropertyValue("Instance Name").toString().trimmed().toAscii().data();
        else
            sIfcObjectName = sIfcName;
        InterfaceObjectRef pParentObject, pInterfaceObject;
        GET_PARENT_BROWSER_NAMES(pBrowserItem);
        pInterfaceObject = InterfaceObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);

        if(eMode == IFC_INTERFACE)
        {
            if (InterfaceObjectContainer::getInstance()->getObject(sIfcObjectName, pInterfaceObject).get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            InterfaceObjectRef pIfcObject = InterfaceObjectContainer::getInstance()->createObject(sIfcName, sIfcObjectName, vectorParentNames, InterfaceType::CATEGORY_INTERFACE);
            if (!pIfcObject.get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            bUpdated = true;
            updateModifiedInterfaceItems(pInterfaceObject, pIfcObject, std::string());
        }
        else if (eMode == IFC_SIGNALGROUP)
        {
            if (InterfaceObjectContainer::getInstance()->getObject(sIfcObjectName, pInterfaceObject).get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            InterfaceObjectRef pIfcObject = InterfaceObjectContainer::getInstance()->createObject(sIfcName, sIfcObjectName, vectorParentNames, InterfaceType::CATEGORY_SIGNALGROUP);
            if (!pIfcObject.get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            bUpdated = true;
            updateModifiedInterfaceItems(pInterfaceObject, pIfcObject, std::string());
        }
        else if (eMode == IFC_SIGNAL)
        {
            if (InterfaceObjectContainer::getInstance()->getObject(sIfcObjectName, pInterfaceObject).get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            InterfaceObjectRef pIfcObject = InterfaceObjectContainer::getInstance()->createObject(sIfcName, sIfcObjectName, vectorParentNames, InterfaceType::CATEGORY_SIGNAL);
            if (!pIfcObject.get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            pIfcObject->pType->iWidth = dialog.getPropertyValue("Width").toInt();
            pIfcObject->pType->wireType = InterfaceType::WIRE_TYPE(dialog.getPropertyValue("RTL Type").toInt());
            pIfcObject->pType->logicalType = InterfaceType::LOGICAL_TYPE(dialog.getPropertyValue("Logic Type").toInt());
            std::string sBitRange = dialog.getPropertyValue("Bit Range").toByteArray().data();
            if (sBitRange.size())
            {
                std::string sLowerLimitBit = sBitRange.substr(sBitRange.find('[') + 1, sBitRange.find(':') - sBitRange.find('[') - 1);
                std::string sUpperLimitBit = sBitRange.substr(sBitRange.find(':') + 1, sBitRange.find(']') - sBitRange.find(':') - 1);
                pIfcObject->pType->iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                pIfcObject->pType->iUpperLimitBit = atoi(sUpperLimitBit.c_str());
            }
            bUpdated = true;
            updateModifiedInterfaceItems(pInterfaceObject, pIfcObject, std::string());
        }
        else if (eMode == IFC_PORT)
        {
            if (InterfaceObjectContainer::getInstance()->getObject(sIfcObjectName, pInterfaceObject).get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            InterfaceObjectRef pIfcObject = InterfaceObjectContainer::getInstance()->createObject(sIfcName, sIfcObjectName, vectorParentNames, InterfaceType::CATEGORY_PORT);
            if (!pIfcObject.get())
            {
                QMessageBox::critical(this, "Error", "Duplicated Connectivity Name, Operation Failed");
                return;
            }
            pIfcObject->pType->portDirection = InterfaceType::PORT_DIRECTION(dialog.getPropertyValue("Direction").toInt());
            pIfcObject->pType->iWidth = dialog.getPropertyValue("Width").toInt();
            pIfcObject->pType->wireType = InterfaceType::WIRE_TYPE(dialog.getPropertyValue("RTL Type").toInt());
            pIfcObject->pType->logicalType = InterfaceType::LOGICAL_TYPE(dialog.getPropertyValue("Logic Type").toInt());
            if (fplOptions.bNetlisting)
            {
                pIfcObject->pType->colorConnectivity = InterfaceType::ETreeColorConnectivity(dialog.getPropertyValue("Conditional Include").toInt());
            }
            std::string sBitRange = dialog.getPropertyValue("Bit Range").toByteArray().data();
            if (sBitRange.size())
            {
                std::string sLowerLimitBit = sBitRange.substr(sBitRange.find('[') + 1, sBitRange.find(':') - sBitRange.find('[') - 1);
                std::string sUpperLimitBit = sBitRange.substr(sBitRange.find(':') + 1, sBitRange.find(']') - sBitRange.find(':') - 1);
                pIfcObject->pType->iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                pIfcObject->pType->iUpperLimitBit = atoi(sUpperLimitBit.c_str());
            }
            bUpdated = true;
            updateModifiedInterfaceItems(pInterfaceObject, pIfcObject, std::string());
        }
        else if (eMode == EDIT_INTERFACE || eMode == EDIT_PORT || eMode == EDIT_SIGNAL || eMode == EDIT_SIGNALGROUP)
        {
            if (pInterfaceObject.get())
            {
                InterfaceType::INTERFACE_CATEGORY category;
                switch (eMode)
                {
                case EDIT_INTERFACE:
                    category = InterfaceType::CATEGORY_INTERFACE;
                    break;
                case EDIT_PORT:
                    category = InterfaceType::CATEGORY_PORT;
                    break;
                case EDIT_SIGNAL:
                    category = InterfaceType::CATEGORY_SIGNAL;
                    break;
                case EDIT_SIGNALGROUP:
                    category = InterfaceType::CATEGORY_SIGNALGROUP;
                    break;
                default:
                    return;
                };
                std::string stringOldName = pInterfaceObject->makeDisplayName();
                if (pInterfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_PORT ||
                    pInterfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNAL)
                    sIfcName = pInterfaceObject->pType->interfaceType;
                //qDebug() << "obj name: " << pInterfaceObject->interfaceObjectName.c_str() << " ??? " << sIfcObjectName.c_str();
                if (pInterfaceObject->interfaceObjectName != sIfcObjectName || pInterfaceObject->pType->interfaceType != sIfcName)
                {
                    if ( (sIfcObjectName != pInterfaceObject->interfaceObjectName) &&
                         InterfaceObjectContainer::getInstance()->getObject(sIfcObjectName, pParentObject).get())
                    {
                        QMessageBox::critical(this, "Error", QString("Duplicated Name ") + QString(sIfcObjectName.c_str()) + QString(", Operation Failed"));
                        return;
                    }
                    //qDebug() << "pType: " << pInterfaceObject->pType->interfaceType.c_str() << " ??? " << sIfcName.c_str();
                    if (pInterfaceObject->pType->interfaceType != sIfcName)
                    {
                        InterfaceObjectContainer::getInstance()->removeObject(pInterfaceObject, pParentObject);
                        InterfaceObjectRef pNewObject = InterfaceObjectContainer::getInstance()->createObject(sIfcName, sIfcObjectName, pParentObject, category);
                        int i;
                        for (i = 0; i < (int)pInterfaceObject->pType->vectorChildObject.size(); i++)
                            pNewObject->pType->vectorChildObject.push_back(pInterfaceObject->pType->vectorChildObject[i]);
                        pInterfaceObject = pNewObject;
                    }

                    if (pInterfaceObject->interfaceObjectName != sIfcObjectName)
                    {
                        pInterfaceObject->interfaceObjectName = sIfcObjectName;
                        if (!pParentObject.get())
                            InterfaceObjectContainer::getInstance()->updateObjectMap(stringOldName, pInterfaceObject);
                    }
                    updateModifiedInterfaceItems(pParentObject, pInterfaceObject, stringOldName);
                }
                switch (eMode)
                {
                case EDIT_PORT:
                    {
                        pInterfaceObject->pType->portDirection = InterfaceType::PORT_DIRECTION(dialog.getPropertyValue("Direction").toInt());
                        pInterfaceObject->pType->iWidth = dialog.getPropertyValue("Width").toInt();
                        pInterfaceObject->pType->wireType = InterfaceType::WIRE_TYPE(dialog.getPropertyValue("RTL Type").toInt());
                        pInterfaceObject->pType->logicalType = InterfaceType::LOGICAL_TYPE(dialog.getPropertyValue("Logic Type").toInt());
                        std::string sBitRange = dialog.getPropertyValue("Bit Range").toByteArray().data();
                        if (sBitRange.size())
                        {
                            std::string sLowerLimitBit = sBitRange.substr(sBitRange.find('[') + 1, sBitRange.find(':') - sBitRange.find('[') - 1);
                            std::string sUpperLimitBit = sBitRange.substr(sBitRange.find(':') + 1, sBitRange.find(']') - sBitRange.find(':') - 1);
                            pInterfaceObject->pType->iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                            pInterfaceObject->pType->iUpperLimitBit = atoi(sUpperLimitBit.c_str());
                        }
                        break;
                    }
                case EDIT_SIGNAL:
                    {
                        pInterfaceObject->pType->iWidth = dialog.getPropertyValue("Width").toInt();
                        pInterfaceObject->pType->wireType = InterfaceType::WIRE_TYPE(dialog.getPropertyValue("RTL Type").toInt());
                        pInterfaceObject->pType->logicalType = InterfaceType::LOGICAL_TYPE(dialog.getPropertyValue("Logic Type").toInt());
                        std::string sBitRange = dialog.getPropertyValue("Bit Range").toByteArray().data();
                        if (sBitRange.size())
                        {
                            std::string sLowerLimitBit = sBitRange.substr(sBitRange.find('[') + 1, sBitRange.find(':') - sBitRange.find('[') - 1);
                            std::string sUpperLimitBit = sBitRange.substr(sBitRange.find(':') + 1, sBitRange.find(']') - sBitRange.find(':') - 1);
                            pInterfaceObject->pType->iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                            pInterfaceObject->pType->iUpperLimitBit = atoi(sUpperLimitBit.c_str());
                        }
                        break;
                    }
                default:
                    break;
                }
                bUpdated = true;
            }
            else
                return;
        }
    }
}

void MainWindow::updateModifiedUnitItems(const UnitObjectRef& pParentObject, const UnitObjectRef& pNewObject, const std::string& stringOldItem)
{
    std::vector<std::vector<UnitObjectRef> > vectorRelatedObjects;
    UnitObjectContainer::getInstance()->getRelatedObjects(pParentObject, vectorRelatedObjects);
    QTreeWidgetItem* pRootItem = ui->treeWidget->invisibleRootItem();
    TInt i, j, k;
    QTreeWidgetItem* pParentItem, *pItem;
    if (vectorRelatedObjects.size())
    {
        for (i = 0; i < (TInt)vectorRelatedObjects.size(); i++)
        {
            std::vector<UnitObjectRef>& vectorRoute = vectorRelatedObjects[i];
            pParentItem = NULL;
            pItem = pRootItem;
            for (j = vectorRoute.size() - 1; j >= 0; j--)
            {
                for (k = 0; k < pItem->childCount(); k++)
                {    if (pItem->child(k)->text(0).toStdString() == vectorRoute[j]->makeDisplayName()) break; }
                if (k < pItem->childCount())
                {    pItem = pItem->child(k); }
                else
                {    return; }
            }
            pParentItem = pItem;

            for (j = 0; j < pParentItem->childCount(); j++)
                if (pParentItem->child(j)->text(0).toStdString() == stringOldItem)
                {
                delete pParentItem->child(j);
                break;
            }
            if (pNewObject.get())
            {
                pItem = createTreeWidgetItem(pNewObject);
                pParentItem->addChild(pItem);
                pParentItem->setExpanded(true);
            }
        }
    }
    else
    {
        for (j = 0; j < pRootItem->childCount(); j++) {
            if (pRootItem->child(j)->text(0).toStdString() == stringOldItem)
            {
                delete pRootItem->child(j);
                break;
            }
        }
        if (pNewObject.get())
        {
            pItem = createTreeWidgetItem(pNewObject);
            ui->treeWidget->addTopLevelItem(pItem);
        }
    }
}

QTreeWidgetItem* MainWindow::createTreeWidgetItem(const UnitObjectRef& pObject)
{
    QTreeWidgetItem* pItem = new QTreeWidgetItem();
    pItem->setText(0, QString(pObject->makeDisplayName().c_str()));
    TInt i;
    for (i = 0; i < (TInt)pObject->pType->vectorChildObject.size(); i++)
    {    pItem->addChild(createTreeWidgetItem(pObject->pType->vectorChildObject[i])); }
    return pItem;
}

void MainWindow::updateModifiedInterfaceItems(const InterfaceObjectRef& pParentObject, const InterfaceObjectRef& pNewObject, const std::string& stringOldItem)
{
    std::vector<std::vector<InterfaceObjectRef> > vectorRelatedObjects;
    InterfaceObjectContainer::getInstance()->getRelatedObjects(pParentObject, vectorRelatedObjects);
    QList<QtProperty*> listProperties = propertyConnectivity->properties();
    QList<QtProperty*>::iterator iteratorList;
    TInt i, j;
    QtProperty* pItem = NULL, *pParentItem = NULL;
    if (pParentObject.get())
    {
        for (i = 0; i < (TInt)vectorRelatedObjects.size(); i++)
        {
            std::vector<InterfaceObjectRef>& vectorRoute = vectorRelatedObjects[i];

            for (iteratorList = listProperties.begin(); iteratorList != listProperties.end(); iteratorList++)
            {
                if ((*iteratorList)->propertyName() == vectorRoute[vectorRoute.size() - 1]->makeDisplayName().c_str() &&
                    (*iteratorList)->valueText().toStdString() == vectorRoute[vectorRoute.size() - 1]->makeDisplayValue()) break;
            }
            if (iteratorList != listProperties.end())
            {   pItem = *iteratorList; }
            pParentItem = pItem;
            for (j = vectorRoute.size() - 2; j >= 0; j--)
            {
                QList<QtProperty*> listSubProperties = pItem->subProperties();
                for (iteratorList = listSubProperties.begin(); iteratorList != listSubProperties.end(); iteratorList++)
                {
                    if ((*iteratorList)->propertyName().toStdString() == vectorRoute[j]->makeDisplayName().c_str() &&
                        (*iteratorList)->valueText().toStdString() == vectorRoute[j]->makeDisplayValue()) {break; }
                }
                if (iteratorList != listSubProperties.end())
                {    pItem = *iteratorList; }
                else
                {    return; }
            }
            pParentItem = pItem;

            QList<QtProperty*> listSubProperties = pItem->subProperties();
            for (iteratorList = listSubProperties.begin(); iteratorList != listSubProperties.end(); iteratorList++)
                if ((*iteratorList)->propertyName().toStdString() == stringOldItem)
                {
                pParentItem->removeSubProperty(*iteratorList);
                break;
            }
            if (pNewObject.get())
            {    createProperty(pNewObject, pItem); }
        }
    }
    else
    {
        QList<QtProperty*> listProperties = propertyConnectivity->properties();
        for (iteratorList = listProperties.begin(); iteratorList != listProperties.end(); iteratorList++)
            if ((*iteratorList)->propertyName().toStdString() == stringOldItem)
            {
            propertyConnectivity->removeProperty(*iteratorList);
            break;
        }
        if (pNewObject.get())
        {    createProperty(pNewObject, NULL); }
    }
}

QtProperty* MainWindow::createProperty(const InterfaceObjectRef& pObject, QtProperty* pParentProperty)
{
    QtVariantProperty *pProperty = managerConnectivity->addProperty(QVariant::String, QString(pObject->makeDisplayName().c_str()));
    pProperty->setEditable(false);
    pProperty->setValue(pObject->pType->getInterfaceCategory());
    if (pParentProperty)
    {    pParentProperty->addSubProperty(pProperty); }
    else
    {    propertyConnectivity->addProperty(pProperty); }
    if (!InterfaceObjectContainer::getInstance()->isTopLevelObject(pObject) &&
        InterfaceObjectContainer::getInstance()->isTopLevelType(pObject->pType->interfaceType))
    {
        QList<QtBrowserItem*> listItems = propertyConnectivity->items(pProperty);
        if (listItems.size())
        {    propertyConnectivity->setExpanded(listItems[0], false); }
    }
    TInt i;
    for (i = 0; i < (TInt)pObject->pType->vectorChildObject.size(); i++)
    {    createProperty(pObject->pType->vectorChildObject[i], pProperty); }
    return pProperty;
}

void MainWindow::slotPropertyValueChanged(QtProperty* p, QVariant v)
{
    if (bInSlotPropertyChanged) { return; }
    PropertyDialog* pDialog = qobject_cast<PropertyDialog*>(sender()->parent());
    if (pDialog)
    {
        if (p->propertyName() == "Bit Range")
        {
            std::string sBitRange = v.toByteArray().data();
            if (sBitRange.size())
            {
                std::string sLowerLimitBit = sBitRange.substr(sBitRange.find('[') + 1, sBitRange.find(':') - sBitRange.find('[') - 1);
                std::string sUpperLimitBit = sBitRange.substr(sBitRange.find(':') + 1, sBitRange.find(']') - sBitRange.find(':') - 1);
                int iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                int iUpperLimitBit = atoi(sUpperLimitBit.c_str());
                if (iUpperLimitBit >= iLowerLimitBit)
                {
                    bInSlotPropertyChanged = true;
                    pDialog->setPropertyValue("Width", QVariant(iUpperLimitBit - iLowerLimitBit + 1));
                    bInSlotPropertyChanged = false;
                }
            }
        }
        else if (p->propertyName() == "Width")
        {
            std::string sBitRange = pDialog->getPropertyValue("Bit Range").toByteArray().data();
            int width = v.toInt();
            if (sBitRange.size())
            {
                std::string sLowerLimitBit = sBitRange.substr(sBitRange.find('[') + 1, sBitRange.find(':') - sBitRange.find('[') - 1);
                std::string sUpperLimitBit = sBitRange.substr(sBitRange.find(':') + 1, sBitRange.find(']') - sBitRange.find(':') - 1);
                int iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                int iUpperLimitBit = atoi(sUpperLimitBit.c_str());
                if (width > 0 && width - 1 + iLowerLimitBit != iUpperLimitBit)
                {
                    char szBuffer[256];
//                    if ((iUpperLimitBit - width + 1) >= 0)
//                    {    iLowerLimitBit = iUpperLimitBit - width + 1; }
//                    else
                    {    iUpperLimitBit = iLowerLimitBit + width - 1; }
                    sprintf(szBuffer, "[%d:%d]", iLowerLimitBit, iUpperLimitBit);
                    bInSlotPropertyChanged = true;
                    pDialog->setPropertyValue("Bit Range", QString(szBuffer));
                    bInSlotPropertyChanged = false;
                }
            }
        }
    }
}

void MainWindow::updateTableSpan()
{
    std::vector<TInt> spanConnectivity, spanDriver, spanReceiver;
    //ConnectivityContainer::getInstance()->getSpan(spanConnectivity, spanDriver, spanReceiver);
    TInt iRowCount = ui->tableWidget->rowCount();
    TInt i, j;
    //Remove Span Information
    spanConnectivity.resize(iRowCount + 1);
    spanDriver.resize(iRowCount + 1);
    spanReceiver.resize(iRowCount + 1);
    for (i = 0; i <= iRowCount; i++)
    {
        spanConnectivity[i] = i;
        spanDriver[i] = i;
        spanReceiver[i] = i;
    }
    //for (i = 0; i < iRowCount; i++)
    //    for (j = 0; j < CONNECTION_TABLE_COLUMN_ACTUAL_NAME; j++)
    //        ui->tableWidget->setSpan(i, j, 1, 1);

    QTableWidgetItem* pItem;
    for (i = 0; i < (TInt)spanConnectivity.size() - 1; i++)
    {
        std::pair<int, int> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(spanConnectivity[i]);
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->getObject(pairConnectivity.first);
        if (spanConnectivity[i + 1] - spanConnectivity[i] > 1)
        {
            ui->tableWidget->setSpan(spanConnectivity[i], CONNECTION_TABLE_COLUMN_INTERFACE, spanConnectivity[i + 1] - spanConnectivity[i], 1);
            ui->tableWidget->setSpan(spanConnectivity[i], CONNECTION_TABLE_COLUMN_ACTUAL_NAME, spanConnectivity[i + 1] - spanConnectivity[i], 1);
            for (j = spanConnectivity[i] + 1; j < spanConnectivity[i + 1]; j++)
            {
                ui->tableWidget->setItem(j, CONNECTION_TABLE_COLUMN_INTERFACE, NULL);
                ui->tableWidget->setItem(j, CONNECTION_TABLE_COLUMN_ACTUAL_NAME, NULL);
            }
        }
        if (ui->tableWidget->item(spanConnectivity[i], CONNECTION_TABLE_COLUMN_INTERFACE) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(spanConnectivity[i], CONNECTION_TABLE_COLUMN_INTERFACE, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(spanConnectivity[i], CONNECTION_TABLE_COLUMN_INTERFACE); }
        if (connectivity->interface.size())
        {    pItem->setText(connectivity->interface.c_str()); }
        else if (connectivity->connectivityType == Connectivity::CONNECTIVITY_TYPE_WIRE)
            pItem->setText("===WIRE===");
        else if (connectivity->connectivityType == Connectivity::CONNECTIVITY_TYPE_SUBINTERFACE)
            pItem->setText("==SUB INTERFACE==");
        if (ui->tableWidget->item(spanConnectivity[i], CONNECTION_TABLE_COLUMN_ACTUAL_NAME) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(spanConnectivity[i], CONNECTION_TABLE_COLUMN_ACTUAL_NAME, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(spanConnectivity[i], CONNECTION_TABLE_COLUMN_ACTUAL_NAME); }
        if (connectivity->actualName.size())
        {    pItem->setText(connectivity->actualName.c_str()); }
    }
    for (i = 0; i < (TInt)spanDriver.size() - 1; i++)
    {
        std::pair<int, int> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(spanDriver[i]);
        if (spanDriver[i + 1] - spanDriver[i] > 1)
        {
            ui->tableWidget->setSpan(spanDriver[i], CONNECTION_TABLE_COLUMN_DRIVER, spanDriver[i + 1] - spanDriver[i], 1);
            for (j = spanDriver[i] + 1; j < spanDriver[i + 1]; j++)
                ui->tableWidget->setItem(j, CONNECTION_TABLE_COLUMN_DRIVER, NULL);
        }
        if (ui->tableWidget->item(spanDriver[i], CONNECTION_TABLE_COLUMN_DRIVER) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(spanDriver[i], CONNECTION_TABLE_COLUMN_DRIVER, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(spanDriver[i], CONNECTION_TABLE_COLUMN_DRIVER); }
        std::string driver = ConnectivityContainer::getInstance()->getDriver(pairConnectivity.first, pairConnectivity.second);
        if (driver.size())
        {    pItem->setText(driver.c_str()); }
        else
        {    pItem->setText(""); }
    }
    for (i = 0; i < iRowCount; i++)
    {
        std::pair<int, int> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(i);
        if (ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_DRIVER_INTERFACE_NAME) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(i, CONNECTION_TABLE_COLUMN_DRIVER_INTERFACE_NAME, pItem);
        }
        else
            pItem = ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_DRIVER_INTERFACE_NAME);
        std::string driver = ConnectivityContainer::getInstance()->getDriverInterface(pairConnectivity.first, pairConnectivity.second);
        if (driver.size())
        {    pItem->setText(driver.c_str()); }
        else
        {    pItem->setText(""); }
    }
    for (i = 0; i < (TInt)spanReceiver.size() - 1; i++)
    {
        std::pair<int, int> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(spanReceiver[i]);
        if (spanReceiver[i + 1] - spanReceiver[i] > 1)
        {
            ui->tableWidget->setSpan(spanReceiver[i], CONNECTION_TABLE_COLUMN_RECEIVER, spanReceiver[i + 1] - spanReceiver[i], 1);
            for (j = spanReceiver[i] + 1; j < spanReceiver[i + 1]; j++)
            {    ui->tableWidget->setItem(j, CONNECTION_TABLE_COLUMN_RECEIVER, NULL); }
        }
        if (ui->tableWidget->item(spanReceiver[i], CONNECTION_TABLE_COLUMN_RECEIVER) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(spanReceiver[i], CONNECTION_TABLE_COLUMN_RECEIVER, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(spanReceiver[i], CONNECTION_TABLE_COLUMN_RECEIVER); }
        std::string receiver = ConnectivityContainer::getInstance()->getReceiver(pairConnectivity.first, pairConnectivity.second);
        if (receiver.size())
        {    pItem->setText(receiver.c_str()); }
        else
        {    pItem->setText(""); }
    }
    for (i = 0; i < iRowCount; i++)
    {
        std::pair<int, int> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(i);
        if (ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_RECEIVER_INTERFACE_NAME) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(i, CONNECTION_TABLE_COLUMN_RECEIVER_INTERFACE_NAME, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_RECEIVER_INTERFACE_NAME); }
        std::string receiver = ConnectivityContainer::getInstance()->getReceiverInterface(pairConnectivity.first, pairConnectivity.second);
        if (receiver.size())
        {    pItem->setText(receiver.c_str()); }
        else
        {    pItem->setText(""); }
    }
    for (i = 0; i < iRowCount; i++)
    {
        std::pair<int, int> pairConnectivity = ConnectivityContainer::getInstance()->rowToConnectivity(i);
        if (ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_DRIVER_TYPE) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(i, CONNECTION_TABLE_COLUMN_DRIVER_TYPE, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_DRIVER_TYPE); }
        bool bIsMultiDriver = ConnectivityContainer::getInstance()->isMultiDriver(pairConnectivity.first);
        if (bIsMultiDriver)
        {    pItem->setText("Multi"); }
        else
        {    pItem->setText("Single"); }
        if (ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_RECEIVER_TYPE) == NULL)
        {
            pItem = new QTableWidgetItem();
            pItem->setFlags(pItem->flags() & ~ Qt::ItemIsEditable);
            ui->tableWidget->setItem(i, CONNECTION_TABLE_COLUMN_RECEIVER_TYPE, pItem);
        }
        else
        {    pItem = ui->tableWidget->item(i, CONNECTION_TABLE_COLUMN_RECEIVER_TYPE); }
        bool bIsMultiReceiver = ConnectivityContainer::getInstance()->isMultiReceiver(pairConnectivity.first);
        if (bIsMultiReceiver)
        {    pItem->setText("Multi"); }
        else
        {    pItem->setText("Single"); }
    }
}

void MainWindow::slotFileNew()
{
    if (bUpdated &&
        QMessageBox::question(this,
                              QString("Save confirmation"),
                              QString("The project has been changed"
                                      " since last save, do you want to save it?"),
                              QMessageBox::Yes,
                              QMessageBox::No) == QMessageBox::Yes)
    {    slotFileSave(); }
    ConnectivityContainer   ::getInstance()->clear();
    InterfaceObjectContainer::getInstance()->clear();
    InterfaceTypeFactory    ::getInstance()->clear();
    UnitObjectContainer     ::getInstance()->clear();
    UnitTypeFactory         ::getInstance()->clear();

    ui->treeWidget->clear();
    ui->tableWidget->setRowCount(0);
    propertyConnectivity->clear();

    stringCurrentFileName.clear();
    projectFileName.clear();
    bUpdated = false;
    projectLastModified = QDateTime();
    setWindowTitle("FastPath Generator -- [Untitled]");
}

void MainWindow::fileOpen(QString& stringFile ) {

    //bUpdated = false;
    projectFileName = stringFile;
    ConnectivityContainer::getInstance()->clear();
    InterfaceObjectContainer::getInstance()->clear();
    InterfaceTypeFactory::getInstance()->clear();
    UnitObjectContainer::getInstance()->clear();
    UnitTypeFactory::getInstance()->clear();

    ui->treeWidget->clear();
    ui->tableWidget->setRowCount(0);
    propertyConnectivity->clear();

    QFileInfo qf(stringFile);
    if (qf.exists()) {
        if (qf.isReadable()) {
            if (projectFileName.endsWith(QString(".csl.xml"))) {
                stringCurrentFileName = projectFileName.left(projectFileName.length() - 8);
            }
            bool bXMLFile = QFile::exists(stringCurrentFileName + ".csl.xml");
            bool bResult = false;

            if (bXMLFile) { bResult = openXMLFile(stringCurrentFileName + ".csl.xml"); }

            if (bResult) { this->setWindowTitle(QString("FastPath Generator -- ") + stringCurrentFileName); }

            projectLastModified= qf.lastModified();
            //QMessageBox::information(this, "QDateTime", projectLastModified.toString(),QMessageBox::Ok);
            bUpdated = false;
        } else {
            QMessageBox::critical( this, "Error opening project", "The project file can not be read.", QMessageBox::Ok);
        }
    } else {
        QMessageBox::critical( this, "Error opening project", "The project file does not exist.", QMessageBox::Ok);
    }
}

void MainWindow::slotFileOpen()
{
    int qsave = -1;
    if (bUpdated) {
        qsave = QMessageBox::question(this, QString("Save confirmation"), QString("The project has been changed"
                                                                                  " since last save, do you want to save it?"), QMessageBox::Yes, QMessageBox::No, QMessageBox::Cancel);
        if (qsave == QMessageBox::Yes ) {
            slotFileSave();
        }
    }
    if ( qsave != QMessageBox::Cancel) {
        QString stringFile = QFileDialog::getOpenFileName(this,
                                                          QString("Open FastPath Project"),
                                                          QString::null,
                                                          "FastPath Project .csl.xml(*.csl.xml)");
        if (stringFile.size() &&
            ( projectFileName != stringFile ||
              QMessageBox::question(this, "Reload project", "Do you want to reload the project?",
                                    QMessageBox::Yes, QMessageBox::No) == QMessageBox::Yes) ) {
            projectFileName = stringFile;
            fileOpen(stringFile );
        }
    }
}

void MainWindow::fileSave() {

    qDebug() << "fileSave projectFileName = " << projectFileName << endl;

    if (projectFileName.size()) {
        if (projectFileName.endsWith(QString(".csl.xml"))) {
            //stripping the extension
            stringCurrentFileName = projectFileName.left(projectFileName.length() - 8);

            if (bUpdated){//The project should be saved only if it was modified
                //saving backup
                //TODO save backup
                bool result = saveXMLFile(stringCurrentFileName + ".csl.xml");
                if( result ) {
                    //generating the .csl file
                    result = saveCSLFile(stringCurrentFileName + ".csl");
                    if (result) {
                        bUpdated = false;
                        this->setWindowTitle(QString("FastPath Generator -- ") + stringCurrentFileName);
                    }
                    projectLastModified = QFileInfo(projectFileName).lastModified();
                    qDebug() << " Project last modified: " << QFileInfo(projectFileName).lastModified().toString();
                } else {
                    //TODO: restore backup
                    QMessageBox::critical(this, "Error saving XML file",
                                          "There was error while saving the project file. Please try save-as!",
                                          QMessageBox::Ok);
                }
            }
        }
        else {
            QMessageBox::critical(this,
                                  "Error saving XML file",
                                  QString("Unit file ") + projectFileName + QString(" does not have .csl.xml file extension!"),
                                  QMessageBox::Ok);
        }

    } else {
        QMessageBox::information(this, "Unnamed Project",
                                 "The project is not named so it can not be saved. Please name the project first.",
                                 QMessageBox::Ok);
    }

}

void MainWindow::slotFileSave() {
    if (projectFileName.size() == 0) {
        slotFileSaveAs();
    } else {
        fileSave();
    }
}

void MainWindow::slotFileSaveAs()
{
    projectFileName = QFileDialog::getSaveFileName(this, QString("Save FastPath Files"), stringCurrentFileName,
                                                   "Fast Path Files(*.csl.xml)");

    if (projectFileName.size()) {
        //automatically add .csl.xml extension if not already present
        if( !projectFileName.endsWith(".csl.xml"))
            projectFileName.append(".csl.xml");

        bUpdated = true; // DEP 2010-01-09
        //stringCurrentFileName = stringFileName;
        fileSave();
    }
}


bool MainWindow::openUnitFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error parsing unit file", QString("Unit file ") + stringFileName
                              + QString(" does not exist or has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QTextStream stream(&file);
    std::stack<UnitObjectRef> stackParentObjects;
    int level = 0, i, parent_level = -1;
    int line_number = 0;
    int object_number = 0;
    std::map<UnitTypeRef, int, RefCountingCompare<UnitType> > mapUnitTypes;
    UnitObjectRef unit;
    while(!stream.atEnd())
    {
        line_number ++;
        QString line = stream.readLine();
        line = line.trimmed();
        if (!line.startsWith('#'))
        {
            for (i = 0, level = 0; i < line.length(); i++, level++)
            {    if (line[i] != '|') break; }
            int left_brace = line.indexOf('{');
            int right_brace = line.indexOf('}');
            if (left_brace == -1 || right_brace == -1 || level > parent_level + 1)
            {
                QMessageBox::critical(this, "Error parsing unit file", QString("Unit file ") + stringFileName
                                      + QString(" line %1 is not a valid line!").arg(line_number), QMessageBox::Ok);
                UnitObjectContainer::getInstance()->clear();
                return false;
            }
            std::string unitTypeName = line.mid(i, left_brace - i).trimmed().toStdString();
            std::string unitObjectName = line.mid(left_brace + 1, right_brace - 1 - left_brace).trimmed().toStdString();
            object_number ++;
            for (; parent_level >= level; parent_level--, stackParentObjects.pop()){}

            if (stackParentObjects.size() && mapUnitTypes[stackParentObjects.top()->pType] >= 2) { continue; }
            if (stackParentObjects.size())
            {    unit = UnitObjectContainer::getInstance()->createObject(unitTypeName, unitObjectName, stackParentObjects.top()); }
            else if (UnitObjectContainer::getInstance()->mapUnitObjects.size())
            {
                QMessageBox::critical(this, "Error parsing unit file", QString("Unit file ") + stringFileName
                                      + QString(" line %1 is not a valid line, only 1 top level instance is allowed!").arg(line_number), QMessageBox::Ok);
                UnitObjectContainer::getInstance()->clear();
                return false;
            }
            else
            {    unit = UnitObjectContainer::getInstance()->createObject(unitTypeName, unitObjectName, NULL); }
            if (!unit.get())
            {
                QMessageBox::critical(this, "Error parsing unit file", QString("Unit file ") + stringFileName
                                      + QString(" line %1 is not a valid line, duplicated instance name found!").arg(line_number), QMessageBox::Ok);
                UnitObjectContainer::getInstance()->clear();
                return false;
            }
            stackParentObjects.push(unit);
            mapUnitTypes[unit->pType]++;
            parent_level = level;
        }
    }
    std::vector<UnitObjectRef> vectorUnits;
    UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
    for (int i = 0; i < (int)vectorUnits.size(); i++)
    {    ui->treeWidget->addTopLevelItem(createTreeWidgetItem(vectorUnits[i])); }
    return object_number;
}

bool MainWindow::openXMLUnitFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error parsing unit file", QString("Unit file ") + stringFileName
                              + QString(" does not exist or has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QXmlInputSource source(&file);
    QXmlSimpleReader reader;
    FplXMLHandler handler;
    reader.setContentHandler(&handler);
    FplXMLErrorHandler errorHandler;
    reader.setErrorHandler(&errorHandler);
    bool bResult = reader.parse(&source);
    if (!bResult)
    {
        QString stringError = errorHandler.errorString();
        QMessageBox::critical(this, "Parsing Error", stringError, QMessageBox::Ok);
        UnitObjectContainer::getInstance()->clear();
        return false;
    }
    std::vector<UnitObjectRef> vectorUnits;
    UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
    int i;
    for (i = 0; i < (int)vectorUnits.size(); i++) {
        if (vectorUnits[i]->unitObjectName != handler.stringTopLevelUnitName)
        {    UnitObjectContainer::getInstance()->removeObject(vectorUnits[i]); }
    }
    vectorUnits.clear();
    UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
    for (i = 0; i < (int)vectorUnits.size(); i++) {
        ui->treeWidget->addTopLevelItem(createTreeWidgetItem(vectorUnits[i]));
    }
    return vectorUnits.size();
}

bool MainWindow::saveUnitFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error writing unit file", QString("Unit file ") + stringFileName
                              + QString(" has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QTextStream stream(&file);
    stream << "#FastPath Logic Unit Hierarchy File v 1.0\n";
    stream << "#This is autogenerated by FastPath Generator, " << QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm") << "\n";

    std::vector<UnitObjectRef> vectorUnits;
    UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
    std::vector<std::string> vectorHierarchyNames;
    int i;
    for (i = 0; i < (int)vectorUnits.size(); i++) {
        vectorUnits[i]->getHierarchyDisplayNames("", vectorHierarchyNames);
    }
    std::string line, prefix;
    for (i = 0; i < (int)vectorHierarchyNames.size(); i++)
    {
        int position = vectorHierarchyNames[i].rfind('.');
        line = vectorHierarchyNames[i].substr(position + 1);
        position = -1;
        prefix = "";
        while((position = vectorHierarchyNames[i].find('.', position + 1)) != -1)
        {    prefix += "|"; }
        line = prefix + line + "\n";
        QString stringOutput = QString(line.c_str());
        stringOutput = stringOutput.replace('(', '{');
        stringOutput = stringOutput.replace(')', '}');
        stream << stringOutput;
    }

    return vectorUnits.size();
}

bool MainWindow::saveXMLUnitFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error writing unit file", QString("Unit file ") + stringFileName
                              + QString(" has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QXmlStreamWriter writer(&file);

    writer.writeComment("Copyright FastPath Logic (2009)");
    writer.writeCharacters("\n");
    writer.writeComment(QString("Interface Library File v1.0, this is autogenerated by FastPath Generator ") + QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm"));
    writer.writeCharacters("\n");
    /*
    writer.writeComment("//----------------------------------------------------------------------\n"
                        "// Copyright (c) 2005-2008 Fastpathlogic\n"
                        "// All Rights Reserved.\n"
                        "// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n"
                        "// the contents of this file may not be disclosed to third parties,\n"
                        "// copied or duplicated in any form, in whole or in part, without the prior\n"
                        "// written permission of Fastpathlogic.\n"
                        "//\n"
                        "// RESTRICTED RIGHTS LEGEND:\n"
                        "// Use, duplication or disclosure by the Government is subject to\n"
                        "// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n"
                        "// Technical Data and Computer Software clause at DFARS 252.227-7013,\n"
                        "// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n"
                        "// Unpublished rights reserved under the Copyright Laws of the United States\n"
                        "//----------------------------------------------------------------------\n");
    writer.writeCharacters("\n");
    */
    writer.setAutoFormatting(true);
    writer.setAutoFormattingIndent(4);
    writer.writeStartElement("CSL");

    saveXMLUnitFile(writer);

    writer.writeEndElement();
    return true;
}
// BEGIN Added by AB 2010-02-02
void MainWindow::colorSubHierarchy(UnitObjectRef unit, UnitObject::EUnitColor color)
{
    unit->setUnitColor(color);
    std::vector<UnitObjectRef> vectorUnits = unit->pType->vectorChildObject;
    for(unsigned int i = 0; i < vectorUnits.size(); ++i)
    {
        colorSubHierarchy(vectorUnits.at(i), color);
    }

}
// END Added by AB 2010-02-02
bool MainWindow::saveXMLUnitFile(QXmlStreamWriter& writer)
{
    std::set<UnitTypeRef, RefCountingCompare<UnitType> > setSavedTypes;
    std::stack<int> stackChild; //index of each layer in the tree
    std::stack<UnitObjectRef> stackObject; //object of each layer in the tree
    std::vector<UnitObjectRef> vectorUnits; //ordered objects that has resolved the dependency

    UnitObjectContainer::getInstance()->getAllExpandedUnits(vectorUnits);

    stackChild.push(-1);
    UnitObjectRef unit;
    //traverse the hierarchy
    while(stackChild.size())
    {
        //index of current object in the current layer
        int index = stackChild.top() + 1;
        if (stackChild.size() == 1)
        {
            //top layer, if index out, break
            if (index >= (int)vectorUnits.size()) break;
            //otherwise get the next one
            unit = vectorUnits[index];
        }
        else
        {
            //traverse the child objects
            while (stackObject.size() && index >= (int)stackObject.top()->pType->vectorChildObject.size())
            {
                //if index out, pop up
                stackObject.pop();
                stackChild.pop();
                index = stackChild.top() + 1;
                // BEGIN Added by AB 2010-02-02
                if(unit->getUnitColor() == UnitObject::GREEN){
                    writer.writeEndElement();
                }
                // END Added by AB 2010-02-02
            }
            if (stackChild.size() == 1)
            {
                //top layer, if index out, break
                if (index >= (int)vectorUnits.size()) break;
                //otherwise get the next one
                unit = vectorUnits[index];
            }
            else
                //get the next one
            {    unit = stackObject.top()->pType->vectorChildObject[index]; }
        }

        //flush the index
        stackChild.pop();
        stackChild.push(index);

        //the unit had been recorded, just and reference
        if (setSavedTypes.count(unit->pType))
        {
            // BEGIN Added by AB 2010-02-02
            if((unit->getUnitColor() == UnitObject::GREEN) || (unit->getUnitColor() == UnitObject::RED && unit->pType->getColorUnitFloorPlanning() ==  UnitType::DIVISION_POINT))
            {
                writer.writeStartElement("UnitInstance");
                writer.writeTextElement("Type", unit->pType->unitType.c_str());
                writer.writeTextElement("Name", unit->unitObjectName.c_str());
                writer.writeEndElement();
            }
            // END Added by AB 2010-02-02
        }
        else
        {
            //otherwise it is a new unit, write the new unit definition
            setSavedTypes.insert(unit->pType);
            // BEGIN Added by AB 2010-02-02
            if(unit->getUnitColor() == UnitObject::GREEN)
            {
                writer.writeStartElement("Unit");
                writer.writeTextElement("Name", QString(unit->pType->unitType.c_str()));
                //            if (unit->pType->unitAbbreviation.size())
                //                writer.writeTextElement("Abbreviation", QString(unit->pType->unitAbbreviation.c_str()));
                //            if (unit->pType->unitDescription.size())
                //                writer.writeTextElement("Description", QString(unit->pType->unitDescription.c_str()));
                if (fplOptions.bNetlisting)
                    writer.writeTextElement("UnitLibraries", unit->pType->getColorUnitLibrariesString().c_str());
                if (fplOptions.bFloorPlanning)
                    writer.writeTextElement("FloorPlanning", unit->pType->getColorUnitFloorPlanningString().c_str());
            }
            // END Added by AB 2010-02-02
            stackChild.push(-1);
            stackObject.push(unit);
        }
    }
    return true;
}

bool MainWindow::openInterfaceFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error parsing interface file", QString("Interface file ") + stringFileName
                              + QString(" does not exist or has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QXmlInputSource source(&file);
    QXmlSimpleReader reader;
    FplXMLHandler handler;
    reader.setContentHandler(&handler);
    FplXMLErrorHandler errorHandler;
    reader.setErrorHandler(&errorHandler);
    bool bResult = reader.parse(&source);
    if (!bResult)
    {
        QString stringError = errorHandler.errorString();
        QMessageBox::critical(this, "Parsing Error", stringError, QMessageBox::Ok);
        InterfaceObjectContainer::getInstance()->clear();
        return false;
    }
    std::vector<InterfaceObjectRef> vectorInterfaces;
    InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);
    for (int i = 0; i < (int)vectorInterfaces.size(); i++)
    {    createProperty(vectorInterfaces[i], NULL); }
    return bResult;
}


//........................................
// Write out an XML version of the interface library file
//........................................
bool MainWindow::saveXMLInterfaceFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error writing interface file", QString("Interface file ") + stringFileName
                              + QString(" has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QXmlStreamWriter writer(&file);

    writer.writeComment("Copyright FastPath Logic (2009)");
    writer.writeCharacters("\n");
    writer.writeComment(QString("Interface Library File v1.0, this is autogenerated by FastPath Generator ") + QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm"));
    writer.writeCharacters("\n");
    /*
    writer.writeComment("//----------------------------------------------------------------------\n"
                        "// Copyright (c) 2005-2008 Fastpathlogic\n"
                        "// All Rights Reserved.\n"
                        "// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n"
                        "// the contents of this file may not be disclosed to third parties,\n"
                        "// copied or duplicated in any form, in whole or in part, without the prior\n"
                        "// written permission of Fastpathlogic.\n"
                        "//\n"
                        "// RESTRICTED RIGHTS LEGEND:\n"
                        "// Use, duplication or disclosure by the Government is subject to\n"
                        "// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n"
                        "// Technical Data and Computer Software clause at DFARS 252.227-7013,\n"
                        "// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n"
                        "// Unpublished rights reserved under the Copyright Laws of the United States\n"
                        "//----------------------------------------------------------------------\n");
    writer.writeCharacters("\n");
    */
    writer.setAutoFormatting(true);
    writer.setAutoFormattingIndent(4);
    writer.writeStartElement("CSL");

    saveXMLInterfaceFile(writer);

    writer.writeEndElement();
    return true;
}

bool MainWindow::saveXMLInterfaceFile(QXmlStreamWriter& writer)
{
    std::set<InterfaceTypeRef, RefCountingCompare<InterfaceType> > setSavedTypes;
    std::stack<int> stackChild;
    std::stack<InterfaceObjectRef> stackObject;
    std::vector<InterfaceObjectRef> vectorInterfaces;

    InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);

    stackChild.push(-1);
    InterfaceObjectRef interface;
    while(stackChild.size())
    {
        int index = stackChild.top() + 1;
        if (stackChild.size() == 1)
        {
            if (index >= (int)vectorInterfaces.size()) { break; }
            interface = vectorInterfaces[index];
        }
        else
        {
            while (stackObject.size() && index >= (int)stackObject.top()->pType->vectorChildObject.size())
            {
                stackObject.pop();
                stackChild.pop();
                index = stackChild.top() + 1;
                writer.writeEndElement();
            }
            if (stackChild.size() == 1)
            {
                if (index >= (int)vectorInterfaces.size()) { break; }
                interface = vectorInterfaces[index];
            }
            else
            {    interface = stackObject.top()->pType->vectorChildObject[index]; }
        }

        stackChild.pop();
        stackChild.push(index);

        switch(interface->pType->interfaceCategory)
        {
        case InterfaceType::CATEGORY_INTERFACE:
            if (setSavedTypes.count(interface->pType))
            {
                writer.writeStartElement("InterfaceInstance");
                writer.writeTextElement("Type", interface->pType->interfaceType.c_str());
                writer.writeTextElement("Name", interface->interfaceObjectName.c_str());
                writer.writeEndElement();
            }
            else
            {
                setSavedTypes.insert(interface->pType);
                writer.writeStartElement("Interface");
                writer.writeTextElement("Name", QString(interface->interfaceObjectName.c_str()));
                stackChild.push(-1);
                stackObject.push(interface);
            }
            break;
        case InterfaceType::CATEGORY_PORT:
            if (setSavedTypes.count(interface->pType))
            {
                writer.writeStartElement("InterfaceInstance");
                writer.writeTextElement("Type", interface->pType->interfaceType.c_str());
                writer.writeTextElement("Name", interface->interfaceObjectName.c_str());
                writer.writeEndElement();
            }
            else
            {
                setSavedTypes.insert(interface->pType);
                writer.writeStartElement("Port");
                writer.writeTextElement("Name", interface->interfaceObjectName.c_str());
                writer.writeTextElement("Direction", interface->pType->getDirection().c_str());
                char szBuffer[256];
                sprintf(szBuffer, "%d:%d", interface->pType->iUpperLimitBit, interface->pType->iLowerLimitBit);
                writer.writeTextElement("BitRange", szBuffer);
                if (interface->pType->wireType != InterfaceType::WIRE_UNKNOWN)
                {    writer.writeTextElement("WireType", interface->pType->getWireType().c_str()); }
                if (interface->pType->logicalType != InterfaceType::LOGICAL_UNKNOWN)
                {    writer.writeTextElement("LogicType", interface->pType->getLogicalType().c_str()); }
                if (fplOptions.bNetlisting)
                {
                    if (interface->pType->colorConnectivity == InterfaceType::ASIC_POWER_RAILS || interface->pType->colorConnectivity == InterfaceType::FPGA_POWER_RAILS) {
                       writer.writeTextElement("ConditionallyInclude", interface->pType->getColorConnectivityString().c_str());
                    }
                }

                stackChild.push(-1);
                stackObject.push(interface);
            }
            break;
        case InterfaceType::CATEGORY_SIGNAL:
            if (setSavedTypes.count(interface->pType))
            {
                writer.writeStartElement("InterfaceInstance");
                writer.writeTextElement("Type", interface->pType->interfaceType.c_str());
                writer.writeTextElement("Name", interface->interfaceObjectName.c_str());
                writer.writeEndElement();
            }
            else
            {
                setSavedTypes.insert(interface->pType);
                writer.writeStartElement("Signal");
                writer.writeTextElement("Name", interface->interfaceObjectName.c_str());
                char szBuffer[256];
                sprintf(szBuffer, "%d:%d", interface->pType->iUpperLimitBit, interface->pType->iLowerLimitBit);
                writer.writeTextElement("BitRange", szBuffer);
                if (interface->pType->wireType != InterfaceType::WIRE_UNKNOWN)
                {   writer.writeTextElement("WireType", interface->pType->getWireType().c_str()); }
                if (interface->pType->logicalType != InterfaceType::LOGICAL_UNKNOWN)
                {    writer.writeTextElement("LogicType", interface->pType->getLogicalType().c_str()); }
                stackChild.push(-1);
                stackObject.push(interface);
            }
            break;
        case InterfaceType::CATEGORY_SIGNALGROUP:
            if (setSavedTypes.count(interface->pType))
            {
                writer.writeStartElement("InterfaceInstance");
                writer.writeTextElement("Type", interface->pType->interfaceType.c_str());
                writer.writeTextElement("Name", interface->interfaceObjectName.c_str());
                writer.writeEndElement();
            }
            else
            {
                setSavedTypes.insert(interface->pType);
                writer.writeStartElement("SignalGroup");
                writer.writeTextElement("Name", QString(interface->interfaceObjectName.c_str()));
                stackChild.push(-1);
                stackObject.push(interface);
            }
            break;
        default:
            break;
        }
    }
    return true;
}

bool MainWindow::openXMLConnectionFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error parsing unit file", QString("Unit file ") + stringFileName
                              + QString(" does not exist or has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QXmlInputSource source(&file);
    QXmlSimpleReader reader;
    FplXMLHandler handler;
    reader.setContentHandler(&handler);
    FplXMLErrorHandler errorHandler;
    reader.setErrorHandler(&errorHandler);
    bool bResult = reader.parse(&source);
    if (bResult)
    {
        int iRow = ConnectivityContainer::getInstance()->getNumberOfRows();
        ui->tableWidget->setRowCount(iRow);
        updateTableSpan();
        return true;
    }
    else
    {
        QString stringError = errorHandler.errorString();
        QMessageBox::critical(this, "Parsing Error", stringError, QMessageBox::Ok);
        ConnectivityContainer::getInstance()->clear();
        return false;
    }
}


bool MainWindow::saveXMLConnectionFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error writing connection file", QString("Connection file ") + stringFileName
                              + QString(" has wrong permission!"), QMessageBox::Ok);
        return false;
    }
    QXmlStreamWriter writer(&file);

    writer.writeComment("Copyright FastPath Logic (2009)");
    writer.writeCharacters("\n");
    writer.writeComment(QString("Interface Library File v1.0, this is autogenerated by FastPath Generator ") + QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm"));
    writer.writeCharacters("\n");
    /*
    writer.writeComment("//----------------------------------------------------------------------\n"
                        "// Copyright (c) 2005-2008 Fastpathlogic\n"
                        "// All Rights Reserved.\n"
                        "// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n"
                        "// the contents of this file may not be disclosed to third parties,\n"
                        "// copied or duplicated in any form, in whole or in part, without the prior\n"
                        "// written permission of Fastpathlogic.\n"
                        "//\n"
                        "// RESTRICTED RIGHTS LEGEND:\n"
                        "// Use, duplication or disclosure by the Government is subject to\n"
                        "// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n"
                        "// Technical Data and Computer Software clause at DFARS 252.227-7013,\n"
                        "// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n"
                        "// Unpublished rights reserved under the Copyright Laws of the United States\n"
                        "//----------------------------------------------------------------------\n");
    writer.writeCharacters("\n");
    */
    writer.setAutoFormatting(true);
    writer.setAutoFormattingIndent(4);
    writer.writeStartElement("CSL");

    bool bSuccess = saveXMLConnectionFile(writer);

    writer.writeEndElement();
    if (!bSuccess)
    {
        file.close();
        file.setFileName(stringFileName);
        file.remove();
    }
    return bSuccess;
}

bool MainWindow::saveXMLConnectionFile(QXmlStreamWriter& writer)
{
    int i, j;
    for (i = 0; i < (int)ConnectivityContainer::getInstance()->vectorConnectivities.size(); i++)
    {
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->vectorConnectivities[i];
        writer.writeStartElement("Connection");
        if (connectivity->actualName.size())
            writer.writeTextElement("ActualName", connectivity->actualName.c_str());
        if (connectivity->interface.size())
        {
            InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(connectivity->interface);
            if (interface.get())
            {
                writer.writeTextElement("InterfaceName", connectivity->interface.c_str());
                if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE)
                    writer.writeTextElement("InterfaceType", "interface");
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_PORT)
                    writer.writeTextElement("InterfaceType", "port");
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNAL)
                    writer.writeTextElement("InterfaceType", "signal");
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP)
                    writer.writeTextElement("InterfaceType", "signalgroup");
            }
            else
            {
                QMessageBox::critical(this, "Unable to save connection file",
                                      QString("Error:saveXMLConnectionFile:1: The connection table contains invalid interface %1").arg(connectivity->interface.c_str()), QMessageBox::Ok);
                return false;
            }
        }
        else
        {
            if (connectivity->connectivityType == Connectivity::CONNECTIVITY_TYPE_WIRE)
                writer.writeTextElement("InterfaceType", "Wire");
            else if (connectivity->connectivityType == Connectivity::CONNECTIVITY_TYPE_SUBINTERFACE)
                writer.writeTextElement("InterfaceType", "SubInterface");
        }

        for (j = 0; j < (int)connectivity->vectorUnits.size(); j++)
        {
            writer.writeStartElement("InterfaceConnection");
            UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].first);
            if (unit.get())
                writer.writeTextElement("DriverUnit", connectivity->vectorUnits[j].first.c_str());
            else {
                qDebug() << "WARNING: Missing Driver Unit for connection " << connectivity->actualName.c_str();
            }

            if (connectivity->vectorCslInterfaces[j].first.size())
            {
                if (connectivity->interface.size() == 0 &&
                    !InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(connectivity->vectorCslInterfaces[j].first).get())
                {
                    QMessageBox::critical(this, "Unable to save connection file",
                                          QString("Error:saveXMLConnectionFile:2: The connection table contains invalid interface %1").arg(connectivity->vectorCslInterfaces[j].first.c_str()), QMessageBox::Ok);
                    return false;
                }
                writer.writeTextElement("DriverInterfaceInstance", connectivity->vectorCslInterfaces[j].first.c_str());
            }

            unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].second);
            if (unit.get())
                writer.writeTextElement("ReceiverUnit", connectivity->vectorUnits[j].second.c_str());
            else {
                qDebug() << "WARNING: Missing Receiver Unit for connection " << connectivity->actualName.c_str();
            }

            if (connectivity->vectorCslInterfaces[j].second.size())
            {
                if (connectivity->interface.size() == 0 &&
                    !InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(connectivity->vectorCslInterfaces[j].second).get())
                {
                    QMessageBox::critical(this, "Unable to save connection file",
                                          QString("Error:saveXMLConnectionFile:3: The connection table contains invalid interface %1").arg(connectivity->vectorCslInterfaces[j].second.c_str()), QMessageBox::Ok);
                    return false;
                }
                writer.writeTextElement("ReceiverInterfaceInstance", connectivity->vectorCslInterfaces[j].second.c_str());
            }
            writer.writeEndElement();
        }
        writer.writeEndElement();
    }
    return true;
}

bool MainWindow::saveXMLFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error writing connection file", QString("Connection file ") + stringFileName
                              + QString(" has wrong permission!"), QMessageBox::Ok);
        return false;
    }
    QXmlStreamWriter writer(&file);

    writer.writeComment("Copyright FastPath Logic (2009)");
    writer.writeCharacters("\n");
    writer.writeComment(QString("Interface Library File v1.0, this is autogenerated by FastPath Generator ") + QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm"));
    writer.writeCharacters("\n");
    /*
    writer.writeComment("//----------------------------------------------------------------------\n"
                        "// Copyright (c) 2005-2008 Fastpathlogic\n"
                        "// All Rights Reserved.\n"
                        "// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n"
                        "// the contents of this file may not be disclosed to third parties,\n"
                        "// copied or duplicated in any form, in whole or in part, without the prior\n"
                        "// written permission of Fastpathlogic.\n"
                        "//\n"
                        "// RESTRICTED RIGHTS LEGEND:\n"
                        "// Use, duplication or disclosure by the Government is subject to\n"
                        "// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n"
                        "// Technical Data and Computer Software clause at DFARS 252.227-7013,\n"
                        "// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n"
                        "// Unpublished rights reserved under the Copyright Laws of the United States\n"
                        "//----------------------------------------------------------------------\n");
    writer.writeCharacters("\n");
    */
    writer.setAutoFormatting(true);
    writer.setAutoFormattingIndent(4);
    writer.writeStartElement("CSL");
    writer.writeStartElement("Options");

    writer.writeTextElement("CSL_default_includes",fplOptions.bAddIncludes ? "true" : "false");
    writer.writeEndElement();

    saveXMLUnitFile(writer);
    saveXMLInterfaceFile(writer);
    saveXMLConnectionFile(writer);

    writer.writeEndElement();
    file.flush();
    file.close();
    return true;
}

bool MainWindow::openXMLFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error parsing fpl file", QString("FPL file ") + stringFileName
                              + QString(" does not exist or has wrong permission!"), QMessageBox::Ok);
        return false;
    }

    QXmlInputSource source(&file);
    QXmlSimpleReader reader;
    FplXMLHandler handler;
    handler.setFplOptions(&fplOptions);
    reader.setContentHandler(&handler);    
    FplXMLErrorHandler errorHandler;
    reader.setErrorHandler(&errorHandler);
    bool bResult = reader.parse(&source);
    if (bResult)
    {
        int i;
        std::vector<UnitObjectRef> vectorUnits;
        UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
        for (i = 0; i < (int)vectorUnits.size(); i++)
            if (vectorUnits[i]->unitObjectName != handler.stringTopLevelUnitName)
                UnitObjectContainer::getInstance()->removeObject(vectorUnits[i]);
        vectorUnits.clear();
        UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
        for (i = 0; i < (int)vectorUnits.size(); i++)
            ui->treeWidget->addTopLevelItem(createTreeWidgetItem(vectorUnits[i]));
        std::vector<InterfaceObjectRef> vectorInterfaces;
        InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);
        for (i = 0; i < (int)vectorInterfaces.size(); i++)
            createProperty(vectorInterfaces[i], NULL);
        int iRow = ConnectivityContainer::getInstance()->getNumberOfRows();
        ui->tableWidget->setRowCount(iRow);
        updateTableSpan();
        return true;
    }
    else
    {
        QString stringError = errorHandler.errorString();
        QMessageBox::critical(this, "Parsing Error", stringError, QMessageBox::Ok);
        UnitObjectContainer::getInstance()->clear();
        InterfaceObjectContainer::getInstance()->clear();
        ConnectivityContainer::getInstance()->clear();
        return false;
    }
}

bool MainWindow::projectIsPrepared(QString windowConfirmationTitle) {
    int quiz = -1;
    if( bUpdated ) {
        quiz = QMessageBox::question(this, windowConfirmationTitle, "The project has been changed"
                                     " since last save, do you want to save it?", QMessageBox::Yes, QMessageBox::No, QMessageBox::Cancel);
        switch (quiz) {
        case QMessageBox::Yes : {
                slotFileSave();
                break;
            };
        case QMessageBox::No : {
                QMessageBox::warning( this, windowConfirmationTitle,
                                      "The project was not saved. The already generated code may be invalid", QMessageBox::Ok);
                return false;
            };
        default: return false;
        };
    };
    if( projectFileName.length() == 0 ) {
        if( QMessageBox::information(this, windowConfirmationTitle,
                                     "The project is undefined. Press OK to open a project.",
                                     QMessageBox::Ok, QMessageBox::Cancel) == QMessageBox::Ok ) {
            slotFileOpen();
        } else { return false; };
    };
    return true;
}

void MainWindow::slotGenerateCSL() {
    if( projectIsPrepared("Generate CSL") && projectFileName.length() != 0) {
        bool result = false;
        QString currentName;
        if( projectFileName.endsWith(".csl.xml") ) {
            currentName = projectFileName.left( projectFileName.length() - 4 );
        } else {
            currentName = projectFileName + ".csl";
        }
        result = saveCSLFile(currentName);
        if ( result ) {
            QMessageBox::information(this, "Generate CSL", "The generation of the CSL code was successful!", QMessageBox::Ok);
        } else {
            QMessageBox::critical(this, "Generate CSL", "The generation of the CSL code has failed!", QMessageBox::Ok);
        }
    };
}

void MainWindow::executeCSL() {
    if (!stringCslcLocation.size())
    {
        QString stringFile = QFileDialog::getOpenFileName(this, QString("Open cslc executable"), QString::null,
                                                          "cslc executable file(cslc)");
        if (!stringFile.size())
            return;
        stringCslcLocation = stringFile;
        savePreferences();
    }

    if (!projectFileName.size())
    {
        QMessageBox::critical(this, "Error executing csl script", "Current FastPath design files are not defined, please design it first!\n", QMessageBox::Ok);
        return;
    }


    bool bCSLFileExists = QFile::exists(projectFileName + ".csl");

    if (bUpdated) { // save both the XML and CSL files if the data structures were updated
        slotFileSave();
    }
    else if (! batchModeOn && ! bCSLFileExists) { // save the csl file if batch mode is off and the csl file does not exist
        fileSave();
    }
    else if (batchModeOn) { // batch mode so save the csl file
        if (projectFileName.endsWith(QString(".csl.xml"))) {
            stringCurrentFileName = projectFileName.left(projectFileName.length() - 8);
            saveCSLFile(stringCurrentFileName + ".csl");
        }
        else {
            QMessageBox::critical(this,
                                  "ERROR:: Batch mode::",
                                  QString("Save file ") + projectFileName + QString(" does not exist or has wrong permission!"),
                                  QMessageBox::Ok);

        }
    }

    // Remove
    //      if (QMessageBox::question(this, "Save confirmation", "You have to save the file in order to execute CSL, do you want to save it now?", QMessageBox::Yes, QMessageBox::No) == QMessageBox::No) {
    //        return;
    //      }

    char szTemp[256];
    int fd;
    sprintf(szTemp, "/tmp/fp.XXXXXX");
    if ((fd = ::mkstemp(szTemp)) != -1)
    {
        FILE* pFile = fdopen(fd, "wt");
        if (pFile == NULL)
        {
            unlink(szTemp);
            ::close(fd);
            QMessageBox::critical(this, "Error executing csl script", "Can not create temporary file in /tmp directory!\n", QMessageBox::Ok);
            return;
        }
        fprintf(pFile, "stty echo\n");
        int index = stringCurrentFileName.lastIndexOf('/');
        QString directory;
        if (index == -1) {
            directory = "/";
        }
        else {
            directory = stringCurrentFileName.left(index);
        }

        fprintf(pFile, "unlink \"%s\"\n", szTemp);
        fprintf(pFile, "cd \"%s\"\n", directory.toAscii().data());

        TString logFileName = "";
        if (logDirOn) { logFileName = logDirectoryName; }
        else          { logFileName = (stringCurrentFileName + ".csl.log").toAscii().data();}

        TString clscArgs = ""; // for printing out the r stage status in a debug version of the r

        TString ampersandOn = " ";

        if (batchModeOn) {
            clscArgs = " --cslom_ast --info --csl_pp on --cpp_gen --csim_gen "; // missing $genCodArg from mRun_regress.pl
            ampersandOn = "&";
        }

        fprintf(pFile, 
                "\"%s\" %s %s | tee %s %s\n",
                stringCslcLocation.toAscii().data(), 
                (stringCurrentFileName + ".csl").toAscii().data(), 
                clscArgs.c_str(),
                logFileName.c_str(),
                ampersandOn.c_str());

        if (batchModeOn) { // exit from the shell at the end if we are in batch mode
            fprintf(pFile, "read c\n"); // read a char to exit
            //fprintf(pFile, "exit\n"); // exit immediately
        }
        else {
            fprintf(pFile, "read c\n"); // read a char to exit
        }

        fclose(pFile);

        if (QFile::exists("/usr/bin/xterm"))
        {
            system(QString("/usr/bin/xterm -e sh %1").arg(szTemp).toAscii().data());
            //bUpdated = false;
            //slotFileNew();
        }
        else if (QFile::exists("/usr/X11/bin/xterm"))
        {
            system(QString("/usr/X11/bin/xterm -e sh %1").arg(szTemp).toAscii().data());
            //bUpdated = false;
            //slotFileNew();
        }
        else
        {
            QMessageBox::critical(this, "Error executing csl script", "Can not find xterm in /usr/bin or /usr/X11/bin!\n", QMessageBox::Ok);
            system(QString("/usr/bin/rm -f %1").arg(szTemp).toAscii().data());
        }
    }
    else {
        QMessageBox::critical(this, "Error executing csl script", "Can not create temporary file in /tmp directory!\n", QMessageBox::Ok);
    }
}

void MainWindow::slotExecuteCSL() {
    if(projectIsPrepared("Execute CSL")) {
        if( UnitObjectContainer::getInstance()->mapUnitObjects.size() != 0) {
            executeCSL();
        } else {
            QMessageBox::critical(this, "Execute CSL", "There should be at least one unit in the design", QMessageBox::Ok);
        };
    };
}

void MainWindow::slotOptions()
{
    PreferenceDialog dialog(this, stringCslcLocation);
    if (dialog.exec() == QDialog::Accepted)
    {
        stringCslcLocation = dialog.getCslcLocation();
        savePreferences();
    }
}

// if the batch flag was passed in then exit

void MainWindow::closeEvent(QCloseEvent*) {
    if (!batchModeOn) {
        if (bUpdated && QMessageBox::question(this, QString("Save confirmation"), QString("File content has been changed"
                                                                                          " since last saving, do you want to save the changed contents?"), QMessageBox::Yes, QMessageBox::No) == QMessageBox::Yes)
        {
            slotFileSave();
            bUpdated = true;
        }
    }
}

bool MainWindow::loadPreferences()
{
    const char* pszHome = getenv("HOME");
    if (!pszHome)
        return false;
    QFile file(QString("%1/.fpl_configure").arg(pszHome));
    if (file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        QTextStream stream(&file);
        while(!stream.atEnd())
        {
            QString line = stream.readLine().trimmed();
            if (line[0] == '#') continue;
            if (line.left(11) == "cslc_source")
            {
                int pos = line.indexOf('=');
                if (pos != -1)
                    stringCslcLocation = line.mid(pos + 1).trimmed();
            }
        }
        return true;
    }
    return false;
}

bool MainWindow::savePreferences()
{
    const char* pszHome = getenv("HOME");
    if (!pszHome)
    {
        QMessageBox::critical(this, "Error", "No ${HOME} environment variable is set! I am not able to save prefences!", QMessageBox::Ok);
        return false;
    }
    QFile file(QString("%1/.fpl_configure").arg(pszHome));
    if (file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream stream(&file);
        if (stringCslcLocation.size())
            stream << "cslc_source=" << stringCslcLocation << "\n";
        return true;
    }
    return false;
}


//------------------------------------------------------------
//
//------------------------------------------------------------

bool MainWindow::saveCSLFile(const QString& stringFileName)
{
    QFile file(stringFileName);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QMessageBox::critical(this, "Error writing connection file", QString("Connection file ") + stringFileName
                              + QString(" has wrong permission!"), QMessageBox::Ok);
        return false;
    }
    QTextStream stream(&file);
    
    stream << "// Copyright FastPath Logic (2009)" << endl;
    stream << QString("// Interface Library File v1.0, this is autogenerated by FastPath Generator ") + QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm") << endl;
    stream << "//----------------------------------------------------------------------\n"
            "// Copyright (c) 2005-2008 Fastpathlogic\n"
            "// All Rights Reserved.\n"
            "// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;\n"
            "// the contents of this file may not be disclosed to third parties,\n"
            "// copied or duplicated in any form, in whole or in part, without the prior\n"
            "// written permission of Fastpathlogic.\n"
            "//\n"
            "// RESTRICTED RIGHTS LEGEND:\n"
            "// Use, duplication or disclosure by the Government is subject to\n"
            "// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in\n"
            "// Technical Data and Computer Software clause at DFARS 252.227-7013,\n"
            "// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.\n"
            "// Unpublished rights reserved under the Copyright Laws of the United States\n"
            "//----------------------------------------------------------------------\n" << endl;
    bool status = true;

    //AB edit
    if(fplOptions.bAddIncludes)
    {
        stream << "//Global include statement\n"
               "csl_include \"" << stringCurrentFileName << "_global_includes.csl\";" << endl;
    }
    bool saveCSLInterfaceFileStatus = saveCSLInterfaceFile(stream);
    bool saveCSLUnitFileStatus      = saveCSLUnitFile     (stream);
    status = saveCSLInterfaceFileStatus && saveCSLUnitFileStatus;

    stream.flush();
    file.flush();
    file.close();

    return status;
}


//------------------------------------------------------------
// insert the unit name into the unique unit name list
//------------------------------------------------------------

void MainWindow::insertUnit(TMap_StringBool* mapUnitList, std::string unit) {
    if (mapUnitList->find(unit) == mapUnitList->end()) {
        (*mapUnitList)[unit] = true;
        //      std::cout << "Added "<< unit << " to map" <<endl;
    }
}

//------------------------------------------------------------
// insert the unit name into the unique unit name list
//------------------------------------------------------------

void MainWindow::printUnitList(QTextStream& stream, TMap_StringBool* mapUnitList) {
    TMap_StringBoolIterator iteratorMapUnitList;

    stream << "//------------------------------------------------------------" << endl;
    stream << "// Begin csl_unit predecalaration" << endl;
    stream << "//------------------------------------------------------------" << endl;

    for (iteratorMapUnitList = mapUnitList->begin(); iteratorMapUnitList != mapUnitList->end(); iteratorMapUnitList++)
    {
        std::string sUnitName = iteratorMapUnitList->first;
        stream << "csl_unit " <<  tr(sUnitName.c_str()) << ";" << endl;

    }
}

//------------------------------------------------------------
// 
//------------------------------------------------------------

bool MainWindow::saveCSLUnitFile(QTextStream& stream) {

    bool ret  = saveCSLPredeclarationUnitFile(stream);

    bool ret1 = saveCSLCreateUnitsUnitFile(stream);

    return ret1;
}


//------------------------------------------------------------
// 
//------------------------------------------------------------

bool MainWindow::saveCSLPredeclarationUnitFile(QTextStream& stream) {
    std::set<UnitTypeRef, RefCountingCompare<UnitType> > setSavedTypes;
    std::stack<int> stackChild;
    std::stack<UnitObjectRef> stackObject;
    std::vector<UnitObjectRef> vectorUnits;

    UnitObjectContainer::getInstance()->getAllExpandedUnits(vectorUnits);

    TMap_StringBool mapUnitList; // unique list of units 


    stackChild.push(-1);
    UnitObjectRef unit;
    while(stackChild.size()) {
        int index = stackChild.top() + 1;
        if (stackChild.size() == 1) {
            if (index >= (int)vectorUnits.size()) { break; }
            unit = vectorUnits[index];
            insertUnit(&mapUnitList, unit->pType->unitType.c_str());
        }
        else {
            while (stackObject.size() && index >= (int)stackObject.top()->pType->vectorChildObject.size()) {
                stackObject.pop();
                stackChild.pop();
                index = stackChild.top() + 1;
            }
            if (stackChild.size() == 1) {
                if (index >= (int)vectorUnits.size()) { break; }
                unit = vectorUnits[index];
                insertUnit(&mapUnitList, unit->pType->unitType.c_str());
            }
            else {
                unit = stackObject.top()->pType->vectorChildObject[index];
                insertUnit(&mapUnitList, unit->pType->unitType.c_str());
            }
        }

        stackChild.pop();
        stackChild.push(index);

        if (! setSavedTypes.count(unit->pType)) {
            setSavedTypes.insert(unit->pType);
            stackChild.push(-1);
            stackObject.push(unit);
        }
    }

    printUnitList(stream, &mapUnitList);
    return true;
}


//------------------------------------------------------------
// check if the unit name exists in the unique unit name list
//------------------------------------------------------------

bool MainWindow::unitExists(TMap_StringBool &mapUnitList, std::string &unit) {
    return !(mapUnitList.find(unit) == mapUnitList.end());
}

//------------------------------------------------------------
// 
//------------------------------------------------------------

void MainWindow::printUnitDecl(QTextStream& stream,     
                               UnitObjectRef &parentUnit) {

    if (parentUnit->pType->unitAbbreviation.size()) {
        stream << endl;
        stream << endl;
        stream << endl;
        stream << "//------------------------------------------------------" << endl;
        stream << "// Unit abreviation" << parentUnit->pType->unitAbbreviation.c_str() << endl;
        stream << "//------------------------------------------------------" << endl;
    }

    if (parentUnit->pType->unitDescription.size()) {
        stream << "//------------------------------------------------------" << endl;
        stream << "// Unit abreviation" << parentUnit->pType->unitDescription.c_str() << endl;
        stream << "//------------------------------------------------------" << endl;
    }

}

//------------------------------------------------------------
// print the current unit's:
// -interface instance reverse methods
// -connections 
//------------------------------------------------------------

void MainWindow::printUnitConstructorAndClose(QTextStream&      stream          , 
                                              RefTVec_RefString refIfcInstRefVec,
                                              TString& sCurrentUnitName, 
                                              bool isRoot) {
    qDebug() <<  "printUnitConstructorAndClose " << " sCurrentUnitName = " << sCurrentUnitName.c_str() << endl;

    stream << "\t" << sCurrentUnitName.c_str()  << "() { " <<  endl;
    //AB edit
    if(fplOptions.bAddIncludes)
    {
        stream << "\t\tcsl_include \"" << sCurrentUnitName.c_str() << "_ctor_includes.csl\";" << endl;
    }
    for (TVec_RefString_const_iter i = refIfcInstRefVec.get()->begin(); i != refIfcInstRefVec.get()->end(); i++) {
        stream << "\t\t" << (*i)->c_str()  << ".reverse();" <<  endl;
    }
    //AB LCA detection and connection update
    /* - uncomment to activate
    for (int i = 0; i < (int)ConnectivityContainer::getInstance()->vectorConnectivities.size(); i++)
    {
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->vectorConnectivities[i];
        for (int j = 0; j < (int)connectivity->vectorUnits.size(); j++)
        {
            std::string driver_str = connectivity->vectorUnits[j].first;
            std::string receiver_str = connectivity->vectorUnits[j].second;
            int k = 0;
            std::string lca_str;
            while (driver_str[k] == receiver_str[k])
            {
                lca_str.push_back(driver_str[k]);
                if(k < driver_str.size() && k < receiver_str.size())
                {
                    k++;
                }
                else
                {
                    break;
                }
            }
            std::string lca_unit_str = lca_str;
            std::string::iterator last_char = lca_unit_str.end() - 1;
            if(*last_char == '.')
            {
                lca_unit_str.erase(last_char);
            }
            UnitObjectRef lca_unit = UnitObjectContainer::getInstance()->getObjectByPath(lca_unit_str);
            if(lca_unit.get())
            {
                if(sCurrentUnitName.compare(lca_unit->pType->unitType) == 0)
                {
                    std::string new_driver_src = connectivity->vectorUnits[j].first;
                    if(new_driver_src.find(lca_str) == 0)
                    {
                        new_driver_src = new_driver_src.substr(lca_str.size());
                    }
                    std::string new_receiver_src = connectivity->vectorUnits[j].second;
                    if(new_receiver_src.find(lca_str) == 0)
                    {
                        new_receiver_src = new_receiver_src.substr(lca_str.size());
                    }
                    UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].first);
                    if (unit.get()) {
                        // FIX writer.writeTextElement("DriverUnit", connectivity->vectorUnits[j].first.c_str());
                        RefString rDriverUnitInstance = getInstanceName(new_driver_src);
                        stream << "\t\t" << rDriverUnitInstance.get()->c_str();
                    }
                    if (connectivity->vectorCslInterfaces[j].first.size()) {
                        // FIX writer.writeTextElement("DriverInterfaceInstance", connectivity->vectorCslInterfaces[j].first.c_str());
                        stream << "." << connectivity->vectorCslInterfaces[j].first.c_str();
                    }
                    unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].second);
                    if (unit.get()) {
                        // FIX writer.writeTextElement("ReceiverUnit", connectivity->vectorUnits[j].second.c_str());
                        RefString rReceiverUnitInstance = getInstanceName(new_receiver_src);
                        stream << ".connect_by_name(" << rReceiverUnitInstance.get()->c_str();
                    }
                    if (connectivity->vectorCslInterfaces[j].second.size()) {
                        // FIX writer.writeTextElement("ReceiverInterfaceInstance", connectivity->vectorCslInterfaces[j].second.c_str());
                        stream << "." << connectivity->vectorCslInterfaces[j].second.c_str() << ",";
                    }
                    if (connectivity->actualName.size()){
                        stream << connectivity->actualName.c_str() << ");" << endl;
                    }
                }
            }
            //AB end of LCA detection and connection update
        }
    } // uncomment to here */

    // comment this to activate LCA based connection generation
    if (isRoot) {
        saveCSLConnectionFile(stream);
    }


    stream << "\t" << "}" <<  endl;
    stream << "};" << endl << endl << endl;
}

//------------------------------------------------------------
// find the longer string
// attempt to match the shorter string
// a.b.c.d
// a.b.x
// a.b == a.b so PC
// 
// a.b.c.x
// a.b.e.y
// a.b.c != a.b.e so ! PC
// 
//------------------------------------------------------------

bool MainWindow::isParentToChildConnection(TString& s0, TString& s1) {
    bool parentChildMatch = false;

    int s0Len = s0.length();
    int s1Len = s1.length();

    //  if      (s0Len == s1Len) { parentChildMatch = (0 == s0.compare(s1)); } // equal strings but-> different strings are siblings
    // strings which are shorter and match the longer string are PC
    if (s0Len <  s1Len) {
        int comp = s1.compare(0, s0.length(), s0);
        parentChildMatch = 0 ==  comp;
    }
    else {
        int comp = s0.compare(0, s1.length(), s1);
        parentChildMatch = 0 == comp;
    }

    qDebug() << "isParentToChildConnection s0 = " << s0.c_str()  << " " << s1.c_str() << " parentChildMatch = "  << parentChildMatch <<endl;

    return parentChildMatch;
}


//------------------------------------------------------------
// check if the interface type name/ instance name exists 
//------------------------------------------------------------

bool MainWindow::typeInstIfcExists(TMap_StringString& unitInstanceMap, TString& typeName, TString& instName) {
    bool exists = false;

    TMap_StringString::iterator iter;
    qDebug() << "typeInstIfcExists ifcTypeName = " << typeName.c_str()  << " " << instName.c_str() << endl;

    for (TMap_StringString::iterator i = unitInstanceMap.begin(); i != unitInstanceMap.end(); i++) {
        qDebug() << "typeInstIfcExists map[ " << (*i).first.c_str()  << "] = " << (*i).second.c_str() << endl;
    }

    if (unitInstanceMap.find(instName) != unitInstanceMap.end()) {
        iter = unitInstanceMap.find(instName);
        qDebug() << "typeInstIfcExists 1 " << endl;
        if ((*iter).second == typeName) {
            qDebug() << "typeInstIfcExists 2 " << endl;
            exists = true;
        }
    }

    return exists;
}

//------------------------------------------------------------
// print the interface instances in the unit and 
// determine which instances to reverse in the constructor 
//------------------------------------------------------------

bool MainWindow::printUnitInterfaceInstances(QTextStream& stream, TString& sCurrentUnit, RefTVec_RefString ifcInstRefVec) {

    stream << "\t// interface instances" << endl;

    TMap_StringString unitInstanceMap;


    //RefTVec_RefString ifcReceiverVec = RefTVec_RefString(new TVec_RefString());

    int i, j;
    for (i = 0; i < (int)ConnectivityContainer::getInstance()->vectorConnectivities.size(); i++)
    {
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->vectorConnectivities[i];
        // FIX writer.writeStartElement("Connection");
        if (connectivity->actualName.size()){
            // FIX writer.writeTextElement("ActualName", connectivity->actualName.c_str());
        }
        if (connectivity->interface.size())
        {
            InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(connectivity->interface);
            if (interface.get())
            {
                // FIX writer.writeTextElement("InterfaceName", connectivity->interface.c_str());
                if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE) {
                    // FIX writer.writeTextElement("InterfaceType", "interface");
                }
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_PORT) {
                    // FIX writer.writeTextElement("InterfaceType", "port");
                }
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNAL) {
                    // FIX writer.writeTextElement("InterfaceType", "signal");
                }
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP) {
                    // FIX writer.writeTextElement("InterfaceType", "signalgroup");
                }
            }
            else
            {
                QMessageBox::critical(this, "Unable to save connection file",
                                      QString("Error:printUnitInterfaceInstances:1 The connection table contains invalid interface %1").arg(connectivity->interface.c_str()), QMessageBox::Ok);
                return false;
            }
        }
        else
        {
            QMessageBox::critical(this, "Unable to save connection file",
                                  QString("Error:printUnitInterfaceInstances:2 The connection table contains invalid interface %1").arg(connectivity->interface.c_str()), QMessageBox::Ok);
            return false;
        }

        // instantiate the driver and receiver interfaces in the unit declaration
        // detect duplicate interface instances
        // dups occur when a single interface instance drives more than one interface
        // dups occur when a single interface instance receives more than one interface


        for (j = 0; j < (int)connectivity->vectorUnits.size(); j++) {
            qDebug() << "------------------------------------------------------------------------------" << endl;
            UnitObjectRef driverUnit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].first);
            RefString sDriverLeafUnit = getLeafUnitName(connectivity->vectorUnits[j].first);

            UnitObjectRef receiverUnit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].second);
            RefString sReceiverLeafUnit = getLeafUnitName(connectivity->vectorUnits[j].second);

            if (sCurrentUnit == *(sDriverLeafUnit).get()) {
                TString ifcTypeName = connectivity->interface.c_str();
                TString ifcInstName = connectivity->vectorCslInterfaces[j].first.c_str();
                if (!typeInstIfcExists(unitInstanceMap, ifcTypeName, ifcInstName)) {
                    unitInstanceMap[ifcInstName] = ifcTypeName;
                    stream << "\t" << ifcTypeName.c_str()  << " " << ifcInstName.c_str() << "; // driver interface" << endl;
                    qDebug() << "driver sCurrentUnit = " << sCurrentUnit.c_str()  << " ifcTypeName = " << ifcTypeName.c_str()  << " instname = " << ifcInstName.c_str() << endl;
                    for (TMap_StringString::iterator i = unitInstanceMap.begin(); i != unitInstanceMap.end(); i++) {
                        qDebug() << "driver map[ " << (*i).first.c_str()  << "] = " << (*i).second.c_str() << endl;
                    }

                }
            }

            if (sCurrentUnit == *(sReceiverLeafUnit).get()) {
                TString ifcTypeName = connectivity->interface.c_str();
                TString ifcInstName = connectivity->vectorCslInterfaces[j].second.c_str();
                if (!typeInstIfcExists(unitInstanceMap, ifcTypeName, ifcInstName)) {
                    unitInstanceMap[ifcInstName] = ifcTypeName;

                    stream << "\t" << ifcTypeName.c_str() << " " << ifcInstName.c_str() << "; // receiver interface" << endl;
                    qDebug() << "receiver sCurrentUnit = " << sCurrentUnit.c_str()  << " ifcTypeName = " << ifcTypeName.c_str()  << " inst name =  " <<ifcInstName.c_str() << endl;

                    for (TMap_StringString::iterator i = unitInstanceMap.begin(); i != unitInstanceMap.end(); i++) {
                        qDebug() << "driver map[ " << (*i).first.c_str()  << "] = " << (*i).second.c_str() << endl;
                    }

                    // push the interfaces that need to be reversed in the receiver units
                    // do not reverse the parent to and child to parent connections
                    RefString rDriverUnitInstance = getInstanceName(connectivity->vectorUnits[j].first);
                    RefString rReceiverUnitInstance = getInstanceName(connectivity->vectorUnits[j].second);

                    if (! isParentToChildConnection(*rDriverUnitInstance, *rReceiverUnitInstance)) {
                        RefString rs = RefString(new TString(connectivity->vectorCslInterfaces[j].second));
                        ifcInstRefVec.get()->push_back(rs);
                        qDebug() <<  "Reverse  = " << connectivity->vectorCslInterfaces[j].second.c_str() << endl;
                    }
                }
            }
        }
    }

    return true;
}

//------------------------------------------------------------
// 
//------------------------------------------------------------

void MainWindow::printUnitDeclaration(QTextStream& stream, 
                                      RefTMap_RefStringRefString rsTsTs,
                                      TString& sCurrentUnitName
                                      ) {
    qDebug() <<  "printUnitDeclaration For sCurrentUnitName = " << sCurrentUnitName.c_str() << endl;

    stream << "//------------------------------------------------------" << endl;
    stream << "csl_unit " << sCurrentUnitName.c_str() <<  " {  // declaration" << endl;


    stream << "\t// unit instances" << endl;

    for (TMap_RefStringRefString_iter k = rsTsTs.get()->begin(); k != rsTsTs.get()->end(); k++) {
        stream <<  "\t" << (*k).first.get()->c_str() << " " << (*k).second.get()->c_str() << "; // unit instance" << endl;
    }
}

//------------------------------------------------------------
// 
//------------------------------------------------------------

void MainWindow::printUnitDeclarations(QTextStream& stream, 
                                       RefTMap_TString_RefTMap_RefStringRefString& refDesignHierarchy,
                                       TString sRootUnitName) {
    qDebug() <<  "printUnitDeclarations sRootUnitName = " << sRootUnitName.c_str() << endl;

    RefTMap_RefStringRefString mapUnitNameUnitInstName; // FIX init??

    TVec_RefString ifcInstRefVec; // vector of receiver interface instances in the current unit-add <ifcInstance>.reverse() in unit constructor
    RefTVec_RefString refIfcInstRefVec = RefTVec_RefString(new TVec_RefString());

    TMap_TString_RefTMap_RefStringRefString* dh = refDesignHierarchy.get();

    for (TMap_TString_RefTMap_RefStringRefString_iter i = dh->begin(); i != dh->end(); i++) {
        TString sCurrentUnitName = *((*i).first);
        RefTMap_RefStringRefString rsTsTs= (*i).second;

        qDebug() <<  "***printUnitDeclarations CHILD BEFORE IF sRootUnitName = " << sRootUnitName.c_str()
                << " sCurrentUnitName = " << sCurrentUnitName.c_str() << endl;
        if (sRootUnitName != sCurrentUnitName) {
            qDebug() <<  "***printUnitDeclarations CHILD IF sRootUnitName = " << sRootUnitName.c_str()
                    << " sCurrentUnitName = " << sCurrentUnitName.c_str() << endl;
            printUnitDeclaration(stream, rsTsTs, sCurrentUnitName);
            refIfcInstRefVec.get()->clear();
            printUnitInterfaceInstances (stream, sCurrentUnitName, refIfcInstRefVec);
            bool isRoot = false;
            //AB edit
            if(fplOptions.bAddIncludes)
            {
                stream << "\tcsl_include \"" << sCurrentUnitName.c_str() << "_declarations_includes.csl\";" << endl;
            }
            printUnitConstructorAndClose(stream, refIfcInstRefVec, sCurrentUnitName, isRoot);
        }
    }

    // FIX make into a find instead of a for loop
    for (TMap_TString_RefTMap_RefStringRefString_iter i = dh->begin(); i != dh->end(); i++) {
        TString sCurrentUnitName = *((*i).first);
        RefTMap_RefStringRefString rsTsTs= (*i).second;

        if (sRootUnitName == sCurrentUnitName) {
            qDebug() <<  "printUnitDeclarations ROOT IF sRootUnitName = " << sRootUnitName.c_str() << endl;
            printUnitDeclaration(stream, rsTsTs, sCurrentUnitName);
            bool isRoot = true;
            refIfcInstRefVec.get()->clear();
            printUnitInterfaceInstances (stream, sRootUnitName, refIfcInstRefVec);
            printUnitConstructorAndClose(stream, refIfcInstRefVec, sCurrentUnitName, isRoot);
        }
    }
}

//------------------------------------------------------------
// Traverse the design hierarchy and create a new unit hierarchy
// pass the new data structure to the print routine 
//------------------------------------------------------------

bool MainWindow::saveCSLCreateUnitsUnitFile(QTextStream& stream) {
    stream << endl;
    stream << endl;
    stream << endl;
    stream << "//------------------------------------------------------------" << endl;
    stream << "// Begin csl_unit declarations" << endl;
    stream << "//------------------------------------------------------------" << endl;

    // for traversing the QT support data structure
    std::set<UnitTypeRef, RefCountingCompare<UnitType> > setSavedTypes;
    std::stack<int> stackChild;
    std::stack<UnitObjectRef> stackObject;
    std::vector<UnitObjectRef> vectorUnits;
    UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
    stackChild.push(-1)     ; // initialize with out of bounds index

    // for creating a new data structure to print
    TMap_StringBool   mapUniqueUnits; // map of the units in the design
    RefTMap_TString_RefTMap_RefStringRefString refDesignHierarchy = RefTMap_TString_RefTMap_RefStringRefString(new TMap_TString_RefTMap_RefStringRefString()); // map of parent unit name and list of children (unitName,InstanceName)
    UnitObjectRef unit      ; // name of the current unit object
    RefTMap_RefStringRefString refMapUnitNameUnitInstName; // FIX init with RefTMap_RefStringRefString(new TMap_RefStringRefString())  the map of a scope's unit and instance names
    TString        sRootUnitName; // the top unit 

    while (stackChild.size()) { // while the stack is not empty
        int index = stackChild.top() + 1;
        if (stackChild.size() == 1) {
            if (index >= (int)vectorUnits.size()) {
                break;
            }
            unit = vectorUnits[index];
            // sRootUnitName = unit->unitObjectName;
            sRootUnitName = unit->pType->unitType; // use the unit name not the instance name
        }
        else {
            while (stackObject.size() && index >= (int)stackObject.top()->pType->vectorChildObject.size()) {
                stackObject.pop();
                stackChild.pop();
                index = stackChild.top() + 1;
            }

            if (stackChild.size() == 1) {
                if (index >= (int)vectorUnits.size()) {
                    break;
                }
                unit = vectorUnits[index];
            }
            else {
                unit = stackObject.top()->pType->vectorChildObject[index];
            }
        } 

        stackChild.pop();
        stackChild.push(index);

        if (! setSavedTypes.count(unit->pType)) { // remember the units that have been seen
            setSavedTypes.insert(unit->pType);
            stackChild.push(-1);
            stackObject.push(unit);

            UnitObjectRef currentUnit = stackObject.top();
            TString sCurrentUnitName  = currentUnit->pType->unitType;

            if (mapUniqueUnits.find(sCurrentUnitName) == mapUniqueUnits.end()) { // add the children to the current unit
                //qDebug() <<  "inside if (mapUniqueUnits.find(sCurrentUnitName) " << sCurrentUnitName.c_str()<< endl;
                TVec_UnitObjectRef vc = currentUnit->pType->vectorChildObject;
                refMapUnitNameUnitInstName = RefTMap_RefStringRefString(new TMap_RefStringRefString());
                // BEGIN Added by AB 2010-02-02
                if((currentUnit)->getUnitColor() == UnitObject::GREEN){
                    for (TVec_UnitObjectRefIterator i = vc.begin(); i != vc.end(); i++) {
                        refMapUnitNameUnitInstName->insert(std::pair<RefString,RefString>(RefString(new std::string((*i)->pType->unitType)),
                                                                                          RefString(new std::string((*i)->unitObjectName))));
                    }
                }
                // END Added by AB 2010-02-02
                //qDebug() <<  "-----------------------------------------------------" << endl;
                for (TMap_RefStringRefString_iter k = refMapUnitNameUnitInstName.get()->begin();
                k != refMapUnitNameUnitInstName.get()->end();
                k++) {
                    //qDebug() <<  "Instance List parent: " << sCurrentUnitName.c_str() << " unit: " << sCurrentUnitName.c_str() << " inst:  "
                    // << (*k).first.get()->c_str() << " " << (*k).second.get()->c_str()
                    //<< "; // unit instance" << endl;
                }

                // qDebug() << "addd children to unit:: " << rsParentUnit.get()->c_str() << endl;
                mapUniqueUnits[sCurrentUnitName] = true;
                // the parent points to the map of unit instances
                refDesignHierarchy->insert(std::pair<RefString, RefTMap_RefStringRefString>
                                           (RefString(new std::string(sCurrentUnitName)),
                                            refMapUnitNameUnitInstName)
                                           );
            }
        }
    }

    // print the child and then the root unit declarations
    printUnitDeclarations(stream, refDesignHierarchy, sRootUnitName);

    return true;
}

//------------------------------------------------------------
// extract the instance name from the string <unitName>(<instanceName>)
//------------------------------------------------------------

RefString MainWindow::getInstanceName(TString& sUnitInstance) {
    bool notFirstTime = false;
    TString sTmp = "";
    TString sUnitInstanceCopy = sUnitInstance;
    // qDebug() << "sUnitInstance = " << sUnitInstance.c_str() << "\n";

    while (sUnitInstanceCopy.find('(') != std::string::npos) {
        if (! notFirstTime) { notFirstTime = true; }
        else {
            sTmp += ".";
        }
        int iLeft = sUnitInstanceCopy.find('(');
        int iRight = sUnitInstanceCopy.find(')');
        // qDebug() << "iLeft+1                  = " << iLeft + 1                 ;
        // qDebug() << "  iRight                   = " << iRight                  ;
        // qDebug() << "  sUnitInstanceCopy.length()-1 = " << sUnitInstanceCopy.length() - 1;
        // qDebug() << "sUnitInstanceCopy = " << sUnitInstanceCopy.c_str() ;
        // qDebug() << endl;
        if (sUnitInstanceCopy.find('.') != std::string::npos) { // see if there is another dot
            // qDebug() << "if" << endl;
            sTmp += sUnitInstanceCopy.substr(iLeft + 1, iRight - iLeft - 1);
            sUnitInstanceCopy = sUnitInstanceCopy.substr(iRight + 3, sUnitInstanceCopy.length() - 1);
            // qDebug() << "sUnitInstanceCopy = " << sUnitInstanceCopy.c_str()  << endl;
        }
        else {
            // qDebug() << "else" << endl;
            sTmp += sUnitInstanceCopy.substr(iLeft + 1, iRight - iLeft - 1);
            sUnitInstanceCopy = "";
        }
        // qDebug() << "sTmp = "<< sTmp.c_str()  << endl;
    }

    // qDebug() << "Final sUnitInstanceCopy = " << sUnitInstanceCopy.c_str()  << endl;
    // qDebug() << "Final sTmp = " << sTmp.c_str()  << endl;

    return (RefString(new std::string(sTmp)));
}

//------------------------------------------------------------
// extract the leaf level unit name from the string <unitName>.(<instanceName>)
//------------------------------------------------------------

RefString MainWindow::getLeafUnitName(TString& sUnitInstance) {
    bool notFirstTime = false;
    TString sTmp = "";
    TString sUnitInstanceCopy = sUnitInstance;
    // qDebug() << "sUnitInstance = " << sUnitInstance.c_str() << "\n";

    while (sUnitInstanceCopy.find('(') != std::string::npos) {
        if (! notFirstTime) { notFirstTime = true; }
        int iLeft = sUnitInstanceCopy.find('(');
        int iRight = sUnitInstanceCopy.find(')');
        // qDebug() << "Leaf iLeft+1                  = " << iLeft + 1                 ;
        // qDebug() << "Leaf   iRight                   = " << iRight                  ;

        if (sUnitInstanceCopy.find('.') != std::string::npos) { // see if there is another dot
            // qDebug() << "Leaf if" << endl;
            // qDebug() << "Leaf   sUnitInstanceCopy.length()-1 = " << sUnitInstanceCopy.length() - 1;
            // qDebug() << "Leaf sUnitInstanceCopy = " << sUnitInstanceCopy.c_str() ;
            // qDebug() << endl;
            sUnitInstanceCopy = sUnitInstanceCopy.substr(iRight + 2, sUnitInstanceCopy.length() - 1);
            // qDebug() << "Leaf sUnitInstanceCopy = " << sUnitInstanceCopy.c_str()  << endl;
        }
        else { // last unit/instance pair
            // qDebug() << "Leaf else" << endl;
            sTmp = sUnitInstanceCopy.substr(0, iLeft); // the last pair is of the format <unitName(<instanceName>)-extract <unitName>
            sUnitInstanceCopy = "";
        }
        // qDebug() << "Leaf sTmp = "<< sTmp.c_str()  << endl;
    }

    // qDebug() << "Leaf Final sUnitInstanceCopy = " << sUnitInstanceCopy.c_str()  << endl;
    // qDebug() << "Leaf Final sTmp = " << sTmp.c_str()  << endl;

    return (RefString(new std::string(sTmp)));
}

//------------------------------------------------------------
// save the connections in a CSL format 
//------------------------------------------------------------

bool MainWindow::saveCSLConnectionFile(QTextStream& stream)
{
    int i, j;
    for (i = 0; i < (int)ConnectivityContainer::getInstance()->vectorConnectivities.size(); i++)
    {
        ConnectivityRef connectivity = ConnectivityContainer::getInstance()->vectorConnectivities[i];
        // FIX writer.writeStartElement("Connection");
        if (connectivity->actualName.size()){
            // FIX writer.writeTextElement("ActualName", connectivity->actualName.c_str());
        }
        if (connectivity->interface.size())
        {
            InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(connectivity->interface);
            if (interface.get())
            {
                // FIX writer.writeTextElement("InterfaceName", connectivity->interface.c_str());
                if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE) {
                    // FIX writer.writeTextElement("InterfaceType", "interface");
                }
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_PORT) {
                    // FIX writer.writeTextElement("InterfaceType", "port");
                }
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNAL) {
                    // FIX writer.writeTextElement("InterfaceType", "signal");
                }
                else if (interface->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP) {
                    // FIX writer.writeTextElement("InterfaceType", "signalgroup");
                }
            }
            else
            {
                QMessageBox::critical(this, "Unable to save connection file",
                                      QString("Error: saveCSLConnectionFile: 1: The connection table contains invalid interface %1").arg(connectivity->interface.c_str()), QMessageBox::Ok);
                return false;
            }
        }
        else
        {
            QMessageBox::critical(this, "Unable to save connection file",
                                  QString("Error: saveCSLConnectionFile: 2: The connection table contains invalid interface %1").arg(connectivity->interface.c_str()), QMessageBox::Ok);
            return false;
        }

        for (j = 0; j < (int)connectivity->vectorUnits.size(); j++)
        {
            // FIX writer.writeStartElement("InterfaceConnection");
            UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].first);
            if (unit.get()) {
                // FIX writer.writeTextElement("DriverUnit", connectivity->vectorUnits[j].first.c_str());
                RefString rDriverUnitInstance = getInstanceName(connectivity->vectorUnits[j].first);
                stream << "\t\t" << rDriverUnitInstance.get()->c_str();
            }
            if (connectivity->vectorCslInterfaces[j].first.size()) {
                // FIX writer.writeTextElement("DriverInterfaceInstance", connectivity->vectorCslInterfaces[j].first.c_str());
                stream << "." << connectivity->vectorCslInterfaces[j].first.c_str();
            }
            unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[j].second);
            if (unit.get()) {
                // FIX writer.writeTextElement("ReceiverUnit", connectivity->vectorUnits[j].second.c_str());
                RefString rReceiverUnitInstance = getInstanceName(connectivity->vectorUnits[j].second);
                stream << ".connect_by_name(" << rReceiverUnitInstance.get()->c_str();
            }
            if (connectivity->vectorCslInterfaces[j].second.size()) {
                // FIX writer.writeTextElement("ReceiverInterfaceInstance", connectivity->vectorCslInterfaces[j].second.c_str());
                stream << "." << connectivity->vectorCslInterfaces[j].second.c_str() << ",";
            }
            if (connectivity->actualName.size()){
                stream << connectivity->actualName.c_str() << ");" << endl;
            }
        }
    }
    return true;
}

//........................................
// Auxillary function for converting from upper to lower case
//........................................

//const char * MainWindow::toLower(std::string data)
// {
//   std::transform(data.begin(), data.end(), data.begin(), ::tolower);
//  return data.c_str();
// }

//........................................
// Write out a CSL version of the interface library file
//........................................

bool MainWindow::saveCSLInterfaceFile(QTextStream& stream)
{
    stream << endl;
    stream << endl;
    stream << endl;
    stream << "//------------------------------------------------------------" << endl;
    stream << "// Begin csl_interface declarations" << endl;
    stream << "//------------------------------------------------------------" << endl;


    std::set<InterfaceTypeRef, RefCountingCompare<InterfaceType> > setSavedTypes;
    std::stack<int> stackChild;
    std::stack<InterfaceObjectRef> stackObject;
    std::vector<InterfaceObjectRef> vectorInterfaces;
    Tpair_LogicalType pairLogicalType;  //MS added
    TVec_LogicalType vectorLogicalType; //MS added
    TVec_LogicalTypeIterator logicalTypeIter; //MS added
    InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);

    std::string currentInterfaceName;
    bool firstInterface = true; // used to control when to write closing braces for csl_interface
    bool logical_type = false; // MS added, is true when the port has a logical_type
    QString logical_data = "NONE"; //MS added
    stackChild.push(-1);
    InterfaceObjectRef interface;

    while(stackChild.size()) {
        int index = stackChild.top() + 1;
        if (stackChild.size() == 1) {
            if (index >= (int)vectorInterfaces.size()) {break;}
            interface = vectorInterfaces[index];
        }
        else {
            while (stackObject.size() && index >= (int)stackObject.top()->pType->vectorChildObject.size()) {
                stackObject.pop();
                stackChild.pop();
                index = stackChild.top() + 1;
            }
            if (stackChild.size() == 1) {
                if (index >= (int)vectorInterfaces.size()) { break; }
                interface = vectorInterfaces[index];
            }
            else {
                interface = stackObject.top()->pType->vectorChildObject[index];
            }
        }

        stackChild.pop();
        stackChild.push(index);

        //qDebug() << "xxxxxxx" << interface->pType->interfaceCategory;
        switch(interface->pType->interfaceCategory) {
        case InterfaceType::CATEGORY_INTERFACE:
            if (setSavedTypes.count(interface->pType)) {
                stream << "   " << interface->pType->interfaceType.c_str() << " " << interface->interfaceObjectName.c_str() << ";" << endl << endl;
            }
            else
            {
                setSavedTypes.insert(interface->pType);

                if (firstInterface) { // don't write out the closing brace for the first interface
                    firstInterface = false;
                }
                else {
                    if (interface->pType->logicalType != InterfaceType::LOGICAL_UNKNOWN) {
                        logical_type = true ;
                    }
                    stream << endl
                            << "    "
                            << QString(currentInterfaceName.c_str())
                            << "() {"
                            << endl;
                    //---------MS added------
                    //if (logical_type == true){
                        for (logicalTypeIter = vectorLogicalType.begin(); logicalTypeIter != vectorLogicalType.end(); logicalTypeIter++){
                            stream << "      "
                                    << logicalTypeIter->first
                                    <<".set_attr( "
                                    << logicalTypeIter->second
                                    << ");" << endl ;
                        }
                        vectorLogicalType.clear();
                    //}
                    stream << " }"
                            << endl
                            << "};" << endl << endl;
                    //------------end-------------
                }

                stream << "csl_interface" <<  " " << QString(interface->interfaceObjectName.c_str()) << " { " << endl;

                stackChild.push(-1);
                stackObject.push(interface);
                currentInterfaceName = interface->interfaceObjectName;
            }
            break;
        case InterfaceType::CATEGORY_PORT:
            if (setSavedTypes.count(interface->pType)) {
                stream <<  "   " << interface->pType->interfaceType.c_str() <<  " " << interface->interfaceObjectName.c_str() << endl;

            }
            else {
                setSavedTypes.insert(interface->pType);

                QString portArg;

                if (0 == interface->pType->iLowerLimitBit) { // the lower index is zero so use a width
                    unsigned int width = interface->pType->iUpperLimitBit - interface->pType->iLowerLimitBit + 1;

                    portArg.setNum(width);
                }
                else { // lower bit is not zero so create a bitrange object
                    //                     unsigned int width = interface->pType->iUpperLimitBit - interface->pType->iLowerLimitBit + 1;
                    QString bitRange = QString("br_") + QString(interface->interfaceObjectName.c_str());
                    stream << "    csl_bitrange "
                            <<  bitRange
                            << " ( "
                            << interface->pType->iUpperLimitBit
                            << ","
                            << interface->pType->iLowerLimitBit
                            << ");"
                            << endl;

                    portArg = bitRange;
                }


                std::string port = interface->pType->getDirection();
                std:: string wireType = interface->pType->getWireType();

                std::transform(port.begin(), port.end(), port.begin(), ::tolower);
                std::transform(wireType.begin(), wireType.end(), wireType.begin(), ::tolower);

                stream << "    csl_port "
                        << interface->interfaceObjectName.c_str()
                        << " ( "
                        << port.c_str();
                stream                    << " , "
                        <<wireType.c_str();

                stream                    << " , "
                        <<portArg;

                stream << ");" << endl;


                /*
                if (interface->pType->wireType != InterfaceType::WIRE_UNKNOWN) {
//                           const char * c = MainWindow::toLower(interface->pType->getWireType());
                  std::string data = interface->pType->getWireType();
                  std::transform(data.begin(), data.end(), data.begin(), ::tolower);
                  stream  << data.c_str() << ",";
                }
                stream << ","
                       << portArg;
                */

                // cslc bug- connections with logic types are not working
                // Logical type-------   MS added  -------begin


                if (interface->pType->logicalType != InterfaceType::LOGICAL_UNKNOWN) {

            logical_type = true ;
            //logicalTypeIter++;
                   //     stream << interface->interfaceObjectName.c_str() << ".set_attr(" << interface->pType->getLogicalType().c_str() << " );" <<endl;
                   //     std::string data = interface->pType->getLogicalType();
            //qDebug() << "xxxxxxx Logical Type: " << interface->pType->getLogicalType().c_str();
                   //     std::transform(data.begin(), data.end(), data.begin(), ::tolower);


                        if(interface->pType->getLogicalType() == "STALL")  {
                            logical_data = "stall";

                        }
                        else
                            if(interface->pType->getLogicalType() == "ENABLE")  {
                            logical_data = "en";
                        }
                        else
                            if(interface->pType->getLogicalType() == "MUXSELECT")  {
                            logical_data = "mux_sel";
                        }
                        else
                            if(interface->pType->getLogicalType() == "CLOCKSIGNAL")  {
                            logical_data = "clock";
                        }
                        else
                            if(interface->pType->getLogicalType() == "RESETSIGNAL")  {
                            logical_data = "reset";
                        }
                        else
                            if(interface->pType->getLogicalType() == "DECODEDMINTERM" || interface->pType->getLogicalType() == "DECODEDMAXTERM" )  {
                            logical_data = "decode";
                        }
                        else
                            if(interface->pType->getLogicalType() == "NONE")  {
                            logical_type = false;
                        }
                        if(logical_type)
                            vectorLogicalType.push_back(Tpair_LogicalType (QString(interface->interfaceObjectName.c_str()), logical_data));

                    }
      else {
                    logical_type = false ;
                }
 /* for (logicalTypeIter = vectorLogicalType.begin(); logicalTypeIter != vectorLogicalType.end(); logicalTypeIter++){
     logicalTypeIter->first = interface->interfaceObjectName.c_str();
     logicalTypeIter->second = logical_data;
      }*/

                //--------end----------------

                stackChild.push(-1);
                stackObject.push(interface);
            }
            break;
        case InterfaceType::CATEGORY_SIGNAL:
            if (setSavedTypes.count(interface->pType))
            {
                //FIXME: How to handle the duplicate reference of the same "signal"?
            }
            else
            {
                setSavedTypes.insert(interface->pType);
                char szBuffer[256];
                sprintf(szBuffer, "%d:%d", interface->pType->iUpperLimitBit, interface->pType->iLowerLimitBit);
                if (interface->pType->wireType != InterfaceType::WIRE_UNKNOWN)
                {
                    // FIX stream << writeTextElement("WireType", interface->pType->getWireType().c_str());
                }
                if (interface->pType->logicalType != InterfaceType::LOGICAL_UNKNOWN)
                {
                    // FIX stream << writeTextElement("LogicType", interface->pType->getLogicalType().c_str());
                }
                stackChild.push(-1);
                stackObject.push(interface);
            }
            break;
        case InterfaceType::CATEGORY_SIGNALGROUP:
            if (setSavedTypes.count(interface->pType)) {
                stream << "   " << interface->pType->interfaceType.c_str() << " " << interface->interfaceObjectName.c_str() << ";" << endl << endl;
            }
            else
            {
                setSavedTypes.insert(interface->pType);

                if (firstInterface) { // don't write out the closing brace for the first interface
                    firstInterface = false;
                }
                else {
                    stream << endl
                            << "    "
                            << QString(currentInterfaceName.c_str())
                            << "() {" << endl ;

                    //---------MS added------begin-------
                                     // if (logical_type == true){
                          for (logicalTypeIter = vectorLogicalType.begin(); logicalTypeIter != vectorLogicalType.end(); logicalTypeIter++){
                         stream <<"      "
                                << logicalTypeIter->first
                                <<".set_attr( " << logicalTypeIter->second
                                << ");" << endl ;
                     }; vectorLogicalType.clear();
                        //}
                    stream << " }"
                            << endl
                            << "};" << endl << endl;
                    //----end----------
                }

                stream << "csl_signal_group" <<  " " << QString(interface->interfaceObjectName.c_str()) << " { " << endl;

                stackChild.push(-1);
                stackObject.push(interface);
                currentInterfaceName = interface->interfaceObjectName;
            }
            break;
        default: // FIX put in an error msg
            break;
        }
    }
    stream << endl
            << "    "
            << QString(currentInterfaceName.c_str())
            << "() { "
            << endl ;
    
    //---------MS added------
    //if (logical_type == true){
        for (logicalTypeIter = vectorLogicalType.begin(); logicalTypeIter != vectorLogicalType.end(); logicalTypeIter++){
            stream << "      "
                    << logicalTypeIter->first
                    <<".set_attr( "
                    << logicalTypeIter->second
                    << ");" << endl ;
        }; vectorLogicalType.clear();
    //}
    stream << "    }"
            << endl
            << "};" << endl << endl;

    return true;
}

void MainWindow::slotActionPreferences()
{
    OptionDialog dialog(fplOptions, this);
    dialog.exec();
}
