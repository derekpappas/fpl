#include "unit.h"
#include "interface.h"
#include <cstdio>

UnitTypeFactory* UnitTypeFactory::unitFactory = NULL;
UnitObjectContainer* UnitObjectContainer::unitObjectContainer = NULL;

UnitType::UnitType() :
        createdObjectCount(0),
        colorUnitFloorPlanning(NORMAL),
        colorUnitLibraries(NORMAL_LIBRARIES)
{
}

UnitType::~UnitType()
{
}

//FIXME: need to provide a way to avoid circle reference of the type names
UnitObjectRef UnitType::addChild(const std::string& childTypeName, const std::string& childObjectName)
{
    //Avoid self reference
    if (unitType == childTypeName)
        return NULL;
    //Avoid circular reference
    if (UnitTypeFactory::getInstance()->getType(childTypeName)->hasChildType(unitType))
        return NULL;

    //Avoid name duplication
    if (hasChild(childObjectName))
        return NULL;

    UnitTypeRef pType = UnitTypeFactory::getInstance()->getType(childTypeName);
    UnitObjectRef pObject = pType->createObject(childObjectName);
    vectorChildObject.push_back(pObject);
    return pObject;
}

bool UnitType::hasChildType(const std::string& childTypeName)
{
    if (unitType == childTypeName) return true;
    int i;
    for (i = 0; i < (int)vectorChildObject.size(); i++)
        if (vectorChildObject[i]->pType->hasChildType(childTypeName)) return true;
    return false;
}

bool UnitType::hasChild(const std::string& childObjectName)
{
    int i;
    for (i = 0; i < (int)vectorChildObject.size(); i++)
        if (vectorChildObject[i]->unitObjectName == childObjectName) return true;
    return false;
}

bool UnitType::hasChild(const UnitObjectRef& unit)
{
    int i;
    for (i = 0; i < (int)vectorChildObject.size(); i++)
        if (vectorChildObject[i] == unit || vectorChildObject[i]->pType->hasChild(unit)) return true;
    return false;
}

UnitObjectRef UnitType::removeChild(const std::string& childObjectName)
{
    int i;
    UnitObjectRef pChild = NULL;
    for (i = 0; i < vectorChildObject.size(); i++)
        if (vectorChildObject[i]->unitObjectName == childObjectName)
        {
        pChild = vectorChildObject[i];
        vectorChildObject.erase(vectorChildObject.begin() + i);
        break;
    }
    return pChild;
}

UnitObjectRef UnitType::getChild(const std::string& childObjectName)
{
    int i;
    for (i = 0; i < vectorChildObject.size(); i++)
        if (vectorChildObject[i]->unitObjectName == childObjectName)
            return vectorChildObject[i];
    return NULL;
}

// BEGIN DEP added 2010-01-27

UnitObjectRef UnitType::getChild(const int i) {
    if( i < vectorChildObject.size()) {
        if (vectorChildObject[i] != 0) {
            return vectorChildObject[i];
        }
    }
    return NULL;
}

// END DEP added 2010-01-27

UnitObjectRef UnitType::createObject(const std::string& unitObjectName)
{
    UnitObjectRef pObj = new UnitObject();
    pObj->pType = this;
    pObj->unitObjectName = unitObjectName;
    createdObjectCount++;
    return pObj;
}

void UnitType::getAllChildTypes(std::set<std::string>& setChildTypes)
{
    if (setChildTypes.count(unitType)) return;
    setChildTypes.insert(unitType);
    int i;
    for (i = 0; i < (int)vectorChildObject.size(); i++)
        vectorChildObject[i]->pType->getAllChildTypes(setChildTypes);
}

int UnitType::decreaseCreatedObjects()
{
    createdObjectCount--;
    if (createdObjectCount == 0)
        UnitTypeFactory::getInstance()->unregisterType(unitType);
    return createdObjectCount;
}

bool UnitType::addDriverInterface(const std::string& s, const std::string& stringName)
{
    InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(s);
    if (interface.get() && interface->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE)
    {
        mapDriverInterfaces[s].insert(stringName);
        return true;
    }
    else
        return false;
}

