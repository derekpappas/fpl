#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtGui/QMainWindow>
#include "qtvariantproperty.h"
#include "qttreepropertybrowser.h"
#include "qtpropertybrowser.h"
#include "qtgroupboxpropertybrowser.h"
#include "fploptions.h"
#include <QTextStream>
#include <QXmlStreamReader>
#include <QXmlStreamWriter>
#include <string>
#include <stack>
#include <map>
#include <string>
#include <QFileInfo>
#include <QDateTime>
// BEGIN Added by AB 2010-02-02
#include "unit.h"
// END Added by AB 2010-02-02

class QXmlStreamWriter;

#include "refcounted.h"

#include <boost/shared_ptr.hpp>
#include <boost/weak_ptr.hpp>


class QContextMenuEvent;
class QTreeWidgetItem;
class QTableWidgetItem;
class ConnectionTable;
class InterfaceType;
typedef RefCounting<InterfaceType> InterfaceTypeRef;
class UnitObject;
typedef RefCounting<UnitObject> UnitObjectRef;
class InterfaceObject;
typedef RefCounting<InterfaceObject> InterfaceObjectRef;
typedef std::pair<QString,QString> Tpair_LogicalType;  //MS added
typedef std::vector<Tpair_LogicalType> TVec_LogicalType; //MS added
typedef TVec_LogicalType::iterator TVec_LogicalTypeIterator; //MS added

typedef std::string TString;
typedef std::map <TString, bool>  TMap_StringBool;
typedef TMap_StringBool::iterator TMap_StringBoolIterator;

typedef std::map <TString, TString>  TMap_StringString;
typedef TMap_StringString::iterator TMap_StringStringIterator;

typedef std::map <TString, bool>  TMap_StringBool;
typedef TMap_StringBool::iterator TMap_StringBool_iter;

typedef std::vector<UnitObjectRef>  TVec_UnitObjectRef;
typedef TVec_UnitObjectRef::iterator TVec_UnitObjectRefIterator;


typedef boost::shared_ptr<TString> RefString;

typedef std::vector<RefString>                                     TVec_RefString;
typedef boost::shared_ptr<TVec_RefString>                          RefTVec_RefString;
typedef TVec_RefString::const_iterator                             TVec_RefString_const_iter;

typedef std::map<RefString, RefString>                             TMap_RefStringRefString;
typedef boost::shared_ptr<TMap_RefStringRefString>                 RefTMap_RefStringRefString;
typedef std::map <RefString, RefTMap_RefStringRefString>           TMap_TString_RefTMap_RefStringRefString; 
typedef boost::shared_ptr<TMap_TString_RefTMap_RefStringRefString> RefTMap_TString_RefTMap_RefStringRefString;  

typedef TMap_RefStringRefString::iterator                          TMap_RefStringRefString_iter;
typedef TMap_TString_RefTMap_RefStringRefString::iterator          TMap_TString_RefTMap_RefStringRefString_iter;
typedef TMap_TString_RefTMap_RefStringRefString::const_iterator    TMap_TString_RefTMap_RefStringRefString_const_iter;

namespace Ui
{
    class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

     private:
    enum ETreeColorUnitFloorPlanning{

        UNIT_FLOORPLANNING_NORMAL             ,
        UNIT_FLOORPLANNING_DIVISION_POINT  // dividing point between top and bottom netlist
    } ;

    enum ETreeColorUnitLibraries {
        UNIT_LIBRARIES_NORMAL        ,
        UNIT_LIBRARIES_ASIC_LIBRARIES,
        UNIT_LIBRARIES_FPGA_LIBRARIES
    } ;

    enum ETreeColorConnectivity{
        CONNECTIVITY_NORMAL          ,
        CONNECTIVITY_ASIC_POWER_RAILS,
        CONNECTIVITY_FPGA_POWER_RAILS
    } ;
    // color vars to control the generation of the netlists using the tree nodes "shading"
    ETreeColorConnectivity colorConnectivity;
    ETreeColorUnitFloorPlanning colorUnitFloorPlanning;
    ETreeColorUnitLibraries colorUnitLibraries;

public:
    MainWindow(int argc, char *argv[], QWidget *parent = 0);
    ~MainWindow();
    enum eUnitPopupMode {ADDUNIT, ADDSUBUNIT, EDITUNIT};
    enum eIfcMode {IFC_PORT, IFC_INTERFACE, IFC_SIGNAL, IFC_SIGNALGROUP, EDIT_PORT, EDIT_INTERFACE, EDIT_SIGNAL, EDIT_SIGNALGROUP};
    void popUpUnitPropertyBox(eUnitPopupMode);
    void popUpIfcPropertyBox(eIfcMode);

    void setColorConnectivity(ETreeColorConnectivity cc) { colorConnectivity = cc; }
    ETreeColorConnectivity getColorConnectivity() { return colorConnectivity     ; }

    void setColorUnitFloorPlanning(ETreeColorUnitFloorPlanning cufp) { colorUnitFloorPlanning = cufp; }
    ETreeColorUnitFloorPlanning getColorUnitFloorPlanning() { return colorUnitFloorPlanning; }

    void setColorUnitLibraries(ETreeColorUnitLibraries cul) { colorUnitLibraries = cul;}
    ETreeColorUnitLibraries setColorUnitLibraries() { return colorUnitLibraries;}

protected:
    virtual bool eventFilter(QObject*, QEvent*);
    virtual void closeEvent(QCloseEvent*);

