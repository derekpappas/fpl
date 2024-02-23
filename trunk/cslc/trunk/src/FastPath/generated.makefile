#############################################################################
# Makefile for building: FastPath
# Generated by qmake (2.01a) (Qt 4.5.0) on: Fri Nov 13 23:17:27 2009
# Project:  FastPath.pro
# Template: app
# Command: /usr/bin/qmake-qt4 -spec /usr/share/qt4/mkspecs/linux-g++ -unix CONFIG+=debug -o Makefile FastPath.pro
#############################################################################

####### Compiler, tools and options

CC            = gcc
CXX           = g++
DEFINES       = -DQT_XML_LIB -DQT_GUI_LIB -DQT_CORE_LIB -DQT_SHARED
CFLAGS        = -pipe -g -D_REENTRANT -Wall -W $(DEFINES)
CXXFLAGS      = -pipe -g -D_REENTRANT -Wall -W $(DEFINES)
INCPATH       = -I/usr/share/qt4/mkspecs/linux-g++ -I. -I/usr/include/qt4/QtCore -I/usr/include/qt4/QtGui -I/usr/include/qt4/QtXml -I/usr/include/qt4 -Iqtpropertybrowser -I/opt/local/include/boost-1_34_1 -I. -I.
LINK          = g++
LFLAGS        = 
LIBS          = $(SUBLIBS)  -L/usr/lib -lQtXml -lQtGui -lQtCore -lpthread
AR            = ar cqs
RANLIB        = 
QMAKE         = /usr/bin/qmake-qt4
TAR           = tar -cf
COMPRESS      = gzip -9f
COPY          = cp -f
SED           = sed
COPY_FILE     = $(COPY)
COPY_DIR      = $(COPY) -r
INSTALL_FILE  = install -m 644 -p
INSTALL_DIR   = $(COPY_DIR)
INSTALL_PROGRAM = install -m 755 -p
DEL_FILE      = rm -f
SYMLINK       = ln -sf
DEL_DIR       = rmdir
MOVE          = mv -f
CHK_DIR_EXISTS= test -d
MKDIR         = mkdir -p

####### Output directory

OBJECTS_DIR   = ./

####### Files

SOURCES       = main.cpp \
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
		fplxmlhandler.cpp moc_mainwindow.cpp \
		moc_qtpropertybrowserutils_p.cpp \
		moc_propertydialog.cpp \
		moc_interfaceconnectiondialog.cpp \
		moc_driverconnectiondialog.cpp \
		moc_treecombobox.cpp \
		moc_preferencedialog.cpp \
		qrc_qtpropertybrowser.cpp
OBJECTS       = main.o \
		mainwindow.o \
		qtvariantproperty.o \
		qttreepropertybrowser.o \
		qtpropertymanager.o \
		qtpropertybrowserutils.o \
		qtpropertybrowser.o \
		qtgroupboxpropertybrowser.o \
		qtbuttonpropertybrowser.o \
		qteditorfactory.o \
		interface.o \
		unit.o \
		comboboxeditorfactory.o \
		refcounted.o \
		connectivity.o \
		propertydialog.o \
		interfaceconnectiondialog.o \
		driverconnectiondialog.o \
		rangeeditorfactory.o \
		treecombobox.o \
		preferencedialog.o \
		fplxmlhandler.o \
		moc_mainwindow.o \
		moc_qtpropertybrowserutils_p.o \
		moc_propertydialog.o \
		moc_interfaceconnectiondialog.o \
		moc_driverconnectiondialog.o \
		moc_treecombobox.o \
		moc_preferencedialog.o \
		qrc_qtpropertybrowser.o
