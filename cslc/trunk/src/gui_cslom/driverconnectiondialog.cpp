#include "driverconnectiondialog.h"
#include "unit.h"
#include "interface.h"
#include "connectivity.h"
#include <vector>
#include "qtvariantproperty.h"
#include "qtpropertybrowser.h"
#include "qtgroupboxpropertybrowser.h"
#include "qteditorfactory.h"
#include <QMessageBox>
#include <cstdio>

DriverConnectionDialog::DriverConnectionDialog(QWidget* parent, const std::string& interface_, bool bDriver, const ConnectivityRef& connectivity_, bool bDriverNameReadOnly) :
    PropertyDialog(parent),
    interface(interface_),
    connectivity(connectivity_),
    bUseDriverInterface(false)
{
    if (bDriver)
        stringDriverReceiver = "Driver";
    else
        stringDriverReceiver = "Receiver";
    setWindowTitle(QString("Add ") + stringDriverReceiver);
    addProperty(QtVariantPropertyManager::groupTypeId(), stringDriverReceiver + " Property");
    addProperty(QtVariantPropertyManager::comboboxTypeId(), "Unit Instance", stringDriverReceiver + " Property");
    setPropertyAttribute("Unit Instance", "comboboxEditable", false);
    setPropertyAttribute("Unit Instance", "comboboxTreeWidget", true);
    QStringList listUnitInstances;
    std::vector<UnitObjectRef> vectorUnits;
    UnitObjectContainer::getInstance()->getAllUnits(vectorUnits);
    std::vector<std::string> vectorHierarchyNames;
    int i;
    for (i = 0; i < (int)vectorUnits.size(); i++)
        vectorUnits[i]->getHierarchyDisplayNames("", vectorHierarchyNames);
    listUnitInstances << "";
    for (i = 0; i < (int)vectorHierarchyNames.size(); i++)
        listUnitInstances << vectorHierarchyNames[i].c_str();
    setPropertyAttribute("Unit Instance", "comboboxNames", listUnitInstances);
    setPropertyRequired("Unit Instance", true);

    InterfaceObjectRef interfaceObject = InterfaceObjectContainer::getInstance()->getObjectByPath(interface);
    if (interfaceObject.get())
    {
        if (interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE ||
            interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP)
        {
            addProperty(QVariant::String, "Interface Instance Name", stringDriverReceiver + " Property");
            if (!bDriverNameReadOnly)
                setPropertyRequired("Interface Instance Name", true);
            else
            {
                setPropertyReadOnly("Interface Instance Name", true);
                setPropertyValue("Interface Instance Name", QString(bDriver ? connectivity->vectorCslInterfaces[0].first.c_str() :
                                                                    connectivity->vectorCslInterfaces[0].second.c_str()));
            }
        }

        addProperty(QVariant::String, "Connection Type", stringDriverReceiver + " Property");
        setPropertyReadOnly("Connection Type", true);
        switch (interfaceObject->pType->interfaceCategory)
        {
        case InterfaceType::CATEGORY_INTERFACE:
            setPropertyValue("Connection Type", "Interface");
            break;
        case InterfaceType::CATEGORY_SIGNALGROUP:
            setPropertyValue("Connection Type", "Signal Group");
            break;
        case InterfaceType::CATEGORY_PORT:
            {
            setPropertyValue("Connection Type", "Port");

            addProperty(QtVariantPropertyManager::enumTypeId(), "Direction", stringDriverReceiver + " Property");
            QStringList portDirections;
            portDirections << "" << "Input" << "Output" << "InOut";
            setPropertyAttribute("Direction", "enumNames", portDirections);
            setPropertyValue("Direction", interfaceObject->pType->portDirection);
            setPropertyReadOnly("Direction", true);

            addProperty(QVariant::Int, "Width", stringDriverReceiver + " Property");
            setPropertyValue("Width", interfaceObject->pType->iWidth);
            setPropertyReadOnly("Width", true);

            addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", stringDriverReceiver + " Property");
            char szBuffer[256];
            ::sprintf(szBuffer, "[%d:%d]", interfaceObject->pType->iLowerLimitBit, interfaceObject->pType->iUpperLimitBit);
            setPropertyValue("Bit Range", QString(szBuffer));
            setPropertyReadOnly("Bit Range", true);

            addProperty(QtVariantPropertyManager::enumTypeId(), "Wire Type", stringDriverReceiver + " Property");
            QStringList wireTypes;
            wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
            setPropertyAttribute("Wire Type", "enumNames", wireTypes);
            setPropertyValue("Wire Type", interfaceObject->pType->wireType);
            setPropertyReadOnly("Wire Type", true);

            addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", stringDriverReceiver + " Property");
            QStringList logicTypes;
            logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
            setPropertyAttribute("Logic Type", "enumNames", logicTypes);
            setPropertyValue("Logic Type", interfaceObject->pType->logicalType);
            setPropertyReadOnly("Logic Type", true);
            }
            break;
        case InterfaceType::CATEGORY_SIGNAL:
            {
            setPropertyValue("Connection Type", "Signal");
            addProperty(QVariant::Int, "Width", stringDriverReceiver + " Property");
            setPropertyValue("Width", interfaceObject->pType->iWidth);
            setPropertyReadOnly("Width", true);

            addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", stringDriverReceiver + " Property");
            char szBuffer[256];
            ::sprintf(szBuffer, "[%d:%d]", interfaceObject->pType->iLowerLimitBit, interfaceObject->pType->iUpperLimitBit);
            setPropertyValue("Bit Range", QString(szBuffer));
            setPropertyReadOnly("Bit Range", true);

            addProperty(QtVariantPropertyManager::enumTypeId(), "Wire Type", stringDriverReceiver + " Property");
            QStringList wireTypes;
            wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
            setPropertyAttribute("Wire Type", "enumNames", wireTypes);
            setPropertyValue("Wire Type", interfaceObject->pType->wireType);
            setPropertyReadOnly("Wire Type", true);

            addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", stringDriverReceiver + " Property");
            QStringList logicTypes;
            logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
            setPropertyAttribute("Logic Type", "enumNames", logicTypes);
            setPropertyValue("Logic Type", interfaceObject->pType->logicalType);
            setPropertyReadOnly("Logic Type", true);
            }
            break;
        default:
            break;
        }
    }
    else
    {
        if (!bDriver)
            addProperty(QVariant::Bool, "Use Driver Interface", stringDriverReceiver + " Property");
        connect(pPropertyManager, SIGNAL(valueChanged(QtProperty *, const QVariant &)), this, SLOT(valueChanged(QtProperty *, const QVariant &)));
    }

    resize(size().width() * 2, size().height());
}

