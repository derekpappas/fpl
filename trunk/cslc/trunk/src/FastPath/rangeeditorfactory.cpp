#include "rangeeditorfactory.h"
#include "qtpropertybrowserutils_p.h"
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
#include <QtGui/QLineEdit>
#include <QtGui/QFrame>
#include <QtGui/QBoxLayout>

#include <limits.h>
#include <float.h>

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

class RangePropertyManagerPrivate
{
    RangePropertyManager *q_ptr;
    Q_DECLARE_PUBLIC(RangePropertyManager)
public:

    struct Data
    {
        Data() : minVal(0), maxVal(0) {}
        Data(const Data& d) : minVal(d.minVal), maxVal(d.maxVal){}
        Data& operator=(const Data& d)
        {
            minVal = d.minVal;
            maxVal = d.maxVal;
            return *this;
        }
        int minVal;
        int maxVal;
    };

    typedef QMap<const QtProperty *, Data> PropertyValueMap;
    PropertyValueMap m_values;
};

RangePropertyManager::RangePropertyManager(QObject *parent)
    : QtAbstractPropertyManager(parent)
{
    d_ptr = new RangePropertyManagerPrivate;
    d_ptr->q_ptr = this;
}

/*!
    Destroys this manager, and all the properties it has created.
*/
RangePropertyManager::~RangePropertyManager()
{
    clear();
    delete d_ptr;
}

QString RangePropertyManager::value(const QtProperty *property) const
{
    const RangePropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return QString("[0:0]");
    RangePropertyManagerPrivate::Data& data = it.value();
    return QString("[%1:%2]").arg(data.minVal).arg(data.maxVal);
}

int RangePropertyManager::minValue(const QtProperty *property) const
{
    QString stringValue = value(property);
    QByteArray bytes = stringValue.toAscii();
    return bytes.mid(1, bytes.indexOf(':') - 1).toInt();
}

int RangePropertyManager::maxValue(const QtProperty* property) const
{
    QString stringValue = value(property);
    QByteArray bytes = stringValue.toAscii();
    return bytes.mid(bytes.indexOf(':') + 1, bytes.length() - 2 - bytes.indexOf(':')).toInt();
}

/*!
    \reimp
*/
QString RangePropertyManager::valueText(const QtProperty *property) const
{
    return value(property);
}

void RangePropertyManager::setValue(QtProperty *property, const QString& stringValue)
{
    const RangePropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    RangePropertyManagerPrivate::Data& data = it.value();

    QString stringInternalValue = QString("[%1:%2]").arg(data.minVal).arg(data.maxVal);
    if (stringInternalValue == stringValue) return;
    QByteArray bytes = stringValue.toAscii();
    data.minVal = bytes.mid(1, bytes.indexOf(':') - 1).toInt();
    data.maxVal = bytes.mid(bytes.indexOf(':') + 1, bytes.length() - 2 - bytes.indexOf(':')).toInt();
    if (data.maxVal < data.minVal)
        data.maxVal = data.minVal;

    emit propertyChanged(property);
    emit valueChanged(property, QString("[%1:%2]").arg(data.minVal).arg(data.maxVal));
}

void RangePropertyManager::setMaxValue(QtProperty* property, int val)
{
    const RangePropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    RangePropertyManagerPrivate::Data& data = it.value();

    if (data.maxVal == val) return;
    data.maxVal = val;
    if (data.minVal > data.maxVal)
        data.minVal = data.maxVal;

    emit propertyChanged(property);
    emit valueChanged(property, QString("[%1:%2]").arg(data.minVal).arg(data.maxVal));
}

void RangePropertyManager::setMinValue(QtProperty* property, int val)
{
    const RangePropertyManagerPrivate::PropertyValueMap::iterator it = d_ptr->m_values.find(property);
    if (it == d_ptr->m_values.end())
        return;

    RangePropertyManagerPrivate::Data& data = it.value();

    if (data.minVal == val) return;
    data.minVal = val;
    if (data.maxVal < data.minVal)
        data.maxVal = data.minVal;

    emit propertyChanged(property);
    emit valueChanged(property, QString("[%1:%2]").arg(data.minVal).arg(data.maxVal));
}
/*!
    \reimp
*/
void RangePropertyManager::initializeProperty(QtProperty *property)
{
    d_ptr->m_values[property] = RangePropertyManagerPrivate::Data();
}

