# -------------------------------------------------
# Project created by QtCreator 2009-07-08T12:00:41
# -------------------------------------------------
TARGET = FastPath
TEMPLATE = app
SOURCES += main.cpp \
    mainwindow.cpp \
    qtpropertybrowser/qtvariantproperty.cpp \
    qtpropertybrowser/qttreepropertybrowser.cpp \
    qtpropertybrowser/qtpropertymanager.cpp \
    qtpropertybrowser/qtpropertybrowserutils.cpp \
    qtpropertybrowser/qtpropertybrowser.cpp \
    qtpropertybrowser/qtgroupboxpropertybrowser.cpp \
    qtpropertybrowser/qtbuttonpropertybrowser.cpp \
    qtpropertybrowser/qteditorfactory.cpp \
    interface.cpp \
    unit.cpp \
    comboboxeditorfactory.cpp \
    refcounted.cpp \
    connectivity.cpp \
    propertydialog.cpp \
    interfaceconnectiondialog.cpp \
    driverconnectiondialog.cpp \
    rangeeditorfactory.cpp \
    treecombobox.cpp \
    preferencedialog.cpp \
    fplxmlhandler.cpp \
    fploptions.cpp \
    optiondialog.cpp
HEADERS += mainwindow.h \
    qtpropertybrowser/qttreepropertybrowser.h \
    qtpropertybrowser/qtpropertymanager.h \
    qtpropertybrowser/qtpropertybrowserutils_p.h \
    qtpropertybrowser/qtpropertybrowser.h \
    qtpropertybrowser/qtgroupboxpropertybrowser.h \
    qtpropertybrowser/qtbuttonpropertybrowser.h \
    qtpropertybrowser/qtvariantproperty.h \
    qtpropertybrowser/qteditorfactory.h \
    interface.h \
    unit.h \
    TypeDefs.h \
    ETreeColoring.h \
    comboboxeditorfactory.h \
    refcounted.h \
    connectivity.h \
    propertydialog.h \
    interfaceconnectiondialog.h \
    driverconnectiondialog.h \
    rangeeditorfactory.h \
    treecombobox.h \
    preferencedialog.h \
    fplxmlhandler.h \
    ETreeColoring.h \
    fploptions.h \
    optiondialog.h
FORMS += mainwindow.ui \
    dialogProperty.ui \
    dialogPreferences.ui
OTHER_FILES += 
RESOURCES += qtpropertybrowser/qtpropertybrowser.qrc
INCLUDEPATH += qtpropertybrowser
INCLUDEPATH += /usr/local/include/boost-1_34_1
LIBS += -L/opt/tools/fontconfig-2.8.0/lib
CONFIG += qt \
    debug
QT += xml \
    core \
    gui
