/****************************************************************************
** Meta object code from reading C++ file 'linenumbers.h'
**
** Created: Thu Jan 14 23:17:33 2010
**      by: The Qt Meta Object Compiler version 61 (Qt 4.5.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "linenumbers.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'linenumbers.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 61
#error "This file was generated using the moc from 4.5.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_LineNumbers[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   12, // methods
       3,   32, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // signals: signature, parameters, type, tag, flags
      13,   12,   12,   12, 0x05,
      35,   12,   12,   12, 0x05,
      60,   12,   12,   12, 0x05,

 // slots: signature, parameters, type, tag, flags
      91,   12,   12,   12, 0x0a,

 // properties: name, type, flags
     118,  114, 0x02095103,
     138,  131, 0x43095103,
     148,  131, 0x43095103,

       0        // eod
};

static const char qt_meta_stringdata_LineNumbers[] = {
    "LineNumbers\0\0digitNumbersChanged()\0"
    "textColorChanged(QColor)\0"
    "backgroundColorChanged(QColor)\0"
    "setDefaultProperties()\0int\0digitNumbers\0"
    "QColor\0textColor\0backgroundColor\0"
};

const QMetaObject LineNumbers::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_LineNumbers,
      qt_meta_data_LineNumbers, 0 }
};

const QMetaObject *LineNumbers::metaObject() const
{
    return &staticMetaObject;
}

void *LineNumbers::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_LineNumbers))
        return static_cast<void*>(const_cast< LineNumbers*>(this));
    return QWidget::qt_metacast(_clname);
}

int LineNumbers::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: digitNumbersChanged(); break;
        case 1: textColorChanged((*reinterpret_cast< const QColor(*)>(_a[1]))); break;
        case 2: backgroundColorChanged((*reinterpret_cast< const QColor(*)>(_a[1]))); break;
        case 3: setDefaultProperties(); break;
        default: ;
        }
        _id -= 4;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< int*>(_v) = digitNumbers(); break;
        case 1: *reinterpret_cast< QColor*>(_v) = textColor(); break;
        case 2: *reinterpret_cast< QColor*>(_v) = backgroundColor(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setDigitNumbers(*reinterpret_cast< int*>(_v)); break;
        case 1: setTextColor(*reinterpret_cast< QColor*>(_v)); break;
        case 2: setBackgroundColor(*reinterpret_cast< QColor*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void LineNumbers::digitNumbersChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}

// SIGNAL 1
void LineNumbers::textColorChanged(const QColor & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void LineNumbers::backgroundColorChanged(const QColor & _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_END_MOC_NAMESPACE
