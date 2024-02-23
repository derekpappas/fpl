#include "comboboxeditorfactory.h"
#include "qtpropertybrowserutils_p.h"
#include "treecombobox.h"
#include <QtGui/QComboBox>
#include <QtGui/QAbstractItemView>
#include <QtGui/QKeyEvent>
#include <QtGui/QApplication>
#include <QtGui/QSpacerItem>
#include <QtCore/QMap>
#include <QtGui/QIcon>
#include <QtCore/QMetaEnum>
#include <QtGui/QFontDatabase>
#include <QtGui/QStyleOption>
#include <QtGui/QStyle>
#include <QtGui/QPainter>
#include <QtGui/QLabel>
#include <QtGui/QLineEdit>
#include <QtGui/QTreeWidget>
#include <QtGui/QStandardItemModel>
#include <QtGui/QListView>

#include <limits.h>
#include <float.h>

template <class Value, class PrivateData>
static Value getData(const QMap<const QtProperty *, PrivateData> &propertyMap,
            Value PrivateData::*data,
            const QtProperty *property, const Value &defaultValue = Value())
{
    typedef QMap<const QtProperty *, PrivateData> PropertyToData;
    typedef Q_TYPENAME PropertyToData::const_iterator PropertyToDataConstIterator;
    const PropertyToDataConstIterator it = propertyMap.constFind(property);
    if (it == propertyMap.constEnd())
        return defaultValue;
    return it.value().*data;
}

template <class Value, class PrivateData>
static Value getValue(const QMap<const QtProperty *, PrivateData> &propertyMap,
            const QtProperty *property, const Value &defaultValue = Value())
{
    return getData<Value>(propertyMap, &PrivateData::val, property, defaultValue);
}

/*! template <class Editor> class EditorFactoryPrivate */
template <class Editor>
class EditorFactoryPrivate
{
public:

    typedef QList<Editor *> EditorList;
    typedef QMap<QtProperty *, EditorList> PropertyToEditorListMap;
    typedef QMap<Editor *, QtProperty *> EditorToPropertyMap;

    Editor *createEditor(QtProperty *property, QWidget *parent);
    void initializeEditor(QtProperty *property, Editor *e);
    void slotEditorDestroyed(QObject *object);

    PropertyToEditorListMap  m_createdEditors;
    EditorToPropertyMap m_editorToProperty;
};

/*! template <class Editor> Editor *EditorFactoryPrivate<Editor>::createEditor */
template <class Editor>
Editor *EditorFactoryPrivate<Editor>::createEditor(QtProperty *property, QWidget *parent)
{
    Editor *editor = new Editor(parent);
    initializeEditor(property, editor);
    return editor;
}

template <class Editor>
void EditorFactoryPrivate<Editor>::initializeEditor(QtProperty *property, Editor *editor)
{
    Q_TYPENAME PropertyToEditorListMap::iterator it = m_createdEditors.find(property);
    if (it == m_createdEditors.end())
        it = m_createdEditors.insert(property, EditorList());
    it.value().append(editor);
    m_editorToProperty.insert(editor, property);
}

template <class Editor>
void EditorFactoryPrivate<Editor>::slotEditorDestroyed(QObject *object)
{
    const Q_TYPENAME EditorToPropertyMap::iterator ecend = m_editorToProperty.end();
    for (Q_TYPENAME EditorToPropertyMap::iterator itEditor = m_editorToProperty.begin(); itEditor !=  ecend; ++itEditor) {
        if (itEditor.key() == object) {
            Editor *editor = itEditor.key();
            QtProperty *property = itEditor.value();
            const Q_TYPENAME PropertyToEditorListMap::iterator pit = m_createdEditors.find(property);
            if (pit != m_createdEditors.end()) {
                pit.value().removeAll(editor);
                if (pit.value().empty())
                    m_createdEditors.erase(pit);
            }
            m_editorToProperty.erase(itEditor);
            return;
        }
    }
}

class ComboBoxPropertyManagerPrivate
{
    ComboBoxPropertyManager *q_ptr;
    Q_DECLARE_PUBLIC(ComboBoxPropertyManager)
public:

