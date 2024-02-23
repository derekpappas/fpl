#ifndef UNIT_H
#define UNIT_H
#include <string>
#include <vector>
#include <map>
#include <set>
#include <deque>
#include "refcounted.h"

class UnitObject;
class InterfaceObject;
class UnitType;

typedef RefCounting<UnitType> UnitTypeRef;
typedef RefCounting<UnitObject> UnitObjectRef;
typedef RefCounting<InterfaceObject> InterfaceObjectRef;
typedef std::vector<UnitObjectRef>::const_iterator T_UnitObjectRefIter;

class UnitType : public RefCounted
{
    friend class UnitObject;
    friend class UnitTypeFactory;
    friend class UnitObjectContainer;

public:
    enum ETreeColorUnitFloorPlanning{
    NORMAL             ,
    DIVISION_POINT  // dividing point between top and bottom netlist
} ;

enum ETreeColorUnitLibraries {
    NORMAL_LIBRARIES        ,
    ASIC_LIBRARIES,
    FPGA_LIBRARIES
} ;

    private:
    ETreeColorUnitFloorPlanning colorUnitFloorPlanning;
    ETreeColorUnitLibraries colorUnitLibraries;

    public:
    void setColorUnitFloorPlanning(ETreeColorUnitFloorPlanning cufp) { colorUnitFloorPlanning = cufp; }
    void setColorUnitFloorPlanning(const std::string&);
    ETreeColorUnitFloorPlanning getColorUnitFloorPlanning() { return colorUnitFloorPlanning; }
    std::string getColorUnitFloorPlanningString();

    void setColorUnitLibraries(ETreeColorUnitLibraries cul) { colorUnitLibraries = cul;}
    void setColorUnitLibraries(const std::string&);
    ETreeColorUnitLibraries getColorUnitLibraries() { return colorUnitLibraries;}
    std::string getColorUnitLibrariesString();

public:
    UnitType();
    ~UnitType();

public:
    std::string unitType;
    std::string unitDescription;
    std::string unitAbbreviation;
    std::vector<UnitObjectRef> vectorChildObject;
    std::map<std::string, std::set<std::string> > mapDriverInterfaces;
    std::map<std::string, std::set<std::string> > mapReceiverInterfaces;

private:
    UnitObjectRef createObject(const std::string& unitObjectName);
    UnitObjectRef removeChild(const std::string& childObjectName);
    UnitObjectRef getChild(const std::string& childObjectName);
    UnitObjectRef getChild(const int i); // DEP added 2010-01-27
    int decreaseCreatedObjects();

public:
    UnitObjectRef addChild(const std::string& childTypeName, const std::string& childObjectName);
    bool hasChild(const std::string& childObjectName);
    bool hasChild(const UnitObjectRef& unit);
    bool hasChildType(const std::string& childTypeName);
    void getAllChildTypes(std::set<std::string>& setUnitTypes);

public:
    bool addDriverInterface(const std::string&, const std::string& stringName);
    bool addReceiverInterface(const std::string&, const std::string& stringName);
    bool removeDriverInterface(const std::string&, const std::string& stringName);
    bool removeReceiverInterface(const std::string&, const std::string& stringName);
    int queryDriverPorts(std::vector<std::string>&, std::vector<int>&);
    int queryReceiverPorts(std::vector<std::string>&, std::vector<int>&);
    // BEGIN Added by AB 2010-02-02
    //T_UnitObjectRefIter UnitType::UnitTreeIterator(UnitObjectRef theRoot);
    // END Added by AB 2010-02-01

private:
    int createdObjectCount;
    void getNodesRecursivelyDepthFirst(UnitObjectRef theNode, std::vector<UnitObjectRef> * unitList);

};

