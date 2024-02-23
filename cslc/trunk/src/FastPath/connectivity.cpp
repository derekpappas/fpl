#include "connectivity.h"
#include "interface.h"
#include "unit.h"
#include <stdio.h>

Connectivity::Connectivity() :
        connectivityType(CONNECTIVITY_TYPE_INTERFACE)
{
}

Connectivity::~Connectivity()
{
}

void Connectivity::updateUnitInterfaces()
{
    if (!interface.size()) return;
    int i;
    for (i = 0; i < (int)vectorUnits.size(); i++)
    {
        UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(vectorUnits[i].first);
        if (!unit.get())
            continue;
        unit->pType->addDriverInterface(interface, actualName);
    }
    for (i = 0; i < (int)vectorUnits.size(); i++)
    {
        UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(vectorUnits[i].second);
        if (!unit.get())
            continue;
        unit->pType->addReceiverInterface(interface, actualName);
    }
}

std::string Connectivity::connectivityTypeName() const
{
    switch (connectivityType)
    {
    case CONNECTIVITY_TYPE_INTERFACE:
        return "Interface";
    case CONNECTIVITY_TYPE_WIRE:
        return "Wire";
    case CONNECTIVITY_TYPE_SUBINTERFACE:
        return "SubInterface";
    default:
        return std::string();
    }
}

ConnectivityContainer* ConnectivityContainer::connectivityContainer = NULL;

ConnectivityContainer::ConnectivityContainer()
{
}

ConnectivityContainer::~ConnectivityContainer()
{
}

ConnectivityRef ConnectivityContainer::addObject(const std::string& interface, Connectivity::CONNECTIVITY_TYPE cType)
{
    ConnectivityRef connectivity = new Connectivity();
    connectivity->interface = interface;
    connectivity->connectivityType = cType;
    vectorConnectivities.push_back(connectivity);
    return connectivity;
}

ConnectivityRef ConnectivityContainer::removeObject(int iIndex)
{
    ConnectivityRef connectivity = vectorConnectivities[iIndex];
    int i;
    for (i = 0; i < connectivity->vectorUnits.size(); i++)
    {
        UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[i].first);
        if (unit.get())
            unit->pType->removeDriverInterface(connectivity->vectorUnits[i].first, connectivity->actualName);
        unit = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[i].second);
        if (unit.get())
            unit->pType->removeReceiverInterface(connectivity->vectorUnits[i].second, connectivity->actualName);
    }
    vectorConnectivities.erase(vectorConnectivities.begin() + iIndex);
    return connectivity;
}

ConnectivityRef ConnectivityContainer::getObject(int iIndex)
{
    ConnectivityRef connectivity = vectorConnectivities[iIndex];
    return connectivity;
}

std::pair<ConnectivityRef, int> ConnectivityContainer::addDriver(int indexConnectivity, int indexDriver)
{
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    connectivity->vectorUnits.insert(connectivity->vectorUnits.begin() + (indexDriver + 1), std::make_pair(std::string(), std::string()));
    if (connectivity->interface.size())
        connectivity->vectorCslInterfaces.insert(connectivity->vectorCslInterfaces.begin() + (indexDriver + 1), std::make_pair(std::string(), std::string()));
    else
        connectivity->vectorCslInterfaces.insert(connectivity->vectorCslInterfaces.begin() + (indexDriver + 1), std::make_pair(std::string(), std::string()));
    return std::make_pair(connectivity, indexDriver + 1);
}

