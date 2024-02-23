#include "propertydialog.h"
#include "qtvariantproperty.h"
#include "qtpropertybrowser.h"
#include "qtgroupboxpropertybrowser.h"
#include "qteditorfactory.h"
#include <QMessageBox>
#include <QGridLayout>

PropertyDialog::PropertyDialog(QWidget* parent) :
        QDialog(parent)
{
    ui.setupUi(this);
    disconnect(ui.buttonBox, SIGNAL(accepted()), this, SLOT(accept()));
    connect(ui.buttonBox, SIGNAL(accepted()), this, SLOT(onAccept()));
    connect(ui.buttonBox, SIGNAL(rejected()), this, SLOT(reject()));

    pPropertyManager = new QtVariantPropertyManager(this);
    pPropertyBrowser = new QtGroupBoxPropertyBrowser(this);
    pEditorFactory = new QtVariantEditorFactory(this);

    pPropertyBrowser->setFactoryForManager(pPropertyManager, pEditorFactory);

    QGridLayout* popup1Layout = new QGridLayout(this);
    popup1Layout->setSpacing(6);
    popup1Layout->setMargin(11);
    popup1Layout->addWidget(pPropertyBrowser);
    popup1Layout->addWidget(ui.buttonBox);
}

void PropertyDialog::onAccept()
{
    if (setRequiredProperties.size())
    {
        std::set<QtVariantProperty*>::iterator iteratorSet;
        for (iteratorSet = setRequiredProperties.begin(); iteratorSet != setRequiredProperties.end(); iteratorSet++)
        {
            QtVariantProperty* pProperty = (*iteratorSet);
            if (pProperty->propertyType() == QVariant::String)
            {
                if (pProperty->valueText() == QString::null)
                {
                    QMessageBox::critical(this, "Error", QString("%1 value has not been set yet").arg(pProperty->propertyName()), QMessageBox::Ok);
                    return;
                }
            }
            else if (pProperty->propertyType() == QtVariantPropertyManager::comboboxTypeId())
            {
                if (pProperty->value().toString() == "" || pProperty->value().toString() == "NONE")
                {
                    QMessageBox::critical(this, "Error", QString("%1 value has not been set yet").arg(pProperty->propertyName()), QMessageBox::Ok);
                    return;
                }
            }
            else if (pProperty->propertyType() == QVariant::Int)
            {
                if (pProperty->value().toInt() == 0)
                {
                    QMessageBox::critical(this, "Error", QString("%1 value has not been set yet").arg(pProperty->propertyName()), QMessageBox::Ok);
                    return;
                }
            }
            else if (pProperty->propertyType() == QtVariantPropertyManager::enumTypeId())
            {
                if (pProperty->value().toInt() == 0)
                {
                    QMessageBox::critical(this, "Error", QString("%1 value has not been set yet").arg(pProperty->propertyName()), QMessageBox::Ok);
                    return;
                }
            }
        }
    }
    QDialog::accept();
}

void PropertyDialog::addProperty(int propertyId, const QString& stringProperty, const QString& stringParent)
{
    if (mapProperties.find(stringProperty) != mapProperties.end()) return;
    QtVariantProperty* pProperty = pPropertyManager->addProperty(propertyId, stringProperty);
    mapProperties[stringProperty] = pProperty;
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringParent)) != mapProperties.end())
        iteratorProperty->second->addSubProperty(pProperty);
    else
        pPropertyBrowser->addProperty(pProperty);
}

void PropertyDialog::setPropertyAttribute(const QString& stringProperty, const QString& stringAttribute, const QVariant& value)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) != mapProperties.end())
        iteratorProperty->second->setAttribute(stringAttribute, value);
}

void PropertyDialog::setPropertyValue(const QString& stringProperty, const QVariant& value)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) != mapProperties.end())
        iteratorProperty->second->setValue(value);
}

QVariant PropertyDialog::getPropertyValue(const QString& stringProperty)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) != mapProperties.end())
        return iteratorProperty->second->value();
    else
        return QVariant();
}

void PropertyDialog::setPropertyRequired(const QString& stringProperty, bool bRequired)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) != mapProperties.end())
    {
        if (bRequired)
            setRequiredProperties.insert(iteratorProperty->second);
        else
            setRequiredProperties.erase(iteratorProperty->second);
    }
}

void getSubProperties(QtProperty* pProperty, QList<QtProperty*>& listProperties)
{
    QList<QtProperty*> listSubProperties = pProperty->subProperties();
    QList<QtProperty*>::iterator iteratorList;
    for (iteratorList = listSubProperties.begin(); iteratorList != listSubProperties.end(); iteratorList++)
        getSubProperties(*iteratorList, listProperties);
    listProperties.append(listSubProperties);
}

void PropertyDialog::removeProperty(const QString& stringProperty)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) == mapProperties.end()) return;
    QtVariantProperty* pProperty = iteratorProperty->second;

    QList<QtProperty*> listProperties;
    getSubProperties(pProperty, listProperties);
    listProperties.append(pProperty);
    QList<QtProperty*>::iterator iteratorList;
    for (iteratorList = listProperties.begin(); iteratorList != listProperties.end(); iteratorList++)
    {
        mapProperties.erase((*iteratorList)->propertyName());
        setRequiredProperties.erase((QtVariantProperty*)*iteratorList);
    }

    QList<QtBrowserItem *> listItems = pPropertyBrowser->items(pProperty);
    QtBrowserItem* pBrowserItem = *(listItems.begin());
    if (pBrowserItem->parent())
        pBrowserItem->parent()->property()->removeSubProperty(pProperty);
    else
        pPropertyBrowser->removeProperty(pProperty);
}

void PropertyDialog::setPropertyReadOnly(const QString& stringProperty, bool bReadOnly)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) != mapProperties.end())
    {
        QtVariantProperty* pProperty = iteratorProperty->second;
        pProperty->setEditable(!bReadOnly);
    }
}

QVariant PropertyDialog::getPropertyAttribute(const QString& stringProperty, const QString& stringAttribute)
{
    std::map<QString, QtVariantProperty*>::iterator iteratorProperty;
    if ((iteratorProperty = mapProperties.find(stringProperty)) != mapProperties.end())
    {
        QtVariantProperty* pProperty = iteratorProperty->second;
        return pProperty->attributeValue(stringAttribute);
    }
    else
        return QVariant();
}