DIST          = /usr/share/qt4/mkspecs/common/g++.conf \
		/usr/share/qt4/mkspecs/common/unix.conf \
		/usr/share/qt4/mkspecs/common/linux.conf \
		/usr/share/qt4/mkspecs/qconfig.pri \
		/usr/share/qt4/mkspecs/features/qt_functions.prf \
		/usr/share/qt4/mkspecs/features/qt_config.prf \
		/usr/share/qt4/mkspecs/features/exclusive_builds.prf \
		/usr/share/qt4/mkspecs/features/default_pre.prf \
		/usr/share/qt4/mkspecs/features/debug.prf \
		/usr/share/qt4/mkspecs/features/default_post.prf \
		/usr/share/qt4/mkspecs/features/qt.prf \
		/usr/share/qt4/mkspecs/features/unix/thread.prf \
		/usr/share/qt4/mkspecs/features/moc.prf \
		/usr/share/qt4/mkspecs/features/warn_on.prf \
		/usr/share/qt4/mkspecs/features/resources.prf \
		/usr/share/qt4/mkspecs/features/uic.prf \
		/usr/share/qt4/mkspecs/features/yacc.prf \
		/usr/share/qt4/mkspecs/features/lex.prf \
		FastPath.pro
QMAKE_TARGET  = FastPath
DESTDIR       = 
TARGET        = FastPath

first: all
####### Implicit rules

.SUFFIXES: .o .c .cpp .cc .cxx .C

.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.C.o:
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o "$@" "$<"

.c.o:
	$(CC) -c $(CFLAGS) $(INCPATH) -o "$@" "$<"

####### Build rules

all: Makefile $(TARGET)

$(TARGET): ui_mainwindow.h ui_dialogProperty.h ui_dialogPreferences.h $(OBJECTS)  
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)

Makefile: FastPath.pro  /usr/share/qt4/mkspecs/linux-g++/qmake.conf /usr/share/qt4/mkspecs/common/g++.conf \
		/usr/share/qt4/mkspecs/common/unix.conf \
		/usr/share/qt4/mkspecs/common/linux.conf \
		/usr/share/qt4/mkspecs/qconfig.pri \
		/usr/share/qt4/mkspecs/features/qt_functions.prf \
		/usr/share/qt4/mkspecs/features/qt_config.prf \
		/usr/share/qt4/mkspecs/features/exclusive_builds.prf \
		/usr/share/qt4/mkspecs/features/default_pre.prf \
		/usr/share/qt4/mkspecs/features/debug.prf \
		/usr/share/qt4/mkspecs/features/default_post.prf \
		/usr/share/qt4/mkspecs/features/qt.prf \
		/usr/share/qt4/mkspecs/features/unix/thread.prf \
		/usr/share/qt4/mkspecs/features/moc.prf \
		/usr/share/qt4/mkspecs/features/warn_on.prf \
		/usr/share/qt4/mkspecs/features/resources.prf \
		/usr/share/qt4/mkspecs/features/uic.prf \
		/usr/share/qt4/mkspecs/features/yacc.prf \
		/usr/share/qt4/mkspecs/features/lex.prf \
		/usr/lib/libQtXml.prl \
		/usr/lib/libQtGui.prl \
		/usr/lib/libQtCore.prl
	$(QMAKE) -spec /usr/share/qt4/mkspecs/linux-g++ -unix CONFIG+=debug -o Makefile FastPath.pro
