#include "fplxmlhandler.h"
#include <QMessageBox>
#include "interface.h"
#include "unit.h"
#include "connectivity.h"
#include <QDebug> // remove for production

FplXMLHandler::FplXMLHandler() :
        iUniqIndex(0), fplOptions(NULL)
{
}

FplXMLHandler::~FplXMLHandler()
{
}

bool FplXMLHandler::characters ( const QString & ch)
{
    if (!stringElement.size()) return true;
    stringText = ch;
    stringText = stringText.replace('\n', ' ');
    QString stringValue = stringText.trimmed();
    if (!stringValue.isNull() && !stringValue.isEmpty())
        stackProperties.top()[stringElement.toStdString()] = stringValue.toStdString();
    return true;
}

bool FplXMLHandler::endDocument ()
{
    return true;
}

bool FplXMLHandler::endElement ( const QString & namespaceURI, const QString & localName, const QString & qName )
{
    if (localName == "Interface" || localName == "Port" || localName == "Signal" || localName == "SignalGroup" || localName == "InterfaceInstance")
    {
        interfaceType.set(NULL);
        if (!parseInterfaceXmlElement(stackElements, stackProperties.top(), interfaceType, stringInterfaceName))
        {
            return false;
        }
        if (stackProperties.size() >= 2)
        {
            stackElements.pop();
            stackProperties.pop();
            std::map<std::string, std::string>& mapProperties = stackProperties.top();
            std::string& stringValue = mapProperties["children"];
            stringValue += (stringInterfaceName + "(" + interfaceType->interfaceType + ")|");
       }
        else
        {
            parseInterfaceXmlElementCreateObject(stackProperties.top(), interfaceType);
            stackElements.pop();
            stackProperties.pop();
        }
    }
    else if (localName == "Unit" || localName == "UnitInstance")
    {
        unitType.set(NULL);
        if (!parseUnitXmlElement(stackElements, stackProperties.top(), unitType, stringUnitName))
        {
            return false;
        }
        if (stackProperties.size() >= 2)
        {
            stackElements.pop();
            stackProperties.pop();
            std::map<std::string, std::string>& mapProperties = stackProperties.top();
            std::string& stringValue = mapProperties["children"];
            stringValue += (stringUnitName + "(" + unitType->unitType + ")|");
        }
        else
        {
            parseUnitXmlElementCreateObject(stackProperties.top(), unitType);
            stackElements.pop();
            stackProperties.pop();
        }
    }
    else if (localName == "Connection" || localName == "InterfaceConnection")
    {
        if (localName == "InterfaceConnection")
        {
            std::map<std::string, std::string>& mapProperties = stackProperties.top();
            std::string stringProperty = mapProperties["DriverUnit"] + "|" + mapProperties["DriverInterfaceInstance"] + "|" +
                                         mapProperties["ReceiverUnit"] + "|" + mapProperties["ReceiverInterfaceInstance"] + "|";
            stackProperties.pop();
            if (stackProperties.size())
            {
                std::map<std::string, std::string>& mapProperties = stackProperties.top();
                std::string& stringValue = mapProperties["children"];
                stringValue += stringProperty;
            }
        }
        else if (localName == "Connection")
        {
            std::map<std::string, std::string>& mapProperties = stackProperties.top();
            if (!mapProperties.count("ActualName") || (!mapProperties.count("InterfaceName") && !mapProperties.count("InterfaceType")))
            {
                stringError = QString("Connection parsing error -- please make sure ActualName/InterfaceName are all there for the given connection\n");
                return false;
            }
            ConnectivityRef connectivity;
            if (mapProperties.count("InterfaceName"))
            {
                InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(mapProperties["InterfaceName"]);
                if (!interface.get())
                {
                    stringError = QString("Connection parsing error -- interface is not found from the library\n");
                    return false;
                }
                connectivity = ConnectivityContainer::getInstance()->addObject(mapProperties["InterfaceName"], Connectivity::CONNECTIVITY_TYPE_INTERFACE);
            }
            else
            {
                if (mapProperties["InterfaceType"] != "Wire" && mapProperties["InterfaceType"] != "SubInterface" )
                {
                    stringError = QString("Connection parsing error -- interface is not found from the library\n");
                    return false;
                }
                if (mapProperties["InterfaceType"] == "Wire")
                    connectivity = ConnectivityContainer::getInstance()->addObject("", Connectivity::CONNECTIVITY_TYPE_WIRE);
                else
                    connectivity = ConnectivityContainer::getInstance()->addObject("", Connectivity::CONNECTIVITY_TYPE_SUBINTERFACE);
            }
            if (!connectivity.get())
            {
                stringError = QString("Connection parsing error -- unable to add connection\n");
                return false;
            }
            connectivity->actualName = mapProperties["ActualName"];
            QString stringChildren = mapProperties["children"].c_str();
            QStringList listChildren = stringChildren.split('|');
            int iSize = listChildren.size() / 4;
            for (int i = 0; i < iSize; i++)
            {
                if ( (listChildren[i * 4] != "") && (listChildren[i * 4 + 2] != "") && (
                    !UnitObjectContainer::getInstance()->getObjectByPath(listChildren[i * 4].toStdString()).get() ||
                    !UnitObjectContainer::getInstance()->getObjectByPath(listChildren[i * 4 + 2].toStdString()).get()))
                {
                    stringError = QString("Connection parsing error -- unable to find the given unit from unit library\n");
                    stringError.append("Unit: " + listChildren[i*4] + " Unit: " + listChildren[i*4+2]);
                    return false;
                }
                connectivity->vectorUnits.push_back(std::make_pair(listChildren[i * 4].toStdString(), listChildren[i * 4 + 2].toStdString()));
                if (connectivity->interface.size() == 0)
                {
                    if (listChildren[i * 4 + 1].toStdString().size() &&
                        !InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(listChildren[i * 4 + 1].toStdString()).get())
                    {
                        stringError = QString("Connection parsing error -- interface is not found from the library\n");
                        return false;
                    }
                    if (listChildren[i * 4 + 3].toStdString().size() &&
                        !InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(listChildren[i * 4 + 3].toStdString()).get())
                    {
                        stringError = QString("Connection parsing error -- interface is not found from the library\n");
                        return false;
                    }
                }
                connectivity->vectorCslInterfaces.push_back(std::make_pair(listChildren[i * 4 + 1].toStdString(), listChildren[i * 4 + 3].toStdString()));
            }
            connectivity->updateUnitInterfaces();
            stackProperties.pop();
        }
    }
    else if (localName == "Options")
    {
        QString stringElement = stackElements.top();
        if(stringElement == QString("Options"))
        {
            if (!stackProperties.top().count("CSL_default_includes"))
            {
                //AB TODO: add error ? - it breaks existing xml files
                //stringError = QString("Options parsing error -- default include tag not found\n");
                //return false;
            }

            QString stringOption = QString(stackProperties.top()["CSL_default_includes"].c_str());

            if (stringOption == QString("true"))
            {
                fplOptions->bAddIncludes = true;

            }
            else if (stringOption == QString("false"))
            {
                fplOptions->bAddIncludes = false;
            }
        }
        if (stackProperties.size() >= 2)
        {
            stackElements.pop();
            stackProperties.pop();
        }
        else
        {
            stackElements.pop();
            stackProperties.pop();
        }
    }
    stringElement.clear();
    return true;
}