    struct Data
    {
        Data() : val(-1), bEditable(true), bTreeWidgetView(false) {}
        int val;
        QString selectedText;
        QStringList comboboxNames;
        QStringList comboboxSelectables;
        QMap<int, QIcon> comboboxIcons;
        bool bEditable;
        bool bTreeWidgetView;
    };

    typedef QMap<const QtProperty *, Data> PropertyValueMap;
    PropertyValueMap m_values;
};

ComboBoxPropertyManager::ComboBoxPropertyManager(QObject *parent)
    : QtAbstractPropertyManager(parent)
{
    d_ptr = new ComboBoxPropertyManagerPrivate;
    d_ptr->q_ptr = this;
}

/*!
    Destroys this manager, and all the properties it has created.
*/
ComboBoxPropertyManager::~ComboBoxPropertyManager()
{
    clear();
    delete d_ptr;
}

QString ComboBoxPropertyManager::value(const QtProperty *property) const
{
    if (isTreeWidgetView(property))
    {
        const ComboBoxPropertyManagerPrivate::PropertyValueMap::const_iterator it = d_ptr->m_values.constFind(property);
        if (it == d_ptr->m_values.constEnd())
            return QString();

        const ComboBoxPropertyManagerPrivate::Data &data = it.value();
        return data.selectedText;
    }
    else
    {
        int val = getValue<int>(d_ptr->m_values, property, -1);
        if (val == -1)
            return QString();
        QStringList stringList = comboboxNames(property);
        return stringList[val];
    }
}

QStringList ComboBoxPropertyManager::comboboxNames(const QtProperty *property) const
{
    return getData<QStringList>(d_ptr->m_values, &ComboBoxPropertyManagerPrivate::Data::comboboxNames, property, QStringList());
}

QStringList ComboBoxPropertyManager::comboboxSelectables(const QtProperty* property) const
{
    return getData<QStringList>(d_ptr->m_values, &ComboBoxPropertyManagerPrivate::Data::comboboxSelectables, property, QStringList());
}

QMap<int, QIcon> ComboBoxPropertyManager::comboboxIcons(const QtProperty *property) const
{
    return getData<QMap<int, QIcon> >(d_ptr->m_values, &ComboBoxPropertyManagerPrivate::Data::comboboxIcons, property, QMap<int, QIcon>());
}

bool ComboBoxPropertyManager::isTreeWidgetView(const QtProperty* property) const
{
    return getData<bool>(d_ptr->m_values, &ComboBoxPropertyManagerPrivate::Data::bTreeWidgetView, property, false);
}

bool ComboBoxPropertyManager::isEditable(const QtProperty* property) const
{
    return getData<bool>(d_ptr->m_values, &ComboBoxPropertyManagerPrivate::Data::bEditable, property, false);
}

/*!
    \reimp
*/
QString ComboBoxPropertyManager::valueText(const QtProperty *property) const
{
    const ComboBoxPropertyManagerPrivate::PropertyValueMap::const_iterator it = d_ptr->m_values.constFind(property);
    if (it == d_ptr->m_values.constEnd())
        return QString();

    const ComboBoxPropertyManagerPrivate::Data &data = it.value();

    if (isTreeWidgetView(property))
        return data.selectedText;

    if (data.val == -1)
        return QString();

    return data.comboboxNames[data.val];
}

/*!
    \reimp
*/
QIcon ComboBoxPropertyManager::valueIcon(const QtProperty *property) const
{
    const ComboBoxPropertyManagerPrivate::PropertyValueMap::const_iterator it = d_ptr->m_values.constFind(property);
    if (it == d_ptr->m_values.constEnd())
        return QIcon();

    const ComboBoxPropertyManagerPrivate::Data &data = it.value();

    const int v = data.val;
    if (v >= 0 && v < data.comboboxIcons.size())
        return data.comboboxIcons.value(v);
    else
        return QIcon();
}

void ComboBoxPropertyManager::setValue(QtProperty *property, int val)
{
    const ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    ComboBoxPropertyManagerPrivate::Data& data = it.value();

    if (val >= data.comboboxNames.count())
        return;

    if (val < 0 && data.comboboxNames.count() > 0)
        return;

    if (val < 0)
        val = -1;

    if (data.val == val)
        return;

    data.val = val;
    if (data.val >= 0)
        data.selectedText = data.comboboxNames[val];
    else
        data.selectedText.clear();

    emit propertyChanged(property);
    emit valueChanged(property, data.val);
}

