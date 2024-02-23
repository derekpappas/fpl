#include "interface.h"
#include <string.h>
#include <deque>
#include <cstdio>

InterfaceTypeFactory* InterfaceTypeFactory::interfaceFactory = NULL;
InterfaceObjectContainer* InterfaceObjectContainer::interfaceObjectContainer = NULL;

static const char* INTERFACE_CATEGORY_STRING[] =
{
    "Unknown",
    "Interface",
    "Port",
    "Signal",
    "Signal Group"
};

InterfaceType::InterfaceType() :
    interfaceCategory(CATEGORY_UNKNOWN),
    iNumberOfBits(0),
    portDirection(PORT_UNKNOWN),
    wireType(WIRE),
    logicalType(LOGICAL_UNKNOWN),
    iWidth(0),
    iUpperLimitBit(0),
    iLowerLimitBit(0),
    createdObjectCount(0),
    unitPortIndex(0),
    colorConnectivity(NORMAL)
{
}

InterfaceType::~InterfaceType()
{
}

void InterfaceType::getAllChildTypes(std::set<std::string>& setChildTypes)
{
    if (setChildTypes.count(interfaceType)) return;
    setChildTypes.insert(interfaceType);
    int i;
    for (i = 0; i < (int)vectorChildObject.size(); i++)
        vectorChildObject[i]->pType->getAllChildTypes(setChildTypes);
}

void InterfaceType::setDirection(const std::string& s)
{
    if (s == "INPUT")
        portDirection = INPUT;
    else if (s == "OUTPUT")
        portDirection = OUTPUT;
    else if (s == "INOUT")
        portDirection = INOUT;
    else
        portDirection = PORT_UNKNOWN;
}

std::string InterfaceType::getDirection() const
{
    switch (portDirection)
    {
    case INPUT:
        return "INPUT";
    case OUTPUT:
        return "OUTPUT";
    case INOUT:
        return "INOUT";
    default:
        return "UNKNOWN";
    }
}

void InterfaceType::setWireType(const std::string& s)
{
    if (s == "WIRE")
        wireType = WIRE;
    else if (s == "WAND")
        wireType = WAND;
    else if (s == "WOR")
        wireType = WOR;
    else if (s == "TRI")
        wireType = TRI;
    else if (s == "TRIAND")
        wireType = TRIAND;
    else if (s == "TRIOR")
        wireType = TRIOR;
    else if (s == "TRI0")
        wireType = TRI0;
    else if (s == "TRI1")
        wireType = TRI1;
    else if (s == "SUPPLY0")
        wireType = SUPPLY0;
    else if (s == "SUPPLY1")
        wireType = SUPPLY1;
    else if (s == "REG")
        wireType = REG;
    else if (s == "INTEGER")
        wireType = INTEGER;
    else if (s == "TIME")
        wireType = TIME;
    else
        wireType = WIRE_UNKNOWN;
}

std::string InterfaceType::getWireType() const
{
    switch(wireType)
    {
    case WIRE:
        return "WIRE";
    case WAND:
        return "WAND";
    case WOR:
        return "WOR";
    case TRI:
        return "TRI";
    case TRIAND:
        return "TRIAND";
    case TRIOR:
        return "TRIOR";
    case TRI0:
        return "TRI0";
    case TRI1:
        return "TRI1";
    case SUPPLY0:
        return "SUPPLY0";
    case SUPPLY1:
        return "SUPPLY1";
    case REG:
        return "REG";
    case INTEGER:
        return "INTEGER";
    case TIME:
        return "TIME";
    default:
        return "UNKNOWN";
    }
}

void InterfaceType::setLogicalType(const std::string& s)
{
    if (s == "ENABLE")
        logicalType = ENABLE;
    else if (s == "STALL")
        logicalType = STALL;
    else if (s == "MUXSELECT")
        logicalType = MUXSELECT;
    else if (s == "DECODEDMINTERM")
        logicalType = DECODEDMINTERM;
    else if (s == "DECODEDMAXTERM")
        logicalType = DECODEDMAXTERM;
    else if (s == "CLOCKSIGNAL")
        logicalType = CLOCKSIGNAL;
    else if (s == "RESETSIGNAL")
        logicalType = RESETSIGNAL;
    else
        logicalType = LOGICAL_UNKNOWN;
}

