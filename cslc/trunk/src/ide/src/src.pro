HEADERS = mainwindow.h \
                mainchild.h \
                highlighter.h \
                replace.h \
                toolscontrol.h \
                tools.h \
                printpreview.h \
                ../../cslc/cslc.h \
                linenumbers.h \
                selectionborder.h \
                instancetree.h
SOURCES = main.cpp \
                mainwindow.cpp \
                mainchild.cpp \
                highlighter.cpp \
                replace.cpp \
                toolscontrol.cpp \
                tools.cpp \
                printpreview.cpp \
                linenumbers.cpp \
                selectionborder.cpp \
                instancetree.cpp
TARGET = ../bin/ide

# install
sources.files = $$SOURCES $$HEADERS $$RESOURCES $$FORMS images
sources.path = $$[QT_INSTALL_EXAMPLES]/mainwindows/mdi
INSTALLS += sources
HEADERS -= textedit.h \
toolscontrol.h \
selectionborder.h
SOURCES -= textedit.cpp \
toolscontrol.cpp \
selectionborder.cpp
RESOURCES += ide.qrc

FORMS += gotoline.ui \
replace.ui \
promptreplace.ui \
findwidget.ui \
tools.ui
TEMPLATE = app

CONFIG += debug \
warn_off
sources.files -= mdi.pro

# WARNING-FIRST INCLUDEPATH MUST CONTAIN '-I' !!!!!!
INCLUDEPATH += -I /usr/include/boost
INCLUDEPATH += /usr/include/xercesc
INCLUDEPATH += ../../../antlr/lib/cpp
INCLUDEPATH += ../../../../antlr/lib/cpp
INCLUDEPATH += ../../../antlr/lib/cpp/antlr

INCLUDEPATH += ..
INCLUDEPATH += ../../support
INCLUDEPATH += ../../support/cli

INCLUDEPATH += ../../aa
INCLUDEPATH += ../../autorouter
INCLUDEPATH += ../../cdom
INCLUDEPATH += ../../csim
INCLUDEPATH += ../../cslc
INCLUDEPATH += ../../csl_command_shell
INCLUDEPATH += ../../csl_gen
INCLUDEPATH += ../../cslom
INCLUDEPATH += ../../cslom2cdom_adapter
INCLUDEPATH += ../../cslom_design_checker
INCLUDEPATH += ../../cslom_generators
INCLUDEPATH += ../../csl_xml_warn_error
INCLUDEPATH += ../../license
INCLUDEPATH += ../../parser
INCLUDEPATH += ../../parser/verilog/
INCLUDEPATH += ../../preproc
INCLUDEPATH += ../../support
INCLUDEPATH += ../../systemc_gen

LIBS += -L/usr/include/boost

LIBS += -lstdc++
LIBS += -lm
LIBS += -lpthread
LIBS += -lhpdf
LIBS += -lpng
LIBS += -lxerces-c
LIBS += -lboost_filesystem
LIBS += /usr/lib/libboost_filesystem.a
LIBS += ../../../antlr/lib/cpp/src/libantlr.a


# make a LIBPATH -L
# then set it up according to the platform with a switch if/else
# LIBS += -L ../../../build/linux/x86_64/parser
# LIBS += csl/libCslParser.a


#LIBS += /cslc/new_cslc.o
#LIBS += /cslc/cslc_Typedef.o

#PLATFORM_ARCH = x86_64
#LIB_DIR_ROOT=../../../build/linux
#LIB_DIR+=$$LIB_DIR_ROOT
#LIB_DIR+=/$$PLATFORM_ARCH


LIB_DIR = ../../../build/linux/x86_64

DEBUG =/debug

LIBS += -L$$LIB_DIR/csl_xml_warn_error$$DEBUG
LIBS += -lWE

LIBS += -L$$LIB_DIR/csl_xml_warn_error$$DEBUG
LIBS += -lCSLC_Errors

LIBS += -L$$LIB_DIR/support$$DEBUG
LIBS += -lSupport

LIBS += -L$$LIB_DIR/preproc$$DEBUG
LIBS += -lPreproc

LIBS += -L$$LIB_DIR/cslom$$DEBUG
LIBS += -lCslom

LIBS += -L$$LIB_DIR/cdom$$DEBUG
LIBS += -lCdom

LIBS += -L$$LIB_DIR/parser/verilog$$DEBUG
LIBS += -lVerilogParser

LIBS += -L$$LIB_DIR/parser/csl$$DEBUG
LIBS += -lCslParser

LIBS += -L$$LIB_DIR/cslom2cdom_adapter$$DEBUG
LIBS += -lAdapter

LIBS += -L$$LIB_DIR/cslom_generators$$DEBUG
LIBS += -lCslomGen

LIBS += -L$$LIB_DIR/autorouter$$DEBUG
LIBS += -lAR


#LIBS += /cslc/new_cslc.o
#LIBS += /cslc/cslc_Typedef.o

#LIBS += ../../../build/linux/x86_64/parser/csl/libCslParser.a
#LIBS += ../../../build/linux/x86_64/cslom2cdom_adapter/libAdapter.a
#LIBS += ../../../build/linux/x86_64/cslom/libCslom.a
#LIBS += ../../../build/linux/x86_64/cdom/libCdom.a
#LIBS += ../../../build/linux/x86_64/parser/verilog/libVerilogParser.a
#LIBS += ../../../build/linux/x86_64/csl_xml_warn_error/libWE.a
#LIBS += ../../../build/linux/x86_64/csl_xml_warn_error/libCSLC_Errors.a
#LIBS += ../../../build/linux/x86_64/autorouter/libAR.a
#LIBS += ../../../build/linux/x86_64/support/libSupport.a
#LIBS += ../../../build/linux/x86_64/preproc/libPreproc.a
#LIBS += ../../../build/linux/x86_64/cslom_generators/libCslomGen.a

#LIBS += ../../../build/linux/x86_64/cslc/new_cslc.o
#LIBS += ../../../build/linux/x86_64/cslc/cslc_Typedef.o