void ComboBoxPropertyManager::setValue(QtProperty *property, const QString& text)
{
    ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    ComboBoxPropertyManagerPrivate::Data& data = it.value();

    int val = -1;
    QStringList::iterator itString;
    for (itString = data.comboboxNames.begin(), val = 0; itString != data.comboboxNames.end(); itString++, val++)
        if (*itString == text) break;
    bool bComboboxNamesChanged = false;
    if (itString == data.comboboxNames.end())
    {
        data.comboboxNames.push_back(text);
        bComboboxNamesChanged = true;
    }

    data.selectedText = text;
    if (data.val == val) return;
    data.val = val;

    it.value() = data;

    if (bComboboxNamesChanged)
    {
        emit comboboxNamesChanged(property, data.comboboxNames);
    }
    emit propertyChanged(property);
    emit valueChanged(property, data.selectedText);
}

void ComboBoxPropertyManager::setComboboxNames(QtProperty *property, const QStringList &comboboxNames)
{
    ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    ComboBoxPropertyManagerPrivate::Data& data = it.value();

    if (data.comboboxNames == comboboxNames)
        return;

    data.comboboxNames = comboboxNames;
    if (data.comboboxSelectables.size() != data.comboboxNames.size())
    {
        QStringList listOld = data.comboboxSelectables;
        data.comboboxSelectables.clear();
        int i;
        for (i = 0; i < data.comboboxNames.size(); i++)
        {
            if (i < listOld.size())
                data.comboboxSelectables << listOld[i];
            else
                data.comboboxSelectables << "1";
        }
    }

    data.val = -1;
    data.selectedText.clear();

    if (comboboxNames.count() > 0)
    {
        data.val = 0;
        data.selectedText = comboboxNames[0];
    }

    emit comboboxNamesChanged(property, data.comboboxNames);

    emit propertyChanged(property);
    emit valueChanged(property, data.selectedText);
}

void ComboBoxPropertyManager::setComboboxSelectables(QtProperty* property, const QStringList& comboboxSelectables)
{
    ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    ComboBoxPropertyManagerPrivate::Data& data = it.value();

    if (data.comboboxSelectables == comboboxSelectables)
        return;

    data.comboboxSelectables = comboboxSelectables;
    if (data.comboboxSelectables.size() != data.comboboxNames.size())
    {
        QStringList listOld = data.comboboxSelectables;
        data.comboboxSelectables.clear();
        int i;
        for (i = 0; i < data.comboboxNames.size(); i++)
        {
            if (i < listOld.size())
                data.comboboxSelectables << listOld[i];
            else
                data.comboboxSelectables << "1";
        }
    }

    emit comboboxSelectablesChanged(property, data.comboboxSelectables);
    emit propertyChanged(property);
}

void ComboBoxPropertyManager::setComboboxIcons(QtProperty *property, const QMap<int, QIcon> &comboboxIcons)
{
    const ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    it.value().comboboxIcons = comboboxIcons;

    emit comboboxIconsChanged(property, it.value().comboboxIcons);

    emit propertyChanged(property);
}

void ComboBoxPropertyManager::setEditable(QtProperty* property, bool b)
{
    const ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;
    it.value().bEditable = b;

    emit editableChanged(property, b);

    emit propertyChanged(property);
}

void ComboBoxPropertyManager::setTreeWidgetView(QtProperty* property, bool b)
{
    const ComboBoxPropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;
    it.value().bTreeWidgetView = b;

    emit treeWidgetViewChanged(property, b);

    emit propertyChanged(property);
}

/*!
    \reimp
*/
void ComboBoxPropertyManager::initializeProperty(QtProperty *property)
{
    d_ptr->m_values[property] = ComboBoxPropertyManagerPrivate::Data();
}

/*!
    \reimp
*/
void ComboBoxPropertyManager::uninitializeProperty(QtProperty *property)
{
    d_ptr->m_values.remove(property);
}

class ComboBoxEditorFactoryPrivate : public EditorFactoryPrivate<TreeComboBox>
{
    ComboBoxEditorFactory *q_ptr;
    Q_DECLARE_PUBLIC(ComboBoxEditorFactory)
public:

    void slotPropertyChanged(QtProperty *property, int value);
    void slotPropertyChanged(QtProperty *property, const QString&);
    void slotComboboxNamesChanged(QtProperty *property, const QStringList &);
    void slotComboboxSelectablesChanged(QtProperty* property, const QStringList&);
    void slotComboboxIconsChanged(QtProperty *property, const QMap<int, QIcon> &);
    void slotSetValue(int value);
    void slotSetValue(const QString&);
    void slotSetText(QObject* pSender, QString text);
    void slotEditableChanged(QtProperty* property, bool b);
    void slotTreeWidgetViewChanged(QtProperty* property, bool b);
};

void ComboBoxEditorFactoryPrivate::slotPropertyChanged(QtProperty *property, int value)
{
    if (!m_createdEditors.contains(property))
        return;

    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QComboBox *editor = itEditor.next();
        editor->blockSignals(true);
        editor->setCurrentIndex(value);
        editor->blockSignals(false);
    }
}

void ComboBoxEditorFactoryPrivate::slotPropertyChanged(QtProperty *property, const QString& value)
{
    if (!m_createdEditors.contains(property))
        return;

    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        TreeComboBox *editor = itEditor.next();
        editor->blockSignals(true);
        editor->setEditText(value);
        TreeComboBoxModel* pModel = qobject_cast<TreeComboBoxModel*>(editor->model());
        if (pModel)
        {
            editor->selectedIndex = pModel->findIndex(value);
            editor->update();
        }
        else
        {
            int iCount = editor->maxCount();
            int i;
            for (i = 0; i < iCount; i++)
                if (editor->itemText(i) == value) break;
            if (i < iCount)
                editor->setCurrentIndex(i);
        }
        editor->blockSignals(false);
    }
}

void ComboBoxEditorFactoryPrivate::slotComboboxNamesChanged(QtProperty *property,
                const QStringList &comboboxNames)
{
    if (!m_createdEditors.contains(property))
        return;

    ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
    if (!manager)
        return;

    QMap<int, QIcon> comboboxIcons = manager->comboboxIcons(property);

    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QComboBox *editor = itEditor.next();
        if (manager->isTreeWidgetView(property))
        {
            editor->blockSignals(true);
            editor->clear();
            TreeComboBoxModel* pModel = static_cast<TreeComboBoxModel*>(editor->model());
            pModel->setStringList(comboboxNames);
            QTreeView* pView = qobject_cast<QTreeView*>(editor->view());
            pView->expandAll();
            editor->blockSignals(false);
        }
        else
        {
            editor->blockSignals(true);
            editor->clear();
            editor->addItems(comboboxNames);
            const int nameCount = comboboxNames.count();
            for (int i = 0; i < nameCount; i++)
                editor->setItemIcon(i, comboboxIcons.value(i));
            editor->setEditText(manager->value(property));
            editor->blockSignals(false);
        }
    }
}

void ComboBoxEditorFactoryPrivate::slotComboboxSelectablesChanged(QtProperty *property,
                const QStringList &comboboxSelectables)
{
    if (!m_createdEditors.contains(property))
        return;

    ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
    if (!manager)
        return;

    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QComboBox *editor = itEditor.next();
        if (manager->isTreeWidgetView(property))
        {
            editor->blockSignals(true);
            TreeComboBoxModel* pModel = static_cast<TreeComboBoxModel*>(editor->model());
            pModel->setSelectableList(comboboxSelectables);
            editor->blockSignals(false);
        }
    }
}

void ComboBoxEditorFactoryPrivate::slotEditableChanged(QtProperty* property, bool b)
{
    if (!m_createdEditors.contains(property))
        return;

    ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
    if (!manager)
        return;

    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QComboBox *editor = itEditor.next();
        editor->blockSignals(true);
        editor->setEditable(b);
        editor->blockSignals(false);
    }
}