bool FplXMLHandler::endPrefixMapping ( const QString & prefix )
{
    return true;
}

QString FplXMLHandler::errorString () const
{
    return stringError;
}

bool FplXMLHandler::ignorableWhitespace ( const QString & ch )
{
    return true;
}

bool FplXMLHandler::processingInstruction ( const QString & target, const QString & data )
{
    return true;
}

void FplXMLHandler::setDocumentLocator ( QXmlLocator * locator )
{
}

bool FplXMLHandler::skippedEntity ( const QString & name )
{
    return true;
}

bool FplXMLHandler::startDocument ()
{
    return true;
}

bool FplXMLHandler::startElement ( const QString & namespaceURI, const QString & localName, const QString & qName, const QXmlAttributes & atts )
{
    if (localName == "Interface" || localName == "Port" || localName == "Signal" || localName == "SignalGroup" || localName == "InterfaceInstance")
    {
        stackElements.push(localName);
        stackProperties.push(std::map<std::string, std::string>());
        stringText.clear();
    }
    else if (localName == "Unit" || localName == "UnitInstance")
    {
        stackElements.push(localName);
        stackProperties.push(std::map<std::string, std::string>());
        stringText.clear();
    }
    else if (localName == "Connection" || localName == "InterfaceConnection")
    {
        stackElements.push(localName);
        stackProperties.push(std::map<std::string, std::string>());
        stringText.clear();
    }
    else if (localName == "Options")
    {
        stackElements.push(localName);
        stackProperties.push(std::map<std::string, std::string>());
        stringText.clear();
    }
    stringElement = localName;
    return true;
}