std::string InterfaceType::getLogicalType() const
{
    switch(logicalType)
    {
    case ENABLE:
        return "ENABLE";
    case STALL:
        return "STALL";
    case MUXSELECT:
        return "MUXSELECT";
    case DECODEDMINTERM:
        return "DECODEDMINTERM";
    case DECODEDMAXTERM:
        return "DECODEDMAXTERM";
    case CLOCKSIGNAL:
        return "CLOCKSIGNAL";
    case RESETSIGNAL:
        return "RESETSIGNAL";
    default:
        return "UNKNOWN";
    }
}

const char* InterfaceType::getInterfaceCategory() const
{
    return fromInterfaceCategory(interfaceCategory);
}

InterfaceType::INTERFACE_CATEGORY InterfaceType::setInterfaceCategory(const char* szCategory)
{
    interfaceCategory = toInterfaceCategory(szCategory);
    return interfaceCategory;
}

InterfaceType::INTERFACE_CATEGORY InterfaceType::toInterfaceCategory(const char* szCategory)
{
    int i;
    for (i = 0; i < sizeof(INTERFACE_CATEGORY_STRING) / sizeof(const char*); i++)
        if (strcmp(INTERFACE_CATEGORY_STRING[i], szCategory) == 0) return (InterfaceType::INTERFACE_CATEGORY)i;
    return (InterfaceType::INTERFACE_CATEGORY)0;
}

const char* InterfaceType::fromInterfaceCategory(INTERFACE_CATEGORY category)
{
    return INTERFACE_CATEGORY_STRING[category];
}

//FIXME: need to provide a way to avoid circle reference of the type names
InterfaceObjectRef InterfaceType::addChild(const std::string& childTypeName, const std::string& childObjectName, InterfaceType::INTERFACE_CATEGORY category)
{
    //Avoid self reference
    if (interfaceType == childTypeName && interfaceCategory == category)
        return NULL;
    //Avoid circular reference
    if (InterfaceTypeFactory::getInstance()->getType(childTypeName)->hasChildType(interfaceType))
        return NULL;

    //Avoid name duplication
    if (hasChild(childObjectName))
        return NULL;

    InterfaceTypeRef pType = InterfaceTypeFactory::getInstance()->getType(childTypeName);
    InterfaceObjectRef pObject = pType->createObject(childObjectName);
    vectorChildObject.push_back(pObject);
    return pObject;
}

bool InterfaceType::hasChildType(const std::string& childTypeName)
{
    if (interfaceType == childTypeName) return true;
    std::vector<InterfaceObjectRef>::iterator iteratorChild;
    for (iteratorChild = vectorChildObject.begin(); iteratorChild != vectorChildObject.end(); iteratorChild ++)
        if ((*iteratorChild)->pType->hasChildType(childTypeName)) return true;
    return false;
}

bool InterfaceType::hasChild(const std::string& childObjectName)
{
    std::vector<InterfaceObjectRef>::iterator iteratorChild;
    for (iteratorChild = vectorChildObject.begin(); iteratorChild != vectorChildObject.end(); iteratorChild ++)
        if ((*iteratorChild)->interfaceObjectName == childObjectName) return true;
    return false;
}

InterfaceObjectRef InterfaceType::removeChild(const std::string& childObjectName)
{
    InterfaceObjectRef pChild = NULL;
    int i;
    for (i = 0; i < vectorChildObject.size(); i++)
        if (vectorChildObject[i]->interfaceObjectName == childObjectName)
        {
            pChild = vectorChildObject[i];
            vectorChildObject.erase(vectorChildObject.begin() + i);
            break;
        }
    return pChild;
}

InterfaceObjectRef InterfaceType::getChild(const std::string& childObjectName)
{
    int i;
    for (i = 0; i < vectorChildObject.size(); i++)
        if (vectorChildObject[i]->interfaceObjectName == childObjectName)
            return vectorChildObject[i];
    return NULL;
}

InterfaceObjectRef InterfaceType::createObject(const std::string& interfaceObjectName)
{
    InterfaceObjectRef pObj = new InterfaceObject();
    pObj->pType = this;
    pObj->interfaceObjectName = interfaceObjectName;
    createdObjectCount ++;
    return pObj;
}