bool UnitType::addReceiverInterface(const std::string& s, const std::string& stringName)
{
    InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(s);
    if (interface.get() && interface->pType->interfaceCategory == InterfaceType::CATEGORY_INTERFACE)
    {
        mapReceiverInterfaces[s].insert(stringName);
        return true;
    }
    else
        return false;
}

bool UnitType::removeDriverInterface(const std::string& s, const std::string& stringName)
{
    if (mapDriverInterfaces.count(s))
    {
        mapDriverInterfaces[s].erase(stringName);
        if (mapDriverInterfaces[s].size() == 0)
            mapDriverInterfaces.erase(s);
        return true;
    }
    else
        return false;
}

bool UnitType::removeReceiverInterface(const std::string& s, const std::string& stringName)
{
    if (mapReceiverInterfaces.count(s))
    {
        mapReceiverInterfaces[s].erase(stringName);
        if (mapReceiverInterfaces[s].size() == 0)
            mapReceiverInterfaces.erase(s);
        return true;
    }
    else
        return false;
}

int UnitType::queryDriverPorts(std::vector<std::string>& v, std::vector<int>& types)
{
    std::map<std::string, std::set<std::string> >::const_iterator iteratorMap;
    std::set<std::string>::const_iterator iteratorSet;
    for (iteratorMap = mapDriverInterfaces.begin(); iteratorMap != mapDriverInterfaces.end(); iteratorMap++)
    {
        InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(iteratorMap->first);
        if (interface.get())
        {
            std::vector<std::string> vectorHierarchyNames;
            interface->getChildHierarchyDisplayNames("", vectorHierarchyNames);
            int i;
            for (iteratorSet = iteratorMap->second.begin(); iteratorSet != iteratorMap->second.end(); iteratorSet++)
            {
                v.push_back(iteratorMap->first + std::string("(") + *iteratorSet + std::string(")"));
                types.push_back(interface->pType->interfaceCategory);
                for (i = 0; i < (int)vectorHierarchyNames.size(); i++)
                {
                    v.push_back(iteratorMap->first + std::string("(") + *iteratorSet + std::string(").") + vectorHierarchyNames[i]);
                    interface = InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(v[v.size() - 1]);
                    if (interface.get())
                        types.push_back(interface->pType->interfaceCategory);
                    else
                        types.push_back(-1);
                }
            }
        }
    }
    return v.size();
}

int UnitType::queryReceiverPorts(std::vector<std::string>& v, std::vector<int>& types)
{
    std::map<std::string, std::set<std::string> >::const_iterator iteratorMap;
    std::set<std::string>::const_iterator iteratorSet;
    for (iteratorMap = mapReceiverInterfaces.begin(); iteratorMap != mapReceiverInterfaces.end(); iteratorMap++)
    {
        InterfaceObjectRef interface = InterfaceObjectContainer::getInstance()->getObjectByPath(iteratorMap->first);
        if (interface.get())
        {
            std::vector<std::string> vectorHierarchyNames;
            interface->getChildHierarchyDisplayNames("", vectorHierarchyNames);
            int i;
            for (iteratorSet = iteratorMap->second.begin(); iteratorSet != iteratorMap->second.end(); iteratorSet++)
            {
                v.push_back(iteratorMap->first + std::string("(") + *iteratorSet + std::string(")"));
                types.push_back(interface->pType->interfaceCategory);
                for (i = 0; i < (int)vectorHierarchyNames.size(); i++)
                {
                    v.push_back(iteratorMap->first + std::string("(") + *iteratorSet + std::string(").") + vectorHierarchyNames[i]);
                    interface = InterfaceObjectContainer::getInstance()->getObjectByVirtualPath(v[v.size() - 1]);
                    if (interface.get())
                        types.push_back(interface->pType->interfaceCategory);
                    else
                        types.push_back(-1);
                }
            }
        }
    }
    return v.size();
}

