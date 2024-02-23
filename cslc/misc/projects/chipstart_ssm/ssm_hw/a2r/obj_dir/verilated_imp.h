// -*- C++ -*-
//*************************************************************************
//
// Copyright 2009-2010 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License.
// Version 2.0.
//
// Verilator is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//=========================================================================
///
/// \file
/// \brief Verilator: Implementation Header, only for verilated.cpp internals.
///
/// Code available from: http://www.veripool.org/verilator
///
//=========================================================================


#ifndef _VERILATED_IMP_H_
#define _VERILATED_IMP_H_ 1 ///< Header Guard

#if !defined(_VERILATED_CPP_) && !defined(_VERILATED_DPI_CPP_)
# error "verilated_imp.h only to be included by verilated*.cpp internals"
#endif

#include "verilatedos.h"
#include "verilated.h"
#include "verilated_heavy.h"

#include <map>
#include <vector>
#include <string>

class VerilatedScope;

//======================================================================
// Types

struct VerilatedCStrCmp {
    // For ordering maps keyed by const char*'s
    bool operator() (const char *a, const char *b) const {
	return std::strcmp(a, b) < 0;
    }
};

class VerilatedImp {
    // Whole class is internal use only - Global information shared between verilated*.cpp files.

    // TYPES
    typedef vector<string> ArgVec;
    typedef map<pair<const void*,void*>,void*> UserMap;
    typedef map<const char*, const VerilatedScope*, VerilatedCStrCmp>  ScopeNameMap;
    typedef map<const char*, int>  ExportNameMap;

    // MEMBERS
    static VerilatedImp	s_s;		///< Static Singleton; One and only static this

    ArgVec		m_argVec;	///< Argument list
    bool		m_argVecLoaded;	///< Ever loaded argument list
    UserMap	 	m_userMap;	///< Map of <(scope,userkey), userData>
    ScopeNameMap	m_nameMap;	///< Map of <scope_name, scope pointer>
    // Slow - somewhat static:
    ExportNameMap	m_exportMap;	///< Map of <export_func_proto, func number>
    int			m_exportNext;	///< Next export funcnum

public: // But only for verilated*.cpp
    // CONSTRUCTORS
    VerilatedImp() : m_argVecLoaded(false), m_exportNext(0) {}
    ~VerilatedImp() {}

    // METHODS - arguments
    static void commandArgs(int argc, const char** argv) {
	s_s.m_argVec.clear();
	for (int i=0; i<argc; i++) s_s.m_argVec.push_back(argv[i]);
	s_s.m_argVecLoaded = true; // Can't just test later for empty vector, no arguments is ok
    }
    static string argPlusMatch(const char* prefixp) {
	// Note prefixp does not include the leading "+"
	size_t len = strlen(prefixp);
	if (VL_UNLIKELY(!s_s.m_argVecLoaded)) {
	    s_s.m_argVecLoaded = true;  // Complain only once
	    vl_fatal("unknown",0,"",
		     "%Error: Verilog called $test$plusargs or $value$plusargs without"
		     " testbench C first calling Verilated::commandArgs(argc,argv).");
	}
	for (ArgVec::iterator it=s_s.m_argVec.begin(); it!=s_s.m_argVec.end(); ++it) {
	    if ((*it)[0]=='+') {
		if (0==strncmp(prefixp, it->c_str()+1, len)) return *it;
	    }
	}
	return "";
    }