void ComboBoxEditorFactoryPrivate::slotTreeWidgetViewChanged(QtProperty* property, bool b)
{
    if (!m_createdEditors.contains(property))
        return;

    ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
    if (!manager)
        return;

    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QComboBox *editor = itEditor.next();
        QStringList stringList = manager->comboboxNames(property);
        int index = editor->currentIndex();
        if (b)
        {
            QTreeView* pView = new QTreeView(editor);
            TreeComboBoxModel* pModel = new TreeComboBoxModel(editor);
            pModel->setStringList(stringList);
            editor->blockSignals(true);
            pView->setHeaderHidden(true);
            editor->setModel(pModel);
            editor->setView(pView);
            if (index != -1)
                editor->setCurrentIndex(index);
            pView->expandAll();
            editor->blockSignals(false);
        }
        else
        {
            QListView* pView = new QListView(editor);
            QStandardItemModel* pModel = new QStandardItemModel(editor);
            editor->setModel(pModel);
            editor->setView(pView);
            editor->blockSignals(true);
            editor->clear();
            editor->insertItems(0, stringList);
            if (index != -1)
                editor->setCurrentIndex(index);
            editor->blockSignals(false);
        }
    }
}

void ComboBoxEditorFactoryPrivate::slotComboboxIconsChanged(QtProperty *property,
                const QMap<int, QIcon> &comboboxIcons)
{
    if (!m_createdEditors.contains(property))
        return;

    ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
    if (!manager)
        return;

    const QStringList comboboxNames = manager->comboboxNames(property);
    QListIterator<TreeComboBox *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QComboBox *editor = itEditor.next();
        editor->blockSignals(true);
        const int nameCount = comboboxNames.count();
        for (int i = 0; i < nameCount; i++)
            editor->setItemIcon(i, comboboxIcons.value(i));
        editor->setEditText(manager->value(property));
        editor->blockSignals(false);
    }
}

void ComboBoxEditorFactoryPrivate::slotSetValue(int value)
{
    QObject *object = q_ptr->sender();
    const  QMap<TreeComboBox *, QtProperty *>::ConstIterator ecend = m_editorToProperty.constEnd();
    for (QMap<TreeComboBox *, QtProperty *>::ConstIterator itEditor = m_editorToProperty.constBegin(); itEditor != ecend; ++itEditor)
        if (itEditor.key() == object) {
            QtProperty *property = itEditor.value();
            ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
            if (!manager)
                return;
            if (manager->isTreeWidgetView(property))
            {
                TreeComboBox* pComboBox = (TreeComboBox*)object;
                TreeComboBoxModel* pModel = qobject_cast<TreeComboBoxModel*>(pComboBox->model());
                if (pModel)
                {
                    QString stringValue = pModel->data(pComboBox->selectedIndex, Qt::EditRole).toString();
                    manager->setValue(property, stringValue);
                }
                else
                    manager->setValue(property, value);
            }
            else
                manager->setValue(property, value);
            return;
        }
}

void ComboBoxEditorFactoryPrivate::slotSetValue(const QString& value)
{
    QObject *object = q_ptr->sender();
    const  QMap<TreeComboBox *, QtProperty *>::ConstIterator ecend = m_editorToProperty.constEnd();
    for (QMap<TreeComboBox *, QtProperty *>::ConstIterator itEditor = m_editorToProperty.constBegin(); itEditor != ecend; ++itEditor)
        if (itEditor.key() == object) {
            QtProperty *property = itEditor.value();
            ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
            if (!manager)
                return;
            manager->setValue(property, value);
            return;
        }
}

void ComboBoxEditorFactoryPrivate::slotSetText(QObject* object, QString text)
{
    const  QMap<TreeComboBox *, QtProperty *>::ConstIterator ecend = m_editorToProperty.constEnd();
    for (QMap<TreeComboBox *, QtProperty *>::ConstIterator itEditor = m_editorToProperty.constBegin(); itEditor != ecend; ++itEditor)
        if (itEditor.key() == object) {
            QtProperty *property = itEditor.value();
            ComboBoxPropertyManager *manager = q_ptr->propertyManager(property);
            if (!manager)
                return;
            manager->setValue(property, text);
            return;
        }
}
ComboBoxEditorFactory::ComboBoxEditorFactory(QObject *parent)
    : QtAbstractEditorFactory<ComboBoxPropertyManager>(parent)
{
    d_ptr = new ComboBoxEditorFactoryPrivate();
    d_ptr->q_ptr = this;

}

/*!
    Destroys this factory, and all the widgets it has created.
*/
ComboBoxEditorFactory::~ComboBoxEditorFactory()
{
    qDeleteAll(d_ptr->m_editorToProperty.keys());
    delete d_ptr;
}