int InterfaceType::decreaseCreatedObjects()
{
    createdObjectCount--;
    if (createdObjectCount == 0)
        InterfaceTypeFactory::getInstance()->unregisterType(interfaceType);
    return createdObjectCount;
}

bool InterfaceType::isAllInput() const
{
    if ((interfaceCategory == CATEGORY_PORT || interfaceCategory == CATEGORY_SIGNAL)
        && portDirection != INPUT) return false;
    unsigned int i;
    for (i = 0; i < vectorChildObject.size(); i++)
        if (!vectorChildObject[i]->isAllInput()) return false;
    return true;
}

bool InterfaceType::isAllOutput() const
{
    if ((interfaceCategory == CATEGORY_PORT || interfaceCategory == CATEGORY_SIGNAL)
        && portDirection != OUTPUT) return false;
    unsigned int i;
    for (i = 0; i < vectorChildObject.size(); i++)
        if (!vectorChildObject[i]->isAllOutput()) return false;
    return true;
}

InterfaceObject::InterfaceObject() :
        pType(NULL),
        topLevel(false)
{
}

InterfaceObject::~InterfaceObject()
{
}

int InterfaceObject::release()
{
    InterfaceTypeRef ref = pType;
    int iResult = RefCounted::release();
    if (iResult == 0 && ref.get())
        ref->decreaseCreatedObjects();
    return iResult;
}

InterfaceObjectRef InterfaceObject::getChild(const std::string& stringObjectName)
{
    if (!pType.get()) return NULL;
    return pType->getChild(stringObjectName);
}

InterfaceObjectRef InterfaceObject::createChild(const std::string& stringObjectName, const std::string& stringObjectType, InterfaceType::INTERFACE_CATEGORY category)
{
    if (!pType.get()) return NULL;
    std::string stringName = stringObjectName;
    if (stringName.size() == 0)
    {
        char szBuffer[32];
        ::sprintf(szBuffer, "_%d", (int)pType->vectorChildObject.size());
        stringName = stringObjectType + szBuffer;
    }
    if (getChild(stringName).get()) return NULL;
    std::string stringInternalType;
    if (category == InterfaceType::CATEGORY_PORT || category == InterfaceType::CATEGORY_SIGNAL)
    {
        char szBuffer[256];
        ::sprintf(szBuffer, "%s___$$$$$$___%d", pType->interfaceType.c_str(), pType->unitPortIndex++);
        stringInternalType = szBuffer;
    }
    else
        stringInternalType = stringObjectType;

    if (pType->interfaceType == stringInternalType) return NULL;

    //Need to first register, then use
    InterfaceTypeRef pChildType = InterfaceTypeFactory::getInstance()->registerType(stringInternalType, category);
    if (pChildType->interfaceCategory != category) return NULL;
    //avoid circular referencing
    if (pChildType->hasChildType(pType->interfaceType)) return NULL;

    return pType->addChild(stringInternalType, stringName, category);
}

bool InterfaceObject::removeChild(const std::string& childObjectName)
{
    if (!pType.get()) return false;
    return (bool)pType->removeChild(childObjectName).get();
}