std::pair<int, int> ConnectivityContainer::removeDriver(int indexConnectivity, int indexDriver)
{
    std::string unit = getDriver(indexConnectivity, indexDriver);
    ConnectivityRef connectivity = getObject(indexConnectivity);
    int indexStart, indexEnd;
    for (indexStart = indexDriver - 1; indexStart >= 0; indexStart --)
        if (getDriver(indexConnectivity, indexStart) != unit) break;
    indexStart ++;
    for (indexEnd = indexDriver + 1; indexEnd < (int)connectivity->vectorUnits.size(); indexEnd++)
        if (getDriver(indexConnectivity, indexEnd) != unit) break;

    std::set<std::string> setDriverUnitInstances, setReceiverUnitInstances;
    for (indexDriver = 0; indexDriver < (int)connectivity->vectorUnits.size(); indexDriver++)
    {
        if (indexDriver < indexStart || indexDriver >= indexEnd)
        {
            UnitObjectRef unitObject = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[indexDriver].first);
            if (unitObject.get())
                setDriverUnitInstances.insert(connectivity->vectorUnits[indexDriver].first);
            unitObject = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[indexDriver].second);
            if (unitObject.get())
                setReceiverUnitInstances.insert(connectivity->vectorUnits[indexDriver].second);
        }
    }

    for (indexDriver = indexEnd - 1; indexDriver >= indexStart; indexDriver--)
    {
        UnitObjectRef unitObject = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[indexDriver].first);
        if (!setDriverUnitInstances.count(connectivity->vectorUnits[indexDriver].first) && unitObject.get())
            unitObject->pType->removeDriverInterface(connectivity->vectorUnits[indexDriver].first, connectivity->actualName);
        unitObject = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[indexDriver].second);
        if (!setReceiverUnitInstances.count(connectivity->vectorUnits[indexDriver].second) && unitObject.get())
            unitObject->pType->removeReceiverInterface(connectivity->vectorUnits[indexDriver].second, connectivity->actualName);
        connectivity->vectorUnits.erase(connectivity->vectorUnits.begin() + indexDriver);
        connectivity->vectorCslInterfaces.erase(connectivity->vectorCslInterfaces.begin() + indexDriver);
    }
    return std::make_pair(indexStart, indexEnd - indexStart);
}

std::pair<ConnectivityRef, int> ConnectivityContainer::addReceiver(int indexConnectivity, int indexDriver)
{
    std::string unitReceiver = getReceiver(indexConnectivity, indexDriver);
    if (unitReceiver.size())
    {
        std::string unit = getDriver(indexConnectivity, indexDriver);
        std::string interface = getDriverInterface(indexConnectivity, indexDriver);

        addDriver(indexConnectivity, indexDriver);
        setDriver(indexConnectivity, indexDriver + 1, unit);
        setDriverInterface(indexConnectivity, indexDriver + 1, interface);
        return std::make_pair(getObject(indexConnectivity), indexDriver + 1);
    }
    else
        return std::make_pair(getObject(indexConnectivity), indexDriver);
}

int ConnectivityContainer::removeReceiver(int indexConnectivity, int indexDriver)
{
    ConnectivityRef connectivity = getObject(indexConnectivity);
    std::string unit = getDriver(indexConnectivity, indexDriver);
    if (indexDriver > 0 && getDriver(indexConnectivity, indexDriver - 1) == unit)
    {
        removeDriver(indexConnectivity, indexDriver);
        return indexDriver;
    }
    else if (indexDriver < (int)connectivity->vectorUnits.size() - 1 && getDriver(indexConnectivity, indexDriver + 1) == unit)
    {
        setReceiver(indexConnectivity, indexDriver, getReceiver(indexConnectivity, indexDriver + 1));
        setReceiverInterface(indexConnectivity, indexDriver, getReceiverInterface(indexConnectivity, indexDriver + 1));
        removeDriver(indexConnectivity, indexDriver + 1);
        return indexDriver + 1;
    }
    else
    {
        setReceiver(indexConnectivity, indexDriver, std::string());
        setReceiverInterface(indexConnectivity, indexDriver, std::string());
        return -1;
    }
}

ConnectivityRef ConnectivityContainer::setDriver(int indexConnectivity, int indexDriver, const std::string& driver)
{
    UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(driver);
    if (!unit.get())
        return ConnectivityRef();
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    std::set<std::string> setDriverUnitInstances;
    int i;
    for (i = 0; i < (int)connectivity->vectorUnits.size(); i++)
    {
        if (i != indexDriver)
        {
            UnitObjectRef unitObject = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[i].first);
            if (unitObject.get())
                setDriverUnitInstances.insert(connectivity->vectorUnits[i].first);
        }
    }
    UnitObjectRef unitOld = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[indexDriver].first);
    if (!setDriverUnitInstances.count(connectivity->vectorUnits[indexDriver].first) && unitOld.get())
        unitOld->pType->removeDriverInterface(connectivity->vectorUnits[indexDriver].first, connectivity->actualName);
    connectivity->vectorUnits[indexDriver].first = driver;
    unit->pType->addDriverInterface(connectivity->interface, connectivity->actualName);
    return connectivity;
}

