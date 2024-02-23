/****************************************************************************
** Meta object code from reading C++ file 'replace.h'
**
** Created: Thu Jan 14 23:17:27 2010
**      by: The Qt Meta Object Compiler version 61 (Qt 4.5.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "replace.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'replace.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 61
#error "This file was generated using the moc from 4.5.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_ReplaceImpl[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
       1,   12, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // slots: signature, parameters, type, tag, flags
      13,   12,   12,   12, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_ReplaceImpl[] = {
    "ReplaceImpl\0\0on_replace_clicked()\0"
};

const QMetaObject ReplaceImpl::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_ReplaceImpl,
      qt_meta_data_ReplaceImpl, 0 }
};

const QMetaObject *ReplaceImpl::metaObject() const
{
    return &staticMetaObject;
}

void *ReplaceImpl::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_ReplaceImpl))
        return static_cast<void*>(const_cast< ReplaceImpl*>(this));
    if (!strcmp(_clname, "Ui::Replace"))
        return static_cast< Ui::Replace*>(const_cast< ReplaceImpl*>(this));
    return QDialog::qt_metacast(_clname);
}

int ReplaceImpl::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: on_replace_clicked(); break;
        default: ;
        }
        _id -= 1;
    }
    return _id;
}
static const uint qt_meta_data_PromptReplaceImpl[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   12, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // slots: signature, parameters, type, tag, flags
      19,   18,   18,   18, 0x08,
      40,   18,   18,   18, 0x08,
      64,   18,   18,   18, 0x08,
      86,   18,   18,   18, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_PromptReplaceImpl[] = {
    "PromptReplaceImpl\0\0on_replace_clicked()\0"
    "on_replaceAll_clicked()\0on_findNext_clicked()\0"
    "on_close_clicked()\0"
};

const QMetaObject PromptReplaceImpl::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_PromptReplaceImpl,
      qt_meta_data_PromptReplaceImpl, 0 }
};

const QMetaObject *PromptReplaceImpl::metaObject() const
{
    return &staticMetaObject;
}

void *PromptReplaceImpl::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_PromptReplaceImpl))
        return static_cast<void*>(const_cast< PromptReplaceImpl*>(this));
    if (!strcmp(_clname, "Ui::PromptReplace"))
        return static_cast< Ui::PromptReplace*>(const_cast< PromptReplaceImpl*>(this));
    return QDialog::qt_metacast(_clname);
}

int PromptReplaceImpl::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: on_replace_clicked(); break;
        case 1: on_replaceAll_clicked(); break;
        case 2: on_findNext_clicked(); break;
        case 3: on_close_clicked(); break;
        default: ;
        }
        _id -= 4;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