void DriverConnectionDialog::valueChanged(QtProperty* pProperty, const QVariant& v)
{
    if (pProperty->propertyName() == "Unit Instance")
    {
        if (bUseDriverInterface) return;
        std::string stringUnit = v.toString().toStdString();
        UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(stringUnit);
        std::vector<std::string> vectorPorts;
        std::vector<int> vectorTypes;
        if (unit.get())
        {
            if (stringDriverReceiver == "Driver")
                unit->pType->queryDriverPorts(vectorPorts, vectorTypes);
            else
                unit->pType->queryReceiverPorts(vectorPorts, vectorTypes);
        }
        QStringList listPorts, listSelectables;
        int i;
        for (i = 0; i < (int)vectorPorts.size(); i++)
        {
            listPorts << vectorPorts[i].c_str();
            if (connectivity->connectivityType == Connectivity::CONNECTIVITY_TYPE_WIRE)
            {
                if (vectorTypes[i] == InterfaceType::CATEGORY_PORT)
                    listSelectables << "1";
                else
                    listSelectables << "0";
            }
            else
            {
                if (vectorPorts[i].find('.') != std::string::npos && vectorTypes[i] == InterfaceType::CATEGORY_INTERFACE)
                    listSelectables << "1";
                else
                    listSelectables << "0";
            }
        }
        if (vectorPorts.size())
        {
            addProperty(QtVariantPropertyManager::comboboxTypeId(), stringDriverReceiver + " Interface", stringDriverReceiver + " Property");
            setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxEditable", false);
            setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxTreeWidget", true);
            setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxNames", listPorts);
            setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxSelectables", listSelectables);
        }
        else
            removeProperty(stringDriverReceiver + " Interface");
    }
    else if (pProperty->propertyName() == stringDriverReceiver + " Interface")
    {
        InterfaceObjectRef interfaceObject = InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(v.toString().toStdString());
        if (interfaceObject.get() && interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_PORT)
        {
            addProperty(QtVariantPropertyManager::enumTypeId(), "Direction", stringDriverReceiver + " Interface");
            QStringList portDirections;
            portDirections << "" << "Input" << "Output" << "InOut";
            setPropertyAttribute("Direction", "enumNames", portDirections);
            setPropertyValue("Direction", interfaceObject->pType->portDirection);
            setPropertyReadOnly("Direction", true);

            addProperty(QVariant::Int, "Width", stringDriverReceiver + " Interface");
            setPropertyValue("Width", interfaceObject->pType->iWidth);
            setPropertyReadOnly("Width", true);

            addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", stringDriverReceiver + " Interface");
            char szBuffer[256];
            ::sprintf(szBuffer, "[%d:%d]", interfaceObject->pType->iLowerLimitBit, interfaceObject->pType->iUpperLimitBit);
            setPropertyValue("Bit Range", QString(szBuffer));
            setPropertyReadOnly("Bit Range", true);

            addProperty(QtVariantPropertyManager::enumTypeId(), "Wire Type", stringDriverReceiver + " Interface");
            QStringList wireTypes;
            wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
            setPropertyAttribute("Wire Type", "enumNames", wireTypes);
            setPropertyValue("Wire Type", interfaceObject->pType->wireType);
            setPropertyReadOnly("Wire Type", true);

            addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", stringDriverReceiver + " Interface");
            QStringList logicTypes;
            logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
            setPropertyAttribute("Logic Type", "enumNames", logicTypes);
            setPropertyValue("Logic Type", interfaceObject->pType->logicalType);
            setPropertyReadOnly("Logic Type", true);
        }
        else
        {
            removeProperty("Direction");
            removeProperty("Width");
            removeProperty("Bit Range");
            removeProperty("Wire Type");
            removeProperty("Logic Type");
        }
    }
    else if (pProperty->propertyName() == "Use Driver Interface")
    {
        bUseDriverInterface = v.toBool();
        if (bUseDriverInterface)
        {
            removeProperty(stringDriverReceiver + " Interface");
        }
        else
        {
            std::string stringUnit = getPropertyValue("Unit Instance").toString().toStdString();
            UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(stringUnit);
            std::vector<std::string> vectorPorts;
            std::vector<int> vectorTypes;
            if (unit.get())
            {
                if (stringDriverReceiver == "Driver")
                    unit->pType->queryDriverPorts(vectorPorts, vectorTypes);
                else
                    unit->pType->queryReceiverPorts(vectorPorts, vectorTypes);
            }
            QStringList listPorts, listSelectables;
            int i;
            for (i = 0; i < (int)vectorPorts.size(); i++)
            {
                listPorts << vectorPorts[i].c_str();
                if (connectivity->connectivityType == Connectivity::CONNECTIVITY_TYPE_WIRE)
                {
                    if (vectorTypes[i] == InterfaceType::CATEGORY_PORT)
                        listSelectables << "1";
                    else
                        listSelectables << "0";
                }
                else
                {
                    if (vectorPorts[i].find('.') != std::string::npos && vectorTypes[i] == InterfaceType::CATEGORY_INTERFACE)
                        listSelectables << "1";
                    else
                        listSelectables << "0";
                }
            }
            if (vectorPorts.size())
            {
                addProperty(QtVariantPropertyManager::comboboxTypeId(), stringDriverReceiver + " Interface", stringDriverReceiver + " Property");
                setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxEditable", false);
                setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxTreeWidget", true);
                setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxNames", listPorts);
                setPropertyAttribute(stringDriverReceiver + " Interface", "comboboxSelectables", listSelectables);
            }
            else
                removeProperty(stringDriverReceiver + " Interface");
        }
    }
}