/*!
    \reimp
*/
void RangePropertyManager::uninitializeProperty(QtProperty *property)
{
    d_ptr->m_values.remove(property);
}

class RangeEditorFactoryPrivate : public EditorFactoryPrivate<QFrame>
{
    RangeEditorFactory *q_ptr;
    Q_DECLARE_PUBLIC(RangeEditorFactory)
public:

    void slotPropertyChanged(QtProperty *property, const QString&);
    void slotSetValue(const QString&);
    void slotSetMinValue(QObject *object, const QString& value);
    void slotSetMaxValue(QObject* object, const QString& value);
};

void RangeEditorFactoryPrivate::slotPropertyChanged(QtProperty *property, const QString& stringValue)
{
    if (!m_createdEditors.contains(property))
        return;

    QByteArray bytes = stringValue.toAscii();
    QListIterator<QFrame *> itEditor(m_createdEditors[property]);
    while (itEditor.hasNext()) {
        QFrame *frame = itEditor.next();
        QLineEdit* lineEdit = (QLineEdit*)((QBoxLayout*)(frame->layout()))->itemAt(0)->widget();
        int minVal = bytes.mid(1, bytes.indexOf(':') - 1).toInt();
        int maxVal = bytes.mid(bytes.indexOf(':') + 1, bytes.length() - 2 - bytes.indexOf(':')).toInt();
        if (lineEdit->text() != QString("%1").arg(maxVal))
        {
            lineEdit->blockSignals(true);
            lineEdit->setText(QString("%1").arg(maxVal));
            lineEdit->blockSignals(false);
        }
        lineEdit = (QLineEdit*)((QBoxLayout*)(frame->layout()))->itemAt(1)->widget();
        if (lineEdit->text() != QString("%1").arg(minVal))
        {
            lineEdit->blockSignals(true);
            lineEdit->setText(QString("%1").arg(minVal));
            lineEdit->blockSignals(false);
        }
    }
}

void RangeEditorFactoryPrivate::slotSetValue(const QString& value)
{
    QObject* object = q_ptr->sender();
    const  QMap<QFrame *, QtProperty *>::ConstIterator ecend = m_editorToProperty.constEnd();
    for (QMap<QFrame *, QtProperty *>::ConstIterator itEditor = m_editorToProperty.constBegin(); itEditor != ecend; ++itEditor)
        if (itEditor.key() == object) {
            QtProperty *property = itEditor.value();
            RangePropertyManager *manager = q_ptr->propertyManager(property);
            if (!manager)
                return;
            manager->setValue(property, value);
            return;
        }
}

void RangeEditorFactoryPrivate::slotSetMinValue(QObject* object, const QString& value)
{
    const  QMap<QFrame *, QtProperty *>::ConstIterator ecend = m_editorToProperty.constEnd();
    for (QMap<QFrame *, QtProperty *>::ConstIterator itEditor = m_editorToProperty.constBegin(); itEditor != ecend; ++itEditor)
        if (((QBoxLayout*)(itEditor.key()->layout()))->itemAt(1)->widget() == object) {
            QtProperty *property = itEditor.value();
            RangePropertyManager *manager = q_ptr->propertyManager(property);
            if (!manager)
                return;
            manager->setMinValue(property, value.toInt());
            return;
        }
}

void RangeEditorFactoryPrivate::slotSetMaxValue(QObject* object, const QString& value)
{
    const  QMap<QFrame *, QtProperty *>::ConstIterator ecend = m_editorToProperty.constEnd();
    for (QMap<QFrame *, QtProperty *>::ConstIterator itEditor = m_editorToProperty.constBegin(); itEditor != ecend; ++itEditor)
        if (((QBoxLayout*)(itEditor.key()->layout()))->itemAt(0)->widget() == object) {
            QtProperty *property = itEditor.value();
            RangePropertyManager *manager = q_ptr->propertyManager(property);
            if (!manager)
                return;
            manager->setMaxValue(property, value.toInt());
            return;
        }
}