ConnectivityRef ConnectivityContainer::setReceiver(int indexConnectivity, int indexDriver, const std::string& receiver)
{
    UnitObjectRef unit = UnitObjectContainer::getInstance()->getObjectByPath(receiver);
    if (!unit.get())
        return ConnectivityRef();
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    std::set<std::string> setReceiverUnitInstances;
    int i;
    for (i = 0; i < (int)connectivity->vectorUnits.size(); i++)
    {
        if (i != indexDriver)
        {
            UnitObjectRef unitObject = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[i].second);
            if (unitObject.get())
                setReceiverUnitInstances.insert(connectivity->vectorUnits[i].second);
        }
    }
    UnitObjectRef unitOld = UnitObjectContainer::getInstance()->getObjectByPath(connectivity->vectorUnits[indexDriver].second);
    if (!setReceiverUnitInstances.size() && unitOld.get())
        unitOld->pType->removeReceiverInterface(connectivity->vectorUnits[indexDriver].second, connectivity->actualName);
    connectivity->vectorUnits[indexDriver].second = receiver;
    unit->pType->addReceiverInterface(connectivity->interface, connectivity->actualName);
    return connectivity;
}

ConnectivityRef ConnectivityContainer::setDriverInterface(int indexConnectivity, int indexDriver, const std::string& driver)
{
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    connectivity->vectorCslInterfaces[indexDriver].first = driver;
    return connectivity;
}

ConnectivityRef ConnectivityContainer::setReceiverInterface(int indexConnectivity, int indexDriver, const std::string& receiver)
{
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    connectivity->vectorCslInterfaces[indexDriver].second = receiver;
    return connectivity;
}

std::string ConnectivityContainer::getDriver(int indexConnectivity, int indexDriver)
{
    if (indexDriver == -1)
        return std::string();
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    return connectivity->vectorUnits[indexDriver].first;
}

std::string ConnectivityContainer::getReceiver(int indexConnectivity, int indexDriver)
{
    if (indexDriver == -1)
        return std::string();
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    return connectivity->vectorUnits[indexDriver].second;
}

std::string ConnectivityContainer::getDriverInterface(int indexConnectivity, int indexDriver)
{
    if (indexDriver == -1)
        return std::string();
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    return connectivity->vectorCslInterfaces[indexDriver].first;
}

std::string ConnectivityContainer::getReceiverInterface(int indexConnectivity, int indexDriver)
{
    if (indexDriver == -1)
        return std::string();
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    if (((int)connectivity->vectorUnits.size()) <= indexDriver)
        addDriver(indexConnectivity);
    return connectivity->vectorCslInterfaces[indexDriver].second;
}

int ConnectivityContainer::indexToRow(int indexConnectivity, int indexDriver)
{
    if (indexConnectivity < 0) return -1;

    int i;
    int iRow = 0;
    for (i = 0; i < indexConnectivity && i < (int)vectorConnectivities.size(); i++)
    {
        if (vectorConnectivities[i]->vectorUnits.size())
            iRow += vectorConnectivities[i]->vectorUnits.size();
        else
            iRow ++;
    }
    if (indexDriver == -1 && i < (int)vectorConnectivities.size())
    {
        if (vectorConnectivities[i]->vectorUnits.size())
            return iRow + vectorConnectivities[i]->vectorUnits.size();
        else
            return iRow + 1;
    }
    else if (indexDriver != -1)
        return iRow + indexDriver;
    else
        return iRow;
}

std::pair<int, int> ConnectivityContainer::rowToConnectivity(int iRow)
{
    int i;
    int iRowCurrent = 0;
    for (i = 0; i < (int)vectorConnectivities.size(); i++)
    {
        if (vectorConnectivities[i]->vectorUnits.size())
            iRowCurrent += vectorConnectivities[i]->vectorUnits.size();
        else
            iRowCurrent ++;
        if (iRowCurrent > iRow) break;
    }
    if (i < (int)vectorConnectivities.size())
    {
        if (vectorConnectivities[i]->vectorUnits.size())
            return std::make_pair(i, vectorConnectivities[i]->vectorUnits.size() - (iRowCurrent - iRow));
        else
            return std::make_pair(i, -1);
    }
    else
        return std::make_pair(-1, -1);
}

