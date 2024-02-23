//*************************************************************************
// DESCRIPTION: Verilator: Preprocessing wrapper
//
// Code available from: http://www.veripool.org/verilator
//
// AUTHORS: Wilson Snyder with Paul Wasson, Duane Gabli
//
//*************************************************************************
//
// Copyright 2004-2010 by Wilson Snyder.  This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
//
// Verilator is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//*************************************************************************

#include "config_build.h"
#include "verilatedos.h"
#include <cstdio>
#include <cstdarg>
#include <unistd.h>
#include <iostream>
#include <algorithm>
#include <list>
#include <set>

#include "V3Global.h"
#include "V3PreShell.h"
#include "V3PreProc.h"
#include "V3File.h"
#include "V3Parse.h"

//######################################################################

class V3PreShellImp {
protected:
    friend class V3PreShell;

    static V3PreShellImp s_preImp;
    static V3PreProc*	s_preprocp;
    static V3InFilter*	s_filterp;

    //---------------------------------------
    // METHODS

    static int debug() {
	static int level = -1;
	if (VL_UNLIKELY(level < 0)) level = v3Global.opt.debugSrcLevel(__FILE__);
	return level;
    }

    void boot(char** env) {
	// Create the implementation pointer
	if (env) {}
	if (!s_preprocp) {
	    FileLine* cmdfl = new FileLine("COMMAND_LINE",0);
	    s_preprocp = V3PreProc::createPreProc(cmdfl);
	    s_preprocp->debug(debug());
	    // Default defines
	    FileLine* prefl = new FileLine("INTERNAL_VERILATOR_DEFINE",0);
	    s_preprocp->defineCmdLine(prefl,"VERILATOR", "1");  // LEAK_OK
	    s_preprocp->defineCmdLine(prefl,"verilator", "1");  // LEAK_OK
	    s_preprocp->defineCmdLine(prefl,"verilator3", "1");  // LEAK_OK
	    s_preprocp->defineCmdLine(prefl,"systemc_clock", "/*verilator systemc_clock*/");  // LEAK_OK
	    s_preprocp->defineCmdLine(prefl,"coverage_block_off", "/*verilator coverage_block_off*/");  // LEAK_OK
	}
    }

    void preproc (FileLine* fl, const string& modname, V3InFilter* filterp, V3ParseImp* parsep) {
	// Preprocess the given module, putting output in vppFilename
	UINFONL(1,"  Preprocessing "<<modname<<endl);

	// Preprocess
	s_filterp = filterp;
	preprocOpen(fl, s_filterp, modname, "Cannot find file containing module: ");
	while (!s_preprocp->isEof()) {
	    string line = s_preprocp->getline();
	    V3Parse::ppPushText(parsep, line);
	}
    }

    void preprocInclude (FileLine* fl, const string& modname) {
	preprocOpen(fl, s_filterp, modname, "Cannot find include file: ");
    }

    void preprocOpen (FileLine* fl, V3InFilter* filterp, const string& modname, const string& errmsg) {
	// Allow user to put `defined names on the command line instead of filenames,
	// then convert them properly.
	string ppmodname = s_preprocp->removeDefines (modname);

	// Open include or master file
	string filename = v3Global.opt.filePath (fl, ppmodname, errmsg);
	if (filename=="") return;  // Not found

	UINFO(2,"    Reading "<<filename<<endl);
	s_preprocp->openFile(fl, filterp, filename);
    }

    // CONSTRUCTORS
    V3PreShellImp() {}
    ~V3PreShellImp() {}
};

V3PreShellImp V3PreShellImp::s_preImp;
V3PreProc* V3PreShellImp::s_preprocp = NULL;
V3InFilter* V3PreShellImp::s_filterp = NULL;

//######################################################################
// Perl class functions

void V3PreShell::boot(char** env) {
    V3PreShellImp::s_preImp.boot(env);
}
void V3PreShell::preproc(FileLine* fl, const string& modname, V3InFilter* filterp, V3ParseImp* parsep) {
    V3PreShellImp::s_preImp.preproc(fl, modname, filterp, parsep);
}
void V3PreShell::preprocInclude(FileLine* fl, const string& modname) {
    V3PreShellImp::s_preImp.preprocInclude(fl, modname);
}
void V3PreShell::defineCmdLine(const string& name, const string& value) {
    FileLine* prefl = new FileLine("COMMAND_LINE_DEFINE",0);
    V3PreShellImp::s_preprocp->defineCmdLine(prefl, name, value);
}
void V3PreShell::undef(const string& name) {
    V3PreShellImp::s_preprocp->undef(name);
}