std::string DriverConnectionDialog::getAssociatedInterfaceObject()
{
    InterfaceObjectRef interfaceObject;
    if (interface.size())
        interfaceObject = InterfaceObjectContainer::getInstance()->getObjectByPath(interface);
    else
        return getPropertyValue(stringDriverReceiver + " Interface").toString().toStdString();
    if (interfaceObject.get() && (interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE ||
        interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP))
        return getPropertyValue("Interface Instance Name").toString().toStdString();
    else
        return std::string();
}

std::string DriverConnectionDialog::getAssociatedUnitObject()
{
    return getPropertyValue("Unit Instance").toString().toStdString();
}

void DriverConnectionDialog::setAssociatedUnitObject(const std::string& stringUnitObject)
{
    if (stringUnitObject.size())
        setPropertyValue("Unit Instance", QString(stringUnitObject.c_str()));
    else
        setPropertyValue("Unit Instance", QString());
}

void DriverConnectionDialog::setAssociatedInterfaceObject(const std::string& interface_)
{
    InterfaceObjectRef interfaceObject = InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(interface);
    if (interface.size() && !interfaceObject.get())
    {
        QMessageBox::critical(this, "Error", QString("Error setting interface type %1(%2)\n!").arg(interface.c_str()).arg(interface_.c_str()), QMessageBox::Ok);
        return;
    }
    if (interfaceObject.get() && (interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE ||
        interfaceObject->pType->interfaceCategory == InterfaceType::CATEGORY_SIGNALGROUP))
        setPropertyValue("Interface Instance Name", QString(interface_.c_str()));
    else
        setPropertyValue(stringDriverReceiver + " Interface", QString(interface_.c_str()));
}

void DriverConnectionDialog::onAccept()
{
    if (!interface.size())
    {
        if (getPropertyValue(stringDriverReceiver + " Interface").toString().isNull())
        {
            QMessageBox::critical(this, "Error",
                                  QString("Current selected unit does not have any interface associated. You have to associate interface with current unit first to be able to select wire port!"), QMessageBox::Ok);
        }
        else
            PropertyDialog::onAccept();
    }
    else
        PropertyDialog::onAccept();
}

