#ifndef INTERFACE_H
#define INTERFACE_H
#include <vector>
#include <string>
#include <map>
#include <set>
#include "TypeDefs.h"
#include "refcounted.h"

class InterfaceObject;
class InterfaceType;

typedef RefCounting<InterfaceObject> InterfaceObjectRef;
typedef RefCounting<InterfaceType> InterfaceTypeRef;

class InterfaceType : public RefCounted
{
    friend class InterfaceObject;
    friend class InterfaceTypeFactory;
    friend class InterfaceObjectContainer;

public:
    InterfaceType();
    ~InterfaceType();

public:
    std::string interfaceType;
    std::string interfaceDescription;
    std::string interfaceAbbreviation;
    std::vector<InterfaceObjectRef> vectorChildObject;

public:
    enum INTERFACE_CATEGORY
    {
        CATEGORY_UNKNOWN,
        CATEGORY_INTERFACE,
        CATEGORY_PORT,
        CATEGORY_SIGNAL,
        CATEGORY_SIGNALGROUP,
        CATEGORY_NUMBER
    };
    enum PORT_DIRECTION
    {
        PORT_UNKNOWN,
        INPUT,
        OUTPUT,
        INOUT
    };
    enum WIRE_TYPE
    {
        WIRE_UNKNOWN,
        WIRE,
        WAND,
        WOR,
        TRI,
        TRIAND,
        TRIOR,
        TRI0,
        TRI1,
        SUPPLY0,
        SUPPLY1,
        REG,
        INTEGER,
        TIME
    };
    enum LOGICAL_TYPE
    {
        LOGICAL_UNKNOWN,
        ENABLE,
        STALL,
        MUXSELECT,
        DECODEDMINTERM,
        DECODEDMAXTERM,
        CLOCKSIGNAL,
        RESETSIGNAL
    };

    // for tree coloring that is used to generate different netlist views
    enum ETreeColorConnectivity{
        NORMAL          ,
        ASIC_POWER_RAILS,
        FPGA_POWER_RAILS
    } ;

public:
    InterfaceObjectRef addChild(const std::string& childTypeName, const std::string& childObjectName, InterfaceType::INTERFACE_CATEGORY category);
    void getAllChildTypes(std::set<std::string>& setChildTypes);

private:
    InterfaceObjectRef createObject(const std::string& interfaceObjectName);
    InterfaceObjectRef removeChild(const std::string& childObjectName);
    InterfaceObjectRef getChild(const std::string& childObjectName);
    bool hasChild(const std::string& childObjectName);
    bool hasChildType(const std::string& childTypeName);
    int decreaseCreatedObjects();
    bool isAllInput() const;
    bool isAllOutput() const;


public:
    INTERFACE_CATEGORY interfaceCategory;
    int iNumberOfBits;
    PORT_DIRECTION portDirection;
    WIRE_TYPE wireType;
    LOGICAL_TYPE logicalType;
    ETreeColorConnectivity colorConnectivity; // the coloring for this node

    TInt iWidth;
    TInt iUpperLimitBit;
    TInt iLowerLimitBit;

    void setDirection(const std::string&);
    std::string getDirection() const;
    void setWireType(const std::string&);
    std::string getWireType() const;
    void setLogicalType(const std::string&);
    std::string getLogicalType() const;

private:
    int createdObjectCount;
    int unitPortIndex;

public:
    const char* getInterfaceCategory() const;
    INTERFACE_CATEGORY setInterfaceCategory(const char*);
    static INTERFACE_CATEGORY toInterfaceCategory(const char*);
    static const char* fromInterfaceCategory(INTERFACE_CATEGORY category);
    void setColorConnectivity(ETreeColorConnectivity cc) { colorConnectivity = cc; }
    void setColorConnectivity(const std::string&);
    ETreeColorConnectivity getColorConnectivity() { return colorConnectivity     ; }
    std::string getColorConnectivityString();

};

class InterfaceObject : public RefCounted
{
public:
    InterfaceObject();
    ~InterfaceObject();