// BEGIN DEP added 2010-01-27
// fix the return type to be an iterator
// BEGIN Added by AB 2010-02-02
/*
T_UnitObjectRefIter UnitType::UnitTreeIterator(UnitObjectRef theRoot) {
    //int nodeCounter = 0;
    std::vector<UnitObjectRef> * unitList = new std::vector<UnitObjectRef>();
    getNodesRecursivelyDepthFirst(theRoot, unitList);
    // System.out.println("unitList has length %d\n", unitList.size() ); //
    // DEBUG
    T_UnitObjectRefIter iter = unitList->begin();

    return iter;
}
*/
// END Added by AB 2010-02-02

void UnitType::getNodesRecursivelyDepthFirst(UnitObjectRef theNode, std::vector<UnitObjectRef> * unitList) {

    int counter = 0;

    unitList->push_back(theNode);
    if (theNode.get()->pType.get()->vectorChildObject.size() != 0)
        for (counter = 0; counter < theNode.get()->pType.get()->vectorChildObject.size(); ++counter)
            getNodesRecursivelyDepthFirst(theNode.get()->getChild(counter), unitList);
}

// END DEP added 2010-01-27

UnitObject::UnitObject() :
        pType(NULL),
        topLevel(false),
        // BEGIN Added by AB 2010-02-02
        unitColor(GREEN)
        // END Added by AB 2010-02-02
{
}

UnitObject::~UnitObject()
{
}

int UnitObject::release()
{
    UnitTypeRef ref = pType;
    int iResult = RefCounted::release();
    if (iResult == 0 && ref.get())
        ref->decreaseCreatedObjects();
    return iResult;
}

UnitObjectRef UnitObject::getChild(const std::string& stringObjectName)
{
    return pType->getChild(stringObjectName);
}

 // DEP added 2010-01-27
UnitObjectRef UnitObject::getChild(const int i) {
    return pType->getChild(i);
}
 // DEP added 2010-01-27

UnitObjectRef UnitObject::createChild(const std::string& stringObjectName, const std::string& stringObjectType)
{
    std::string stringName = stringObjectName;
    if (stringName.size() == 0)
    {
        char szBuffer[32];
        ::sprintf(szBuffer, "_%d", (int)pType->vectorChildObject.size());
        stringName = stringObjectType + szBuffer;
    }
    if (getChild(stringObjectName).get()) return NULL;
    if (pType->unitType == stringObjectType) return NULL;

    //Need to first register, then use
    UnitTypeRef pChildType = UnitTypeFactory::getInstance()->registerType(stringObjectType);
    //avoid circular referencing
    if (pChildType->hasChildType(pType->unitType)) return NULL;

    UnitObjectRef pObject = pType->addChild(stringObjectType, stringName);
    return pObject;
}

bool UnitObject::removeChild(const std::string& childObjectName)
{
    return (bool)pType->removeChild(childObjectName).get();
}

bool UnitObject::getRelatedObjects(const UnitObjectRef& pUpdatedObject, std::vector<std::vector<UnitObjectRef> >& vectorAffectedObjects)
{
    std::vector<std::vector<UnitObjectRef> > vectorAffectedObjectsLocal;
    std::vector<UnitObjectRef> vectorRoute;
    int iSize = vectorAffectedObjects.size();
    if (pType == pUpdatedObject->pType)
    {
        vectorRoute.push_back(this);
        vectorAffectedObjectsLocal.push_back(vectorRoute);
        vectorAffectedObjects.insert(vectorAffectedObjects.end(), vectorAffectedObjectsLocal.begin(), vectorAffectedObjectsLocal.end());
        vectorAffectedObjectsLocal.clear();
        return true;
    }

    int i, j;
    for (i = 0; i < pType->vectorChildObject.size(); i++)
    {
        if (pType->vectorChildObject[i]->getRelatedObjects(pUpdatedObject, vectorAffectedObjectsLocal))
        {
            for (j = 0; j < vectorAffectedObjectsLocal.size(); j++)
                vectorAffectedObjectsLocal[j].push_back(this);
            vectorAffectedObjects.insert(vectorAffectedObjects.end(), vectorAffectedObjectsLocal.begin(), vectorAffectedObjectsLocal.end());
            vectorAffectedObjectsLocal.clear();
        }
    }
    return vectorAffectedObjects.size() != iSize;
}