void ConnectivityContainer::getSpan(std::vector<int>& spanInterface, std::vector<int>& spanDriver, std::vector<int>& spanReceiver)
{
    int i, j;
    int iRow = 0;

    std::pair<std::string, std::string> pairLastDriver;
    std::pair<std::string, std::string> pairLastReceiver;

    for (i = 0; i < (int)vectorConnectivities.size(); i++)
    {
        if (vectorConnectivities[i]->vectorUnits.size())
        {
            pairLastDriver.first = vectorConnectivities[i]->vectorUnits[0].first;
            pairLastDriver.second = vectorConnectivities[i]->vectorCslInterfaces[0].first;
            pairLastReceiver.first = vectorConnectivities[i]->vectorUnits[0].second;
            pairLastReceiver.second = vectorConnectivities[i]->vectorCslInterfaces[0].second;
        }
        else
        {
            pairLastDriver.first.clear();
            pairLastDriver.second.clear();
            pairLastReceiver.first.clear();
            pairLastReceiver.second.clear();
        }
        break;
    }

    for (i = 0; i < (int)vectorConnectivities.size(); i++)
    {
        spanInterface.push_back(iRow);
        spanDriver.push_back(iRow);
        spanReceiver.push_back(iRow);
        if (vectorConnectivities[i]->vectorUnits.size())
            for (j = 0; j < (int)vectorConnectivities[i]->vectorUnits.size(); j++)
            {
                if (vectorConnectivities[i]->vectorUnits[j].first != pairLastDriver.first &&
                    vectorConnectivities[i]->vectorCslInterfaces[j].first == pairLastDriver.second)
                {
                    pairLastDriver.first = vectorConnectivities[i]->vectorUnits[j].first;
                    pairLastDriver.second = vectorConnectivities[i]->vectorCslInterfaces[j].first;
                    if (spanDriver[spanDriver.size() - 1] != iRow)
                        spanDriver.push_back(iRow);
                }
                if (vectorConnectivities[i]->vectorUnits[j].second != pairLastReceiver.first &&
                    vectorConnectivities[i]->vectorCslInterfaces[j].second == pairLastReceiver.second)
                {
                   pairLastReceiver.first = vectorConnectivities[i]->vectorUnits[j].second;
                   pairLastReceiver.second = vectorConnectivities[i]->vectorCslInterfaces[j].second;
                   if (spanReceiver[spanReceiver.size() - 1] != iRow)
                       spanReceiver.push_back(iRow);
                }
                iRow ++;
            }
        else
        {
            pairLastDriver.first.clear();
            pairLastDriver.second.clear();
            pairLastReceiver.first.clear();
            pairLastReceiver.second.clear();
            iRow++;
        }
    }
    spanInterface.push_back(iRow);
    spanDriver.push_back(iRow);
    spanReceiver.push_back(iRow);
}

ConnectivityContainer* ConnectivityContainer::getInstance()
{
    return connectivityContainer;
}

void ConnectivityContainer::initialize()
{
    if (connectivityContainer == NULL)
        connectivityContainer = new ConnectivityContainer();
}

void ConnectivityContainer::release()
{
    if (connectivityContainer)
        delete connectivityContainer;
    connectivityContainer = NULL;
}

bool ConnectivityContainer::hasDriver(int indexConnectivity, const std::string& unit)
{
    ConnectivityRef connectivity = getObject(indexConnectivity);
    int i;
    for (i = 0; i < (int)connectivity->vectorUnits.size(); i++)
        if (connectivity->vectorUnits[i].first == unit) return true;
    return false;
}

bool ConnectivityContainer::hasReceiver(int indexConnectivity, int indexDriver, const std::string& unit)
{
    ConnectivityRef connectivity = getObject(indexConnectivity);
    std::string unitDriver = getDriver(indexConnectivity, indexDriver);
    int indexStart, indexEnd;
    for (indexStart = indexDriver - 1; indexStart >= 0; indexStart --)
        if (getDriver(indexConnectivity, indexStart) != unitDriver) break;
    indexStart ++;
    for (indexEnd = indexDriver + 1; indexEnd < (int)connectivity->vectorUnits.size(); indexEnd++)
        if (getDriver(indexConnectivity, indexEnd) != unitDriver) break;

    int i;
    for (i = indexStart; i < indexEnd; i++)
        if (connectivity->vectorUnits[i].second == unit) return true;
    return false;
}