/*!
    \internal

    Reimplemented from the QtAbstractEditorFactory class.
*/
void ComboBoxEditorFactory::connectPropertyManager(ComboBoxPropertyManager *manager)
{
    connect(manager, SIGNAL(valueChanged(QtProperty *, int)),
                this, SLOT(slotPropertyChanged(QtProperty *, int)));
    connect(manager, SIGNAL(valueChanged(QtProperty *, const QString&)),
                this, SLOT(slotPropertyChanged(QtProperty *, const QString&)));
    connect(manager, SIGNAL(comboboxNamesChanged(QtProperty *, const QStringList &)),
                this, SLOT(slotComboboxNamesChanged(QtProperty *, const QStringList &)));
    connect(manager, SIGNAL(comboboxSelectablesChanged(QtProperty *, const QStringList &)),
                this, SLOT(slotComboboxSelectablesChanged(QtProperty *, const QStringList &)));
    connect(manager, SIGNAL(editableChanged(QtProperty*, bool)),
                this, SLOT(slotEditableChanged(QtProperty*, bool)));
    connect(manager, SIGNAL(treeWidgetViewChanged(QtProperty*, bool)),
                this, SLOT(slotTreeWidgetViewChanged(QtProperty*, bool)));
}

/*!
    \internal

    Reimplemented from the QtAbstractEditorFactory class.
*/
QWidget *ComboBoxEditorFactory::createEditor(ComboBoxPropertyManager *manager, QtProperty *property,
        QWidget *parent)
{
    QComboBox *editor;
    editor = d_ptr->createEditor(property, parent);
    bool bEditable = manager->isEditable(property);
    if (bEditable)
        editor->setEditable(true);
    editor->setSizePolicy(QSizePolicy::Ignored, QSizePolicy::Fixed);
    editor->view()->setTextElideMode(Qt::ElideRight);
    QStringList comboboxNames = manager->comboboxNames(property);
    editor->addItems(comboboxNames);
    QMap<int, QIcon> comboboxIcons = manager->comboboxIcons(property);
    const int comboboxNamesCount = comboboxNames.count();
    for (int i = 0; i < comboboxNamesCount; i++)
        editor->setItemIcon(i, comboboxIcons.value(i));
    editor->setEditText(manager->value(property));

    connect(editor, SIGNAL(currentIndexChanged(int)), this, SLOT(slotSetValue(int)));
    //connect(editor, SIGNAL(editTextChanged(QString)), this, SLOT(slotSetText(QString)));
    connect(editor, SIGNAL(currentSelectedIndexChanged(const QString&)), this, SLOT(slotSetValue(const QString&)));
    connect(editor, SIGNAL(destroyed(QObject *)),
                this, SLOT(slotEditorDestroyed(QObject *)));
    editor->installEventFilter(this);
    return editor;
}

void ComboBoxEditorFactory::disconnectPropertyManager(ComboBoxPropertyManager *manager)
{
    disconnect(manager, SIGNAL(valueChanged(QtProperty *, int)),
                this, SLOT(slotPropertyChanged(QtProperty *, int)));
    disconnect(manager, SIGNAL(comboboxNamesChanged(QtProperty *, const QStringList &)),
                this, SLOT(slotcomboboxNamesChanged(QtProperty *, const QStringList &)));
    disconnect(manager, SIGNAL(comboboxSelectablesChanged(QtProperty *, const QStringList &)),
                this, SLOT(slotcomboboxSelectablesChanged(QtProperty *, const QStringList &)));
}

bool ComboBoxEditorFactory::eventFilter(QObject* pObject, QEvent* pEvent)
{
    if (pEvent->type() == QEvent::FocusOut)
    {
        QLineEdit* pLineEdit = ((QComboBox*)pObject)->lineEdit();
        if (pLineEdit)
            d_func()->slotSetText(pObject, pLineEdit->text());
    }
    else if (pEvent->type() == QEvent::KeyRelease)
    {
        QKeyEvent* pKeyEvent = (QKeyEvent*)pEvent;
        QLineEdit* pLineEdit = ((QComboBox*)pObject)->lineEdit();
        if (pLineEdit && pKeyEvent->key() == Qt::Key_Return)
            d_func()->slotSetText(pObject, pLineEdit->text());
    }
    return false;
}

#include "moc_comboboxeditorfactory.cpp"