    void updateModifiedUnitItems(const UnitObjectRef& pParentObject, const UnitObjectRef& pNewObject, const std::string& stringOldItem);
    QTreeWidgetItem* createTreeWidgetItem(const UnitObjectRef& pObject);

    void updateModifiedInterfaceItems(const InterfaceObjectRef& pParentObject, const InterfaceObjectRef& pNewObject, const std::string& stringOldItem);
    QtProperty* createProperty(const InterfaceObjectRef& pObject, QtProperty* pParentProperty);

    void updateTableSpan();

    bool openUnitFile(const QString&);
    bool openXMLUnitFile(const QString&);
    bool openInterfaceFile(const QString&);
    bool openXMLConnectionFile(const QString&);
    bool openConnectionFile(const QString&);
    bool openXMLFile(const QString&);

    bool saveUnitFile(const QString&);
    bool saveConnectionFile(const QString&);

    bool saveXMLFile(const QString&);
    bool saveXMLUnitFile(const QString&);
    bool saveXMLUnitFile(QXmlStreamWriter&);
    bool saveXMLInterfaceFile(const QString&);
    bool saveXMLInterfaceFile(QXmlStreamWriter&);
    bool saveXMLConnectionFile(const QString&);
    bool saveXMLConnectionFile(QXmlStreamWriter&);
    // BEGIN Added by AB 2010-02-02
    void colorSubHierarchy(UnitObjectRef unit, UnitObject::EUnitColor color);
    // END Added by AB 2010-02-02
    bool saveCSLFile(const QString& s);
    // bool saveCSLUnitFile(const QString&);
    bool saveCSLUnitFile(QTextStream& stream); // old function
    bool saveCSLPredeclarationUnitFile(QTextStream& stream);
    bool saveCSLCreateUnitsUnitFile(QTextStream& stream);
    //  bool saveCSLInterfaceFile(const QString&);
    bool saveCSLInterfaceFile(QTextStream&);
    //  bool saveCSLConnectionFile(const QString&);
    bool saveCSLConnectionFile(QTextStream&);


    bool loadPreferences();
    bool savePreferences();
private slots:
    void slotTreeContextMenu();
    void slotTableContextMenu();
    void slotIfcContextMenu();

    void slotFileNew();
    void slotFileOpen();
    void slotFileSave();
    void slotFileSaveAs();

    void slotExecuteCSL();
    void slotOptions();

    void slotPropertyValueChanged(QtProperty*, QVariant);
    //const char * toLower(std::string data);

    void fileOpen(QString& stringFile );
    /*!
      This method saves the .csl and .csl.xml files
      */
    void fileSave( );
    void executeCSL();

    void slotActionPreferences();

    void slotGenerateCSL();

    void slotHelpContents();
    void slotHelpAbout();

private:
    Ui::MainWindow *ui;

    /*!
      The name of the current project
      */
    QString projectFileName; // make this into an array or a class to hold a list of csl.xml files
    /*!
      Stores the date and time when the project file was last modified.
      */
    QDateTime projectLastModified;

    /*!
      This method verifies if the project file(s) are accesible and has changed since last save.
      It returns false if the project file(s) are not accessible, else it returns true.
      */
    bool checkProjectFiles();
    bool allowReload;

    bool projectIsPrepared(QString windowConfirmationTitle);
    QtTreePropertyBrowser *browser;
    QtBrowserItem* pBrowserItem;

    QtVariantPropertyManager* managerConnectivity;
    QtTreePropertyBrowser *propertyConnectivity;

    QTreeWidgetItem *pItem;
    QTableWidgetItem *pConnection;
    int iTreeItemCount;
    int iInterfaceCount;
    ConnectionTable* pTable;

    bool batchModeOn;
    bool        cmdLineXmlFileOn  ;
    std::string cmdLineXmlFileName;

    bool        logDirOn        ;        
    std::string logDirectoryName;

    std::string sUnitName;
    std::string sInstanceName;
    std::string sIfcName;
    std::string sIfcObjectName;
    QDialog* pPropertyDialog;

    QString stringCurrentFileName;

    FplOptions fplOptions;
    QString stringCslcLocation;

    bool bInSlotPropertyChanged;
    /*!
      Global variable, it is True when the project was modified since last save.
      */
    bool bUpdated;

    // SaveCSL functions

    void insertUnit(TMap_StringBool* mapUnitList, std::string unit);
    void printUnitList(QTextStream& stream, TMap_StringBool* mapUnitList); 
    bool unitExists(TMap_StringBool &mapUnitList, std::string &unit);
    void printUnitDecl(QTextStream& stream, UnitObjectRef &parentUnit);
    void printUnitDeclarations(QTextStream& stream, RefTMap_TString_RefTMap_RefStringRefString& designHierarchy, TString sRootName);
    void printUnitConstructorAndClose(QTextStream& stream, RefTVec_RefString ifcInstRefVec, TString& sCurrentUnitName, bool isRoot);
    bool printUnitInterfaceInstances (QTextStream& stream, TString& sCurrentUnit, RefTVec_RefString ifcInstRefVec);

    void printUnitDeclaration(QTextStream& stream, 
                              RefTMap_RefStringRefString rsTsTs,
                              TString& sCurrentUnitName);

    RefString getInstanceName(TString& sUnitInstance);
    RefString getLeafUnitName(TString& sUnitInstance); 
    bool isParentToChildConnection(TString& s0, TString& s1);
    bool typeInstIfcExists(TMap_StringString &unitInstanceMap, std::string &typeName, std::string &instName);

};

#endif // MAINWINDOW_H