class UnitObject : public RefCounted
{
public:
    UnitObject();
    ~UnitObject();
    // BEGIN Added by AB 2010-02-02
    enum EUnitColor {
        GREEN,
        RED
    };
    // END Added by AB 2010-02-02
    UnitTypeRef pType;
    std::string unitObjectName;
    std::string userComments;
    bool topLevel;
    // BEGIN Added by AB 2010-02-02
    EUnitColor unitColor;
    // END Added by AB 2010-02-02
public:
    UnitObjectRef getChild(const std::string& stringObjectName);
    UnitObjectRef getChild(const int i); // DEP added 2010-01-27
    UnitObjectRef createChild(const std::string& stringObjectName, const std::string& stringObjectType);
    bool removeChild(const std::string&);
    bool getRelatedObjects(const UnitObjectRef& pUpdatedObject, std::vector<std::vector<UnitObjectRef> >& vectorAffectedObjects);
    std::string makeDisplayName();
    static std::string makeDisplayName(const std::string& stringObjectName, const std::string& stringTypeName);
    static std::string getObjectName(const std::string& stringDisplayName);
    static std::string getTypeName(const std::string& stringDisplayName);
    void getHierarchyDisplayNames(const std::string& stringParentHierarchyName, std::vector<std::string>& vectorHierarchyNames);
    std::string locate(const std::string& objectName);
    int count(const std::string& objectName);
    void getAllChildObjectsWithUniqueType(std::set<std::string>& setUnitTypes, std::deque<UnitObjectRef>& queueUnitObjects);
    // BEGIN Added by AB 2010-02-02
    void setUnitColor(EUnitColor c) { unitColor = c; }
    EUnitColor getUnitColor() { return unitColor; }
    // END Added by AB 2010-02-02

public:
    virtual int release();
};

class UnitTypeFactory
{
    friend class UnitType;
    friend class UnitObject;
    friend class UnitObjectContainer;
private:
    UnitTypeFactory();
    ~UnitTypeFactory();
    bool unregisterType(const std::string& unitTypeName);
    int getAllUnits(std::vector<UnitTypeRef>& vectorUnits);
public:
    UnitTypeRef registerType(const std::string& unitTypeName);
    UnitTypeRef getType(const std::string& unitTypeName);
    void clear();
public:
    static UnitTypeFactory* getInstance();
    static void initialize();
    static void release();
public:
    std::map<std::string, UnitTypeRef> mapUnitTypes;

private:
    static UnitTypeFactory* unitFactory;
};

class UnitObjectContainer
{
private:
    UnitObjectContainer();
    ~UnitObjectContainer();
public:
    std::map<std::string, UnitObjectRef> mapUnitObjects;
    UnitObjectRef createObject(const std::string& unitTypeName, const std::string& unitObjectName, const std::vector<std::string>& vectorParentName);
    UnitObjectRef createObject(const std::string& unitTypeName, const std::string& unitObjectName, const UnitObjectRef& pParentObject);
    UnitObjectRef getObject(const std::vector<std::string>& vectorParentName, UnitObjectRef* ppParentObject = NULL);
    UnitObjectRef getObject(const std::string& unitObjectName, const UnitObjectRef& pParentObject = NULL);
    UnitObjectRef getObjectByPath(const std::string& unitObjectName, UnitObjectRef* ppParentObject = NULL);
    bool removeObject(const std::string& unitObjectName, const UnitObjectRef& pParentObject = NULL);
    bool removeObject(const UnitObjectRef& pObject, const UnitObjectRef& pParentObject = NULL);
    bool getRelatedObjects(const UnitObjectRef& pUpdatedObject, std::vector<std::vector<UnitObjectRef> >& vectorAffectedObjects);
    bool updateObjectMap(const std::string& stringUnit, const UnitObjectRef&);
    int getAllUnits(std::vector<UnitObjectRef>& vectorUnits);
    int getAllExpandedUnits(std::vector<UnitObjectRef>& vectorUnits);
    void clear();
    std::string locate(const std::string& unitObjectName);
    int count(const std::string& objectName);
    std::string uniqueName(const std::string& stringUrl);

    static UnitObjectContainer* getInstance();
    static void initialize();
    static void release();
private:
    static UnitObjectContainer* unitObjectContainer;
};
#endif // UNIT_H