void ConnectivityContainer::clear()
{
    vectorConnectivities.clear();
}

bool ConnectivityContainer::hasDuplicatedName(const std::string& actualName, const std::string& originalName)
{
    if (actualName == originalName) return false;
    int i;
    for (i = 0; i < (int)vectorConnectivities.size(); i++)
        if (vectorConnectivities[i]->actualName == actualName &&
            vectorConnectivities[i]->actualName != originalName) return true;
    return false;
}

bool ConnectivityContainer::hasUnitReferenced(const UnitObjectRef& unit)
{
    if (!unit.get()) return false;
    int i, j;
    for (i = 0; i < (int)vectorConnectivities.size(); i++)
        for (j = 0; j < (int)vectorConnectivities[i]->vectorUnits.size(); j++)
        {
            UnitObjectRef driver = UnitObjectContainer::getInstance()->getObjectByPath(vectorConnectivities[i]->vectorUnits[j].first);
            if (driver.get() && (driver == unit || unit->pType->hasChild(driver)))
                return true;
            UnitObjectRef receiver = UnitObjectContainer::getInstance()->getObjectByPath(vectorConnectivities[i]->vectorUnits[j].second);
            if (receiver.get() && (receiver == unit || unit->pType->hasChild(receiver)))
                return true;
        }
    return false;
}

void ConnectivityContainer::updateReferencedUnit(const UnitObjectRef& unit, const std::string& stringNewDisplayName)
{
    if (!unit.get()) return;
    int i, j, k;
    for (i = 0; i < (int)vectorConnectivities.size(); i++)
        for (j = 0; j < (int)vectorConnectivities[i]->vectorUnits.size(); j++)
        {
            UnitObjectRef driver = UnitObjectContainer::getInstance()->getObjectByPath(vectorConnectivities[i]->vectorUnits[j].first);
            if (driver.get() && (driver == unit || unit->pType->hasChild(driver)))
            {
                std::string stringDriver = vectorConnectivities[i]->vectorUnits[j].first;
                std::vector<std::string> vectorDisplayNames, vectorTypeNames;
                vectorDisplayNames.reserve(10);
                vectorTypeNames.reserve(10);
                int iPrev = 0, iPos;
                do
                {
                    iPos = stringDriver.find('.', iPrev);
                    if (iPos != -1)
                    {
                        vectorDisplayNames.insert(vectorDisplayNames.begin(), UnitObject::getObjectName(stringDriver.substr(iPrev, iPos - iPrev)));
                        vectorTypeNames.insert(vectorTypeNames.begin(), UnitObject::getTypeName(stringDriver.substr(iPrev, iPos - iPrev)));
                    }
                    else
                    {
                        vectorDisplayNames.insert(vectorDisplayNames.begin(), UnitObject::getObjectName(stringDriver.substr(iPrev)));
                        vectorTypeNames.insert(vectorTypeNames.begin(), UnitObject::getTypeName(stringDriver.substr(iPrev)));
                    }
                    UnitObjectRef pObject = UnitObjectContainer::getInstance()->getObject(vectorDisplayNames, NULL);
                    if (pObject == unit)
                    {
                        if (iPos != -1)
                            stringDriver = stringDriver.substr(iPos + 1);
                        else
                            stringDriver.clear();
                        if (stringDriver.size())
                            stringDriver = stringNewDisplayName + "." + stringDriver;
                        else
                            stringDriver = stringNewDisplayName;
                        for (k = 1; k < (int)vectorDisplayNames.size(); k++)
                            stringDriver = UnitObject::makeDisplayName(vectorDisplayNames[k], vectorTypeNames[k]) + "." + stringDriver;
                        if (stringNewDisplayName.size())
                            vectorConnectivities[i]->vectorUnits[j].first = stringDriver;
                        else
                            vectorConnectivities[i]->vectorUnits[j].first.clear();
                        break;
                    }
                    iPrev = iPos + 1;
                }
                while(iPos != -1);
            }
            UnitObjectRef receiver = UnitObjectContainer::getInstance()->getObjectByPath(vectorConnectivities[i]->vectorUnits[j].second);
            if (receiver.get() && (receiver == unit || unit->pType->hasChild(receiver)))
            {
                std::string stringReceiver = vectorConnectivities[i]->vectorUnits[j].second;
                std::vector<std::string> vectorDisplayNames, vectorTypeNames;
                vectorDisplayNames.reserve(10);
                vectorTypeNames.reserve(10);
                int iPrev = 0, iPos;
                do
                {
                    iPos = stringReceiver.find('.', iPrev);
                    if (iPos != -1)
                    {
                        vectorDisplayNames.insert(vectorDisplayNames.begin(), UnitObject::getObjectName(stringReceiver.substr(iPrev, iPos - iPrev)));
                        vectorTypeNames.insert(vectorTypeNames.begin(), UnitObject::getTypeName(stringReceiver.substr(iPrev, iPos - iPrev)));
                    }
                    else
                    {
                        vectorDisplayNames.insert(vectorDisplayNames.begin(), UnitObject::getObjectName(stringReceiver.substr(iPrev)));
                        vectorTypeNames.insert(vectorTypeNames.begin(), UnitObject::getTypeName(stringReceiver.substr(iPrev)));
                    }
                    UnitObjectRef pObject = UnitObjectContainer::getInstance()->getObject(vectorDisplayNames, NULL);
                    if (pObject == unit)
                    {
                        if (iPos != -1)
                            stringReceiver = stringReceiver.substr(iPos + 1);
                        else
                            stringReceiver.clear();
                        if (stringReceiver.size())
                            stringReceiver = stringNewDisplayName + "." + stringReceiver;
                        else
                            stringReceiver = stringNewDisplayName;
                        for (k = 1; k < (int)vectorDisplayNames.size(); k++)
                            stringReceiver = UnitObject::makeDisplayName(vectorDisplayNames[k], vectorTypeNames[k]) + "." + stringReceiver;
                        if (stringNewDisplayName.size())
                            vectorConnectivities[i]->vectorUnits[j].second = stringReceiver;
                        else
                            vectorConnectivities[i]->vectorUnits[j].second.clear();
                        break;
                    }
                    iPrev = iPos + 1;
                }
                while(iPos != -1);
            }
        }
}

