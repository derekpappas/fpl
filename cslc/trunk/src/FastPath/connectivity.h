#ifndef CONNECTIVITY_H
#define CONNECTIVITY_H
#include "refcounted.h"
#include <vector>
#include <string>


class Connectivity;
typedef RefCounting<Connectivity> ConnectivityRef;
class UnitObject;
typedef RefCounting<UnitObject> UnitObjectRef;
class InterfaceObject;
typedef RefCounting<InterfaceObject> InterfaceObjectRef;

class Connectivity : public RefCounted
{
public:
    Connectivity();
    ~Connectivity();
 // for tree coloring that is used to generate different netlist views
    enum ETreeColorConnectivity{
        NORMAL          ,
        ASIC_POWER_RAILS,
        FPGA_POWER_RAILS
    } ;
    ETreeColorConnectivity colorConnectivity; // the coloring for this node

    enum CONNECTIVITY_TYPE{
        CONNECTIVITY_TYPE_INTERFACE,
        CONNECTIVITY_TYPE_WIRE,
        CONNECTIVITY_TYPE_SUBINTERFACE
    };

    void setColorConnectivity(ETreeColorConnectivity cc) { colorConnectivity = cc; }
    ETreeColorConnectivity getColorConnectivity() { return colorConnectivity     ; }
    std::string getColorConnectivityString();
    std::string connectivityTypeName() const;

    std::string connectivityName;
    std::string actualName;
    std::string interface;
    CONNECTIVITY_TYPE connectivityType;
    std::vector<std::pair<std::string, std::string> > vectorCslInterfaces;
    std::vector<std::pair<std::string, std::string> > vectorUnits;

public:

    void updateUnitInterfaces();

};

class ConnectivityContainer
{
private:
    ConnectivityContainer();
    ~ConnectivityContainer();
public:
    std::vector<ConnectivityRef> vectorConnectivities;
public:
    ConnectivityRef addObject(const std::string&, Connectivity::CONNECTIVITY_TYPE cType);
    ConnectivityRef removeObject(int iIndex);
    ConnectivityRef getObject(int iIndex);

    std::pair<ConnectivityRef, int> addDriver(int indexConnectivity, int iIndexDriver = -1);
    std::pair<int, int> removeDriver(int indexConnectivity, int indexDriver);

    std::pair<ConnectivityRef, int> addReceiver(int indexConnectivity, int iIndexDriver);
    int removeReceiver(int indexConnectivity, int indexDriver);

    ConnectivityRef setDriver(int indexConnectivity, int indexDriver, const std::string& driver);
    ConnectivityRef setReceiver(int indexConnectivity, int indexDriver, const std::string& receiver);
    ConnectivityRef setDriverInterface(int indexConnectivity, int indexDriver, const std::string& driver);
    ConnectivityRef setReceiverInterface(int indexConnectivity, int indexDriver, const std::string& receiver);
    std::string getDriver(int indexConnectivity, int indexDriver);
    std::string getReceiver(int indexConnectivity, int indexDriver);
    std::string getDriverInterface(int indexConnectivity, int indexDriver);
    std::string getReceiverInterface(int indexConnectivity, int indexDriver);
    int indexToRow(int indexConnectivity, int indexDriver = -1);
    std::pair<int, int> rowToConnectivity(int iRow);
    void getSpan(std::vector<int>& spanInterface, std::vector<int>& spanDriver, std::vector<int>& spanReceiver);

    bool hasDriver(int indexConnectivity, const std::string& stringDriver);
    bool hasReceiver(int indexConnectivity, int indexDriver, const std::string& stringReceiver);
    
    void clear();
    int getNumberOfRows();
    bool hasDuplicatedName(const std::string& actualName, const std::string& originalName);
    bool hasUnitReferenced(const UnitObjectRef& unit);
    void updateReferencedUnit(const UnitObjectRef& unit, const std::string& stringNewDisplayName);
    bool hasInterfaceReferenced(const InterfaceObjectRef& interface);
    bool isMultiDriver(int indexConnectivity);
    bool isMultiReceiver(int indexConnectivity);

    static ConnectivityContainer* getInstance();
    static void initialize();
    static void release();
private:
    static ConnectivityContainer* connectivityContainer;
};

#endif // CONNECTIVITY_H