std::string UnitObject::makeDisplayName()
{
    return makeDisplayName(unitObjectName, pType->unitType);
}

std::string UnitObject::makeDisplayName(const std::string& stringObjectName, const std::string& stringTypeName)
{
    return stringTypeName + "(" + stringObjectName + ")";
}

std::string UnitObject::getObjectName(const std::string& stringDisplayName)
{
    int left_bracket = stringDisplayName.find('(');
    int right_bracket = stringDisplayName.find(')');
    return stringDisplayName.substr(left_bracket + 1, right_bracket - left_bracket - 1);
}

std::string UnitObject::getTypeName(const std::string& stringDisplayName)
{
    int left_bracket = stringDisplayName.find('(');
    return stringDisplayName.substr(0, left_bracket);
}

void UnitObject::getHierarchyDisplayNames(const std::string& stringParentHierarchyName, std::vector<std::string>& vectorHierarchyNames)
{
    std::string stringThisHierarchyName;
    if (stringParentHierarchyName.size())
        stringThisHierarchyName = stringParentHierarchyName + "." + makeDisplayName();
    else
        stringThisHierarchyName = makeDisplayName();
    vectorHierarchyNames.push_back(stringThisHierarchyName);
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
        pType->vectorChildObject[i]->getHierarchyDisplayNames(stringThisHierarchyName, vectorHierarchyNames);
}

std::string UnitObject::locate(const std::string& objectName)
{
    if (unitObjectName == objectName)
        return makeDisplayName();
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
    {
        std::string stringPathName = pType->vectorChildObject[i]->locate(objectName);
        if (stringPathName.size())
            return makeDisplayName() + "." + stringPathName;
    }
    return std::string();
}

int UnitObject::count(const std::string& objectName)
{
    int iCount = 0;
    if (unitObjectName == objectName)
        iCount ++;
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
        iCount += pType->vectorChildObject[i]->count(objectName);
    return iCount;
}

void UnitObject::getAllChildObjectsWithUniqueType(std::set<std::string>& setChildTypes, std::deque<UnitObjectRef>& queueUnitObjects)
{
    if (setChildTypes.count(pType->unitType)) return;
    setChildTypes.insert(pType->unitType);
    queueUnitObjects.push_back(this);
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
        pType->vectorChildObject[i]->getAllChildObjectsWithUniqueType(setChildTypes, queueUnitObjects);
}

UnitTypeFactory::UnitTypeFactory()
{
}

UnitTypeFactory::~UnitTypeFactory()
{
}

UnitTypeRef UnitTypeFactory::getType(const std::string& unitTypeName)
{
    std::map<std::string, UnitTypeRef>::iterator iteratorUnitType;
    iteratorUnitType = mapUnitTypes.find(unitTypeName);
    if (iteratorUnitType != mapUnitTypes.end())
        return iteratorUnitType->second;
    else
        return NULL;
}

UnitTypeRef UnitTypeFactory::registerType(const std::string& unitTypeName)
{
    std::map<std::string, UnitTypeRef>::iterator iteratorUnitType;

    iteratorUnitType = mapUnitTypes.find(unitTypeName);
    if (iteratorUnitType == mapUnitTypes.end())
    {
        UnitTypeRef pNewType = new UnitType();
        //FIXME: need to provide a way to also register the child types and interface types
        mapUnitTypes[unitTypeName] = pNewType;
        pNewType->unitType = unitTypeName;
        return pNewType;
    }
    else
        return iteratorUnitType->second;
    return NULL;
}

bool UnitTypeFactory::unregisterType(const std::string& unitTypeName)
{
    std::map<std::string, UnitTypeRef>::iterator iteratorUnitType;
    iteratorUnitType = mapUnitTypes.find(unitTypeName);
    if (iteratorUnitType != mapUnitTypes.end())
    {
        //FIXME : I also need to delete all the referenced unit objects later
        mapUnitTypes.erase(iteratorUnitType);
        return true;
    }
    else
        return false;
}

// put all units into a vector.
// the units are stored in a map

int UnitTypeFactory::getAllUnits(std::vector<UnitTypeRef>& vectorUnits)
{
    std::map<std::string, UnitTypeRef>::iterator iteratorUnitType;
    for (iteratorUnitType = mapUnitTypes.begin(); iteratorUnitType != mapUnitTypes.end(); iteratorUnitType++)
        vectorUnits.push_back(iteratorUnitType->second);
    return (vectorUnits.size());
}

UnitTypeFactory* UnitTypeFactory::getInstance()
{
    return unitFactory;
}

void UnitTypeFactory::initialize()
{
    if (unitFactory == NULL)
        unitFactory = new UnitTypeFactory();
}

void UnitTypeFactory::release()
{
    if (unitFactory)
        delete unitFactory;
    unitFactory = NULL;
}

void UnitTypeFactory::clear()
{
    mapUnitTypes.clear();
}

UnitObjectContainer::UnitObjectContainer()
{
}

UnitObjectContainer::~UnitObjectContainer()
{
}

UnitObjectRef UnitObjectContainer::createObject(const std::string& unitTypeName, const std::string& unitObjectName, const std::vector<std::string>& vectorParentName)
{
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    if (vectorParentName.size())
    {
        std::string stringTopObject = vectorParentName[vectorParentName.size() - 1];
        iteratorUnitObject = mapUnitObjects.find(stringTopObject);
        if (iteratorUnitObject == mapUnitObjects.end()) return NULL;
        
        int i;
        UnitObjectRef pObject = iteratorUnitObject->second;
        for (i = vectorParentName.size() - 2; i >= 0; i--)
        {
            stringTopObject = vectorParentName[i];
            pObject = pObject->getChild(stringTopObject);
        }
        return pObject->createChild(unitObjectName, unitTypeName);
    }
    else
    {
        iteratorUnitObject = this->mapUnitObjects.find(unitObjectName);
        if (iteratorUnitObject == mapUnitObjects.end())
        {
            std::map<std::string, UnitTypeRef>::iterator iteratorUnitType;
            iteratorUnitType = UnitTypeFactory::getInstance()->mapUnitTypes.find(unitTypeName);
            UnitTypeRef pType;
            if (iteratorUnitType == UnitTypeFactory::getInstance()->mapUnitTypes.end())
                pType = UnitTypeFactory::getInstance()->registerType(unitTypeName);
            else
                pType = iteratorUnitType->second;
            UnitObjectRef pNewObject = pType->createObject(unitObjectName);
            mapUnitObjects[unitObjectName] = pNewObject;
            pNewObject->topLevel = true;
            return pNewObject;
        }
        return NULL;
    }
}

UnitObjectRef UnitObjectContainer::createObject(const std::string& unitTypeName, const std::string& unitObjectName, const UnitObjectRef& pParentObject)
{
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    if (pParentObject.get())
        return pParentObject->createChild(unitObjectName, unitTypeName);
    else
    {
        iteratorUnitObject = this->mapUnitObjects.find(unitObjectName);
        if (iteratorUnitObject == mapUnitObjects.end())
        {
            std::map<std::string, UnitTypeRef>::iterator iteratorUnitType;
            iteratorUnitType = UnitTypeFactory::getInstance()->mapUnitTypes.find(unitTypeName);
            UnitTypeRef pType;
            if (iteratorUnitType == UnitTypeFactory::getInstance()->mapUnitTypes.end())
                pType = UnitTypeFactory::getInstance()->registerType(unitTypeName);
            else
                pType = iteratorUnitType->second;
            UnitObjectRef pNewObject = pType->createObject(unitObjectName);
            mapUnitObjects[unitObjectName] = pNewObject;
            pNewObject->topLevel = true;
            return pNewObject;
        }
        return NULL;
    }
}

UnitObjectRef UnitObjectContainer::getObject(const std::vector<std::string>& vectorParentName, UnitObjectRef* ppParentObject)
{
    if (ppParentObject) *ppParentObject = NULL;
    if (!vectorParentName.size()) return NULL;
    std::string stringTopObject = vectorParentName[vectorParentName.size() - 1];
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject = mapUnitObjects.find(stringTopObject);
    if (iteratorUnitObject == mapUnitObjects.end()) return NULL;

    int i;
    UnitObjectRef pObject = iteratorUnitObject->second;
    for (i = vectorParentName.size() - 2; i >= 0; i--)
    {
        stringTopObject = vectorParentName[i];
        if (ppParentObject) *ppParentObject = pObject;
        pObject = pObject->getChild(stringTopObject);
    }
    return pObject;
}

UnitObjectRef UnitObjectContainer::getObjectByPath(const std::string& stringPathName, UnitObjectRef* ppParentObject)
{
    std::vector<std::string> vectorParentNames;
    int iPos = -1, iPrevPos;
    std::string stringName;
    do
    {
        iPrevPos = iPos + 1;
        iPos = stringPathName.find('.', iPrevPos);

        if (iPos != -1)
            stringName = stringPathName.substr(iPrevPos, iPos - iPrevPos);
        else
            stringName = stringPathName.substr(iPrevPos);
        TInt iLeft = stringName.find('('); \
                     TInt iRight = stringName.find(')'); \
                                   stringName = stringName.substr(iLeft + 1, iRight - iLeft - 1); \
                                                vectorParentNames.insert(vectorParentNames.begin(), stringName);
    }while(iPos != -1);
    return getObject(vectorParentNames, ppParentObject);
}

UnitObjectRef UnitObjectContainer::getObject(const std::string& unitObjectName, const UnitObjectRef& pParentObject)
{
    if (pParentObject.get())
        return pParentObject->getChild(unitObjectName);
    else
    {
        std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject = mapUnitObjects.find(unitObjectName);
        if (iteratorUnitObject == mapUnitObjects.end()) return NULL;

        return iteratorUnitObject->second;
    }
}

bool UnitObjectContainer::removeObject(const std::string& unitObjectName, const UnitObjectRef& pParentObject)
{
    if (pParentObject.get())
        return pParentObject->removeChild(unitObjectName);
    else
    {
        std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
        //allow duplicated object name in different types, so the key is set to be objectname@typename
        iteratorUnitObject = this->mapUnitObjects.find(unitObjectName);
        if (iteratorUnitObject != mapUnitObjects.end())
        {
            mapUnitObjects.erase(iteratorUnitObject);
            return true;
        }
        return false;
    }
}

bool UnitObjectContainer::removeObject(const UnitObjectRef& pObject, const UnitObjectRef& pParentObject)
{
    return removeObject(pObject->unitObjectName, pParentObject);
}

bool UnitObjectContainer::getRelatedObjects(const UnitObjectRef& pUpdatedObject, std::vector<std::vector<UnitObjectRef> >& vectorAffectedObjects)
{
    if (pUpdatedObject == NULL) return false;
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    for (iteratorUnitObject = mapUnitObjects.begin(); iteratorUnitObject != mapUnitObjects.end(); iteratorUnitObject++)
        iteratorUnitObject->second->getRelatedObjects(pUpdatedObject, vectorAffectedObjects);
    return vectorAffectedObjects.size();
}

bool UnitObjectContainer::updateObjectMap(const std::string& stringUnit, const UnitObjectRef& pObject)
{
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject = mapUnitObjects.find(stringUnit);
    if (iteratorUnitObject != mapUnitObjects.end())
        mapUnitObjects.erase(iteratorUnitObject);
    mapUnitObjects[pObject->unitObjectName] = pObject;
    return true;
}

int UnitObjectContainer::getAllUnits(std::vector<UnitObjectRef>& vectorUnits)
{
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    for (iteratorUnitObject = mapUnitObjects.begin(); iteratorUnitObject != mapUnitObjects.end(); iteratorUnitObject++)
        vectorUnits.push_back(iteratorUnitObject->second);
    return vectorUnits.size();
}

void UnitObjectContainer::clear()
{
    mapUnitObjects.clear();
}

UnitObjectContainer* UnitObjectContainer::getInstance()
{
    return unitObjectContainer;
}

void UnitObjectContainer::initialize()
{
    if (unitObjectContainer == NULL)
        unitObjectContainer = new UnitObjectContainer();
}

void UnitObjectContainer::release()
{
    if (unitObjectContainer)
        delete unitObjectContainer;
    unitObjectContainer = NULL;
}

