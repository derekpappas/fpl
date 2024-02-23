#ifndef DRIVERCONNECTIONDIALOG_H
#define DRIVERCONNECTIONDIALOG_H
#include "propertydialog.h"
#include "refcounted.h"
#include "interface.h"
#include "connectivity.h"
class QtProperty;
class QVariant;
class UnitObject;
typedef RefCounting<UnitObject> UnitObjectRef;
class Connectivity;
typedef RefCounting<Connectivity> ConnectivityRef;

class DriverConnectionDialog : public PropertyDialog
{
    Q_OBJECT
public:
    DriverConnectionDialog(QWidget*, const std::string&, bool bDriver, const ConnectivityRef& connectivity, bool bDriverNameReadOnly);
    std::string getAssociatedInterfaceObject();
    std::string getAssociatedUnitObject();
    void setAssociatedUnitObject(const std::string&);
    void setAssociatedInterfaceObject(const std::string& interface);
    virtual void onAccept();

protected slots:
    void valueChanged(QtProperty *, const QVariant &);

private:
    std::string interface;
    QString stringDriverReceiver;
    ConnectivityRef connectivity;
    bool bUseDriverInterface;
};

#endif // DRIVERCONNECTIONDIALOG_H