    InterfaceTypeRef pType;
    std::string interfaceObjectName;
    std::string userComments;
    int hierachyLevel;
    bool topLevel;
public:
    InterfaceObjectRef getChild(const std::string& stringName);
    InterfaceObjectRef createChild(const std::string& stringObjectName, const std::string& stringObjectType, InterfaceType::INTERFACE_CATEGORY category);
    bool removeChild(const std::string&);
    bool getRelatedObjects(const InterfaceObjectRef& pUpdatedObject, std::vector<std::vector<InterfaceObjectRef> >& vectorAffectedObjects);
    std::string makeDisplayName();
    static std::string makeDisplayName(const std::string& stringObjectName, const std::string& stringInterfaceName);
    std::string makeDisplayValue();
    static std::string makeDisplayValue(InterfaceType::INTERFACE_CATEGORY category);
    void getHierarchyDisplayNames(const std::string& stringParentHierarchyName, std::vector<std::string>& vectorHierarchyNames);
    void getChildHierarchyDisplayNames(const std::string& stringParentHierarchyName, std::vector<std::string>& vectorHierarchyNames);
    std::string locate(const std::string& objectName);
    int count(const std::string& objectName);
    bool isAllInput() const;
    bool isAllOutput() const;
    
public:
    virtual int release();
};

class InterfaceTypeFactory
{
    friend class InterfaceType;
    friend class InterfaceObject;
    friend class InterfaceObjectContainer;
private:
    InterfaceTypeFactory();
    ~InterfaceTypeFactory();
public:
    InterfaceTypeRef getType(const std::string& InterfaceTypeName);
    InterfaceTypeRef registerType(const std::string& InterfaceTypeName, InterfaceType::INTERFACE_CATEGORY);
    bool unregisterType(const std::string& InterfaceTypeName);
    void clear();
    static InterfaceTypeFactory* getInstance();
    static void initialize();
    static void release();
public:
    std::map<std::string, InterfaceTypeRef> mapInterfaceTypes;
private:
    static InterfaceTypeFactory* interfaceFactory;
};

class InterfaceObjectContainer
{
private:
    InterfaceObjectContainer();
    ~InterfaceObjectContainer();

public:
    std::map<std::string, InterfaceObjectRef> mapInterfaceObjects;
    InterfaceObjectRef createObject(const std::string& InterfaceTypeName, const std::string& interfaceObjectName, const std::vector<std::string>& vectorParentName, InterfaceType::INTERFACE_CATEGORY category);
    InterfaceObjectRef createObject(const std::string& InterfaceTypeName, const std::string& interfaceObjectName, const InterfaceObjectRef& pParentObject, InterfaceType::INTERFACE_CATEGORY category);
    InterfaceObjectRef getObject(const std::vector<std::string>& vectorParentName, InterfaceObjectRef* ppParentObject = NULL);
    InterfaceObjectRef getObject(const std::string& interfaceObjectName, const InterfaceObjectRef& pParentObject = NULL);
    InterfaceObjectRef getObjectByPath(const std::string& stringPath, InterfaceObjectRef* ppParentObject = NULL);
    InterfaceObjectRef getObjectByVirtualPath(const std::string& stringPath, InterfaceObjectRef* ppParentObject = NULL);
    bool removeObject(const std::string& interfaceObjectName, const InterfaceObjectRef& pParentObject = NULL);
    bool removeObject(const InterfaceObjectRef& pObject, const InterfaceObjectRef& pParentObject = NULL);
    bool getRelatedObjects(const InterfaceObjectRef& pUpdatedObject, std::vector<std::vector<InterfaceObjectRef> >& vectorAffectedObjects);
    bool updateObjectMap(const std::string& stringInterface, const InterfaceObjectRef&);
    int getAllInterfaces(std::vector<InterfaceObjectRef>& vectorInterfaces);
    void clear();
    std::string locate(const std::string&);
    int count(const std::string&);
    std::string uniqueName(const std::string& stringPath);
    bool isTopLevelType(const std::string&);
    bool isTopLevelObject(const InterfaceObjectRef& interface);
    static InterfaceObjectContainer* getInstance();
    static void initialize();
    static void release();

private:
    static InterfaceObjectContainer* interfaceObjectContainer;
};
#endif // INTERFACE_H
