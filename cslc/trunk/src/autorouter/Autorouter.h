//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/**
 * Author: Bogdan Zamfir <bogdanz@fplsrl.com>
 */

#ifndef __INC_GUARD_AUTOROUTER
#define __INC_GUARD_AUTOROUTER

#include "../cslom/CSLOM.h"
#include "../support/CommonSupport.h"
#include "CSLOM_InstTree.h"

namespace NSAutorouter {
     
typedef enum _EInstanceRel {
  REL_UNDEFINED = 3,
  REL_PC        = 0,
  REL_CP        = 1,
  REL_SS        = 2,
  REL_MAX       = 4
} EInstanceRel;

//Holds enum constants for signal relation types
typedef enum _Relation_Type {
  REL_SHIFT = 2,
  SIBLING_UNDEF = (REL_SS  << REL_SHIFT) | NSCSLOm::DIR_UNDEFINED,
  SIBLING_IN    = (REL_SS  << REL_SHIFT) | NSCSLOm::INPUT        ,
  SIBLING_OUT   = (REL_SS  << REL_SHIFT) | NSCSLOm::OUTPUT       ,
  SIBLING_INOUT = (REL_SS  << REL_SHIFT) | NSCSLOm::INOUT        ,
  PC_UNDEF      = (REL_PC  << REL_SHIFT) | NSCSLOm::DIR_UNDEFINED,
  PC_IN         = (REL_PC  << REL_SHIFT) | NSCSLOm::INPUT        ,
  PC_OUT        = (REL_PC  << REL_SHIFT) | NSCSLOm::OUTPUT       ,
  PC_INOUT      = (REL_PC  << REL_SHIFT) | NSCSLOm::INOUT        ,
  CP_UNDEF      = (REL_CP  << REL_SHIFT) | NSCSLOm::DIR_UNDEFINED,
  CP_IN         = (REL_CP  << REL_SHIFT) | NSCSLOm::INPUT        ,
  CP_OUT        = (REL_CP  << REL_SHIFT) | NSCSLOm::OUTPUT       ,
  CP_INOUT      = (REL_CP  << REL_SHIFT) | NSCSLOm::INOUT
} Relation_Type;

//Holds enum constants for unit relation types
typedef enum _Unit_Type {
  MP     ,
  MC     ,
  IA     ,
  IF     ,
  LOCAL
} Unit_Type;

//Holds enum constants for LHS_RHS types
typedef enum _LHS_RHS_Type {
  LH_MP_IN	    , // 
  LH_MP_OUT     ,
  LH_MP_INOUT	,
  LH_MC_IN      ,
  LH_MC_OUT     ,
  LH_MC_INOUT	,
  LH_IA_IN      ,
  LH_IA_OUT     ,
  LH_IA_INOUT	,
  LH_IF_IN      ,
  LH_IF_OUT     ,
  LH_IF_INOUT	,
  LH_LOCAL_LHS	,
  LH_LOCAL_RHS
} LHS_RHS_Type;

//Holds enum constants for signal direction types
typedef enum _Direction_Type {
  SHIFT = 2,
  //DOC: csl_autorouter.fm, Table 1.2 Row 0
  SIBLING_UNDEF_UNDEF  = (SIBLING_UNDEF << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  SIBLING_UNDEF_IN     = (SIBLING_UNDEF << SHIFT) | NSCSLOm::INPUT        ,
  SIBLING_UNDEF_OUT    = (SIBLING_UNDEF << SHIFT) | NSCSLOm::OUTPUT       ,
  SIBLING_UNDEF_INOUT  = (SIBLING_UNDEF << SHIFT) | NSCSLOm::INOUT        ,
  SIBLING_IN_UNDEF     = (SIBLING_IN    << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  SIBLING_IN_IN        = (SIBLING_IN    << SHIFT) | NSCSLOm::INPUT        ,
  SIBLING_IN_OUT       = (SIBLING_IN    << SHIFT) | NSCSLOm::OUTPUT       ,
  SIBLING_IN_INOUT     = (SIBLING_IN    << SHIFT) | NSCSLOm::INOUT        ,
  SIBLING_OUT_UNDEF    = (SIBLING_OUT   << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  SIBLING_OUT_IN       = (SIBLING_OUT   << SHIFT) | NSCSLOm::INPUT        ,
  SIBLING_OUT_OUT      = (SIBLING_OUT   << SHIFT) | NSCSLOm::OUTPUT       ,
  SIBLING_OUT_INOUT    = (SIBLING_OUT   << SHIFT) | NSCSLOm::INOUT        ,
  SIBLING_INOUT_UNDEF  = (SIBLING_INOUT << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  SIBLING_INOUT_IN     = (SIBLING_INOUT << SHIFT) | NSCSLOm::INPUT        ,
  SIBLING_INOUT_OUT    = (SIBLING_INOUT << SHIFT) | NSCSLOm::OUTPUT       ,
  SIBLING_INOUT_INOUT  = (SIBLING_INOUT << SHIFT) | NSCSLOm::INOUT        ,
  PC_UNDEF_UNDEF       = (PC_UNDEF      << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  PC_UNDEF_IN          = (PC_UNDEF      << SHIFT) | NSCSLOm::INPUT        ,
  PC_UNDEF_OUT         = (PC_UNDEF      << SHIFT) | NSCSLOm::OUTPUT       ,
  PC_UNDEF_INOUT       = (PC_UNDEF      << SHIFT) | NSCSLOm::INOUT        ,
  PC_IN_UNDEF          = (PC_IN         << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  PC_IN_IN             = (PC_IN         << SHIFT) | NSCSLOm::INPUT        ,
  PC_IN_OUT            = (PC_IN         << SHIFT) | NSCSLOm::OUTPUT       ,
  PC_IN_INOUT          = (PC_IN         << SHIFT) | NSCSLOm::INOUT        ,
  PC_OUT_UNDEF         = (PC_OUT        << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  PC_OUT_IN            = (PC_OUT        << SHIFT) | NSCSLOm::INPUT        ,
  PC_OUT_OUT           = (PC_OUT        << SHIFT) | NSCSLOm::OUTPUT       ,
  PC_OUT_INOUT         = (PC_OUT        << SHIFT) | NSCSLOm::INOUT        ,
  PC_INOUT_UNDEF       = (PC_INOUT      << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  PC_INOUT_IN          = (PC_INOUT      << SHIFT) | NSCSLOm::INPUT        ,
  PC_INOUT_OUT         = (PC_INOUT      << SHIFT) | NSCSLOm::OUTPUT       ,
  PC_INOUT_INOUT       = (PC_INOUT      << SHIFT) | NSCSLOm::INOUT        ,
  CP_UNDEF_UNDEF       = (CP_UNDEF      << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  CP_UNDEF_IN          = (CP_UNDEF      << SHIFT) | NSCSLOm::INPUT        ,
  CP_UNDEF_OUT         = (CP_UNDEF      << SHIFT) | NSCSLOm::OUTPUT       ,
  CP_UNDEF_INOUT       = (CP_UNDEF      << SHIFT) | NSCSLOm::INOUT        ,
  CP_IN_UNDEF          = (CP_IN         << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  CP_IN_IN             = (CP_IN         << SHIFT) | NSCSLOm::INPUT        ,
  CP_IN_OUT            = (CP_IN         << SHIFT) | NSCSLOm::OUTPUT       ,
  CP_IN_INOUT          = (CP_IN         << SHIFT) | NSCSLOm::INOUT        ,
  CP_OUT_UNDEF         = (CP_OUT        << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  CP_OUT_IN            = (CP_OUT        << SHIFT) | NSCSLOm::INPUT        ,
  CP_OUT_OUT           = (CP_OUT        << SHIFT) | NSCSLOm::OUTPUT       ,
  CP_OUT_INOUT         = (CP_OUT        << SHIFT) | NSCSLOm::INOUT        ,
  CP_INOUT_UNDEF       = (CP_INOUT      << SHIFT) | NSCSLOm::DIR_UNDEFINED,
  CP_INOUT_IN          = (CP_INOUT      << SHIFT) | NSCSLOm::INPUT        ,
  CP_INOUT_OUT         = (CP_INOUT      << SHIFT) | NSCSLOm::OUTPUT       ,
  CP_INOUT_INOUT       = (CP_INOUT      << SHIFT) | NSCSLOm::INOUT        ,
} DirectionType;

//Holds enum constants for signal connection types
typedef enum _LHS_RHS_Connect_Type {
  LR_SHIFT = 4,
  //csl_autorouter.fm. Table 1.5 Rows 0-2 and all columns
  //MP_MP connections
  // DOC: csl_autorouter.fm table: 1.5 row : 0
  IA_INOUT_IA_IN     =   (LH_IA_INOUT  << LR_SHIFT) | LH_IA_IN,
  IA_INOUT_IA_INOUT  =   (LH_IA_INOUT  << LR_SHIFT) | LH_IA_INOUT,
  IA_INOUT_IA_OUT    =   (LH_IA_INOUT  << LR_SHIFT) | LH_IA_OUT,
  IA_INOUT_IF_IN     =   (LH_IA_INOUT  << LR_SHIFT) | LH_IF_IN,
  IA_INOUT_IF_INOUT  =   (LH_IA_INOUT  << LR_SHIFT) | LH_IF_INOUT,
  IA_INOUT_IF_OUT    =   (LH_IA_INOUT  << LR_SHIFT) | LH_IF_OUT,
  IA_INOUT_LOCAL_LHS =   (LH_IA_INOUT  << LR_SHIFT) | LH_LOCAL_LHS,
  IA_INOUT_LOCAL_RHS =   (LH_IA_INOUT  << LR_SHIFT) | LH_LOCAL_RHS,
  IA_INOUT_MC_IN     =   (LH_IA_INOUT  << LR_SHIFT) | LH_MC_IN,
  IA_INOUT_MC_INOUT  =   (LH_IA_INOUT  << LR_SHIFT) | LH_MC_INOUT,
  IA_INOUT_MC_OUT    =   (LH_IA_INOUT  << LR_SHIFT) | LH_MC_OUT,
  IA_INOUT_MP_IN     =   (LH_IA_INOUT  << LR_SHIFT) | LH_MP_IN,
  IA_INOUT_MP_INOUT  =   (LH_IA_INOUT  << LR_SHIFT) | LH_MP_INOUT,
  IA_INOUT_MP_OUT    =   (LH_IA_INOUT  << LR_SHIFT) | LH_MP_OUT,
  IA_IN_IA_IN        =   (LH_IA_IN     << LR_SHIFT) | LH_IA_IN,
  IA_IN_IA_INOUT     =   (LH_IA_IN     << LR_SHIFT) | LH_IA_INOUT,
  IA_IN_IA_OUT       =   (LH_IA_IN     << LR_SHIFT) | LH_IA_OUT,
  IA_IN_IF_IN        =   (LH_IA_IN     << LR_SHIFT) | LH_IF_IN,
  IA_IN_IF_INOUT     =   (LH_IA_IN     << LR_SHIFT) | LH_IF_INOUT,
  IA_IN_IF_OUT       =   (LH_IA_IN     << LR_SHIFT) | LH_IF_OUT,
  IA_IN_LOCAL_LHS    =   (LH_IA_IN     << LR_SHIFT) | LH_LOCAL_LHS,
  IA_IN_LOCAL_RHS    =   (LH_IA_IN     << LR_SHIFT) | LH_LOCAL_RHS,
  IA_IN_MC_IN        =   (LH_IA_IN     << LR_SHIFT) | LH_MC_IN,
  IA_IN_MC_INOUT     =   (LH_IA_IN     << LR_SHIFT) | LH_MC_INOUT,
  IA_IN_MC_OUT       =   (LH_IA_IN     << LR_SHIFT) | LH_MC_OUT,
  IA_IN_MP_IN        =   (LH_IA_IN     << LR_SHIFT) | LH_MP_IN,
  IA_IN_MP_INOUT     =   (LH_IA_IN     << LR_SHIFT) | LH_MP_INOUT,
  IA_IN_MP_OUT       =   (LH_IA_IN     << LR_SHIFT) | LH_MP_OUT,
  IA_OUT_IA_IN       =   (LH_IA_OUT    << LR_SHIFT) | LH_IA_IN,
  IA_OUT_IA_INOUT    =   (LH_IA_OUT    << LR_SHIFT) | LH_IA_INOUT,
  IA_OUT_IA_OUT      =   (LH_IA_OUT    << LR_SHIFT) | LH_IA_OUT,
  IA_OUT_IF_IN       =   (LH_IA_OUT    << LR_SHIFT) | LH_IF_IN,
  IA_OUT_IF_INOUT    =   (LH_IA_OUT    << LR_SHIFT) | LH_IF_INOUT,
  IA_OUT_IF_OUT      =   (LH_IA_OUT    << LR_SHIFT) | LH_IF_OUT,
  IA_OUT_LOCAL_LHS   =   (LH_IA_OUT    << LR_SHIFT) | LH_LOCAL_LHS,
  IA_OUT_LOCAL_RHS   =   (LH_IA_OUT    << LR_SHIFT) | LH_LOCAL_RHS,
  IA_OUT_MC_IN       =   (LH_IA_OUT    << LR_SHIFT) | LH_MC_IN,
  IA_OUT_MC_INOUT    =   (LH_IA_OUT    << LR_SHIFT) | LH_MC_INOUT,
  IA_OUT_MC_OUT      =   (LH_IA_OUT    << LR_SHIFT) | LH_MC_OUT,
  IA_OUT_MP_IN       =   (LH_IA_OUT    << LR_SHIFT) | LH_MP_IN,
  IA_OUT_MP_INOUT    =   (LH_IA_OUT    << LR_SHIFT) | LH_MP_INOUT,
  IA_OUT_MP_OUT      =   (LH_IA_OUT    << LR_SHIFT) | LH_MP_OUT,
  IF_INOUT_IA_IN     =   (LH_IF_INOUT  << LR_SHIFT) | LH_IA_IN,
  IF_INOUT_IA_INOUT  =   (LH_IF_INOUT  << LR_SHIFT) | LH_IA_INOUT,
  IF_INOUT_IA_OUT    =   (LH_IF_INOUT  << LR_SHIFT) | LH_IA_OUT,
  IF_INOUT_IF_IN     =   (LH_IF_INOUT  << LR_SHIFT) | LH_IF_IN,
  IF_INOUT_IF_INOUT  =   (LH_IF_INOUT  << LR_SHIFT) | LH_IF_INOUT,
  IF_INOUT_IF_OUT    =   (LH_IF_INOUT  << LR_SHIFT) | LH_IF_OUT,
  IF_INOUT_LOCAL_LHS =   (LH_IF_INOUT  << LR_SHIFT) | LH_LOCAL_LHS,
  IF_INOUT_LOCAL_RHS =   (LH_IF_INOUT  << LR_SHIFT) | LH_LOCAL_RHS,
  IF_INOUT_MC_IN     =   (LH_IF_INOUT  << LR_SHIFT) | LH_MC_IN,
  IF_INOUT_MC_INOUT  =   (LH_IF_INOUT  << LR_SHIFT) | LH_MC_INOUT,
  IF_INOUT_MC_OUT    =   (LH_IF_INOUT  << LR_SHIFT) | LH_MC_OUT,
  IF_INOUT_MP_IN     =   (LH_IF_INOUT  << LR_SHIFT) | LH_MP_IN,
  IF_INOUT_MP_INOUT  =   (LH_IF_INOUT  << LR_SHIFT) | LH_MP_INOUT,
  IF_INOUT_MP_OUT    =   (LH_IF_INOUT  << LR_SHIFT) | LH_MP_OUT,
  IF_IN_IA_IN        =   (LH_IF_IN     << LR_SHIFT) | LH_IA_IN,
  IF_IN_IA_INOUT     =   (LH_IF_IN     << LR_SHIFT) | LH_IA_INOUT,
  IF_IN_IA_OUT       =   (LH_IF_IN     << LR_SHIFT) | LH_IA_OUT,
  IF_IN_IF_IN        =   (LH_IF_IN     << LR_SHIFT) | LH_IF_IN,
  IF_IN_IF_INOUT     =   (LH_IF_IN     << LR_SHIFT) | LH_IF_INOUT,
  IF_IN_IF_OUT       =   (LH_IF_IN     << LR_SHIFT) | LH_IF_OUT,
  IF_IN_LOCAL_LHS    =   (LH_IF_IN     << LR_SHIFT) | LH_LOCAL_LHS,
  IF_IN_LOCAL_RHS    =   (LH_IF_IN     << LR_SHIFT) | LH_LOCAL_RHS,
  IF_IN_MC_IN        =   (LH_IF_IN     << LR_SHIFT) | LH_MC_IN,
  IF_IN_MC_INOUT     =   (LH_IF_IN     << LR_SHIFT) | LH_MC_INOUT,
  IF_IN_MC_OUT       =   (LH_IF_IN     << LR_SHIFT) | LH_MC_OUT,
  IF_IN_MP_IN        =   (LH_IF_IN     << LR_SHIFT) | LH_MP_IN,
  IF_IN_MP_INOUT     =   (LH_IF_IN     << LR_SHIFT) | LH_MP_INOUT,
  IF_IN_MP_OUT       =   (LH_IF_IN     << LR_SHIFT) | LH_MP_OUT,
  IF_OUT_IA_IN       =   (LH_IF_OUT    << LR_SHIFT) | LH_IA_IN,
  IF_OUT_IA_INOUT    =   (LH_IF_OUT    << LR_SHIFT) | LH_IA_INOUT,
  IF_OUT_IA_OUT      =   (LH_IF_OUT    << LR_SHIFT) | LH_IA_OUT,
  IF_OUT_IF_IN       =   (LH_IF_OUT    << LR_SHIFT) | LH_IF_IN,
  IF_OUT_IF_INOUT    =   (LH_IF_OUT    << LR_SHIFT) | LH_IF_INOUT,
  IF_OUT_IF_OUT      =   (LH_IF_OUT    << LR_SHIFT) | LH_IF_OUT,
  IF_OUT_LOCAL_LHS   =   (LH_IF_OUT    << LR_SHIFT) | LH_LOCAL_LHS,
  IF_OUT_LOCAL_RHS   =   (LH_IF_OUT    << LR_SHIFT) | LH_LOCAL_RHS,
  IF_OUT_MC_IN       =   (LH_IF_OUT    << LR_SHIFT) | LH_MC_IN,
  IF_OUT_MC_INOUT    =   (LH_IF_OUT    << LR_SHIFT) | LH_MC_INOUT,
  IF_OUT_MC_OUT      =   (LH_IF_OUT    << LR_SHIFT) | LH_MC_OUT,
  IF_OUT_MP_IN       =   (LH_IF_OUT    << LR_SHIFT) | LH_MP_IN,
  IF_OUT_MP_INOUT    =   (LH_IF_OUT    << LR_SHIFT) | LH_MP_INOUT,
  IF_OUT_MP_OUT      =   (LH_IF_OUT    << LR_SHIFT) | LH_MP_OUT,
  LOCAL_LHS_IA_IN    =   (LH_LOCAL_LHS << LR_SHIFT) | LH_IA_IN,
  LOCAL_LHS_IA_INOUT =   (LH_LOCAL_LHS << LR_SHIFT) | LH_IA_INOUT,
  LOCAL_LHS_IA_OUT   =   (LH_LOCAL_LHS << LR_SHIFT) | LH_IA_OUT,
  LOCAL_LHS_IF_IN    =   (LH_LOCAL_LHS << LR_SHIFT) | LH_IF_IN,
  LOCAL_LHS_IF_INOUT =   (LH_LOCAL_LHS << LR_SHIFT) | LH_IF_INOUT,
  LOCAL_LHS_IF_OUT   =   (LH_LOCAL_LHS << LR_SHIFT) | LH_IF_OUT,
  LOCAL_LHS_LOCAL_LHS=   (LH_LOCAL_LHS << LR_SHIFT) | LH_LOCAL_LHS,
  LOCAL_LHS_LOCAL_RHS=   (LH_LOCAL_LHS << LR_SHIFT) | LH_LOCAL_RHS,
  LOCAL_LHS_MC_IN    =   (LH_LOCAL_LHS << LR_SHIFT) | LH_MC_IN,
  LOCAL_LHS_MC_INOUT =   (LH_LOCAL_LHS << LR_SHIFT) | LH_MC_INOUT,
  LOCAL_LHS_MC_OUT   =   (LH_LOCAL_LHS << LR_SHIFT) | LH_MC_OUT,
  LOCAL_LHS_MP_IN    =   (LH_LOCAL_LHS << LR_SHIFT) | LH_MP_IN,
  LOCAL_LHS_MP_INOUT =   (LH_LOCAL_LHS << LR_SHIFT) | LH_MP_INOUT,
  LOCAL_LHS_MP_OUT   =   (LH_LOCAL_LHS << LR_SHIFT) | LH_MP_OUT,
  LOCAL_RHS_IA_IN    =   (LH_LOCAL_RHS << LR_SHIFT) | LH_IA_IN,
  LOCAL_RHS_IA_INOUT =   (LH_LOCAL_RHS << LR_SHIFT) | LH_IA_INOUT,
  LOCAL_RHS_IA_OUT   =   (LH_LOCAL_RHS << LR_SHIFT) | LH_IA_OUT,
  LOCAL_RHS_IF_IN    =   (LH_LOCAL_RHS << LR_SHIFT) | LH_IF_IN,
  LOCAL_RHS_IF_INOUT =   (LH_LOCAL_RHS << LR_SHIFT) | LH_IF_INOUT,
  LOCAL_RHS_IF_OUT   =   (LH_LOCAL_RHS << LR_SHIFT) | LH_IF_OUT,
  LOCAL_RHS_LOCAL_LHS=   (LH_LOCAL_RHS << LR_SHIFT) | LH_LOCAL_LHS,
  LOCAL_RHS_LOCAL_RHS=   (LH_LOCAL_RHS << LR_SHIFT) | LH_LOCAL_RHS,
  LOCAL_RHS_MC_IN    =   (LH_LOCAL_RHS << LR_SHIFT) | LH_MC_IN,
  LOCAL_RHS_MC_INOUT =   (LH_LOCAL_RHS << LR_SHIFT) | LH_MC_INOUT,
  LOCAL_RHS_MC_OUT   =   (LH_LOCAL_RHS << LR_SHIFT) | LH_MC_OUT,
  LOCAL_RHS_MP_IN    =   (LH_LOCAL_RHS << LR_SHIFT) | LH_MP_IN,
  LOCAL_RHS_MP_INOUT =   (LH_LOCAL_RHS << LR_SHIFT) | LH_MP_INOUT,
  LOCAL_RHS_MP_OUT   =   (LH_LOCAL_RHS << LR_SHIFT) | LH_MP_OUT,
  MC_INOUT_IA_IN     =   (LH_MC_INOUT  << LR_SHIFT) | LH_IA_IN,
  MC_INOUT_IA_INOUT  =   (LH_MC_INOUT  << LR_SHIFT) | LH_IA_INOUT,
  MC_INOUT_IA_OUT    =   (LH_MC_INOUT  << LR_SHIFT) | LH_IA_OUT,
  MC_INOUT_IF_IN     =   (LH_MC_INOUT  << LR_SHIFT) | LH_IF_IN,
  MC_INOUT_IF_INOUT  =   (LH_MC_INOUT  << LR_SHIFT) | LH_IF_INOUT,
  MC_INOUT_IF_OUT    =   (LH_MC_INOUT  << LR_SHIFT) | LH_IF_OUT,
  MC_INOUT_LOCAL_LHS =   (LH_MC_INOUT  << LR_SHIFT) | LH_LOCAL_LHS,
  MC_INOUT_LOCAL_RHS =   (LH_MC_INOUT  << LR_SHIFT) | LH_LOCAL_RHS,
  MC_INOUT_MC_IN     =   (LH_MC_INOUT  << LR_SHIFT) | LH_MC_IN,
  MC_INOUT_MC_INOUT  =   (LH_MC_INOUT  << LR_SHIFT) | LH_MC_INOUT,
  MC_INOUT_MC_OUT    =   (LH_MC_INOUT  << LR_SHIFT) | LH_MC_OUT,
  MC_INOUT_MP_IN     =   (LH_MC_INOUT  << LR_SHIFT) | LH_MP_IN,
  MC_INOUT_MP_INOUT  =   (LH_MC_INOUT  << LR_SHIFT) | LH_MP_INOUT,
  MC_INOUT_MP_OUT    =   (LH_MC_INOUT  << LR_SHIFT) | LH_MP_OUT,
  MC_IN_IA_IN        =   (LH_MC_IN     << LR_SHIFT) | LH_IA_IN,
  MC_IN_IA_INOUT     =   (LH_MC_IN     << LR_SHIFT) | LH_IA_INOUT,
  MC_IN_IA_OUT       =   (LH_MC_IN     << LR_SHIFT) | LH_IA_OUT,
  MC_IN_IF_IN        =   (LH_MC_IN     << LR_SHIFT) | LH_IF_IN,
  MC_IN_IF_INOUT     =   (LH_MC_IN     << LR_SHIFT) | LH_IF_INOUT,
  MC_IN_IF_OUT       =   (LH_MC_IN     << LR_SHIFT) | LH_IF_OUT,
  MC_IN_LOCAL_LHS    =   (LH_MC_IN     << LR_SHIFT) | LH_LOCAL_LHS,
  MC_IN_LOCAL_RHS    =   (LH_MC_IN     << LR_SHIFT) | LH_LOCAL_RHS,
  MC_IN_MC_IN        =   (LH_MC_IN     << LR_SHIFT) | LH_MC_IN,
  MC_IN_MC_INOUT     =   (LH_MC_IN     << LR_SHIFT) | LH_MC_INOUT,
  MC_IN_MC_OUT       =   (LH_MC_IN     << LR_SHIFT) | LH_MC_OUT,
  MC_IN_MP_IN        =   (LH_MC_IN     << LR_SHIFT) | LH_MP_IN,
  MC_IN_MP_INOUT     =   (LH_MC_IN     << LR_SHIFT) | LH_MP_INOUT,
  MC_IN_MP_OUT       =   (LH_MC_IN     << LR_SHIFT) | LH_MP_OUT,
  MC_OUT_IA_IN       =   (LH_MC_OUT    << LR_SHIFT) | LH_IA_IN,
  MC_OUT_IA_INOUT    =   (LH_MC_OUT    << LR_SHIFT) | LH_IA_INOUT,
  MC_OUT_IA_OUT      =   (LH_MC_OUT    << LR_SHIFT) | LH_IA_OUT,
  MC_OUT_IF_IN       =   (LH_MC_OUT    << LR_SHIFT) | LH_IF_IN,
  MC_OUT_IF_INOUT    =   (LH_MC_OUT    << LR_SHIFT) | LH_IF_INOUT,
  MC_OUT_IF_OUT      =   (LH_MC_OUT    << LR_SHIFT) | LH_IF_OUT,
  MC_OUT_LOCAL_LHS   =   (LH_MC_OUT    << LR_SHIFT) | LH_LOCAL_LHS,
  MC_OUT_LOCAL_RHS   =   (LH_MC_OUT    << LR_SHIFT) | LH_LOCAL_RHS,
  MC_OUT_MC_IN       =   (LH_MC_OUT    << LR_SHIFT) | LH_MC_IN,
  MC_OUT_MC_INOUT    =   (LH_MC_OUT    << LR_SHIFT) | LH_MC_INOUT,
  MC_OUT_MC_OUT      =   (LH_MC_OUT    << LR_SHIFT) | LH_MC_OUT,
  MC_OUT_MP_IN       =   (LH_MC_OUT    << LR_SHIFT) | LH_MP_IN,
  MC_OUT_MP_INOUT    =   (LH_MC_OUT    << LR_SHIFT) | LH_MP_INOUT,
  MC_OUT_MP_OUT      =   (LH_MC_OUT    << LR_SHIFT) | LH_MP_OUT,
  MP_INOUT_IA_IN     =   (LH_MP_INOUT  << LR_SHIFT) | LH_IA_IN,
  MP_INOUT_IA_INOUT  =   (LH_MP_INOUT  << LR_SHIFT) | LH_IA_INOUT,
  MP_INOUT_IA_OUT    =   (LH_MP_INOUT  << LR_SHIFT) | LH_IA_OUT,
  MP_INOUT_IF_IN     =   (LH_MP_INOUT  << LR_SHIFT) | LH_IF_IN,
  MP_INOUT_IF_INOUT  =   (LH_MP_INOUT  << LR_SHIFT) | LH_IF_INOUT,
  MP_INOUT_IF_OUT    =   (LH_MP_INOUT  << LR_SHIFT) | LH_IF_OUT,
  MP_INOUT_LOCAL_LHS =   (LH_MP_INOUT  << LR_SHIFT) | LH_LOCAL_LHS,
  MP_INOUT_LOCAL_RHS =   (LH_MP_INOUT  << LR_SHIFT) | LH_LOCAL_RHS,
  MP_INOUT_MC_IN     =   (LH_MP_INOUT  << LR_SHIFT) | LH_MC_IN,
  MP_INOUT_MC_INOUT  =   (LH_MP_INOUT  << LR_SHIFT) | LH_MC_INOUT,
  MP_INOUT_MC_OUT    =   (LH_MP_INOUT  << LR_SHIFT) | LH_MC_OUT,
  MP_INOUT_MP_IN     =   (LH_MP_INOUT  << LR_SHIFT) | LH_MP_IN,
  MP_INOUT_MP_INOUT  =   (LH_MP_INOUT  << LR_SHIFT) | LH_MP_INOUT,
  MP_INOUT_MP_OUT    =   (LH_MP_INOUT  << LR_SHIFT) | LH_MP_OUT,
  MP_IN_IA_IN        =   (LH_MP_IN     << LR_SHIFT) | LH_IA_IN,
  MP_IN_IA_INOUT     =   (LH_MP_IN     << LR_SHIFT) | LH_IA_INOUT,
  MP_IN_IA_OUT       =   (LH_MP_IN     << LR_SHIFT) | LH_IA_OUT,
  MP_IN_IF_IN        =   (LH_MP_IN     << LR_SHIFT) | LH_IF_IN,
  MP_IN_IF_INOUT     =   (LH_MP_IN     << LR_SHIFT) | LH_IF_INOUT,
  MP_IN_IF_OUT       =   (LH_MP_IN     << LR_SHIFT) | LH_IF_OUT,
  MP_IN_LOCAL_LHS    =   (LH_MP_IN     << LR_SHIFT) | LH_LOCAL_LHS,
  MP_IN_LOCAL_RHS    =   (LH_MP_IN     << LR_SHIFT) | LH_LOCAL_RHS,
  MP_IN_MC_IN        =   (LH_MP_IN     << LR_SHIFT) | LH_MC_IN,
  MP_IN_MC_INOUT     =   (LH_MP_IN     << LR_SHIFT) | LH_MC_INOUT,
  MP_IN_MC_OUT       =   (LH_MP_IN     << LR_SHIFT) | LH_MC_OUT,
  MP_IN_MP_IN        =   (LH_MP_IN     << LR_SHIFT) | LH_MP_IN,
  MP_IN_MP_INOUT     =   (LH_MP_IN     << LR_SHIFT) | LH_MP_INOUT,
  MP_IN_MP_OUT       =   (LH_MP_IN     << LR_SHIFT) | LH_MP_OUT,
  MP_OUT_IA_IN       =   (LH_MP_OUT    << LR_SHIFT) | LH_IA_IN,
  MP_OUT_IA_INOUT    =   (LH_MP_OUT    << LR_SHIFT) | LH_IA_INOUT,
  MP_OUT_IA_OUT      =   (LH_MP_OUT    << LR_SHIFT) | LH_IA_OUT,
  MP_OUT_IF_IN       =   (LH_MP_OUT    << LR_SHIFT) | LH_IF_IN,
  MP_OUT_IF_INOUT    =   (LH_MP_OUT    << LR_SHIFT) | LH_IF_INOUT,
  MP_OUT_IF_OUT      =   (LH_MP_OUT    << LR_SHIFT) | LH_IF_OUT,
  MP_OUT_LOCAL_LHS   =   (LH_MP_OUT    << LR_SHIFT) | LH_LOCAL_LHS,
  MP_OUT_LOCAL_RHS   =   (LH_MP_OUT    << LR_SHIFT) | LH_LOCAL_RHS,
  MP_OUT_MC_IN       =   (LH_MP_OUT    << LR_SHIFT) | LH_MC_IN,
  MP_OUT_MC_INOUT    =   (LH_MP_OUT    << LR_SHIFT) | LH_MC_INOUT,
  MP_OUT_MC_OUT      =   (LH_MP_OUT    << LR_SHIFT) | LH_MC_OUT,
  MP_OUT_MP_IN       =   (LH_MP_OUT    << LR_SHIFT) | LH_MP_IN,
  MP_OUT_MP_INOUT    =   (LH_MP_OUT    << LR_SHIFT) | LH_MP_INOUT,
  MP_OUT_MP_OUT      =   (LH_MP_OUT    << LR_SHIFT) | LH_MP_OUT,
} LHS_RHS_Connect_Type;

//class definition section
class CAutorouter;
class CAutorouterScope;
class ConnectionEndPoint;
class Connection;

//reference class declaration section
typedef boost::shared_ptr<CAutorouter>               RefCAutorouter;
typedef boost::shared_ptr<CAutorouterScope>          RefCAutorouterScope;
typedef boost::shared_ptr<ConnectionEndPoint>        RefConnectionEndPoint;
typedef boost::shared_ptr<Connection>                RefConnection;

typedef boost::weak_ptr<CAutorouter>                 WeakCAutorouter;
typedef boost::weak_ptr<CAutorouterScope>            WeakCAutorouterScope;
typedef boost::weak_ptr<ConnectionEndPoint>          WeakConnectionEndPoint;
typedef boost::weak_ptr<Connection>                  WeakConnection;

typedef std::vector<RefConnection>                   TVec_RefConnection;  // vector of RefConnection
typedef TVec_RefConnection::const_iterator           TVec_RefConnection_const_iter;
typedef boost::shared_ptr<TVec_RefConnection>        RefTVec_RefConnection;

struct less_RefCSLOmExprLink {
    TBool operator() (const NSCSLOm::RefCSLOmExprLink& s1, const NSCSLOm::RefCSLOmExprLink& s2) const;
};

typedef std::map<NSCSLOm::RefCSLOmExprLink, RefCAutorouterScope, less_RefCSLOmExprLink> TMap_RefCSLOmExprLink_RefCAutorouterScope;
typedef boost::shared_ptr<TMap_RefCSLOmExprLink_RefCAutorouterScope> RefTMap_RefCSLOmExprLink_RefCAutorouterScope;
//TBool exprLinkEqual(RefCSLOmExprLink, RefCSLOmExprLink);

// ********************************************************************************
// CAutorouterScope class
// ********************************************************************************
class CAutorouterScope {
  private:
    NSCSLOm::RefCSLOmExprLink m_scopeLink;
    NSCSLOm::RefCSLOmUnitInstance m_scopePtr;
    NSCInstTree::RefCInstTreeNode m_scopeNode;
    WeakCAutorouterScope m_weakRef;

    static RefTMap_RefCSLOmExprLink_RefCAutorouterScope m_scopeCache;

    CAutorouterScope(TLineNumberType, RefString);
    RefCAutorouterScope getThis() { return m_weakRef.lock(); }
  public:
    static RefCAutorouterScope build(TLineNumberType, RefString, NSCSLOm::RefCSLOmExprLink);

    NSCSLOm::RefCSLOmExprLink     getScopeLink() const { return m_scopeLink; }
    NSCSLOm::RefCSLOmUnitInstance getScopePtr () const { return m_scopePtr ; }
    NSCInstTree::RefCInstTreeNode getScopeNode() const { return m_scopeNode; }
};

// ********************************************************************************
// ConnectionEndPoint class
// ********************************************************************************
class ConnectionEndPoint {
  private:
    TLineNumberType m_lineNumber;
    RefString m_fileName;
    NSCSLOm::RefCSLOmExprLink m_endPointLink;
    NSCSLOm::RefCSLOmExpr m_endPointExpr;
    NSCInstTree::RefCInstTreeNode m_postProcessNode;
    NSCSLOm::RefCSLOmConnectable m_endPoint;
    RefTVec_RefString m_interfaceNames;
    RefTVec_RefString m_endPointIfcNames;
    TBool m_wasSignal;

    RefString m_prefix;
    RefString m_ifcName;
    TUInt m_lvl;

    ConnectionEndPoint(TLineNumberType, RefString);


  public:
    static RefConnectionEndPoint build(TLineNumberType, RefString, NSCSLOm::RefCSLOmExprLink, RefString = RefString(), TUInt = -1);
    static RefConnectionEndPoint build(TLineNumberType, RefString, NSCSLOm::RefCSLOmExpr, RefString = RefString(), TUInt = -1);
    TBool genPort(TLineNumberType lineNumber, RefString fileName, NSCSLOm::ECSLOmPortDirection dir = NSCSLOm::DIR_UNDEFINED);
    
    TBool hasPrefix() { return m_prefix != RefString() ; }
    TBool hasExpr() { return m_endPointExpr != NSCSLOm::RefCSLOmExpr() ; }

    void processExpr(NSCSLOm::ECSLOmPortDirection);
    void processLink(TBool isEndPointParam = FALSE);
    /*****************/
    /* API functions */
    /*****************/
    TBool wasSignal() { return m_wasSignal; }

    RefTVec_RefString getInterfaceNames () { return m_interfaceNames; }
    RefTVec_RefString getEndPointIfcNames () { return m_endPointIfcNames; }
    void removeInterfaceNames () { m_interfaceNames = RefTVec_RefString(); }

    const TLineNumberType getLineNumber() const {
      return m_lineNumber;
    }

    const RefString getFileName() const {
      return m_fileName;
    }

    const NSCInstTree::RefCInstTreeNode getPostProcessNode() const {
      return m_postProcessNode;
    }

    const NSCSLOm::RefCSLOmExprLink getLink() const {
      ASSERT(m_endPointLink.get(), "link to endpoint null"); 
      return m_endPointLink;
    }

    const NSCSLOm::RefCSLOmConnectable getEndPoint() const {
      ASSERT(m_endPoint.get(), "endpoint null"); 
      return m_endPoint;
    }
};

// ********************************************************************************
// Connection class
// ********************************************************************************
class Connection {
  private:
    static RefTVec_RefConnection m_connectionMap;

    TLineNumberType m_lineNumber;
    RefString m_fileName;
    RefConnectionEndPoint m_endPoint1;
    RefConnectionEndPoint m_endPoint2;

    RefString m_interName;

    RefTVec_TLong m_routePath;
    NSCInstTree::RefCInstTreeNode m_NCA;

    Connection(TLineNumberType, RefString);
  public:
    static RefConnection build(TLineNumberType, RefString, RefConnectionEndPoint, RefConnectionEndPoint, RefString = RefString());

    NSCSLOm::RefCSLOmConnectable create(NSCInstTree::RefCInstTreeNode, NSCSLOm::RefCSLOmPortDecl, EInstanceRel, RefString, RefTVec_RefString = RefTVec_RefString());
    
    static TBool lookup(NSCSLOm::RefCSLOmExprLink, NSCSLOm::RefCSLOmExprLink, NSCSLOm::RefCSLOmUnitDecl, RefString, RefTVec_RefString);
    static void addConnection(NSCSLOm::RefCSLOmExpr, NSCSLOm::RefCSLOmExpr, RefString = RefString(), TBool = TRUE);
    static void addConnectionPort(NSCSLOm::RefCSLOmExpr, NSCSLOm::RefCSLOmExpr, RefString, TBool = FALSE, TBool = FALSE, TInt = -1);
    static TBool addConnectionInterface(NSCSLOm::RefCSLOmExprLink, NSCSLOm::RefCSLOmExprLink, RefString, TBool, TBool, TInt);
    static TBool addConnectionSignalGroup(NSCSLOm::RefCSLOmExprLink, NSCSLOm::RefCSLOmExprLink, RefString);

    void process();

    RefString getInterName() { return m_interName; }
    
    TLineNumberType getLineNumber() {
      return m_lineNumber;
    }

    RefString getFileName() {
      return m_fileName;
    }

    RefTVec_TLong getRoutePath() {
      return m_routePath;
    }
    
    NSCInstTree::RefCInstTreeNode getNCA() {
      return m_NCA;
    }

    static const RefTVec_RefConnection getConnectionMap() {
      return m_connectionMap;
    }

    const RefConnectionEndPoint getEndPoint1() const {
      ASSERT(m_endPoint1.get(), "endpoint not set");
      return m_endPoint1;
    }

    const RefConnectionEndPoint getEndPoint2() const {
      ASSERT(m_endPoint2.get(), "endpoint not set");
      return m_endPoint2;
    }
};


// ------------------------------------------------------
// |              CAutorouter class                     |
// ------------------------------------------------------
class CAutorouter {
  private:
    friend class ConnectionEndPoint;
    friend class Connection;

    LHS_RHS_Connect_Type m_connectType;
    NSCInstTree::RefCInstTreeNode m_root;
    static NSCSLOm::RefCSLOmExprLink m_lastName;

    static RefString getRelName(RefConnection, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode, EInstanceRel);
    static TBool check(RefConnection, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode, EInstanceRel);
    static TBool checkRelationshipSignalSignal(TInt);
    static TBool checkBitRangeSignalSignal(TLineNumberType, RefString, NSCSLOm::RefCSLOmConnectable, NSCSLOm::RefCSLOmConnectable, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode, NSCSLOm::RefCSLOmExprLink = NSCSLOm::RefCSLOmExprLink(), NSCSLOm::RefCSLOmExprLink = NSCSLOm::RefCSLOmExprLink());
    static NSCSLOm::RefCSLOmConnectable existsPort(NSCInstTree::RefCInstTreeNode, const RefString&, NSCInstTree::RefCInstTreeNode, RefTVec_RefString = RefTVec_RefString(), TLineNumberType lineNumber = 0, RefString fileName = RefString(), TBool = FALSE);
    static NSCSLOm::RefCSLOmExprLink buildExprLink(NSCSLOm::RefCSLOmConnectable, RefTVec_RefString = RefTVec_RefString(), RefString = RefString(), NSCInstTree::RefCInstTreeNode = NSCInstTree::RefCInstTreeNode(), TBool = FALSE);
    static TBool createConnection(RefConnection, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode, EInstanceRel);
    static TBool createSibSibConnection(RefConnection, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode);
    static TBool createCPConnection(RefConnection, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode);
    static TBool createPCConnection(RefConnection, NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode);
    static NSCSLOm::RefCSLOmInterface buildInterfaces(TLineNumberType, RefString, NSCSLOm::RefCSLOmUnitDecl, RefTVec_RefString, NSCInstTree::RefCInstTreeNode);
    static NSCSLOm::RefCSLOmGroupSignal buildSignalGroups(TLineNumberType, RefString, NSCSLOm::RefCSLOmUnitDecl, RefTVec_RefString, NSCInstTree::RefCInstTreeNode);
  protected:
  public:
//     CAutorouter(NSCInstTree::RefCInstTreeNode);
//     //void connect(RefCPortNode port1, RefCPortNode port2);
//     /**
//      * This method computes the NCA (LH_Nearest Common Ancester) path between
//      * two endpoint insts in the Inst Tree.
//      * @endPoint1 The starting point of the path
//      * @endPoint2 The ending point of the path
//      */
//     ~CAutorouter() {};

    static RefTVec_TLong getNumHid(NSCInstTree::RefCInstTreeNode node);

    static TLong getNCA(NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode);
    static RefTVec_TLong getARPath(NSCInstTree::RefCInstTreeNode, NSCInstTree::RefCInstTreeNode);

    static void traverseSegments(RefConnection);
    static TBool routeSegments(RefConnection, TLong, TLong, EInstanceRel);
    
    static void startAutoRouter();
    TBool lookUP(TLong, TLong);




};

} //end of namespace NSAutorouter


#endif //__INC_GUARD_AUTOROUTER