bool InterfaceObject::getRelatedObjects(const InterfaceObjectRef& pUpdatedObject, std::vector<std::vector<InterfaceObjectRef> >& vectorAffectedObjects)
{
    std::vector<std::vector<InterfaceObjectRef> > vectorAffectedObjectsLocal;
    std::vector<InterfaceObjectRef> vectorRoute;
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
    if (pType.get())
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

std::string InterfaceObject::makeDisplayName()
{
    if (!pType.get()) return std::string();
    if (!topLevel && pType->interfaceCategory != InterfaceType::CATEGORY_PORT && pType->interfaceCategory != InterfaceType::CATEGORY_SIGNAL)
        return makeDisplayName(interfaceObjectName, pType->interfaceType);
    else
        return interfaceObjectName;
}

std::string InterfaceObject::makeDisplayName(const std::string& stringObjectName, const std::string& stringInterfaceName)
{
    return stringInterfaceName + "(" + stringObjectName + ")";
}

std::string InterfaceObject::makeDisplayValue()
{
    if (!pType.get()) return std::string();
    return makeDisplayValue(pType->interfaceCategory);
}

std::string InterfaceObject::makeDisplayValue(InterfaceType::INTERFACE_CATEGORY category)
{
    return INTERFACE_CATEGORY_STRING[category];
}

void InterfaceObject::getHierarchyDisplayNames(const std::string& stringParentHierarchyName, std::vector<std::string>& vectorHierarchyNames)
{
    std::string stringThisHierarchyName;
    if (stringParentHierarchyName.size())
    {
        InterfaceObjectRef parent = InterfaceObjectContainer::getInstance()->getObjectByPath(stringParentHierarchyName);
        if (parent.get() != this)
            stringThisHierarchyName = stringParentHierarchyName + "." + makeDisplayName();
        else
            stringThisHierarchyName = stringParentHierarchyName;
    }
    else
        stringThisHierarchyName = makeDisplayName();
    vectorHierarchyNames.push_back(stringThisHierarchyName);
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
        pType->vectorChildObject[i]->getHierarchyDisplayNames(stringThisHierarchyName, vectorHierarchyNames);
}

void InterfaceObject::getChildHierarchyDisplayNames(const std::string& stringParentHierarchyName, std::vector<std::string>& vectorHierarchyNames)
{
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
        pType->vectorChildObject[i]->getHierarchyDisplayNames(stringParentHierarchyName, vectorHierarchyNames);
}

std::string InterfaceObject::locate(const std::string& objectName)
{
    if (interfaceObjectName == objectName)
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

int InterfaceObject::count(const std::string& objectName)
{
    int iCount = 0;
    if (interfaceObjectName == objectName)
        iCount++;
    int i;
    for (i = 0; i < (int)pType->vectorChildObject.size(); i++)
        iCount += pType->vectorChildObject[i]->count(objectName);
    return iCount;
}

bool InterfaceObject::isAllInput() const
{
    if (pType.get())
        return pType->isAllInput();
    else
        return true;
}

bool InterfaceObject::isAllOutput() const
{
    if (pType.get())
        return pType->isAllOutput();
    else
        return true;
}

InterfaceTypeFactory::InterfaceTypeFactory()
{
}

InterfaceTypeFactory::~InterfaceTypeFactory()
{
}

InterfaceTypeRef InterfaceTypeFactory::getType(const std::string& interfaceTypeName)
{
    std::map<std::string, InterfaceTypeRef>::iterator iteratorInterfaceType;
    iteratorInterfaceType = mapInterfaceTypes.find(interfaceTypeName);
    if (iteratorInterfaceType != mapInterfaceTypes.end())
        return iteratorInterfaceType->second;
    else
        return NULL;
}

InterfaceTypeRef InterfaceTypeFactory::registerType(const std::string& interfaceTypeName, InterfaceType::INTERFACE_CATEGORY category)
{
    std::map<std::string, InterfaceTypeRef>::iterator iteratorInterfaceType;

    iteratorInterfaceType = mapInterfaceTypes.find(interfaceTypeName);
    if (iteratorInterfaceType == mapInterfaceTypes.end())
    {
        InterfaceTypeRef pNewType = new InterfaceType();
        //FIXME: need to provide a way to also register the child types and interface types
        mapInterfaceTypes[interfaceTypeName] = pNewType;
        pNewType->interfaceType = interfaceTypeName;
        pNewType->interfaceCategory = category;
        return pNewType;
    }
    else
        return iteratorInterfaceType->second;
    return NULL;
}

void InterfaceTypeFactory::clear()
{
    mapInterfaceTypes.clear();
}

InterfaceTypeFactory* InterfaceTypeFactory::getInstance()
{
    return interfaceFactory;
}

void InterfaceTypeFactory::initialize()
{
    if (interfaceFactory == NULL)
        interfaceFactory = new InterfaceTypeFactory();
}

void InterfaceTypeFactory::release()
{
    if (interfaceFactory)
        delete interfaceFactory;
    interfaceFactory = NULL;
}

bool InterfaceTypeFactory::unregisterType(const std::string& interfaceTypeName)
{
    std::map<std::string, InterfaceTypeRef>::iterator iteratorInterfaceType;
    iteratorInterfaceType = mapInterfaceTypes.find(interfaceTypeName);
    if (iteratorInterfaceType != mapInterfaceTypes.end())
    {
        //FIXME : I also need to delete all the referenced Interface objects later
        mapInterfaceTypes.erase(iteratorInterfaceType);
        return true;
    }
    else
        return false;
}

InterfaceObjectContainer::InterfaceObjectContainer()
{
}

InterfaceObjectContainer::~InterfaceObjectContainer()
{
}

InterfaceObjectRef InterfaceObjectContainer::createObject(const std::string& interfaceTypeName, const std::string& interfaceObjectName, const std::vector<std::string>& vectorParentName, InterfaceType::INTERFACE_CATEGORY category)
{
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    if (vectorParentName.size())
    {
        std::string stringTopObject = vectorParentName[vectorParentName.size() - 1];
        iteratorInterfaceObject = mapInterfaceObjects.find(stringTopObject);
        if (iteratorInterfaceObject == mapInterfaceObjects.end()) return NULL;

        int i;
        InterfaceObjectRef pObject = iteratorInterfaceObject->second;
        for (i = vectorParentName.size() - 2; i >= 0; i--)
        {
            stringTopObject = vectorParentName[i];
            pObject = pObject->getChild(stringTopObject);
        }
        return pObject->createChild(interfaceObjectName, interfaceTypeName, category);
    }
    else
    {
        iteratorInterfaceObject = mapInterfaceObjects.find(interfaceObjectName);
        if (iteratorInterfaceObject == mapInterfaceObjects.end())
        {
            std::map<std::string, InterfaceTypeRef>::iterator iteratorInterfaceType;
            iteratorInterfaceType = InterfaceTypeFactory::getInstance()->mapInterfaceTypes.find(interfaceTypeName);
            InterfaceTypeRef pType;
            if (iteratorInterfaceType == InterfaceTypeFactory::getInstance()->mapInterfaceTypes.end())
                pType = InterfaceTypeFactory::getInstance()->registerType(interfaceTypeName, category);
            else
                pType = iteratorInterfaceType->second;
            if (pType.get() && pType->interfaceCategory == category)
            {
                InterfaceObjectRef pNewObject = pType->createObject(interfaceObjectName);
                mapInterfaceObjects[interfaceObjectName] = pNewObject;
                pNewObject->topLevel = true;
                return pNewObject;
            }
            else
                return NULL;
        }
        return NULL;
    }
}

InterfaceObjectRef InterfaceObjectContainer::createObject(const std::string& interfaceTypeName, const std::string& interfaceObjectName, const InterfaceObjectRef& pParentObject, InterfaceType::INTERFACE_CATEGORY category)
{
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    if (pParentObject.get())
        return pParentObject->createChild(interfaceObjectName, interfaceTypeName, category);
    else
    {
        iteratorInterfaceObject = mapInterfaceObjects.find(interfaceObjectName);
        if (iteratorInterfaceObject == mapInterfaceObjects.end())
        {
            std::map<std::string, InterfaceTypeRef>::iterator iteratorInterfaceType;
            iteratorInterfaceType = InterfaceTypeFactory::getInstance()->mapInterfaceTypes.find(interfaceTypeName);
            InterfaceTypeRef pType;
            if (iteratorInterfaceType == InterfaceTypeFactory::getInstance()->mapInterfaceTypes.end())
                pType = InterfaceTypeFactory::getInstance()->registerType(interfaceTypeName, category);
            else
                pType = iteratorInterfaceType->second;
            //Don't allow anything other than Interface/Signal Group being created on the top level.
            if (pType.get() && pType->interfaceCategory == category)
            {
                if (pType->interfaceCategory != InterfaceType::CATEGORY_INTERFACE &&
                    pType->interfaceCategory != InterfaceType::CATEGORY_SIGNALGROUP)
                    return NULL;
                InterfaceObjectRef pNewObject = pType->createObject(interfaceObjectName);
                mapInterfaceObjects[interfaceObjectName] = pNewObject;
                pNewObject->topLevel = true;
                return pNewObject;
            }
            else
                return NULL;
        }
        return NULL;
    }
}

InterfaceObjectRef InterfaceObjectContainer::getObject(const std::vector<std::string>& vectorParentName, InterfaceObjectRef* ppParentObject)
{
    if (ppParentObject) *ppParentObject = NULL;
    if (!vectorParentName.size()) return NULL;
    std::string stringTopObject = vectorParentName[vectorParentName.size() - 1];
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject = mapInterfaceObjects.find(stringTopObject);
    if (iteratorInterfaceObject == mapInterfaceObjects.end()) return NULL;

    int i;
    InterfaceObjectRef pObject = iteratorInterfaceObject->second;
    for (i = vectorParentName.size() - 2; i >= 0; i--)
    {
        stringTopObject = vectorParentName[i];
        if (ppParentObject) *ppParentObject = pObject;
        pObject = pObject->getChild(stringTopObject);
    }
    return pObject;
}

InterfaceObjectRef InterfaceObjectContainer::getObjectByPath(const std::string& stringPathName, InterfaceObjectRef* ppParentObject)
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

InterfaceObjectRef InterfaceObjectContainer::getObjectByVirtualPath(const std::string& stringPathName, InterfaceObjectRef* ppParentObject)
{
    int iPos = stringPathName.find('.');
    std::string stringExtension, stringPrefix;
    if (iPos != -1)
    {
        stringExtension = stringPathName.substr(iPos + 1);
        stringPrefix = stringPathName.substr(0, iPos);
    }
    else
        stringPrefix = stringPathName;

    TInt iNamePos = stringPrefix.find('(');
    if (stringExtension.size())
        stringExtension = stringPrefix.substr(0, iNamePos) + std::string(".") + stringExtension;
    else
        stringExtension = stringPrefix.substr(0, iNamePos);
    return getObjectByPath(stringExtension, ppParentObject);
}

InterfaceObjectRef InterfaceObjectContainer::getObject(const std::string& interfaceObjectName, const InterfaceObjectRef& pParentObject)
{
    if (pParentObject.get())
        return pParentObject->getChild(interfaceObjectName);
    else
    {
        std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject = mapInterfaceObjects.find(interfaceObjectName);
        if (iteratorInterfaceObject == mapInterfaceObjects.end()) return NULL;

        return iteratorInterfaceObject->second;
    }
}

bool InterfaceObjectContainer::removeObject(const std::string& interfaceObjectName, const InterfaceObjectRef& pParentObject)
{
    if (pParentObject.get())
        return pParentObject->removeChild(interfaceObjectName);
    else
    {
        std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
        iteratorInterfaceObject = mapInterfaceObjects.find(interfaceObjectName);
        if (iteratorInterfaceObject != mapInterfaceObjects.end())
        {
            mapInterfaceObjects.erase(iteratorInterfaceObject);
            return true;
        }
        return false;
    }
}

bool InterfaceObjectContainer::removeObject(const InterfaceObjectRef& pObject, const InterfaceObjectRef& pParentObject)
{
    return removeObject(pObject->interfaceObjectName, pParentObject);
}

bool InterfaceObjectContainer::getRelatedObjects(const InterfaceObjectRef& pUpdatedObject, std::vector<std::vector<InterfaceObjectRef> >& vectorAffectedObjects)
{
    if (pUpdatedObject == NULL) return false;
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    for (iteratorInterfaceObject = mapInterfaceObjects.begin(); iteratorInterfaceObject != mapInterfaceObjects.end(); iteratorInterfaceObject++)
        iteratorInterfaceObject->second->getRelatedObjects(pUpdatedObject, vectorAffectedObjects);
    return vectorAffectedObjects.size();
}

bool InterfaceObjectContainer::updateObjectMap(const std::string& stringInterface, const InterfaceObjectRef& pObject)
{
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject = mapInterfaceObjects.find(stringInterface);
    if (iteratorInterfaceObject != mapInterfaceObjects.end())
        mapInterfaceObjects.erase(iteratorInterfaceObject);
    mapInterfaceObjects[pObject->interfaceObjectName] = pObject;
    pObject->topLevel = true;
    return true;
}

int InterfaceObjectContainer::getAllInterfaces(std::vector<InterfaceObjectRef>& vectorInterfaces)
{
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    std::set<std::string> setInterfaceTypes;
    for (iteratorInterfaceObject = mapInterfaceObjects.begin(); iteratorInterfaceObject != mapInterfaceObjects.end(); iteratorInterfaceObject++)
        setInterfaceTypes.insert(iteratorInterfaceObject->second->pType->interfaceType);
    std::set<std::string> setChildInterfaceTypes;
    std::set<std::string>::const_iterator iteratorChildType;
    std::deque<InterfaceObjectRef> queueTemporaryInterfaces;
    for (iteratorInterfaceObject = mapInterfaceObjects.begin(); iteratorInterfaceObject != mapInterfaceObjects.end(); iteratorInterfaceObject++)
        queueTemporaryInterfaces.push_back(iteratorInterfaceObject->second);
    while(queueTemporaryInterfaces.size())
    {
        setChildInterfaceTypes.clear();
        queueTemporaryInterfaces[0]->pType->getAllChildTypes(setChildInterfaceTypes);
        setChildInterfaceTypes.erase(queueTemporaryInterfaces[0]->pType->interfaceType);
        for (iteratorChildType = setChildInterfaceTypes.begin(); iteratorChildType != setChildInterfaceTypes.end(); iteratorChildType++)
            if (setInterfaceTypes.count(*iteratorChildType)) break;
        if (iteratorChildType != setChildInterfaceTypes.end())
        {
            queueTemporaryInterfaces.push_back(queueTemporaryInterfaces[0]);
            queueTemporaryInterfaces.pop_front();
        }
        else
        {
            vectorInterfaces.push_back(queueTemporaryInterfaces[0]);
            setInterfaceTypes.erase(queueTemporaryInterfaces[0]->pType->interfaceType);
            queueTemporaryInterfaces.pop_front();
        }
    }

    return vectorInterfaces.size();
}

void InterfaceObjectContainer::clear()
{
    mapInterfaceObjects.clear();
}

InterfaceObjectContainer* InterfaceObjectContainer::getInstance()
{
    return interfaceObjectContainer;
}

void InterfaceObjectContainer::initialize()
{
    if (interfaceObjectContainer == NULL)
        interfaceObjectContainer = new InterfaceObjectContainer();
}

void InterfaceObjectContainer::release()
{
    if (interfaceObjectContainer)
        delete interfaceObjectContainer;
    interfaceObjectContainer = NULL;
}

std::string InterfaceObjectContainer::locate(const std::string& interfaceObjectName)
{
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    for (iteratorInterfaceObject = mapInterfaceObjects.begin(); iteratorInterfaceObject != mapInterfaceObjects.end(); iteratorInterfaceObject++)
    {
        std::string stringPathName = iteratorInterfaceObject->second->locate(interfaceObjectName);
        if (stringPathName.size())
            return stringPathName;
    }
    return std::string();
}

int InterfaceObjectContainer::count(const std::string& stringObjectName)
{
    int iCount = 0;
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    for (iteratorInterfaceObject = mapInterfaceObjects.begin(); iteratorInterfaceObject != mapInterfaceObjects.end(); iteratorInterfaceObject++)
        iCount += iteratorInterfaceObject->second->count(stringObjectName);
    return iCount;
}

bool InterfaceObjectContainer::isTopLevelType(const std::string& stringType)
{
    std::map<std::string, InterfaceObjectRef>::iterator iteratorInterfaceObject;
    for (iteratorInterfaceObject = mapInterfaceObjects.begin(); iteratorInterfaceObject != mapInterfaceObjects.end(); iteratorInterfaceObject++)
        if (iteratorInterfaceObject->second->pType->interfaceType == stringType) return true;
    return false;
}

bool InterfaceObjectContainer::isTopLevelObject(const InterfaceObjectRef& interface)
{
    if (mapInterfaceObjects.count(interface->interfaceObjectName) && mapInterfaceObjects[interface->interfaceObjectName] == interface)
        return true;
    return false;
}

std::string InterfaceObjectContainer::uniqueName(const std::string& stringPathName)
{
    InterfaceObjectRef interface = getObjectByPath(stringPathName);
    if (count(interface->interfaceObjectName) == 1)
        return interface->interfaceObjectName;
    else
        return stringPathName;
}

std::string InterfaceType::getColorConnectivityString() {
    switch (colorConnectivity) {
    case    NORMAL     : return "NORMAL";
    case    ASIC_POWER_RAILS     : return "ASIC_POWER_RAILS";
    case    FPGA_POWER_RAILS     : return "FPGA_POWER_RAILS";
    default: return "getColorConnectivityString bad type"; // should throw exception 
    }
}

void InterfaceType::setColorConnectivity(const std::string& s)
{
    if (s == "NORMAL")
        colorConnectivity = NORMAL;
    else if (s == "ASIC_POWER_RAILS")
        colorConnectivity = ASIC_POWER_RAILS;
    else if (s == "FPGA_POWER_RAILS")
        colorConnectivity = FPGA_POWER_RAILS;
}