RangeEditorFactory::RangeEditorFactory(QObject *parent)
    : QtAbstractEditorFactory<RangePropertyManager>(parent)
{
    d_ptr = new RangeEditorFactoryPrivate();
    d_ptr->q_ptr = this;

}

/*!
    Destroys this factory, and all the widgets it has created.
*/
RangeEditorFactory::~RangeEditorFactory()
{
    qDeleteAll(d_ptr->m_editorToProperty.keys());
    delete d_ptr;
}

/*!
    \internal

    Reimplemented from the QtAbstractEditorFactory class.
*/
void RangeEditorFactory::connectPropertyManager(RangePropertyManager *manager)
{
    connect(manager, SIGNAL(valueChanged(QtProperty *, const QString&)),
                this, SLOT(slotPropertyChanged(QtProperty *, const QString&)));
}

/*!
    \internal

    Reimplemented from the QtAbstractEditorFactory class.
*/
QWidget *RangeEditorFactory::createEditor(RangePropertyManager *manager, QtProperty *property,
        QWidget *parent)
{
    QFrame *editor = d_ptr->createEditor(property, parent);
    int minVal = manager->minValue(property);
    int maxVal = manager->maxValue(property);
    QBoxLayout* pLayout = new QBoxLayout(QBoxLayout::LeftToRight, editor);
    editor->setLayout(pLayout);
    QLineEdit* lineEdit = new QLineEdit(editor);
    pLayout->addWidget(lineEdit);
    lineEdit->setWindowTitle("maxVal");
    QIntValidator* pValidator = new QIntValidator(lineEdit);
    pValidator->setRange(0, INT_MAX);
    lineEdit->setValidator(pValidator);
    lineEdit->setText(QString("%1").arg(maxVal));
    lineEdit->installEventFilter(this);
    lineEdit = new QLineEdit(editor);
    pLayout->addWidget(lineEdit);
    lineEdit->setWindowTitle("minVal");
    pValidator = new QIntValidator(lineEdit);
    pValidator->setRange(0, INT_MAX);
    lineEdit->setValidator(pValidator);
    lineEdit->setText(QString("%1").arg(minVal));
    lineEdit->installEventFilter(this);

    connect(editor, SIGNAL(destroyed(QObject *)), this, SLOT(slotEditorDestroyed(QObject *)));

    return editor;
}

void RangeEditorFactory::disconnectPropertyManager(RangePropertyManager *manager)
{
    disconnect(manager, SIGNAL(valueChanged(QtProperty *, const QString&)),
                this, SLOT(slotPropertyChanged(QtProperty *, const QString&)));
}

bool RangeEditorFactory::eventFilter(QObject* pObject, QEvent* pEvent)
{
    if (pEvent->type() == QEvent::FocusOut)
    {
        QLineEdit* pLineEdit = ((QLineEdit*)pObject);
        if (pLineEdit->windowTitle() == "minVal")
            d_func()->slotSetMinValue(pObject, pLineEdit->text());
        else
            d_func()->slotSetMaxValue(pObject, pLineEdit->text());
    }
    else if (pEvent->type() == QEvent::KeyRelease)
    {
        QKeyEvent* pKeyEvent = (QKeyEvent*)pEvent;
        QLineEdit* pLineEdit = ((QLineEdit*)pObject);
        if (pKeyEvent->key() == Qt::Key_Return)
        {
            if (pLineEdit->windowTitle() == "minVal")
                d_func()->slotSetMinValue(pObject, pLineEdit->text());
            else
                d_func()->slotSetMaxValue(pObject, pLineEdit->text());
        }
    }
    return false;
}

#include "moc_rangeeditorfactory.cpp"