/usr/share/qt4/mkspecs/common/g++.conf:
/usr/share/qt4/mkspecs/common/unix.conf:
/usr/share/qt4/mkspecs/common/linux.conf:
/usr/share/qt4/mkspecs/qconfig.pri:
/usr/share/qt4/mkspecs/features/qt_functions.prf:
/usr/share/qt4/mkspecs/features/qt_config.prf:
/usr/share/qt4/mkspecs/features/exclusive_builds.prf:
/usr/share/qt4/mkspecs/features/default_pre.prf:
/usr/share/qt4/mkspecs/features/debug.prf:
/usr/share/qt4/mkspecs/features/default_post.prf:
/usr/share/qt4/mkspecs/features/qt.prf:
/usr/share/qt4/mkspecs/features/unix/thread.prf:
/usr/share/qt4/mkspecs/features/moc.prf:
/usr/share/qt4/mkspecs/features/warn_on.prf:
/usr/share/qt4/mkspecs/features/resources.prf:
/usr/share/qt4/mkspecs/features/uic.prf:
/usr/share/qt4/mkspecs/features/yacc.prf:
/usr/share/qt4/mkspecs/features/lex.prf:
/usr/lib/libQtXml.prl:
/usr/lib/libQtGui.prl:
/usr/lib/libQtCore.prl:
qmake:  FORCE
	@$(QMAKE) -spec /usr/share/qt4/mkspecs/linux-g++ -unix CONFIG+=debug -o Makefile FastPath.pro

dist: 
	@$(CHK_DIR_EXISTS) .tmp/FastPath1.0.0 || $(MKDIR) .tmp/FastPath1.0.0 
	$(COPY_FILE) --parents $(SOURCES) $(DIST) .tmp/FastPath1.0.0/ && $(COPY_FILE) --parents mainwindow.h qtpropertybrowser/qttreepropertybrowser.h qtpropertybrowser/qtpropertymanager.h qtpropertybrowser/qtpropertybrowserutils_p.h qtpropertybrowser/qtpropertybrowser.h qtpropertybrowser/qtgroupboxpropertybrowser.h qtpropertybrowser/qtbuttonpropertybrowser.h qtpropertybrowser/qtvariantproperty.h qtpropertybrowser/qteditorfactory.h interface.h unit.h TypeDefs.h comboboxeditorfactory.h refcounted.h connectivity.h propertydialog.h interfaceconnectiondialog.h driverconnectiondialog.h rangeeditorfactory.h treecombobox.h interfacexmlhandler.h preferencedialog.h fplxmlhandler.h shared_ptr.h .tmp/FastPath1.0.0/ && $(COPY_FILE) --parents qtpropertybrowser/qtpropertybrowser.qrc .tmp/FastPath1.0.0/ && $(COPY_FILE) --parents main.cpp mainwindow.cpp qtpropertybrowser/qtvariantproperty.cpp qtpropertybrowser/qttreepropertybrowser.cpp qtpropertybrowser/qtpropertymanager.cpp qtpropertybrowser/qtpropertybrowserutils.cpp qtpropertybrowser/qtpropertybrowser.cpp qtpropertybrowser/qtgroupboxpropertybrowser.cpp qtpropertybrowser/qtbuttonpropertybrowser.cpp qtpropertybrowser/qteditorfactory.cpp interface.cpp unit.cpp comboboxeditorfactory.cpp refcounted.cpp connectivity.cpp propertydialog.cpp interfaceconnectiondialog.cpp driverconnectiondialog.cpp rangeeditorfactory.cpp treecombobox.cpp preferencedialog.cpp fplxmlhandler.cpp .tmp/FastPath1.0.0/ && $(COPY_FILE) --parents mainwindow.ui dialogProperty.ui dialogPreferences.ui .tmp/FastPath1.0.0/ && (cd `dirname .tmp/FastPath1.0.0` && $(TAR) FastPath1.0.0.tar FastPath1.0.0 && $(COMPRESS) FastPath1.0.0.tar) && $(MOVE) `dirname .tmp/FastPath1.0.0`/FastPath1.0.0.tar.gz . && $(DEL_FILE) -r .tmp/FastPath1.0.0


clean:compiler_clean 
	-$(DEL_FILE) $(OBJECTS)
	-$(DEL_FILE) *~ core *.core


####### Sub-libraries

distclean: clean
	-$(DEL_FILE) $(TARGET) 
	-$(DEL_FILE) Makefile


mocclean: compiler_moc_header_clean compiler_moc_source_clean

mocables: compiler_moc_header_make_all compiler_moc_source_make_all

