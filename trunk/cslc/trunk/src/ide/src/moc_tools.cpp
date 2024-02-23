/****************************************************************************
** Meta object code from reading C++ file 'tools.h'
**
** Created: Sat Nov 7 09:35:00 2009
**      by: The Qt Meta Object Compiler version 61 (Qt 4.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "tools.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'tools.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 61
#error "This file was generated using the moc from 4.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_Tools[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   12, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // slots: signature, parameters, type, tag, flags
       7,    6,    6,    6, 0x08,
      29,    6,    6,    6, 0x08,
      55,    6,    6,    6, 0x08,
      81,    6,    6,    6, 0x08,
     107,    6,    6,    6, 0x08,
     132,    6,    6,    6, 0x08,
     164,  159,    6,    6, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_Tools[] = {
    "Tools\0\0on_okButton_clicked()\0"
    "on_cancelButton_clicked()\0"
    "on_cslcLocation_clicked()\0"
    "on_makeLocation_clicked()\0"
    "on_gdbLocation_clicked()\0"
    "on_ctagsLocation_clicked()\0dest\0"
    "chooseLocation(QLineEdit*)\0"
};

const QMetaObject Tools::staticMetaObject = {
    { &QDialog::staticMetaObject, qt_meta_stringdata_Tools,
      qt_meta_data_Tools, 0 }
};

const QMetaObject *Tools::metaObject() const
{
    return &staticMetaObject;
}

void *Tools::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_Tools))
        return static_cast<void*>(const_cast< Tools*>(this));
    if (!strcmp(_clname, "Ui::Tools"))
        return static_cast< Ui::Tools*>(const_cast< Tools*>(this));
    return QDialog::qt_metacast(_clname);
}

int Tools::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: on_okButton_clicked(); break;
        case 1: on_cancelButton_clicked(); break;
        case 2: on_cslcLocation_clicked(); break;
        case 3: on_makeLocation_clicked(); break;
        case 4: on_gdbLocation_clicked(); break;
        case 5: on_ctagsLocation_clicked(); break;
        case 6: chooseLocation((*reinterpret_cast< QLineEdit*(*)>(_a[1]))); break;
        default: ;
        }
        _id -= 7;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