    // METHODS - user scope tracking
    // We implement this as a single large map instead of one map per scope
    // There's often many more scopes than userdata's and thus having a ~48byte
    // per map overhead * N scopes would take much more space and cache thrashing.
    static inline void userInsert(const void* scopep, void* userKey, void* userData) {
	UserMap::iterator it=s_s.m_userMap.find(make_pair(scopep,userKey));
	if (it != s_s.m_userMap.end()) it->second = userData;
	// When we support VL_THREADs, we need a lock around this insert, as it's runtime
	else s_s.m_userMap.insert(it, make_pair(make_pair(scopep,userKey),userData));
    }
    static inline void* userFind(const void* scopep, void* userKey) {
	UserMap::iterator it=s_s.m_userMap.find(make_pair(scopep,userKey));
	if (VL_LIKELY(it != s_s.m_userMap.end())) return it->second;
	else return NULL;
    }
private:
    /// Symbol table destruction cleans up the entries for each scope.
    static void userEraseScope(const VerilatedScope* scopep) {
	// Slow ok - called once/scope on destruction, so we simply iterate.
	for (UserMap::iterator it=s_s.m_userMap.begin(); it!=s_s.m_userMap.end(); ) {
	    if (it->first.first == scopep) {
		s_s.m_userMap.erase(it++);
	    } else {
		++it;
	    }
	}
    }

public: // But only for verilated*.cpp
    // METHODS - scope name
    static void scopeInsert(const VerilatedScope* scopep) {
	// Slow ok - called once/scope at construction
	ScopeNameMap::iterator it=s_s.m_nameMap.find(scopep->name());
	if (it == s_s.m_nameMap.end()) {
	    s_s.m_nameMap.insert(it, make_pair(scopep->name(),scopep));
	}
    }
    static inline const VerilatedScope* scopeFind(const char* namep) {
	ScopeNameMap::iterator it=s_s.m_nameMap.find(namep);
	if (VL_LIKELY(it != s_s.m_nameMap.end())) return it->second;
	else return NULL;
    }
    static void scopeErase(const VerilatedScope* scopep) {
	// Slow ok - called once/scope at destruction
	userEraseScope(scopep);
	ScopeNameMap::iterator it=s_s.m_nameMap.find(scopep->name());
	if (it != s_s.m_nameMap.end()) s_s.m_nameMap.erase(it);
    }

    static void scopesDump() {
	VL_PRINTF("scopesDump:\n");
	for (ScopeNameMap::iterator it=s_s.m_nameMap.begin(); it!=s_s.m_nameMap.end(); ++it) {
	    const VerilatedScope* scopep = it->second;
	    scopep->scopeDump();
	}
	VL_PRINTF("\n");
    }

public: // But only for verilated*.cpp
    // METHODS - export names

    // Each function prototype is converted to a function number which we
    // then use to index a 2D table also indexed by scope number, because we
    // can't know at Verilation time what scopes will exist in other modules
    // in the design that also happen to have our same callback function.
    // Rather than a 2D map, the integer scheme saves 500ish ns on a likely
    // miss at the cost of a multiply, and all lookups move to slowpath.
    static int exportInsert(const char* namep) {
	// Slow ok - called once/function at creation
	ExportNameMap::iterator it=s_s.m_exportMap.find(namep);
	if (it == s_s.m_exportMap.end()) {
	    s_s.m_exportMap.insert(it, make_pair(namep, s_s.m_exportNext++));
	    return s_s.m_exportNext++;
	} else {
	    return it->second;
	}
    }
    static int exportFind(const char* namep) {
	ExportNameMap::iterator it=s_s.m_exportMap.find(namep);
	if (VL_LIKELY(it != s_s.m_exportMap.end())) return it->second;
	string msg = (string("%Error: Testbench C called ")+namep
		      +" but no such DPI export function name exists in ANY model");
	vl_fatal("unknown",0,"", msg.c_str());
	return -1;
    }
    static const char* exportName(int funcnum) {
	// Slowpath; find name for given export; errors only so no map to reverse-map it
	for (ExportNameMap::iterator it=s_s.m_exportMap.begin(); it!=s_s.m_exportMap.end(); ++it) {
	    if (it->second == funcnum) return it->first;
	}
	return "*UNKNOWN*";
    }
    // We don't free up m_exportMap until the end, because we can't be sure
    // what other models are using the assigned funcnum's.
};

#endif  // Guard
