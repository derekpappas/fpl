/****************************************************************************
** Meta object code from reading C++ file 'mainchild.h'
**
** Created: Thu Jan 14 23:17:17 2010
**      by: The Qt Meta Object Compiler version 61 (Qt 4.5.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "mainchild.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainchild.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 61
#error "This file was generated using the moc from 4.5.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainChild[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   12, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // signals: signature, parameters, type, tag, flags
      13,   11,   10,   10, 0x05,
      38,   10,   10,   10, 0x25,

 // slots: signature, parameters, type, tag, flags
      55,   10,   10,   10, 0x0a,
      72,   10,   10,   10, 0x0a,
      91,   10,   10,   10, 0x0a,
     118,  106,   10,   10, 0x0a,
     164,  138,   10,   10, 0x0a,
     242,  227,   10,   10, 0x2a,
     307,  300,   10,   10, 0x2a,
     343,  340,   10,   10, 0x2a,
     375,  368,   10,   10, 0x0a,
     392,   10,   10,   10, 0x2a,
     405,   10,   10,   10, 0x0a,
     420,   10,   10,   10, 0x08,
     453,  442,   10,   10, 0x08,
     479,   10,   10,   10, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainChild[] = {
    "MainChild\0\0,\0message(QString,QString)\0"
    "message(QString)\0readFromStdout()\0"
    "setCursorChanged()\0slotStopCslc()\0"
    "line,column\0gotoLine(long,long)\0"
    "ui,ttf,options,fromButton\0"
    "slotFind(Ui::FindWidget,QString,QTextDocument::FindFlags,bool)\0"
    "ui,ttf,options\0"
    "slotFind(Ui::FindWidget,QString,QTextDocument::FindFlags)\0"
    "ui,ttf\0slotFind(Ui::FindWidget,QString)\0"
    "ui\0slotFind(Ui::FindWidget)\0indent\0"
    "slotIndent(bool)\0slotIndent()\0"
    "slotUnindent()\0documentWasModified()\0"
    "completion\0insertCompletion(QString)\0"
    "slotAdjustSize()\0"
};

const QMetaObject MainChild::staticMetaObject = {
    { &QTextEdit::staticMetaObject, qt_meta_stringdata_MainChild,
      qt_meta_data_MainChild, 0 }
};

const QMetaObject *MainChild::metaObject() const
{
    return &staticMetaObject;
}

void *MainChild::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainChild))
        return static_cast<void*>(const_cast< MainChild*>(this));
    return QTextEdit::qt_metacast(_clname);
}

int MainChild::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QTextEdit::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: message((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 1: message((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: readFromStdout(); break;
        case 3: setCursorChanged(); break;
        case 4: slotStopCslc(); break;
        case 5: gotoLine((*reinterpret_cast< long(*)>(_a[1])),(*reinterpret_cast< long(*)>(_a[2]))); break;
        case 6: slotFind((*reinterpret_cast< Ui::FindWidget(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QTextDocument::FindFlags(*)>(_a[3])),(*reinterpret_cast< bool(*)>(_a[4]))); break;
        case 7: slotFind((*reinterpret_cast< Ui::FindWidget(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QTextDocument::FindFlags(*)>(_a[3]))); break;
        case 8: slotFind((*reinterpret_cast< Ui::FindWidget(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 9: slotFind((*reinterpret_cast< Ui::FindWidget(*)>(_a[1]))); break;
        case 10: slotIndent((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 11: slotIndent(); break;
        case 12: slotUnindent(); break;
        case 13: documentWasModified(); break;
        case 14: insertCompletion((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 15: slotAdjustSize(); break;
        default: ;
        }
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void MainChild::message(QString _t1, QString _t2)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 0, 1, _a);
}
QT_END_MOC_NAMESPACE
