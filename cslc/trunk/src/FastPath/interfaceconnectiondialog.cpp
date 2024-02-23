#include "interfaceconnectiondialog.h"
#include "interface.h"
#include "qtvariantproperty.h"
#include "qtpropertybrowser.h"
#include "qtgroupboxpropertybrowser.h"
#include "qteditorfactory.h"
#include "connectivity.h"
#include <QMessageBox>
#include <cstdio>

InterfaceConnectionDialog::InterfaceConnectionDialog(QWidget* parent) :
        PropertyDialog(parent)
{
    setWindowTitle("Interface Connection");
    addProperty(QtVariantPropertyManager::groupTypeId(), "Connectivity Object");
    addProperty(QtVariantPropertyManager::comboboxTypeId(), "Connection Type", "Connectivity Object");
    setPropertyAttribute("Connection Type", "comboboxEditable", false);
    setPropertyAttribute("Connection Type", "comboboxTreeWidget", true);
    QStringList connectionTypes;
    connectionTypes << "Interface" << "Wire" << "SubInterface";
    setPropertyAttribute("Connection Type", "comboboxNames", connectionTypes);
    addProperty(QVariant::String, "Actual Name", "Connectivity Object");
    setPropertyRequired("Actual Name", true);
    addProperty(QtVariantPropertyManager::comboboxTypeId(), "Library Interface", "Connectivity Object");
    setPropertyAttribute("Library Interface", "comboboxEditable", false);
    setPropertyAttribute("Library Interface", "comboboxTreeWidget", true);
    std::vector<InterfaceObjectRef> vectorInterfaces;
    InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);
    QStringList interfaceTypes;
    int i;
    for (i = 0; i < (int)vectorInterfaces.size(); i++)
        interfaceTypes << vectorInterfaces[i]->interfaceObjectName.c_str();
    setPropertyAttribute("Library Interface", "comboboxNames", interfaceTypes);

    connect(pPropertyManager, SIGNAL(valueChanged(QtProperty *, const QVariant &)), this, SLOT(valueChanged(QtProperty *, const QVariant &)));

    if (interfaceTypes.size())
        valueChanged(mapProperties["Library Interface"], QVariant(interfaceTypes[0]));
}

