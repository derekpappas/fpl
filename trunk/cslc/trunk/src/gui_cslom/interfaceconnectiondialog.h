#ifndef INTERFACECONNECTIONDIALOG_H
#define INTERFACECONNECTIONDIALOG_H

#include "propertydialog.h"
#include "refcounted.h"

class QWidget;
class QtProperty;
class InterfaceObject;
typedef RefCounting<InterfaceObject> InterfaceObjectRef;

class InterfaceConnectionDialog : public PropertyDialog
{
    Q_OBJECT
public:
    InterfaceConnectionDialog(QWidget* parent);
protected slots:
    void valueChanged(QtProperty *, const QVariant &);

protected:
    virtual void onAccept();
public:
    virtual void setPropertyValue(const QString& stringProperty, const QVariant& value);
private:
    QString originalName;
};

#endif // INTERFACECONNECTIONDIALOG_H