compiler_moc_header_make_all: moc_mainwindow.cpp moc_qttreepropertybrowser.cpp moc_qtpropertymanager.cpp moc_qtpropertybrowserutils_p.cpp moc_qtpropertybrowser.cpp moc_qtgroupboxpropertybrowser.cpp moc_qtbuttonpropertybrowser.cpp moc_qtvariantproperty.cpp moc_qteditorfactory.cpp moc_comboboxeditorfactory.cpp moc_propertydialog.cpp moc_interfaceconnectiondialog.cpp moc_driverconnectiondialog.cpp moc_rangeeditorfactory.cpp moc_treecombobox.cpp moc_preferencedialog.cpp
compiler_moc_header_clean:
	-$(DEL_FILE) moc_mainwindow.cpp moc_qttreepropertybrowser.cpp moc_qtpropertymanager.cpp moc_qtpropertybrowserutils_p.cpp moc_qtpropertybrowser.cpp moc_qtgroupboxpropertybrowser.cpp moc_qtbuttonpropertybrowser.cpp moc_qtvariantproperty.cpp moc_qteditorfactory.cpp moc_comboboxeditorfactory.cpp moc_propertydialog.cpp moc_interfaceconnectiondialog.cpp moc_driverconnectiondialog.cpp moc_rangeeditorfactory.cpp moc_treecombobox.cpp moc_preferencedialog.cpp
moc_mainwindow.cpp: refcounted.h \
		mainwindow.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) mainwindow.h -o moc_mainwindow.cpp

moc_qttreepropertybrowser.cpp: qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qttreepropertybrowser.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qttreepropertybrowser.h -o moc_qttreepropertybrowser.cpp

moc_qtpropertymanager.cpp: qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtpropertymanager.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtpropertymanager.h -o moc_qtpropertymanager.cpp

moc_qtpropertybrowserutils_p.cpp: qtpropertybrowser/qtpropertybrowserutils_p.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtpropertybrowserutils_p.h -o moc_qtpropertybrowserutils_p.cpp

moc_qtpropertybrowser.cpp: qtpropertybrowser/qtpropertybrowser.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtpropertybrowser.h -o moc_qtpropertybrowser.cpp

moc_qtgroupboxpropertybrowser.cpp: qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtgroupboxpropertybrowser.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtgroupboxpropertybrowser.h -o moc_qtgroupboxpropertybrowser.cpp

moc_qtbuttonpropertybrowser.cpp: qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtbuttonpropertybrowser.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtbuttonpropertybrowser.h -o moc_qtbuttonpropertybrowser.cpp

moc_qtvariantproperty.cpp: qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtvariantproperty.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtvariantproperty.h -o moc_qtvariantproperty.cpp

moc_qteditorfactory.cpp: qtpropertybrowser/qtpropertymanager.h \
		qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qteditorfactory.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qteditorfactory.h -o moc_qteditorfactory.cpp

moc_comboboxeditorfactory.cpp: comboboxeditorfactory.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) comboboxeditorfactory.h -o moc_comboboxeditorfactory.cpp

moc_propertydialog.cpp: ui_dialogProperty.h \
		propertydialog.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) propertydialog.h -o moc_propertydialog.cpp

moc_interfaceconnectiondialog.cpp: propertydialog.h \
		ui_dialogProperty.h \
		refcounted.h \
		interfaceconnectiondialog.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) interfaceconnectiondialog.h -o moc_interfaceconnectiondialog.cpp

moc_driverconnectiondialog.cpp: propertydialog.h \
		ui_dialogProperty.h \
		refcounted.h \
		interface.h \
		TypeDefs.h \
		driverconnectiondialog.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) driverconnectiondialog.h -o moc_driverconnectiondialog.cpp

moc_rangeeditorfactory.cpp: rangeeditorfactory.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) rangeeditorfactory.h -o moc_rangeeditorfactory.cpp

