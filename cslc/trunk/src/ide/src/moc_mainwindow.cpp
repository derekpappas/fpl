/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created: Thu Jan 14 23:17:12 2010
**      by: The Qt Meta Object Compiler version 61 (Qt 4.5.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "mainwindow.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 61
#error "This file was generated using the moc from 4.5.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_MainWindow[] = {

 // content:
       2,       // revision
       0,       // classname
       0,    0, // classinfo
      42,   12, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors

 // signals: signature, parameters, type, tag, flags
      12,   11,   11,   11, 0x05,

 // slots: signature, parameters, type, tag, flags
      28,   11,   23,   11, 0x08,
      38,   11,   11,   11, 0x08,
      48,   11,   11,   11, 0x08,
      64,   55,   11,   11, 0x08,
      78,   11,   11,   11, 0x08,
      85,   11,   11,   11, 0x08,
      94,   11,   11,   11, 0x08,
     102,   11,   11,   11, 0x08,
     113,   11,   11,   11, 0x08,
     128,   11,   11,   11, 0x08,
     145,   11,   11,   11, 0x08,
     152,   11,   11,   11, 0x08,
     159,   11,   11,   11, 0x08,
     165,   11,   11,   11, 0x08,
     172,   11,   11,   11, 0x08,
     180,   11,   11,   11, 0x08,
     187,   11,   11,   11, 0x08,
     196,   11,   11,   11, 0x08,
     206,   11,   11,   11, 0x08,
     213,   11,   11,   11, 0x08,
     228,   11,   11,   11, 0x08,
     243,   11,   11,   11, 0x08,
     258,   11,   11,   11, 0x08,
     277,   11,   11,   11, 0x08,
     304,  288,   11,   11, 0x08,
     350,  345,   11,   11, 0x28,
     386,   11,   11,   11, 0x28,
     420,  415,   11,   11, 0x08,
     461,   11,   11,   11, 0x08,
     476,   11,   11,   11, 0x08,
     484,   11,   11,   11, 0x08,
     493,   11,   11,   11, 0x08,
     505,   11,   11,   11, 0x08,
     516,   11,   11,   11, 0x08,
     528,   11,   11,   11, 0x08,
     540,   11,   11,   11, 0x08,
     553,   11,   11,   11, 0x08,
     568,   11,   11,   11, 0x08,
     582,   11,   11,   11, 0x08,
     601,   11,   11,   11, 0x08,
     636,   11,  625,   11, 0x08,

       0        // eod
};

static const char qt_meta_stringdata_MainWindow[] = {
    "MainWindow\0\0stopCslc()\0bool\0isEmpty()\0"
    "newFile()\0open()\0fileName\0open(QString)\0"
    "save()\0saveAs()\0print()\0printPdf()\0"
    "printPreview()\0openRecentFile()\0undo()\0"
    "redo()\0cut()\0copy()\0paste()\0font()\0"
    "setDir()\0replace()\0find()\0findContinue()\0"
    "slotFindNext()\0findPrevious()\0"
    "slotFindPrevious()\0setFocus()\0"
    "text,fromButton\0"
    "slotFindWidget_textChanged(QString,bool)\0"
    "text\0slotFindWidget_textChanged(QString)\0"
    "slotFindWidget_textChanged()\0item\0"
    "slotDoubleClickLogWind(QListWidgetItem*)\0"
    "slotStopCslc()\0about()\0runcsl()\0"
    "runoptcsl()\0GotoLine()\0GotoMatch()\0"
    "setupCslc()\0slotIndent()\0slotUnindent()\0"
    "updateMenus()\0updateWindowMenu()\0"
    "switchLayoutDirection()\0MainChild*\0"
    "createMainChild()\0"
};

const QMetaObject MainWindow::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_MainWindow,
      qt_meta_data_MainWindow, 0 }
};

const QMetaObject *MainWindow::metaObject() const
{
    return &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_MainWindow))
        return static_cast<void*>(const_cast< MainWindow*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        switch (_id) {
        case 0: stopCslc(); break;
        case 1: { bool _r = isEmpty();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 2: newFile(); break;
        case 3: open(); break;
        case 4: open((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 5: save(); break;
        case 6: saveAs(); break;
        case 7: print(); break;
        case 8: printPdf(); break;
        case 9: printPreview(); break;
        case 10: openRecentFile(); break;
        case 11: undo(); break;
        case 12: redo(); break;
        case 13: cut(); break;
        case 14: copy(); break;
        case 15: paste(); break;
        case 16: font(); break;
        case 17: setDir(); break;
        case 18: replace(); break;
        case 19: find(); break;
        case 20: findContinue(); break;
        case 21: slotFindNext(); break;
        case 22: findPrevious(); break;
        case 23: slotFindPrevious(); break;
        case 24: setFocus(); break;
        case 25: slotFindWidget_textChanged((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< bool(*)>(_a[2]))); break;
        case 26: slotFindWidget_textChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 27: slotFindWidget_textChanged(); break;
        case 28: slotDoubleClickLogWind((*reinterpret_cast< QListWidgetItem*(*)>(_a[1]))); break;
        case 29: slotStopCslc(); break;
        case 30: about(); break;
        case 31: runcsl(); break;
        case 32: runoptcsl(); break;
        case 33: GotoLine(); break;
        case 34: GotoMatch(); break;
        case 35: setupCslc(); break;
        case 36: slotIndent(); break;
        case 37: slotUnindent(); break;
        case 38: updateMenus(); break;
        case 39: updateWindowMenu(); break;
        case 40: switchLayoutDirection(); break;
        case 41: { MainChild* _r = createMainChild();
            if (_a[0]) *reinterpret_cast< MainChild**>(_a[0]) = _r; }  break;
        default: ;
        }
        _id -= 42;
    }
    return _id;
}

// SIGNAL 0
void MainWindow::stopCslc()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