void InterfaceConnectionDialog::valueChanged(QtProperty * property, const QVariant &v)
{
    if (property->propertyName() == "Connection Type")
    {
        if (v.toString() == "Interface")
        {
            addProperty(QtVariantPropertyManager::comboboxTypeId(), "Library Interface", "Connectivity Object");
            setPropertyAttribute("Library Interface", "comboboxEditable", false);
            setPropertyAttribute("Library Interface", "comboboxTreeWidget", true);
            std::vector<InterfaceObjectRef> vectorInterfaces;
            InterfaceObjectContainer::getInstance()->getAllInterfaces(vectorInterfaces);
            QStringList interfaceTypes;
            int i;
            for (i = 0; i < (int)vectorInterfaces.size(); i++)
                interfaceTypes << vectorInterfaces[i]->interfaceObjectName.c_str();
            setPropertyAttribute("Library Interface", "comboboxNames", interfaceTypes);
        }
        else
            removeProperty("Library Interface");
    }
    else if (property->propertyName() == "Library Interface")
    {
        std::string stringText = property->valueText().toStdString();
        InterfaceObjectRef interfaceObject = InterfaceObjectContainer::getInstance()->getObjectByPath(stringText);
        switch (interfaceObject->pType->interfaceCategory)
        {
        case InterfaceType::CATEGORY_UNKNOWN:
            removeProperty("Direction");
            removeProperty("Width");
            removeProperty("Bit Range");
            removeProperty("Wire Type");
            removeProperty("Logic Type");
            setPropertyValue("Connection Type", "");
            break;
        case InterfaceType::CATEGORY_SIGNALGROUP:
            removeProperty("Direction");
            removeProperty("Width");
            removeProperty("Bit Range");
            removeProperty("Wire Type");
            removeProperty("Logic Type");
            setPropertyValue("Connection Type", "Signal Group");
            break;
        case InterfaceType::CATEGORY_INTERFACE:
            removeProperty("Direction");
            removeProperty("Width");
            removeProperty("Bit Range");
            removeProperty("Wire Type");
            removeProperty("Logic Type");
            setPropertyValue("Connection Type", "Interface");
            break;
        case InterfaceType::CATEGORY_PORT:
            {
                addProperty(QtVariantPropertyManager::enumTypeId(), "Direction", "Connectivity Object");
                QStringList portDirections;
                portDirections << "" << "Input" << "Output" << "InOut";
                setPropertyAttribute("Direction", "enumNames", portDirections);
                setPropertyValue("Direction", interfaceObject->pType->portDirection);
                setPropertyReadOnly("Direction", true);

                addProperty(QVariant::Int, "Width", "Connectivity Object");
                setPropertyValue("Width", interfaceObject->pType->iWidth);
                setPropertyReadOnly("Width", true);

                addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", "Connectivity Object");
                setPropertyAttribute("Bit Range", "regExp", QRegExp("^\\[\\d+\\:\\d+\\]$"));
                char szBuffer[256];
                ::sprintf(szBuffer, "[%d:%d]", interfaceObject->pType->iLowerLimitBit, interfaceObject->pType->iUpperLimitBit);
                setPropertyValue("Bit Range", QString(szBuffer));
                setPropertyReadOnly("Bit Range", true);

                addProperty(QtVariantPropertyManager::enumTypeId(), "Wire Type", "Connectivity Object");
                QStringList wireTypes;
                wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
                setPropertyAttribute("Wire Type", "enumNames", wireTypes);
                setPropertyValue("Wire Type", interfaceObject->pType->wireType);
                setPropertyReadOnly("Wire Type", true);

                addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", "Connectivity Object");
                QStringList logicTypes;
                logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
                setPropertyAttribute("Logic Type", "enumNames", logicTypes);
                setPropertyValue("Logic Type", interfaceObject->pType->logicalType);
                setPropertyReadOnly("Logic Type", true);

                setPropertyValue("Connection Type", "Port");
            }
            break;
        case InterfaceType::CATEGORY_SIGNAL:
            {
                removeProperty("Direction");

                addProperty(QVariant::Int, "Width", "Connectivity Object");
                setPropertyValue("Width", interfaceObject->pType->iWidth);
                setPropertyReadOnly("Width", true);

                addProperty(QtVariantPropertyManager::rangeTypeId(), "Bit Range", "Connectivity Object");
                char szBuffer[256];
                ::sprintf(szBuffer, "[%d:%d]", interfaceObject->pType->iLowerLimitBit, interfaceObject->pType->iUpperLimitBit);
                setPropertyValue("Bit Range", QString(szBuffer));
                setPropertyReadOnly("Bit Range", true);

                addProperty(QtVariantPropertyManager::enumTypeId(), "Wire Type", "Connectivity Object");
                QStringList wireTypes;
                wireTypes << "NONE" << "Wire" << "Wand" << "Wor" << "Tri" << "Triand" << "Trior" << "Tri0" << "Tri1" << "Supply0" << "Supply1" << "Reg" << "Integer" << "Time";
                setPropertyAttribute("Wire Type", "enumNames", wireTypes);
                setPropertyValue("Wire Type", interfaceObject->pType->wireType);
                setPropertyReadOnly("Wire Type", true);

                addProperty(QtVariantPropertyManager::enumTypeId(), "Logic Type", "Connectivity Object");
                QStringList logicTypes;
                logicTypes << "NONE" << "Enable" << "Stall" << "Mux Select" << "Decoded Minterm" << "Decoded Maxterm" << "Clock Signal" << "Reset Signal";
                setPropertyAttribute("Logic Type", "enumNames", logicTypes);
                setPropertyValue("Logic Type", interfaceObject->pType->logicalType);
                setPropertyReadOnly("Logic Type", true);

               setPropertyValue("Connection Type", "Signal");
            }
            break;
            default: QMessageBox::critical(this, "Error", "Internal error in Interface Connection, Type", QMessageBox::Ok);
        };
    }
}

void InterfaceConnectionDialog::onAccept()
{
    QString actualName = getPropertyValue("Actual Name").toString().trimmed();
    if (ConnectivityContainer::getInstance()->hasDuplicatedName(actualName.toStdString(), originalName.toStdString()))
        QMessageBox::critical(this, "Error", "Error setting actual name - name is duplicated!", QMessageBox::Ok);
    else
        PropertyDialog::onAccept();
}

void InterfaceConnectionDialog::setPropertyValue(const QString& stringProperty, const QVariant& value)
{
    PropertyDialog::setPropertyValue(stringProperty, value);
    if (stringProperty == "Actual Name")
        originalName = value.toString().trimmed();
}