moc_treecombobox.cpp: treecombobox.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) treecombobox.h -o moc_treecombobox.cpp

moc_preferencedialog.cpp: ui_dialogPreferences.h \
		preferencedialog.h
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) preferencedialog.h -o moc_preferencedialog.cpp

compiler_rcc_make_all: qrc_qtpropertybrowser.cpp
compiler_rcc_clean:
	-$(DEL_FILE) qrc_qtpropertybrowser.cpp
qrc_qtpropertybrowser.cpp: qtpropertybrowser/qtpropertybrowser.qrc \
		qtpropertybrowser/images/fpl_logo.png \
		qtpropertybrowser/images/cursor-vsplit.png \
		qtpropertybrowser/images/cursor-sizeh.png \
		qtpropertybrowser/images/cursor-forbidden.png \
		qtpropertybrowser/images/cursor-sizev.png \
		qtpropertybrowser/images/cursor-whatsthis.png \
		qtpropertybrowser/images/cursor-busy.png \
		qtpropertybrowser/images/cursor-wait.png \
		qtpropertybrowser/images/cursor-ibeam.png \
		qtpropertybrowser/images/cursor-hand.png \
		qtpropertybrowser/images/cursor-openhand.png \
		qtpropertybrowser/images/cursor-sizeall.png \
		qtpropertybrowser/images/cursor-sizef.png \
		qtpropertybrowser/images/cursor-sizeb.png \
		qtpropertybrowser/images/cursor-hsplit.png \
		qtpropertybrowser/images/cursor-cross.png \
		qtpropertybrowser/images/cursor-closedhand.png \
		qtpropertybrowser/images/cursor-arrow.png \
		qtpropertybrowser/images/cursor-uparrow.png
	/usr/bin/rcc -name qtpropertybrowser qtpropertybrowser/qtpropertybrowser.qrc -o qrc_qtpropertybrowser.cpp

compiler_image_collection_make_all: qmake_image_collection.cpp
compiler_image_collection_clean:
	-$(DEL_FILE) qmake_image_collection.cpp
compiler_moc_source_make_all: qttreepropertybrowser.moc qtpropertymanager.moc qteditorfactory.moc
compiler_moc_source_clean:
	-$(DEL_FILE) qttreepropertybrowser.moc qtpropertymanager.moc qteditorfactory.moc
qttreepropertybrowser.moc: qtpropertybrowser/qttreepropertybrowser.h \
		qtpropertybrowser/qtpropertybrowser.h \
		moc_qttreepropertybrowser.cpp \
		qtpropertybrowser/qttreepropertybrowser.cpp
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qttreepropertybrowser.cpp -o qttreepropertybrowser.moc

qtpropertymanager.moc: qtpropertybrowser/qtpropertymanager.h \
		qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtpropertybrowserutils_p.h \
		moc_qtpropertymanager.cpp \
		qtpropertybrowser/qtpropertymanager.cpp
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qtpropertymanager.cpp -o qtpropertymanager.moc

qteditorfactory.moc: qtpropertybrowser/qteditorfactory.h \
		qtpropertybrowser/qtpropertymanager.h \
		qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtpropertybrowserutils_p.h \
		moc_qteditorfactory.cpp \
		qtpropertybrowser/qteditorfactory.cpp
	/usr/bin/moc-qt4 $(DEFINES) $(INCPATH) qtpropertybrowser/qteditorfactory.cpp -o qteditorfactory.moc

compiler_uic_make_all: ui_mainwindow.h ui_dialogProperty.h ui_dialogPreferences.h
compiler_uic_clean:
	-$(DEL_FILE) ui_mainwindow.h ui_dialogProperty.h ui_dialogPreferences.h
ui_mainwindow.h: mainwindow.ui
	/usr/bin/uic-qt4 mainwindow.ui -o ui_mainwindow.h