std::string UnitObjectContainer::locate(const std::string& unitObjectName)
{
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    for (iteratorUnitObject = mapUnitObjects.begin(); iteratorUnitObject != mapUnitObjects.end(); iteratorUnitObject++)
    {
        std::string stringPathName = iteratorUnitObject->second->locate(unitObjectName);
        if (stringPathName.size())
            return stringPathName;
    }
    return std::string();
}

int UnitObjectContainer::count(const std::string& unitObjectName)
{
    int iCount = 0;
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    for (iteratorUnitObject = mapUnitObjects.begin(); iteratorUnitObject != mapUnitObjects.end(); iteratorUnitObject++)
        iCount += iteratorUnitObject->second->count(unitObjectName);
    return iCount;
}

std::string UnitObjectContainer::uniqueName(const std::string& stringPathName)
{
    UnitObjectRef unit = getObjectByPath(stringPathName);
    if (count(unit->unitObjectName) == 1)
        return unit->unitObjectName;
    else
        return stringPathName;
}

int UnitObjectContainer::getAllExpandedUnits(std::vector<UnitObjectRef>& vectorUnits)
{
    std::map<std::string, UnitObjectRef>::iterator iteratorUnitObject;
    std::set<std::string> setUnitTypes;
    std::deque<UnitObjectRef> queueTemporaryUnits;
    for (iteratorUnitObject = mapUnitObjects.begin(); iteratorUnitObject != mapUnitObjects.end(); iteratorUnitObject++)
        iteratorUnitObject->second->getAllChildObjectsWithUniqueType(setUnitTypes, queueTemporaryUnits);
    std::set<std::string> setChildUnitTypes;
    std::set<std::string>::const_iterator iteratorChildType;
    while(queueTemporaryUnits.size())
    {
        setChildUnitTypes.clear();
        queueTemporaryUnits[0]->pType->getAllChildTypes(setChildUnitTypes);
        setChildUnitTypes.erase(queueTemporaryUnits[0]->pType->unitType);
        for (iteratorChildType = setChildUnitTypes.begin(); iteratorChildType != setChildUnitTypes.end(); iteratorChildType++)
            if (setUnitTypes.count(*iteratorChildType)) break;
        if (iteratorChildType != setChildUnitTypes.end())
        {
            queueTemporaryUnits.push_back(queueTemporaryUnits[0]);
            queueTemporaryUnits.pop_front();
        }
        else
        {
            vectorUnits.push_back(queueTemporaryUnits[0]);
            setUnitTypes.erase(queueTemporaryUnits[0]->pType->unitType);
            queueTemporaryUnits.pop_front();
        }
    }

    return vectorUnits.size();
}

std::string UnitType::getColorUnitLibrariesString() {
    switch (colorUnitLibraries) {
    case NORMAL_LIBRARIES: return "NORMAL_LIBRARIES";
    case ASIC_LIBRARIES  : return "ASIC_LIBRARIES";
    case FPGA_LIBRARIES  : return "FPGA_LIBRARIES";
    default: return "getColorUnitLibrariesString bad type"; // should throw exception
    }
}

void UnitType::setColorUnitLibraries(const std::string & s)
{
    if (s == "NORMAL_LIBRARIES")
        colorUnitLibraries = NORMAL_LIBRARIES;
    else if (s == "ASIC_LIBRARIES")
        colorUnitLibraries = ASIC_LIBRARIES;
    else if (s == "FPGA_LIBRARIES")
        colorUnitLibraries = FPGA_LIBRARIES;

}

std::string UnitType::getColorUnitFloorPlanningString() {
    switch (colorUnitFloorPlanning) {
    case NORMAL        : return "NORMAL";
    case DIVISION_POINT: return "DIVISION_POINT";
    default: return "getColorUnitFloorPlanningString bad type"; // should throw exception
    }
}

void UnitType::setColorUnitFloorPlanning(const std::string & s)
{
    if (s == "NORMAL")
        colorUnitFloorPlanning = NORMAL;
    else if (s == "DIVISION_POINT")
        colorUnitFloorPlanning = DIVISION_POINT;
}