int ConnectivityContainer::getNumberOfRows()
{
    int i, iRow = 0;
    for (i = 0; i < (int)vectorConnectivities.size(); i++)
    {
        if (vectorConnectivities[i]->vectorUnits.size())
            iRow += vectorConnectivities[i]->vectorUnits.size();
        else
            iRow ++;
    }
    return iRow;
}

bool ConnectivityContainer::hasInterfaceReferenced(const InterfaceObjectRef& interface)
{
    if (!interface.get()) return false;
    int i;
    for (i = 0; i < (int)vectorConnectivities.size(); i++)
        if (vectorConnectivities[i]->interface == interface->interfaceObjectName) return true;
    return false;
}

bool ConnectivityContainer::isMultiDriver(int indexConnectivity)
{
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    int i;
    for (i = 1; i < connectivity->vectorUnits.size(); i++)
        if (connectivity->vectorUnits[i].first.size() && connectivity->vectorUnits[i].first != connectivity->vectorUnits[0].first)
            return true;
    return false;
}

bool ConnectivityContainer::isMultiReceiver(int indexConnectivity)
{
    ConnectivityRef connectivity = vectorConnectivities[indexConnectivity];
    int i;
    for (i = 1; i < connectivity->vectorUnits.size(); i++)
        if (connectivity->vectorUnits[i].second.size() && connectivity->vectorUnits[i].second != connectivity->vectorUnits[0].second)
            return true;
    return false;
}

 std::string Connectivity::getColorConnectivityString() {
    switch (colorConnectivity) {
    case    NORMAL     : return "NORMAL";
    case    ASIC_POWER_RAILS     : return "ASIC_POWER_RAILS";
    case    FPGA_POWER_RAILS     : return "FPGA_POWER_RAILS";
    default: return "getColorConnectivityString bad type"; // should throw exception
    }
}
