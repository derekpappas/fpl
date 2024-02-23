#ifndef RANGEEDITORFACTORY_H
#define RANGEEDITORFACTORY_H

#include "qtpropertybrowser.h"

class RangePropertyManagerPrivate;

class RangePropertyManager : public QtAbstractPropertyManager
{
    Q_OBJECT
public:
    RangePropertyManager(QObject *parent = 0);
    ~RangePropertyManager();

    int minValue(const QtProperty *property) const;
    int maxValue(const QtProperty *property) const;
    QString value(const QtProperty *property) const;

public Q_SLOTS:
    void setMinValue(QtProperty *property, int val);
    void setMaxValue(QtProperty *property, int val);
    void setValue(QtProperty *property, const QString& stringValue);

Q_SIGNALS:
    void valueChanged(QtProperty* property, const QString& text);

protected:
    QString valueText(const QtProperty *property) const;
    virtual void initializeProperty(QtProperty *property);
    virtual void uninitializeProperty(QtProperty *property);

private:
    RangePropertyManagerPrivate *d_ptr;
    Q_DECLARE_PRIVATE(RangePropertyManager)
    Q_DISABLE_COPY(RangePropertyManager)
};

class RangeEditorFactoryPrivate;

class RangeEditorFactory : public QtAbstractEditorFactory<RangePropertyManager>
{
    Q_OBJECT
public:
    RangeEditorFactory(QObject *parent = 0);
    ~RangeEditorFactory();
protected:
    void connectPropertyManager(RangePropertyManager *manager);
    QWidget *createEditor(RangePropertyManager *manager, QtProperty *property,
                QWidget *parent);
    void disconnectPropertyManager(RangePropertyManager *manager);
    bool eventFilter(QObject* pObject, QEvent* pEvent);
private:
    RangeEditorFactoryPrivate *d_ptr;
    Q_DECLARE_PRIVATE(RangeEditorFactory)
    Q_DISABLE_COPY(RangeEditorFactory)
    Q_PRIVATE_SLOT(d_func(), void slotPropertyChanged(QtProperty *, const QString&))
    Q_PRIVATE_SLOT(d_func(), void slotSetMinValue(QObject *, const QString&))
    Q_PRIVATE_SLOT(d_func(), void slotSetMaxValue(QObject *, const QString&))
    Q_PRIVATE_SLOT(d_func(), void slotSetValue(const QString&))
    Q_PRIVATE_SLOT(d_func(), void slotEditorDestroyed(QObject *))
};



#endif // RangeEDITORFACTORY_H