bool FplXMLHandler::startPrefixMapping ( const QString & prefix, const QString & uri )
{
    return true;
}

bool FplXMLHandler::parseUnitXmlElement(const std::stack<QString>& stackElements, std::map<std::string, std::string>& mapProperties, UnitTypeRef& unitType, std::string& stringUnitName)
{
    QString stringElement = stackElements.top();
    if (stringElement == QString("UnitInstance"))
    {
        if (!mapProperties.count("Name") || !mapProperties.count("Type"))
        {
            stringError = QString("UnitInstance parsing error -- please make sure Name/(Type or UnitInstance) are all there for the given unit\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Type"];
        unitType = UnitTypeFactory::getInstance()->getType(stringTypeName);
        if (!unitType.get())
        {
            stringError = QString("Unit parsing error -- the current type is not defined\n");
            return false;
        }
        stringUnitName = mapProperties["Name"];

        if (mapProperties.count("children"))
        {
            stringError = QString("UnitInstance parsing error -- is not allowed to have child elements\n");
            return false;
        }
    }
    else if (stringElement == QString("Unit"))
    {
        if (!mapProperties.count("Name"))
        {
            stringError = QString("UnitType parsing error -- please make sure Name are all there for the given unit type\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Name"];
        unitType = UnitTypeFactory::getInstance()->registerType(stringTypeName);
        if (!unitType.get())
        {
            stringError = QString("Unit parsing error -- the current type is already defined\n");
            return false;
        }
        if (mapProperties.count("Abbreviation"))
            unitType->unitAbbreviation = mapProperties["Abbreviation"];
        if (mapProperties.count("Description"))
            unitType->unitDescription = mapProperties["Description"];
        if (mapProperties.count("FloorPlanning"))
            unitType->setColorUnitFloorPlanning(mapProperties["FloorPlanning"]);
        if (mapProperties.count("UnitLibraries"))
            unitType->setColorUnitLibraries(mapProperties["UnitLibraries"]);
        if (mapProperties.count("children"))
        {
            std::string stringChildren = mapProperties["children"];
            int current_separator = 0, next_separator = -1;
            while(current_separator != -1)
            {
                next_separator = stringChildren.find('|', current_separator);
                if (next_separator == -1)
                    break;
                std::string stringChild = stringChildren.substr(current_separator, next_separator - current_separator);
                int left_bracket = stringChild.find('(');
                std::string stringUnitName = stringChild.substr(0, left_bracket);
                int right_bracket = stringChild.find(')');
                std::string stringTypeName = stringChild.substr(left_bracket + 1, right_bracket - left_bracket - 1);
                UnitTypeRef childType = UnitTypeFactory::getInstance()->getType(stringTypeName);
                unitType->addChild(stringTypeName, stringUnitName);
                current_separator = next_separator + 1;
            }
        }
        stringUnitName.clear();
    }
    return true;
}

bool FplXMLHandler::parseUnitXmlElementCreateObject(const std::map<std::string, std::string>& mapProperties, UnitTypeRef unitType)
{
    if (!mapProperties.count("Name"))
    {
        stringError = QString("Unit parsing error -- please make sure Name is there for the given unit\n");
        return false;
    }
    std::map<std::string, std::string>::const_iterator iteratorMap = mapProperties.find("Name");
    std::string stringName = iteratorMap->second;
    UnitObjectRef unit = UnitObjectContainer::getInstance()->createObject(unitType->unitType, stringName, NULL);
    if (!unit.get())
    {
        stringError = QString("Unit parsing error -- the current name is already used by another unit\n");
        return false;
    }
    if (mapProperties.count("children"))
    {
        iteratorMap = mapProperties.find("children");
        std::string stringChildren = iteratorMap->second;
        int current_separator = 0, next_separator = -1;
        while(current_separator != -1)
        {
            next_separator = stringChildren.find('|', current_separator);
            if (next_separator == -1)
                break;
            std::string stringChild = stringChildren.substr(current_separator, next_separator - current_separator);
            int left_bracket = stringChild.find('(');
            std::string stringUnitName = stringChild.substr(0, left_bracket);
            int right_bracket = stringChild.find(')');
            std::string stringTypeName = stringChild.substr(left_bracket + 1, right_bracket - left_bracket - 1);
            UnitTypeRef childType = UnitTypeFactory::getInstance()->getType(stringTypeName);
            unitType->addChild(stringTypeName, stringUnitName);
            current_separator = next_separator + 1;
        }
    }
    stringTopLevelUnitName = unit->unitObjectName;
    return true;
}
/*
bool FplXMLHandler::parseOptionsXmlElement(const std::stack<QString>& stackElements, std::map<std::string, std::string>& mapProperties)
{
        QString stringElement = stackElements.top();
        if(stringElement == QString("CSL_default_includes"))
        {
            std::cout << mapProperties["CSL_default_includes"]
        }
}
*/
bool FplXMLHandler::parseInterfaceXmlElement(const std::stack<QString>& stackElements, std::map<std::string, std::string>& mapProperties, InterfaceTypeRef& interfaceType, std::string& stringInterfaceName)
{
    QString stringElement = stackElements.top();
    if (stringElement == QString("Port"))
    {
        if (!mapProperties.count("Name") || !mapProperties.count("Direction"))
        {
            stringError = QString("Port parsing error -- please make sure Name/Direction are all there for the given port\n");
            return false;
        }
        if (!mapProperties.count("BitRange") && !mapProperties.count("Width"))
        {
            stringError = QString("Port parsing error -- please make sure BitRange or Width is there for the given port\n");
            return false;
        }
        if (mapProperties.count("children"))
        {
            stringError = QString("Port parsing error -- port is not allowed to have child elements\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Name"];
        char szBuffer[256];
        sprintf(szBuffer, "___$$$$$$___INTERNAL____%d____", iUniqIndex++);
        interfaceType = InterfaceTypeFactory::getInstance()->registerType(szBuffer, InterfaceType::CATEGORY_PORT);
        if (!interfaceType.get())
        {
            stringError = QString("Port parsing error -- the current name is already used by another interface\n");
            return false;
        }
        if (interfaceType.get())
        {
            interfaceType->setDirection(QString(mapProperties["Direction"].c_str()).toUpper().toStdString());
            if (mapProperties.count("LogicType"))
                interfaceType->setLogicalType(QString(mapProperties["LogicType"].c_str()).toUpper().toStdString());
            else
                interfaceType->setLogicalType("NONE");
            if (mapProperties.count("WireType"))
                interfaceType->setWireType(QString(mapProperties["WireType"].c_str()).toUpper().toStdString());
            else
                interfaceType->setWireType("NONE");
            if (mapProperties.count("BitRange"))
            {
                std::string stringBitRange = mapProperties["BitRange"];
                std::string sUpperLimitBit = stringBitRange.substr(0, stringBitRange.find(':'));
                std::string sLowerLimitBit = stringBitRange.substr(stringBitRange.find(':') + 1, stringBitRange.length() - stringBitRange.find(':') - 1);
                interfaceType->iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                interfaceType->iUpperLimitBit = atoi(sUpperLimitBit.c_str());
                interfaceType->iWidth = interfaceType->iUpperLimitBit - interfaceType->iLowerLimitBit + 1;
            }
            else
            {
                interfaceType->iWidth = atoi(mapProperties["Width"].c_str());
                interfaceType->iLowerLimitBit = 0;
                interfaceType->iUpperLimitBit = interfaceType->iWidth - 1;
            }
            if (mapProperties.count("ConditionallyInclude"))
            {
                interfaceType->setColorConnectivity(mapProperties["ConditionallyInclude"]);
            }
            stringInterfaceName = stringTypeName;
        }
    }
    else if (stringElement == QString("Signal"))
    {
        if (!mapProperties.count("Name"))
        {
            stringError = QString("Signal parsing error -- please make sure Name is there for the given signal\n");
            return false;
        }
        if (!mapProperties.count("BitRange") && !mapProperties.count("Width"))
        {
            stringError = QString("Signal parsing error -- please make sure BitRange or Width is there for the given signal\n");
            return false;
        }
        if (mapProperties.count("children"))
        {
            stringError = QString("Signal parsing error -- signal is not allowed to have child elements\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Name"];
        char szBuffer[256];
        sprintf(szBuffer, "___$$$$$$___INTERNAL____%d____", iUniqIndex++);
        interfaceType = InterfaceTypeFactory::getInstance()->registerType(szBuffer, InterfaceType::CATEGORY_SIGNAL);
        if (!interfaceType.get())
        {
            stringError = QString("Signal parsing error -- the current name is already used by another interface");
            return false;
        }
        if (interfaceType.get())
        {
            if (mapProperties.count("LogicType"))
                interfaceType->setLogicalType(QString(mapProperties["LogicType"].c_str()).toUpper().toStdString());
            else
                interfaceType->setLogicalType("NONE");
            if (mapProperties.count("WireType"))
                interfaceType->setWireType(QString(mapProperties["WireType"].c_str()).toUpper().toStdString());
            else
                interfaceType->setWireType("NONE");
            if (mapProperties.count("BitRange"))
            {
                std::string stringBitRange = mapProperties["BitRange"];
                std::string sUpperLimitBit = stringBitRange.substr(0, stringBitRange.find(':'));
                std::string sLowerLimitBit = stringBitRange.substr(stringBitRange.find(':') + 1, stringBitRange.length() - stringBitRange.find(':') - 1);
                interfaceType->iLowerLimitBit = atoi(sLowerLimitBit.c_str());
                interfaceType->iUpperLimitBit = atoi(sUpperLimitBit.c_str());
                interfaceType->iWidth = interfaceType->iUpperLimitBit - interfaceType->iLowerLimitBit + 1;
            }
            else
            {
                interfaceType->iWidth = atoi(mapProperties["Width"].c_str());
                interfaceType->iLowerLimitBit = 0;
                interfaceType->iUpperLimitBit = interfaceType->iWidth - 1;
            }
            stringInterfaceName = stringTypeName;
        }
    }
    else if (stringElement == QString("Interface"))
    {
        if (!mapProperties.count("Name"))
        {
            stringError = QString("Interface parsing error -- please make sure Name is there for the given interface\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Name"];
        interfaceType = InterfaceTypeFactory::getInstance()->registerType(stringTypeName, InterfaceType::CATEGORY_INTERFACE);
        if (!interfaceType.get())
        {
            stringError = QString("Interface parsing error -- the current name is already used by another interface\n");
            return false;
        }
    }
    else if (stringElement == QString("SignalGroup"))
    {
        if (!mapProperties.count("Name"))
        {
            stringError = QString("SignalGroup parsing error -- please make sure Name is there for the given signalgroup\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Name"];
        interfaceType = InterfaceTypeFactory::getInstance()->registerType(stringTypeName, InterfaceType::CATEGORY_SIGNALGROUP);
        if (!interfaceType.get())
        {
            stringError = QString("SignalGroup parsing error -- the current name is already used by another interface\n");
            return false;
        }
    }
    else if (stringElement == QString("InterfaceInstance"))
    {
        if (!mapProperties.count("Name") || !mapProperties.count("Type"))
        {
            stringError = QString("InterfaceInstance parsing error -- please make sure Name/Type are all there for the given instance\n");
            return false;
        }
        if (mapProperties.count("children"))
        {
            stringError = QString("InterfaceInstance parsing error -- signal is not allowed to have child elements\n");
            return false;
        }
        std::string stringTypeName = mapProperties["Type"];
        stringInterfaceName = mapProperties["Name"];
        interfaceType = InterfaceTypeFactory::getInstance()->getType(stringTypeName);
        if (!interfaceType.get())
        {
            stringError = QString("InterfaceInstance parsing error -- the current type name does not exist!\n");
            return false;
        }
    }

    if (mapProperties.count("children"))
    {
        std::string stringChildren = mapProperties["children"];
        int current_separator = 0, next_separator = -1;
        while(current_separator != -1)
        {
            next_separator = stringChildren.find('|', current_separator);
            if (next_separator == -1)
                break;
            std::string stringChild = stringChildren.substr(current_separator, next_separator - current_separator);
            int left_bracket = stringChild.find('(');
            std::string stringInterfaceName = stringChild.substr(0, left_bracket);
            int right_bracket = stringChild.find(')');
            std::string stringTypeName = stringChild.substr(left_bracket + 1, right_bracket - left_bracket - 1);
            InterfaceTypeRef childType = InterfaceTypeFactory::getInstance()->getType(stringTypeName);
            interfaceType->addChild(stringTypeName, stringInterfaceName, childType->interfaceCategory);
            current_separator = next_separator + 1;
        }
    }
    return true;
}

bool FplXMLHandler::parseInterfaceXmlElementCreateObject(const std::map<std::string, std::string>& mapProperties, InterfaceTypeRef interfaceType)
{
    if (!mapProperties.count("Name"))
    {
        stringError = QString("Interface parsing error -- please make sure Name is there for the given interface\n");
        return false;
    }
    std::map<std::string, std::string>::const_iterator iteratorMap = mapProperties.find("Name");
    std::string stringName = iteratorMap->second;
    InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->createObject(interfaceType->interfaceType, stringName, NULL, interfaceType->interfaceCategory);
    if (!interface.get())
    {
        stringError = QString("Interface parsing error -- the current name is already used by another interface\n");
        return false;
    }
    if (mapProperties.count("children"))
    {
        iteratorMap = mapProperties.find("children");
        std::string stringChildren = iteratorMap->second;
        int current_separator = 0, next_separator = -1;
        while(current_separator != -1)
        {
            next_separator = stringChildren.find('|', current_separator);
            if (next_separator == -1)
                break;
            std::string stringChild = stringChildren.substr(current_separator, next_separator - current_separator);
            int left_bracket = stringChild.find('(');
            std::string stringInterfaceName = stringChild.substr(0, left_bracket);
            int right_bracket = stringChild.find(')');
            std::string stringTypeName = stringChild.substr(left_bracket + 1, right_bracket - left_bracket - 1);
            InterfaceTypeRef childType = InterfaceTypeFactory::getInstance()->getType(stringTypeName);
            if (!interfaceType->addChild(stringTypeName, stringInterfaceName, childType->interfaceCategory).get())
            {
                if (childType->interfaceCategory == InterfaceType::CATEGORY_PORT ||
                    childType->interfaceCategory == InterfaceType::CATEGORY_SIGNAL)
                    InterfaceTypeFactory::getInstance()->unregisterType(stringTypeName);
            }
            current_separator = next_separator + 1;
        }
    }
    return true;
}

bool FplXMLErrorHandler::error ( const QXmlParseException & exception )
{
    stringError = QString("Xml parsing error[line %1][column %2]: %3\n").arg(exception.lineNumber())
                  .arg(exception.columnNumber()).arg(exception.message());
    return false;
}

QString FplXMLErrorHandler::errorString () const
{
    return stringError;
}

bool FplXMLErrorHandler::fatalError ( const QXmlParseException & exception )
{
    stringError = QString("Xml parsing fatal error[line %1][column %2]: %3\n").arg(exception.lineNumber())
                  .arg(exception.columnNumber()).arg(exception.message());
    return false;
}

bool FplXMLErrorHandler::warning ( const QXmlParseException & exception )
{
    stringError = QString("Xml parsing fatal warning[line %1][column %2]: %3\n").arg(exception.lineNumber())
                  .arg(exception.columnNumber()).arg(exception.message());
    return true;
}
