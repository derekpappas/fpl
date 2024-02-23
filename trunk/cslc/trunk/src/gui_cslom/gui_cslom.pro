# -------------------------------------------------
# Project created by QtCreator 2009-07-08T12:00:41
# -------------------------------------------------
TARGET = gui_cslom
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
    optiondialog.cpp \
    gui_cslom_visitor.cpp
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
    optiondialog.h \
    gui_cslom_visitor.h
FORMS += mainwindow.ui \
    dialogProperty.ui \
    dialogPreferences.ui
OTHER_FILES += 
RESOURCES += qtpropertybrowser/qtpropertybrowser.qrc
INCLUDEPATH += qtpropertybrowser
INCLUDEPATH += ../support
INCLUDEPATH += ../cslom
INCLUDEPATH += ../cslom_generators
INCLUDEPATH += ../cslc
INCLUDEPATH += ${WORK}/trunk/antlr/lib/cpp
INCLUDEPATH += ${BOOST_INCLUDE}


linux-g++-64: LIBS += ${WORK}/trunk/build/linux/x86_64/cslc/debug/cslc_Typedef.o \
                      ${WORK}/trunk/build/linux/x86_64/cslc/debug/new_cslc.o
linux-g++-32: LIBS += ${WORK}/trunk/build/linux/x86/cslc/debug/cslc_Typedef.o \
                      ${WORK}/trunk/build/linux/x86/cslc/debug/new_cslc.o

LIBS += -L${CSL_FONT_CONFIG_HOME}/lib

linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/csl_xml_warn_error -Wl,-Bdynamic -lWE -lCSLC_Errors
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/preproc -lPreproc
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/parser/verilog -lVerilogParser
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/cdom -lCdom
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/parser/csl -lCslParser
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/cslom -lCslom
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/cslom2cdom_adapter -lAdapter
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/cslom_design_checker -lCslomChecker
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/cslom_generators -lCslomGen
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/autorouter -lAR
linux-g++-64: LIBS += -L${WORK}/trunk/build/linux/x86_64/support -lSupport
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/csl_xml_warn_error -Wl,-Bdynamic -lWE -lCSLC_Errors
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/preproc -lPreproc
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/parser/verilog -lVerilogParser
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/cdom -lCdom
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/parser/csl -lCslParser
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/cslom -lCslom
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/cslom2cdom_adapter -lAdapter
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/cslom_design_checker -lCslomChecker
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/cslom_generators -lCslomGen
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/autorouter -lAR
linux-g++-32: LIBS += -L${WORK}/trunk/build/linux/x86/support -lSupport

LIBS += -L${WORK}/trunk/antlr/lib/cpp/src -lantlr

linux-g++-64: LIBS += -L/usr/lib64 -lxerces-c
linux-g++-32: LIBS += -L/usr/lib -lxerces-c

LIBS += -L/${BOOST_HOME}/lib -lboost_filesystem


CONFIG += qt \
    debug
QT += xml \
    core \
    gui