ui_dialogProperty.h: dialogProperty.ui
	/usr/bin/uic-qt4 dialogProperty.ui -o ui_dialogProperty.h

ui_dialogPreferences.h: dialogPreferences.ui
	/usr/bin/uic-qt4 dialogPreferences.ui -o ui_dialogPreferences.h

compiler_yacc_decl_make_all:
compiler_yacc_decl_clean:
compiler_yacc_impl_make_all:
compiler_yacc_impl_clean:
compiler_lex_make_all:
compiler_lex_clean:
compiler_clean: compiler_moc_header_clean compiler_rcc_clean compiler_moc_source_clean compiler_uic_clean 

####### Compile

main.o: main.cpp mainwindow.h \
		refcounted.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o main.o main.cpp

mainwindow.o: mainwindow.cpp mainwindow.h \
		refcounted.h \
		ui_mainwindow.h \
		comboboxeditorfactory.h \
		unit.h \
		interface.h \
		TypeDefs.h \
		connectivity.h \
		propertydialog.h \
		ui_dialogProperty.h \
		interfaceconnectiondialog.h \
		driverconnectiondialog.h \
		fplxmlhandler.h \
		preferencedialog.h \
		ui_dialogPreferences.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o mainwindow.o mainwindow.cpp

qtvariantproperty.o: qtpropertybrowser/qtvariantproperty.cpp qtpropertybrowser/qtvariantproperty.h \
		qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtpropertymanager.h \
		qtpropertybrowser/qteditorfactory.h \
		comboboxeditorfactory.h \
		rangeeditorfactory.h \
		moc_qtvariantproperty.cpp
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qtvariantproperty.o qtpropertybrowser/qtvariantproperty.cpp

qttreepropertybrowser.o: qtpropertybrowser/qttreepropertybrowser.cpp qtpropertybrowser/qttreepropertybrowser.h \
		qtpropertybrowser/qtpropertybrowser.h \
		moc_qttreepropertybrowser.cpp \
		qttreepropertybrowser.moc
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qttreepropertybrowser.o qtpropertybrowser/qttreepropertybrowser.cpp

qtpropertymanager.o: qtpropertybrowser/qtpropertymanager.cpp qtpropertybrowser/qtpropertymanager.h \
		qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtpropertybrowserutils_p.h \
		moc_qtpropertymanager.cpp \
		qtpropertymanager.moc
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qtpropertymanager.o qtpropertybrowser/qtpropertymanager.cpp

qtpropertybrowserutils.o: qtpropertybrowser/qtpropertybrowserutils.cpp qtpropertybrowser/qtpropertybrowserutils_p.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qtpropertybrowserutils.o qtpropertybrowser/qtpropertybrowserutils.cpp

qtpropertybrowser.o: qtpropertybrowser/qtpropertybrowser.cpp qtpropertybrowser/qtpropertybrowser.h \
		moc_qtpropertybrowser.cpp
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qtpropertybrowser.o qtpropertybrowser/qtpropertybrowser.cpp

qtgroupboxpropertybrowser.o: qtpropertybrowser/qtgroupboxpropertybrowser.cpp qtpropertybrowser/qtgroupboxpropertybrowser.h \
		qtpropertybrowser/qtpropertybrowser.h \
		moc_qtgroupboxpropertybrowser.cpp
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qtgroupboxpropertybrowser.o qtpropertybrowser/qtgroupboxpropertybrowser.cpp

qtbuttonpropertybrowser.o: qtpropertybrowser/qtbuttonpropertybrowser.cpp qtpropertybrowser/qtbuttonpropertybrowser.h \
		qtpropertybrowser/qtpropertybrowser.h \
		moc_qtbuttonpropertybrowser.cpp
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qtbuttonpropertybrowser.o qtpropertybrowser/qtbuttonpropertybrowser.cpp

