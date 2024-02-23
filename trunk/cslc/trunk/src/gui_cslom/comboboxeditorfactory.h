#ifndef COMBOBOXEDITORFACTORY_H
#define COMBOBOXEDITORFACTORY_H

// use the modified version of the QT code
// this needs to be fixed
// use regular code
// or put back the changes to QT
#include "qtpropertybrowser/qtpropertybrowser.h"

/*! class ComboBoxPropertyManagerPrivate */
class ComboBoxPropertyManagerPrivate;

/*! class ComboBoxPropertyManager */
class ComboBoxPropertyManager : public QtAbstractPropertyManager
{
    Q_OBJECT
public:
    ComboBoxPropertyManager(QObject *parent = 0);
    ~ComboBoxPropertyManager();

    QString value(const QtProperty *property) const;
    QStringList comboboxNames(const QtProperty *property) const;
    QStringList comboboxSelectables(const QtProperty* property) const;
    QMap<int, QIcon> comboboxIcons(const QtProperty *property) const;
    bool isTreeWidgetView(const QtProperty* property) const;
    bool isEditable(const QtProperty* property) const;

public Q_SLOTS:
    void setValue(QtProperty *property, int val);
    void setValue(QtProperty* property, const QString& text);
    void setComboboxNames(QtProperty *property, const QStringList &names);
    void setComboboxSelectables(QtProperty* property, const QStringList& selectables);
    void setComboboxIcons(QtProperty *property, const QMap<int, QIcon> &icons);
    void setTreeWidgetView(QtProperty *property, bool b);
    void setEditable(QtProperty *property, bool b);
Q_SIGNALS:
    void valueChanged(QtProperty *property, int val);
    void valueChanged(QtProperty* property, const QString& text);
    void comboboxNamesChanged(QtProperty *property, const QStringList &names);
    void comboboxSelectablesChanged(QtProperty* property, const QStringList& selectables);
    void comboboxIconsChanged(QtProperty *property, const QMap<int, QIcon> &icons);
    void editableChanged(QtProperty* property, bool b);
    void treeWidgetViewChanged(QtProperty* property, bool b);
protected:
    QString valueText(const QtProperty *property) const;
    QIcon valueIcon(const QtProperty *property) const;
    virtual void initializeProperty(QtProperty *property);
    virtual void uninitializeProperty(QtProperty *property);
private:
    ComboBoxPropertyManagerPrivate *d_ptr;
    Q_DECLARE_PRIVATE(ComboBoxPropertyManager)
    Q_DISABLE_COPY(ComboBoxPropertyManager)
};

/*! class ComboBoxEditorFactoryPrivate */
class ComboBoxEditorFactoryPrivate;

/*! class ComboBoxEditorFactory */
class ComboBoxEditorFactory : public QtAbstractEditorFactory<ComboBoxPropertyManager>
{
    Q_OBJECT
public:
    ComboBoxEditorFactory(QObject *parent = 0);
    ~ComboBoxEditorFactory();
protected:
    void connectPropertyManager(ComboBoxPropertyManager *manager);
    QWidget *createEditor(ComboBoxPropertyManager *manager, QtProperty *property,
                QWidget *parent);
    void disconnectPropertyManager(ComboBoxPropertyManager *manager);
    bool eventFilter(QObject* pObject, QEvent* pEvent);
private:
    ComboBoxEditorFactoryPrivate *d_ptr;
    Q_DECLARE_PRIVATE(ComboBoxEditorFactory)
    Q_DISABLE_COPY(ComboBoxEditorFactory)
    Q_PRIVATE_SLOT(d_func(), void slotPropertyChanged(QtProperty *, int))
    Q_PRIVATE_SLOT(d_func(), void slotPropertyChanged(QtProperty *, const QString&))
    Q_PRIVATE_SLOT(d_func(), void slotComboboxNamesChanged(QtProperty *,
                        const QStringList &))
    Q_PRIVATE_SLOT(d_func(), void slotComboboxSelectablesChanged(QtProperty*, const QStringList&))
    Q_PRIVATE_SLOT(d_func(), void slotEditableChanged(QtProperty*, bool))
    Q_PRIVATE_SLOT(d_func(), void slotTreeWidgetViewChanged(QtProperty*, bool))
    Q_PRIVATE_SLOT(d_func(), void slotComboboxIconsChanged(QtProperty *,
                        const QMap<int, QIcon> &))
    Q_PRIVATE_SLOT(d_func(), void slotSetValue(int))
    Q_PRIVATE_SLOT(d_func(), void slotSetValue(const QString&))
    Q_PRIVATE_SLOT(d_func(), void slotSetText(QObject*, QString))
    Q_PRIVATE_SLOT(d_func(), void slotEditorDestroyed(QObject *))
};



#endif // COMBOBOXEDITORFACTORY_H
