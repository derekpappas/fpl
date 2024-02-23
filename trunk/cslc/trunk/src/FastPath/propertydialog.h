#ifndef PROPERTYDIALOG_H
#define PROPERTYDIALOG_H

#include <QDialog>
#include <map>
#include <set>

#include "ui_dialogProperty.h"
class QtVariantPropertyManager;
class QtGroupBoxPropertyBrowser;
class QtVariantEditorFactory;
class QtVariantProperty;


class PropertyDialog : public QDialog
{
    Q_OBJECT
public:
    PropertyDialog(QWidget* parent);

    void addProperty(int propertyId, const QString& stringProperty, const QString& stringParent = QString::null);
    void setPropertyAttribute(const QString& stringProperty, const QString& stringAttribute, const QVariant& value);
    QVariant getPropertyAttribute(const QString& stringProperty, const QString& stringAttribute);
    virtual void setPropertyValue(const QString& stringProperty, const QVariant& value);
    QVariant getPropertyValue(const QString& stringProperty);
    void setPropertyRequired(const QString& stringProperty, bool bRequired);
    void setPropertyReadOnly(const QString& stringProperty, bool bReadOnly);
    void removeProperty(const QString& stringProperty);

public:
    Ui_DialogProperty ui;
protected slots:
    virtual void onAccept();
public:
    QtVariantPropertyManager* pPropertyManager;
    QtGroupBoxPropertyBrowser* pPropertyBrowser;
    QtVariantEditorFactory* pEditorFactory;

protected:
    std::map<QString, QtVariantProperty*> mapProperties;
    std::set<QtVariantProperty*> setRequiredProperties;
};

#endif // PROPERTYDIALOG_H