qteditorfactory.o: qtpropertybrowser/qteditorfactory.cpp qtpropertybrowser/qteditorfactory.h \
		qtpropertybrowser/qtpropertymanager.h \
		qtpropertybrowser/qtpropertybrowser.h \
		qtpropertybrowser/qtpropertybrowserutils_p.h \
		moc_qteditorfactory.cpp \
		qteditorfactory.moc
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qteditorfactory.o qtpropertybrowser/qteditorfactory.cpp

interface.o: interface.cpp interface.h \
		TypeDefs.h \
		refcounted.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o interface.o interface.cpp

unit.o: unit.cpp unit.h \
		refcounted.h \
		interface.h \
		TypeDefs.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o unit.o unit.cpp

comboboxeditorfactory.o: comboboxeditorfactory.cpp comboboxeditorfactory.h \
		treecombobox.h \
		moc_comboboxeditorfactory.cpp
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o comboboxeditorfactory.o comboboxeditorfactory.cpp

refcounted.o: refcounted.cpp refcounted.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o refcounted.o refcounted.cpp

connectivity.o: connectivity.cpp connectivity.h \
		refcounted.h \
		interface.h \
		TypeDefs.h \
		unit.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o connectivity.o connectivity.cpp

propertydialog.o: propertydialog.cpp propertydialog.h \
		ui_dialogProperty.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o propertydialog.o propertydialog.cpp

interfaceconnectiondialog.o: interfaceconnectiondialog.cpp interfaceconnectiondialog.h \
		propertydialog.h \
		ui_dialogProperty.h \
		refcounted.h \
		interface.h \
		TypeDefs.h \
		connectivity.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o interfaceconnectiondialog.o interfaceconnectiondialog.cpp

driverconnectiondialog.o: driverconnectiondialog.cpp driverconnectiondialog.h \
		propertydialog.h \
		ui_dialogProperty.h \
		refcounted.h \
		interface.h \
		TypeDefs.h \
		unit.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o driverconnectiondialog.o driverconnectiondialog.cpp

rangeeditorfactory.o: rangeeditorfactory.cpp rangeeditorfactory.h \
		moc_rangeeditorfactory.cpp
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o rangeeditorfactory.o rangeeditorfactory.cpp

treecombobox.o: treecombobox.cpp treecombobox.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o treecombobox.o treecombobox.cpp

preferencedialog.o: preferencedialog.cpp preferencedialog.h \
		ui_dialogPreferences.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o preferencedialog.o preferencedialog.cpp

fplxmlhandler.o: fplxmlhandler.cpp fplxmlhandler.h \
		refcounted.h \
		interface.h \
		TypeDefs.h \
		unit.h \
		connectivity.h
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o fplxmlhandler.o fplxmlhandler.cpp

moc_mainwindow.o: moc_mainwindow.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_mainwindow.o moc_mainwindow.cpp

moc_qtpropertybrowserutils_p.o: moc_qtpropertybrowserutils_p.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_qtpropertybrowserutils_p.o moc_qtpropertybrowserutils_p.cpp

moc_propertydialog.o: moc_propertydialog.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_propertydialog.o moc_propertydialog.cpp

moc_interfaceconnectiondialog.o: moc_interfaceconnectiondialog.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_interfaceconnectiondialog.o moc_interfaceconnectiondialog.cpp

moc_driverconnectiondialog.o: moc_driverconnectiondialog.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_driverconnectiondialog.o moc_driverconnectiondialog.cpp

moc_treecombobox.o: moc_treecombobox.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_treecombobox.o moc_treecombobox.cpp

moc_preferencedialog.o: moc_preferencedialog.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o moc_preferencedialog.o moc_preferencedialog.cpp

qrc_qtpropertybrowser.o: qrc_qtpropertybrowser.cpp 
	$(CXX) -c $(CXXFLAGS) $(INCPATH) -o qrc_qtpropertybrowser.o qrc_qtpropertybrowser.cpp

####### Install

install:   FORCE

uninstall:   FORCE

FORCE:
