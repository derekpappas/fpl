//----------------------------------------------------------------------
// Copyright (c) 2006 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/*
 *   Part of the Verilog parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

header "post_include_hpp"
    {
    #include <string>
    
    #include "Def.hpp"
    #include "VerilogNumber.hpp"
    #include "VerAST.hpp"
    #include "Tools.hpp"
    #include "../../support/CommonSupport.h"
    #include "../../cdom/CDOM.h"

//    #include "cdom/RefCount.h"

    ANTLR_USING_NAMESPACE(std);
    ANTLR_USING_NAMESPACE(antlr);
    ANTLR_USING_NAMESPACE(NSCdom);
    }

options
    {
    language="Cpp";
    genHashLines = true;
    }

{
ANTLR_USING_NAMESPACE(antlr);
#include "../../support/CommonSupport.h"

#define _RS(str) (RefString(new string(str)))

#include <iostream>

//#define __PRINT_AST

#ifdef __PRINT_AST

#define PRINT_AST(x) printAST(x)

#else

#define PRINT_AST(x)

#endif

void VerilogTreeWalker::printAST(RefVerAST ast)
    {
    cout << "Found " << getTokenName(ast->getType())
         << " '" << ast->getText()
         << "'"
         << " <"
         << ast->getLine() << ":"
         << ast->getColumn()
         << ">"
         << endl;
    }

}

class VerilogTreeWalker extends TreeParser;

options {
    //codeGenDebug = false;
    k = 1;
    importVocab = VerilogParser;
    ASTLabelType = "RefVerAST";
    defaultErrorHandler = false;
}

{
//void VerilogTreeWalker::printAST(RefVerAST ast);
void printAST(RefVerAST ast);
}

//PRIORITY 5
// A.1.3 Module and primitive source text
source_text [RefCDOmDesign design] :
    (description[design])*
    ;

//since the description rule reads the attrColl, 
//module and udp_declaration should get the attrColl referince
//in order to build their instances with them
description [RefCDOmDesign design]
  {
    RefCDOmAttrListCollection attrColl;
  }
: attrColl=attrs_opt
  ( module[design, attrColl]
  | udp_declaration[design, attrColl]
  )
;

module [RefCDOmDesign design, RefCDOmAttrListCollection attrColl]
  {
    pair<RefString, int> name; //Modified by Eugen, name type should be RefString
    RefCDOmModuleDecl moduleDecl;
    CDOmModuleDecl::EKeywordType kw;
  }
: #(mod:MODULE_DEF
    //{ cout << "#" << mod->getLine() << endl; }
    (  K_MODULE { kw = CDOmModuleDecl::KEYWORD_MODULE; }
    |  K_MACROMODULE { kw = CDOmModuleDecl::KEYWORD_MACROMODULE; }
    )
    name=identifier
    {
      moduleDecl = design->buildModuleDecl(#mod->getLine(), name.first, kw);
      if(attrColl.get()) moduleDecl->setAttrListCollection(attrColl);
    }
    ( module_parameter_port_list[moduleDecl])?
    ( list_of_port_declarations[moduleDecl]
    | list_of_ports[moduleDecl]
      // If there is only one empty port in the list, that means
      // there are no ports at all
    )?
    (module_item[moduleDecl])*
  )
;

//PRIORITY 5
// A.1.4 Module parameters and ports
module_parameter_port_list [RefCDOmModuleDecl moduleDecl] 
  { 
    RefCDOmParamDeclCollection declColl; 
    RefCDOmAttrHolder attrHolder;
  }
: #(mppl:MODULE_PARAMETER_PORT_LIST
    { 
      moduleDecl->buildParamDeclCollection(#mppl->getLine()); 
      declColl = moduleDecl->getParamDeclCollection();
    }
    /* Even though parameter declaration is a attribute holde, in this case it doesn't support this behaviour */
    (attrHolder = parameter_declaration[declColl])+ //added left value to avoid warning
  )
;

list_of_ports [RefCDOmModuleDecl moduleDecl] 
: (port[moduleDecl])+
;

list_of_port_declarations [RefCDOmBase parent] 
  { 
    RefCDOmAttrListCollection attrListColl;
    RefCDOmPortDecl portDecl;
  }
: #(LIST_OF_PORT_DECLARATIONS 
    ( attrListColl=attrs_opt 
      portDecl=port_declaration[parent]
      { if(attrListColl.get()) portDecl->setAttrListCollection(attrListColl); }
    )+
  )
;

port [RefCDOmModuleDecl moduleDecl]
  { RefCDOmPortItem portItem; }
: #( pt:PORT 
    ( port_expression [moduleDecl, RefString()]
    | named_port_expression[moduleDecl]
    | // Empty port
      { portItem = moduleDecl->buildPortItem(#pt->getLine(), CDOmPortItem::PORT_ITEM_EMPTY); }
    )
  ) // port may be empty
  { PRINT_AST(#PORT); }
;

named_port_expression [RefCDOmModuleDecl moduleDecl]
{ pair<RefString, int> named; }
: #(NAMED_PORT_EXPRESSION named=identifier port_expression[moduleDecl, named.first])
;

port_expression [RefCDOmModuleDecl moduleDecl, const RefString named]
: #( pe:PORT_EXPRESSION 
    ( port_reference [ moduleDecl->buildPortItem(#pe->getLine(),  CDOmPortItem::PORT_ITEM_SIMPLE, named) ]
    | port_reference_concat [ moduleDecl->buildPortItem(#pe->getLine(),  CDOmPortItem::PORT_ITEM_CONCAT, named) ]
    )
  )
  { PRINT_AST(#PORT_EXPRESSION); }
;

port_reference_concat [RefCDOmPortItem portItem] :
    #(PORT_REFERENCE_CONCAT (port_reference[portItem])+)
    { PRINT_AST(#PORT_REFERENCE_CONCAT); }
    ;

port_reference [RefCDOmPortItem portItem]
  {
    pair<RefString, int> name;
    RefCDOmRangeExpr rangeExpr;
  }
: #(pr:PORT_REFERENCE name=identifier (rangeExpr=range_expression)?)
    {
      RefCDOmExprLink exprLink = CDOmExprLink::build(#pr->getLine(), name.first);
      if( rangeExpr.get() )
        exprLink->setRangeExpr(rangeExpr);
      portItem->addPortExprLink(exprLink);
    }
;

port_declaration [RefCDOmBase parent] returns [RefCDOmPortDecl returned]
: returned=inout_declaration [ parent ]
| returned=input_declaration [ parent ]
| returned=output_declaration[ parent ]
;

//PRIORITY 5
// A.1.5 Module items
module_item [RefCDOmModuleDecl moduleDecl] 
  {
    RefCDOmAttrHolder attrHolder;
    RefCDOmAttrListCollection attrListColl;
  }
: attrListColl=attrs_opt
  ( attrHolder=port_declaration            [ moduleDecl ]
  | attrHolder=module_or_generate_item     [ moduleDecl ]
  | attrHolder=local_parameter_declaration [ moduleDecl ]
  | attrHolder=parameter_declaration       [ moduleDecl ]
  | attrHolder=specparam_declaration       [ moduleDecl ]
  )
  { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
| ( specify_block               [ moduleDecl ]
  | generated_instantiation     [ moduleDecl ]
  )
;

module_or_generate_item [RefCDOmBase parent] returns [RefCDOmAttrHolder returned]
: returned=module_or_generate_item_declaration [ parent ]
| returned=parameter_override                  [ parent ]
| returned=continuous_assign                   [ parent ] 
| returned=gate_instantiation                  [ parent ]
| returned=module_or_udp_instantiation         [ parent ]
| returned=initial_construct                   [ parent ]
| returned=always_construct                    [ parent ]
;

module_or_generate_item_declaration [RefCDOmBase parent] returns [RefCDOmAttrHolder returned]
: returned=net_declaration      [ parent ]
| returned=reg_declaration      [ parent ]
| returned=integer_declaration  [ parent ]
| returned=real_declaration     [ parent ]
| returned=time_declaration     [ parent ]
| returned=realtime_declaration [ parent ]
| returned=event_declaration    [ parent ]
| returned=genvar_declaration   [ parent ]
| returned=task_declaration     [ parent ]
| returned=function_declaration [ parent ]
;

parameter_override [ RefCDOmBase parent ] returns [ RefCDOmParamOverride returnedParamOverride ]
  {
    RefCDOmMinTypMax minTypMax;
    RefCDOmExprLink exprLink;
  }
: #(K_DEFPARAM
    ( #(da:DEFPARAM_ASSIGNMENT
        exprLink=hierarchical_identifier 
        minTypMax=mintypmax_expression
        { returnedParamOverride = CDOmParamOverride::build(#da->getLine(),  parent, exprLink, minTypMax ); }
      )
    )
    ( #(DEFPARAM_ASSIGNMENT
        exprLink=hierarchical_identifier 
        minTypMax=mintypmax_expression
        { returnedParamOverride->addParamAssn( exprLink, minTypMax ); }
      )
    )*
  )
;

//PRIORITY 5
// A.2 Declarations
// A.2.1 Declaration types
// A.2.1.1 Module parameter declarations
local_parameter_declaration [RefCDOmBase parent] returns [RefCDOmParamDecl returnedParamDecl]
  {
    TBool sgn = FALSE;
    RefCDOmRange rng;
    CDOmParamDecl::EParamType paramType = CDOmParamDecl::PARAM_NA;
  }
: #(lp:K_LOCALPARAM
    (
      (K_SIGNED { sgn = TRUE; })?
      (rng=range)?
      {
        returnedParamDecl = CDOmParamDecl::build(#lp->getLine(), parent, CDOmParamDecl::PARAM_DECL_LOCAL);
        if (sgn)
            returnedParamDecl->setSigned();
        if (rng.get() != NULL)
            returnedParamDecl->setRange(rng);
      }
    | paramType=parameter_type
      { returnedParamDecl = CDOmParamDecl::build(#lp->getLine(), parent, CDOmParamDecl::PARAM_DECL_LOCAL, paramType); }
    )
    list_of_param_assignments[returnedParamDecl]
  )
  { PRINT_AST(#K_LOCALPARAM); }
;

parameter_declaration [RefCDOmBase parent] returns [RefCDOmParamDecl returnedParamDecl]
  {
    TBool sgn = FALSE;
    RefCDOmRange rng;
    CDOmParamDecl::EParamType paramType = CDOmParamDecl::PARAM_NA;
  }
: #(pr:K_PARAMETER
    ( (K_SIGNED { sgn = TRUE; })?
      (rng=range)?
      {
        returnedParamDecl = CDOmParamDecl::build(#pr->getLine(), parent, CDOmParamDecl::PARAM_DECL_SIMPLE);
        if (sgn)
          returnedParamDecl->setSigned();
        if (rng.get() != NULL)
          returnedParamDecl->setRange(rng);
      }
    | paramType=parameter_type
      { returnedParamDecl = CDOmParamDecl::build(#pr->getLine(), parent, CDOmParamDecl::PARAM_DECL_SIMPLE, paramType); }
    )
    list_of_param_assignments[returnedParamDecl]
  )
  { PRINT_AST(#K_PARAMETER); }
;

specparam_declaration [RefCDOmBase parent] returns [RefCDOmParamDecl paramDecl]
  {
    RefCDOmRange rng;
  }
: #(sp:K_SPECPARAM
    { 
      paramDecl = CDOmParamDecl::build(#sp->getLine(),  parent, CDOmParamDecl::PARAM_DECL_SPEC); 
    }
    ( rng=range
      { paramDecl->setRange(rng); }
    )?
    list_of_specparam_assignments[paramDecl]
  )
  { PRINT_AST(#K_SPECPARAM); }
;

parameter_type returns [CDOmParamDecl::EParamType paramType] 
: K_INTEGER  { paramType = CDOmParamDecl::PARAM_INTEGER ; }
| K_REAL     { paramType = CDOmParamDecl::PARAM_REAL    ; }
| K_REALTIME { paramType = CDOmParamDecl::PARAM_REALTIME; }
| K_TIME     { paramType = CDOmParamDecl::PARAM_TIME    ; }
;

//PRIORITY 5
// A.2.1.2 Port declarations
inout_declaration [RefCDOmBase parent] returns [RefCDOmPortDecl portDecl]
  {
    pair<RefString, int> name;
    ECDOmNetType nt = NET_UNDEFINED;
    TBool sgn = FALSE;
    RefCDOmRange rng;
  }
: #( ino:K_INOUT 
      (nt=net_type)?
      (K_SIGNED { sgn = TRUE; })?
      (rng=range)?
      {
        portDecl = CDOmPortDecl::buildNetPortDecl(#ino->getLine(),  parent, PORT_INOUT, nt);
        if (sgn)
          portDecl->setSigned();
        if (rng.get() != NULL)
          portDecl->setRange(rng);
      }
      ( name=identifier
        { portDecl->addPort(name.second, name.first); }
      )+
  )
;

input_declaration [RefCDOmBase parent] returns [RefCDOmPortDecl portDecl]
  {
    pair<RefString, int> name;
    ECDOmNetType nt = NET_UNDEFINED;
    TBool sgn = FALSE;
    RefCDOmRange rng;
  }
: #( inpt:K_INPUT 
    (nt=net_type)?
    (K_SIGNED { sgn = TRUE; })?
    (rng=range)?
    {
      portDecl = CDOmPortDecl::buildNetPortDecl(#inpt->getLine(),  parent, PORT_INPUT, nt);
      if (sgn)
          portDecl->setSigned();
      if (rng.get() != NULL)
          portDecl->setRange(rng);
    }
    (name=identifier
      {
        portDecl->addPort(name.second, name.first);
      }
    )+
  )
  { PRINT_AST(#K_INPUT); }
;

output_declaration [RefCDOmBase parent] returns [RefCDOmPortDecl portDecl]
  {
    pair<RefString, int> name;
    ECDOmNetType nt = NET_UNDEFINED;
    ECDOmVarType vt = VAR_UNDEFINED;
    TBool sgn = FALSE;
    RefCDOmRange rng;
    RefCDOmExpr expr;
  }
: #( out:K_OUTPUT 
    (
      (nt=net_type)?
      (K_SIGNED { sgn = TRUE; })?
      (rng=range)?
      {
        portDecl = CDOmPortDecl::buildNetPortDecl(#out->getLine(), parent, PORT_OUTPUT, nt);
        if (sgn)
            portDecl->setSigned();
        if (rng.get() != NULL)
            portDecl->setRange(rng);
      }
      (name=identifier
        {
          portDecl->addPort(name.second, name.first);
        }
      )+
    | ( K_REG { vt = VAR_REG; }
        (K_SIGNED { sgn = TRUE; })?
        (rng=range)?
      | vt=output_variable_type
      )
      {
        portDecl = CDOmPortDecl::buildVarPortDecl(#out->getLine(), parent, vt);
        if (sgn)
          portDecl->setSigned();
        if (rng.get() != NULL)
          portDecl->setRange(rng);
      }
      ( name=identifier
        { portDecl->addPort(name.second, name.first); }
      | #( VARIABLE_PORT_IDENTIFIER
          name=identifier
          expr=expression // constant expression
          {
            portDecl->addPort(name.second, name.first, expr);
          }
        )
      )+
    )
  )
  { PRINT_AST(#K_OUTPUT); }
;

//PRIORITY 5
// A.2.1.3 Type declaration
integer_declaration [RefCDOmBase parent] returns [RefCDOmVarDecl returnedVarDecl]
: #( int_:K_INTEGER 
    { returnedVarDecl = CDOmVarDecl::build(#int_->getLine(), parent, VAR_INTEGER); }
    list_of_variable_identifiers[returnedVarDecl]
  )
  { PRINT_AST(#K_INTEGER); }
;

real_declaration [RefCDOmBase parent] returns [RefCDOmVarDecl returnedVarDecl]
: #(rl:K_REAL 
    { returnedVarDecl = CDOmVarDecl::build(#rl->getLine(), parent, VAR_REAL); }
    list_of_variable_identifiers[returnedVarDecl]
  )
;

//PRIORITY 3
time_declaration [RefCDOmBase parent] returns [RefCDOmVarDecl returnedVarDecl]
: #(tm:K_TIME 
    { returnedVarDecl = CDOmVarDecl::build(#tm->getLine(), parent, VAR_TIME); }
    list_of_variable_identifiers[returnedVarDecl]
  )
;
//PRIORITY 3
realtime_declaration [RefCDOmBase parent] returns [ RefCDOmVarDecl returnedVarDecl ]
: #(rt:K_REALTIME 
    { returnedVarDecl = CDOmVarDecl::build(#rt->getLine(), parent, VAR_REALTIME); }
    list_of_variable_identifiers[returnedVarDecl]
  )
;

reg_declaration [RefCDOmBase parent] returns [RefCDOmVarDecl returnedVarDecl]
  {
    TBool sgn = FALSE;
    RefCDOmRange rng = RefCDOmRange();
  }
: #(rg:K_REG 
    (K_SIGNED {sgn = TRUE;})?
    (rng=range)?
    {
      returnedVarDecl = CDOmVarDecl::build(#rg->getLine(), parent, VAR_REG);
      if (sgn)
         returnedVarDecl->setSigned();
      if (rng.get() != NULL)
         returnedVarDecl->setRange(rng);
    }
    list_of_variable_identifiers[returnedVarDecl]
  )
  { PRINT_AST(#K_REG); }
;

net_declaration [RefCDOmBase parent] returns [ RefCDOmNetDecl netDecl ]
  {
    ECDOmNetType nt = NET_UNDEFINED;
    ECDOmDriveStrength ds1, ds2;
    CDOmNetDecl::EChargeStrength cs;
    CDOmNetDecl::EVectorAccessType vat = CDOmNetDecl::VECTOR_ACCESS_UNDEFINED;
    RefCDOmRange rng;
  }
: #(ndecl:NET_DECLARATION
    ( nt=net_type
      { netDecl = CDOmNetDecl::build(#ndecl->getLine(), parent, nt); }
      (drive_strength[ds1, ds2] { netDecl->setDriveStrength(ds1, ds2); } )?
      (vat=expandrange)?
      (K_SIGNED { netDecl->setSigned(); } )?
      (rng=range { netDecl->setRange(rng, vat); })?
      (delay3[netDecl])?
      list_of_net_identifiers_or_decl_assignments[netDecl]
    | trirg:K_TRIREG // Maybe it is better to merge these 2 alternatives
      {
        nt = NET_TRIREG;
        netDecl = CDOmNetDecl::build(#trirg->getLine(), parent, nt);
      }
      ( cs=charge_strength { netDecl->setChargeStrength(cs); }
      | drive_strength[ds1, ds2] { netDecl->setDriveStrength(ds1, ds2); }
      )?
      (vat=expandrange)?
      (K_SIGNED { netDecl->setSigned(); } )?
      (rng=range { netDecl->setRange(rng, vat); } )?
      (delay3[netDecl])?
      list_of_net_identifiers_or_decl_assignments[netDecl]
    )
  )
  { PRINT_AST(#NET_DECLARATION); }
;

expandrange returns [CDOmNetDecl::EVectorAccessType vat] 
: K_VECTORED { vat = CDOmNetDecl::VECTOR_ACCESS_VECTORED; }
| K_SCALARED { vat = CDOmNetDecl::VECTOR_ACCESS_SCALARED; }
;

//PRIORITY 2
event_declaration [RefCDOmBase parent] returns [RefCDOmEventDecl returnedEventDecl]
: #(ev:K_EVENT 
    //The returned object is being built in the list_of_event_identifiers rule
    list_of_event_identifiers [ returnedEventDecl, parent, #ev->getLine() ]
  )
  { PRINT_AST(#K_EVENT); }
;

//PRIORITY 1
genvar_declaration [ RefCDOmBase parent ] returns [RefCDOmGenvarDecl returned]
: #(K_GENVAR returned=list_of_genvar_identifiers [ parent ] )
  // the genVar object is created in the list_of_genvar_identifiers rule using the information in that rule to create the object
  { PRINT_AST(#K_GENVAR); }
;

// A.2.2 Declaration data types
//PRIORITY 5
// A.2.2.1 Net and variable types
net_type returns [ECDOmNetType res] 
: K_SUPPLY0 { res = NET_SUPPLY0; }
| K_SUPPLY1 { res = NET_SUPPLY1; }
| K_TRI     { res = NET_TRI    ; }
| K_TRIAND  { res = NET_TRIAND ; }
| K_TRIOR   { res = NET_TRIOR  ; }
| K_TRI0    { res = NET_TRI0   ; }
| K_TRI1    { res = NET_TRI1   ; }
| K_WIRE    { res = NET_WIRE   ; }
| K_WAND    { res = NET_WAND   ; }
| K_WOR     { res = NET_WOR    ; }
;

output_variable_type returns [ECDOmVarType res]
: K_INTEGER { res = VAR_INTEGER; }
| K_TIME    { res = VAR_TIME   ; }
;

variable_type [RefCDOmVarDecl varDecl]
  {
    pair<RefString, int> name;
    RefCDOmExpr expr;
    RefCDOmRangeList rangeList = RefCDOmRangeList();
  }
: #(vt:VARIABLE_TYPE
    name=identifier
    ( ( rangeList=list_of_dimensions )?
      { varDecl->addVar((unsigned long)#vt->getLine(), name.first, rangeList); }
    | expr=expression
      { varDecl->addVar((unsigned long)#vt->getLine(), name.first, expr); }
    )
  )
;

//PRIORITY 1
// A.2.2.2 Strengths
drive_strength [ECDOmDriveStrength& ds1, ECDOmDriveStrength& ds2]
: ( ds1=strength0 
  ( ds2=strength1 
  | ds2=highz1
  )
| ds1=strength1 
  ( ds2=strength0 
  | ds2=highz0
  )
| ds1=highz0 
  ds2=strength1
| ds1=highz1 
  ds2=strength0
)
;

strength0 returns [ECDOmDriveStrength s0]
: K_SUPPLY0 { s0 = DRIVE_STRENGTH_SUPPLY_0; }
| K_STRONG0 { s0 = DRIVE_STRENGTH_STRONG_0; }
| K_PULL0   { s0 = DRIVE_STRENGTH_PULL_0  ; }
| K_WEAK0   { s0 = DRIVE_STRENGTH_WEAK_0  ; }
;

strength1 returns [ECDOmDriveStrength s1]
: K_SUPPLY1 { s1 = DRIVE_STRENGTH_SUPPLY_1; }
| K_STRONG1 { s1 = DRIVE_STRENGTH_STRONG_1; }
| K_PULL1   { s1 = DRIVE_STRENGTH_PULL_1  ; }
| K_WEAK1   { s1 = DRIVE_STRENGTH_WEAK_1  ; }
;

highz0 returns [ECDOmDriveStrength hz0] 
: K_HIGHZ0  { hz0 = DRIVE_STRENGTH_HIGHZ_0; }
;

highz1 returns [ECDOmDriveStrength hz1] 
: K_HIGHZ1  { hz1 = DRIVE_STRENGTH_HIGHZ_1; }
;

charge_strength returns [CDOmNetDecl::EChargeStrength cs]
: K_SMALL  { cs = CDOmNetDecl::CHARGE_STRENGTH_SMALL ; }
| K_MEDIUM { cs = CDOmNetDecl::CHARGE_STRENGTH_MEDIUM; }
| K_LARGE  { cs = CDOmNetDecl::CHARGE_STRENGTH_LARGE ; }
;

//PRIORITY 1
// A.2.2.3 Delays
delay3 [RefCDOmBase delayHolder]
  {
    RefCDOmExpr expr;
    RefCDOmMinTypMax minTypMax;
    bool fatal = false;
    RefCDOmDelay delay;
  }
: #(dl:DELAY
    {
      switch(delayHolder->getType()) {
        case TYPE_GATE_INSTANTIATION:
          (boost::static_pointer_cast<CDOmGateInstantiation>(delayHolder))->buildDelay(#dl->getLine());
          delay = (boost::static_pointer_cast<CDOmGateInstantiation>(delayHolder))->getDelay();
          break;
        case TYPE_CONT_ASSN:
          (boost::static_pointer_cast<CDOmContAssn>(delayHolder))->buildDelay3(#dl->getLine());
          delay = (boost::static_pointer_cast<CDOmContAssn>(delayHolder))->getDelay3();
          break;
        case TYPE_NET_DECL:
          (boost::static_pointer_cast<CDOmNetDecl>(delayHolder))->buildDelay3(#dl->getLine());
          delay = (boost::static_pointer_cast<CDOmNetDecl>(delayHolder))->getDelay3();
          break;
        default:
          fatal = true;
      }
    }
    { !fatal }?
    ( expr=delay_value 
      { 
        switch(expr->getExprType()) {
          case CDOmExpr::EXPR_NUMBER : 
            delay->setNumDelayValue( boost::static_pointer_cast<CDOmNumber>(expr) );
            break;
          case CDOmExpr::EXPR_REAL_NUMBER :
            delay->setRealNumDelayValue( boost::static_pointer_cast<CDOmReal>(expr) );
            break;
          case CDOmExpr::EXPR_HID :
            delay->setExprLink( boost::static_pointer_cast<CDOmExprLink>(expr) );
            break;
          default :
            fatal = true;
        }
      }
      {!fatal}?
    | minTypMax=mintypmax_expression { delay->addMinTypMax(minTypMax); }
      (minTypMax=mintypmax_expression { delay->addMinTypMax(minTypMax); }
        (minTypMax=mintypmax_expression { delay->addMinTypMax(minTypMax); })?
      )?
    )
  )
  { PRINT_AST(#DELAY); }
;

delay2 [RefCDOmModuleOrUdpInstantiation delayHolder]
  {
    RefCDOmExpr expr;
    RefCDOmMinTypMax minTypMax;
    RefCDOmDelay delay;
    bool delay2FATAL = true;
  }
: #(dl:DELAY
  {
    delayHolder->buildDelay2(#dl->getLine());
    delay = delayHolder->getDelay2();
  }
    ( expr=delay_value 
      { 
        switch(expr->getExprType()) {
          case CDOmExpr::EXPR_NUMBER:
            delay->setNumDelayValue(boost::static_pointer_cast<CDOmNumber>(expr));
            break;
          case CDOmExpr::EXPR_REAL_NUMBER:
            delay->setRealNumDelayValue(boost::static_pointer_cast<CDOmReal>(expr));
            break;
          case CDOmExpr::EXPR_HID:
            delay->setExprLink(boost::static_pointer_cast<CDOmExprLink>(expr));
            break;
          default:
            delay2FATAL = false;
        }
      }
      { delay2FATAL }?
    | minTypMax=mintypmax_expression { delay->addMinTypMax(minTypMax); }
      (minTypMax=mintypmax_expression { delay->addMinTypMax(minTypMax); }
      )?
    )
  )
  { PRINT_AST(#DELAY); }
;

delay_value returns [RefCDOmExpr returnedExpr] 
  {
    CCDOMAdapter adapter = CCDOMAdapter::getInstance();
    pair<RefString, int> str;
  }
: #(dv:DELAY_VALUE
      ( un:UNSIGNED_NUMBER
        { returnedExpr = adapter.convertToCDOmNumberFrom_UNSIGNED_NUMBER(#un->getLine(), #un->getNumber()); }
      | un1:REAL_NUMBER
        { returnedExpr = adapter.convertToCDOmRealFrom_REAL_NUMBER(#un1->getLine(), #un1->getNumber()); }
      | str=identifier
        { returnedExpr = CDOmExprLink::build(str.second, str.first); }
      )
  )
  { PRINT_AST(#DELAY_VALUE); }
;

//PRIORITY 5
// A.2.3 Declaration lists
list_of_net_identifiers_or_decl_assignments [RefCDOmNetDecl netDecl]
  {
    pair<RefString, int> name;
    RefCDOmRangeList rangeList;
    RefCDOmExpr expr;
  }
: #(LIST_OF_NET_IDENTIFIERS
    ( name=identifier  
      { rangeList = RefCDOmRangeList(); } 
      (rangeList=list_of_dimensions)?
      { netDecl->addNet(name.second, name.first, rangeList); }
    )+
  )
| #(LIST_OF_NET_DECL_ASSIGNMENTS
    (name=identifier expr=expression
      { netDecl->addNet(name.second, name.first, expr); }
    )+
  )
;

//PRIORITY 2
list_of_event_identifiers [ RefCDOmEventDecl &eventDecl, RefCDOmBase parent, int lineNumber]
  {
    RefCDOmRangeList rangeList;
    RefCDOmRange range;
    pair<RefString, int> str;
  }
: ( str=identifier { rangeList = RefCDOmRangeList(  ); }
    ( range=dimension 
      {
        if( rangeList.get() )
          rangeList->addItem( range );
        else
          rangeList = CDOmRangeList::build(range->getLineNumber(),  range );
      }
    )*
    { eventDecl = CDOmEventDecl::build(str.second,  parent, str.first, rangeList ); }
  )
  ( str=identifier { rangeList = RefCDOmRangeList(  ); }
    ( range=dimension 
      {
        if( rangeList.get() )
          rangeList->addItem( range );
        else
          rangeList = CDOmRangeList::build(range->getLineNumber(),  range );
      }
    )*
    { eventDecl->addEvent(str.second,  str.first, rangeList ); }
  )*
;

list_of_genvar_identifiers [ RefCDOmBase parent ] returns [RefCDOmGenvarDecl genvarDecl]
  { pair<RefString, int> name; }
: ( name=identifier { genvarDecl = CDOmGenvarDecl::build(name.second,  parent, name.first ); } )
  ( name=identifier { genvarDecl->addGenvar(name.second,  name.first ); } )*
;

list_of_param_assignments [RefCDOmParamDecl paramDecl]
: (param_assignment[paramDecl])+
;

list_of_variable_identifiers [RefCDOmVarDecl varDecl]
: (variable_type[varDecl])+
;

//PRIORITY 1
list_of_specparam_assignments [RefCDOmParamDecl paramDecl]
: (param_assignment[paramDecl] 
| pulse_control_specparam[paramDecl])+
;

//PRIORITY 1
pulse_control_specparam [ RefCDOmParamDecl paramDecl ]
  {
    RefCDOmRangeExpr rng1 = RefCDOmRangeExpr(  );
    RefCDOmRangeExpr rng2 = RefCDOmRangeExpr(  );
    RefCDOmMinTypMax minTypMax1;
    RefCDOmMinTypMax minTypMax2 = RefCDOmMinTypMax(  );
    pair<RefString, int> str1(RefString(  ), 0);
    pair<RefString, int> str2(RefString(  ), 0);
    RefCDOmExprLink exprLink1, exprLink2;
  }
: #(pcs:PULSE_CONTROL_SPECPARAM
    ( 
      str1=identifier
      ( rng1=range_expression )?
      { 
        exprLink1 = CDOmExprLink::build(str1.second,  str1.first );
        if( rng1.get() )
          exprLink1->setRangeExpr( rng1 );
      }
      str2=identifier
      ( rng2=range_expression )?
      { 
        exprLink2 = CDOmExprLink::build(str2.second,  str2.first );
        if( rng2.get() )
          exprLink2->setRangeExpr( rng2 );
      }
    )? // constant_range_expression // specify_input_terminal_descriptor
    ASSIGN // '='
    minTypMax1=mintypmax_expression // reject_limit_value
    ( minTypMax2=mintypmax_expression )? //error_limit_value
    {
      if( exprLink1.get() )
        paramDecl->addPulseControl(#pcs->getLine(), exprLink1, exprLink2, minTypMax1, minTypMax2 );
      else
        paramDecl->addPulseControl(#pcs->getLine(), minTypMax1, minTypMax2 );
    }
  )
;

//PRIORITY 4
// A.2.4 Declaration assignments

param_assignment [RefCDOmParamDecl paramDecl]
  {
    pair<RefString, int> name;
    RefCDOmMinTypMax minTypMax;
  }
: #( PARAM_ASSIGNMENT
    name=identifier
    minTypMax=mintypmax_expression // constant expression, may be mintypmax only
  )
  { paramDecl->addParam(name.second, name.first, minTypMax); }
;

//PRIORITY 5
// A.2.5 Declaration ranges

// Range and dimension have a similar structure
// is it necessary to handle them separately?

dimension returns [RefCDOmRange rng]
  { RefCDOmExpr lsb, msb; }
: #(dim:DIMENSION
    lsb=expression // constant expression
    msb=expression // constant expression
  )
  { rng = CDOmRange::build(#dim->getLine(), lsb, msb); }
;

list_of_dimensions returns [RefCDOmRangeList rangeList]
  { RefCDOmRange rng; }
: ( rng=dimension 
    { rangeList = CDOmRangeList::build(rng->getLineNumber(), rng); }
  )
  ( rng=dimension
    { rangeList->addItem(rng); }
  )*
;

range returns [RefCDOmRange rng]
  { RefCDOmExpr lsb, msb; }
: #(rn:RANGE
    lsb=expression // constant expression
    msb=expression // constant expression
  )
  {
    rng = CDOmRange::build(#rn->getLine(), lsb, msb);
    PRINT_AST(#RANGE);
  }
;

list_of_ranges returns [RefCDOmRangeList rangeList]
  { RefCDOmRange rng; }
: ( rng=range 
    { rangeList = CDOmRangeList::build(rng->getLineNumber(), rng); }
  )
  ( rng=range
    { rangeList->addItem(rng); }
  )*
;


//PRIORITY 4
// A.2.6 Function declaration
function_declaration [RefCDOmBase parent] returns [ RefCDOmFuncDecl returnedFuncDecl ]
  {
    bool acceptNext = true;
    bool isAutomatic = false, isSigned = false;
    RefCDOmAttrListCollection attrListColl;
    pair<RefString, int> name;
    RefCDOmRange my_range=RefCDOmRange();
    RefCDOmAttrHolder attrHolder;
    ECDOmVarType varType = VAR_UNDEFINED;
    RefCDOmStmt stmt;
  }
: #(K_FUNCTION
    (K_AUTOMATIC { isAutomatic = true; } )?
    (K_SIGNED    { isSigned    = true; } )? 
    ( my_range=range
    | K_INTEGER { varType = VAR_INTEGER ; } 
    | K_REAL    { varType = VAR_REAL    ; }  
    | K_REALTIME{ varType = VAR_REALTIME; }   
    | K_TIME    { varType = VAR_TIME    ; } 
    )?
    name=identifier
    ( { 
        returnedFuncDecl = CDOmFuncDecl::build(name.second,  parent, CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST, name.first, isAutomatic, isSigned); 
        if( my_range.get() )
          returnedFuncDecl->setRange( my_range );
        else if( varType != VAR_UNDEFINED )
          returnedFuncDecl->setVarType( varType );
      }
      attrListColl=attrs_opt
      attrHolder=function_item_declaration[ returnedFuncDecl ]
      { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
      ( attrListColl=attrs_opt
        { acceptNext }?
        ( attrHolder=function_item_declaration[ returnedFuncDecl ]
          { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
        | stmt=statement 
          { 
           acceptNext = false;
           if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
           returnedFuncDecl->setFuncStmt( stmt );
          }
        )
      )*
    | { 
        returnedFuncDecl = CDOmFuncDecl::build(name.second,  parent, CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST, name.first, isAutomatic, isSigned); 
        if( my_range.get() )
          returnedFuncDecl->setRange( my_range );
        else if( varType != VAR_UNDEFINED )
          returnedFuncDecl->setVarType( varType );
      }
      function_port_list[ returnedFuncDecl ]
      ( attrListColl=attrs_opt 
        {acceptNext}?
        ( attrHolder=block_item_declaration[ returnedFuncDecl ]
          { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
        | stmt=statement 
          { 
            acceptNext = false;
            if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
            returnedFuncDecl->setFuncStmt( stmt );
          }
        )
      )*
    )
    { !acceptNext }?
  )
  { PRINT_AST(#K_FUNCTION); }
;

function_item_declaration [RefCDOmBase parent] returns [ RefCDOmAttrHolder  returnedAttrHolder ]
: returnedAttrHolder=block_item_declaration [ parent ]
| returnedAttrHolder=tf_input_declaration   [ parent ]
;

function_port_list [RefCDOmBase parent]
  {
    RefCDOmAttrListCollection attrListColl;
    RefCDOmAttrHolder attrHolder;
  }
: #(FUNCTION_PORT_LIST 
    ( attrListColl=attrs_opt 
      attrHolder=tf_input_declaration[ parent ]
      { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );}
    )+
  )
  { PRINT_AST(#FUNCTION_PORT_LIST); }
;

//PRIORITY 4
// A.2.7 Task declaration
task_declaration [RefCDOmBase parent] returns [ RefCDOmTaskDecl returnedTaskDecl ]
  { 
    RefCDOmAttrHolder attrHolder;
    pair<RefString, int> name;
    RefCDOmAttrListCollection attrListColl;
    RefCDOmStmt stmt;
    bool isAutomatic = false;
    bool acceptNext = true; 
  }
: #(K_TASK
    (K_AUTOMATIC { isAutomatic=true; } )?
    name=identifier
    ( 
      { returnedTaskDecl = CDOmTaskDecl::build(name.second,  parent, CDOmTaskDecl::TASK_DECL_WITH_TASK_PORT_LIST, name.first, isAutomatic); }
      task_port_list[ returnedTaskDecl ] 
    )?
    {
      if( !returnedTaskDecl.get() )
        returnedTaskDecl = CDOmTaskDecl::build(name.second,  parent, CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST, name.first, isAutomatic);
    }
    ( attrListColl=attrs_opt
      {acceptNext}?
      ( attrHolder=task_item_declaration[ returnedTaskDecl ] 
        { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
      | stmt=statement_or_null 
        { 
          acceptNext = false;
          if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
          returnedTaskDecl->setStmt( stmt );
        }
      )
    )* 
    // if you have port declarations here
    // task_port_list will not be presented
    // it is checked in parser
    {!acceptNext}?
  )
  { PRINT_AST(#K_TASK); }
;

task_item_declaration [ RefCDOmBase parent ] returns [ RefCDOmAttrHolder returnedAttrHolder ]
: returnedAttrHolder=block_item_declaration [ parent ]
| returnedAttrHolder=tf_input_declaration   [ parent ] 
| returnedAttrHolder=tf_output_declaration  [ parent ] 
| returnedAttrHolder=tf_inout_declaration   [ parent ] 
;

task_port_list [RefCDOmBase parent]
: #(TASK_PORT_LIST 
    ( task_port_item[ parent ] )+
  )
  { PRINT_AST(#TASK_PORT_LIST); }
;

task_port_item [RefCDOmBase parent]
  {
    RefCDOmAttrListCollection attrListColl;
    RefCDOmAttrHolder attrHolder;
  }
: attrListColl=attrs_opt
  ( attrHolder=tf_input_declaration  [ parent ] 
  | attrHolder=tf_output_declaration [ parent ] 
  | attrHolder=tf_inout_declaration  [ parent ] 
  )
  { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
;

tf_input_declaration [RefCDOmBase parent] returns [ RefCDOmTFPortDecl returned ]
  {
    ECDOmVarType varType=VAR_UNDEFINED;
    RefCDOmRange my_range;
    pair<RefString, int> str;
  }
: #(inpt:K_INPUT
    ( (K_REG { varType=VAR_REG; } )? 
      { returned = CDOmTFPortDecl::build(#inpt->getLine(),  parent, PORT_INPUT, varType); }
      (K_SIGNED { returned->setSigned(); } )? 
      (my_range=range { returned->setRange( my_range ); } )?
    | varType=task_port_type
      {
        returned = CDOmTFPortDecl::build(#inpt->getLine(),  parent, PORT_INPUT, varType);
      }
    )
    (str=identifier {returned->addPort(str.second,  str.first ); } )+
  )
  { PRINT_AST(#K_INPUT); }
;

tf_output_declaration [RefCDOmBase parent] returns [ RefCDOmTFPortDecl returned ]
  {
    ECDOmVarType varType=VAR_UNDEFINED;
    RefCDOmRange my_range;
    pair<RefString, int> str;
  }
: #(outpt:K_OUTPUT
    ( (K_REG { varType=VAR_REG; } )? 
      { returned = CDOmTFPortDecl::build(#outpt->getLine(),  parent, PORT_OUTPUT, varType); }
      (K_SIGNED { returned->setSigned(); } )? 
      (my_range=range { returned->setRange( my_range ); } )?
    | varType=task_port_type
      { returned = CDOmTFPortDecl::build(#outpt->getLine(),  parent, PORT_OUTPUT, varType); }
    )
    (str=identifier { returned->addPort(str.second,  str.first ); } )+
  )
  { PRINT_AST(#K_OUTPUT); }
;

tf_inout_declaration [RefCDOmBase parent] returns [ RefCDOmTFPortDecl returned ]
  {
    ECDOmVarType varType=VAR_UNDEFINED;
    RefCDOmRange my_range;
    pair<RefString, int> str;
  }
: #(inout:K_INOUT
    ( (K_REG { varType=VAR_REG; } )? 
      { returned = CDOmTFPortDecl::build(#inout->getLine(),  parent, PORT_INOUT, varType); }
      (K_SIGNED { returned->setSigned(); } )? 
      (my_range=range { returned->setRange( my_range ); } )?
    | varType=task_port_type
      {
        returned = CDOmTFPortDecl::build(#inout->getLine(),  parent, PORT_INOUT, varType);
      }
    )
    (str=identifier {returned->addPort(str.second,  str.first); } )+
  )
  { PRINT_AST(#K_INOUT); }
;

task_port_type returns [ ECDOmVarType returned ]
: K_INTEGER  { returned = VAR_INTEGER ; }  
| K_REAL     { returned = VAR_REAL    ; } 
| K_REALTIME { returned = VAR_REALTIME; }
| K_TIME     { returned = VAR_TIME    ; } 
;

//PRIORITY 5
// A.2.8 Block item declarations
block_item_declaration [RefCDOmBase parent] returns [ RefCDOmAttrHolder returnedAttrHolder ]
: returnedAttrHolder = reg_declaration             [ parent ]
| returnedAttrHolder = integer_declaration         [ parent ]
| returnedAttrHolder = time_declaration            [ parent ]
| returnedAttrHolder = real_declaration            [ parent ]
| returnedAttrHolder = realtime_declaration        [ parent ]
| returnedAttrHolder = event_declaration           [ parent ]
| returnedAttrHolder = local_parameter_declaration [ parent ]
| returnedAttrHolder = parameter_declaration       [ parent ]
;

//PRIORITY 3
// A.3 Primitive instances
// A.3.1 Primitive instantiation and instances
gate_instantiation [RefCDOmBase parent] returns [RefCDOmGateInstantiation gateInst]
  { 
    ECDOmDriveStrength ds1, ds2; 
    CDOmGateInstantiation::EPrimitiveType gateType;
  }
: #(gi:GATE_INSTANTIATION
    ( gateType=cmos_switchtype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      ( delay3[gateInst])? 
      (cmos_switch_instance [ gateInst ] )+
    | gateType=enable_gatetype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      (drive_strength[ds1, ds2] { gateInst->setDriveStrength(ds1, ds2); } )? 
      ( delay3[gateInst])? 
      (enable_gate_instance [ gateInst ] )+
    | gateType=mos_switchtype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      ( delay3[gateInst])? 
      (mos_switch_instance [ gateInst ] )+
    | gateType=n_input_gatetype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      (drive_strength[ds1, ds2] { gateInst->setDriveStrength(ds1, ds2); } )? 
      ( delay3[gateInst])? 
      (n_input_gate_instance [ gateInst ] )+
    | gateType=n_output_gatetype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      (drive_strength[ds1, ds2] { gateInst->setDriveStrength(ds1, ds2); } )? 
      ( delay3[gateInst])? 
      (n_output_gate_instance [ gateInst ] )+
    | gateType=pass_enable_switchtype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      ( delay3[gateInst])? 
      (pass_enable_switch_instance [ gateInst ] )+
    | gateType=pass_switchtype 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, gateType); }
      (pass_switch_instance [ gateInst ] )+
    | K_PULLDOWN 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, CDOmGateInstantiation::GATE_INST_PULLDOWN); }
      (pulldown_strength [ gateInst ] )? 
      (pull_gate_instance [ gateInst ] )+
    | K_PULLUP 
      { gateInst = CDOmGateInstantiation::build(#gi->getLine(), parent, CDOmGateInstantiation::GATE_INST_PULLUP); }
      (pullup_strength [ gateInst ] )? 
      (pull_gate_instance [ gateInst ] )+
    )
  )
;

cmos_switch_instance [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(CMOS_SWITCH_INSTANCE
    (name_of_gate_instance [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    expr=expression { gateInst->addExpr( expr ); } 
    expr=expression { gateInst->addExpr( expr ); } 
    expr=expression { gateInst->addExpr( expr ); }
  )
  { PRINT_AST(#CMOS_SWITCH_INSTANCE); }
;

enable_gate_instance [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(ENABLE_GATE_INSTANCE
    (name_of_gate_instance [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    expr=expression { gateInst->addExpr( expr ); }
    expr=expression { gateInst->addExpr( expr ); }
  )
;

mos_switch_instance [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(MOS_SWITCH_INSTANCE
    (name_of_gate_instance [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    expr=expression { gateInst->addExpr( expr ); }
    expr=expression { gateInst->addExpr( expr ); }
  )
;

n_input_gate_instance [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(N_INPUT_GATE_INSTANCE
    (name_of_gate_instance [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    ( expr=expression { gateInst->addExpr( expr ); } )+
  )
;

n_output_gate_instance [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(N_OUTPUT_GATE_INSTANCE
    ( name_of_gate_instance [ gateInst ]  )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    ( expr=expression { gateInst->addExpr( expr ); } )+ // only last terminal is input (expression) // others must be output (lvalue)
  )
;

pass_enable_switch_instance  [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(PASS_ENABLE_SWITCH_INSTANCE
    ( name_of_gate_instance [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    expr=lvalue { gateInst->addLvalue( expr ); }
    expr=expression { gateInst->addExpr( expr ); }
  )
;

pass_switch_instance  [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(PASS_SWITCH_INSTANCE
    ( name_of_gate_instance  [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
    expr=lvalue { gateInst->addLvalue( expr ); }
  )
;

pull_gate_instance  [RefCDOmGateInstantiation gateInst]
  { RefCDOmExpr expr; } 
: #(PULL_GATE_INSTANCE
    ( name_of_gate_instance  [ gateInst ] )?
    expr=lvalue { gateInst->addLvalue( expr ); }
  )
;

name_of_gate_instance  [RefCDOmGateInstantiation gateInst]
  { 
    pair<RefString, int> id;
    RefCDOmRange rng = RefCDOmRange();
  }
: id=identifier 
  ( rng=range )?
  { gateInst->addID( id.first, rng ); }
;

// A.3.2 Primitive strengths
pulldown_strength  [RefCDOmGateInstantiation gateInst]
  { ECDOmDriveStrength streng1, streng2; TBool tst = TRUE; }
: streng1=strength0 
  ( streng2=strength1 { tst = FALSE; gateInst->setDriveStrength(streng1, streng2); } )?
  { if( tst ) gateInst->setSingleDriveStrength( streng1 ); }
| streng1=strength1 
  streng2=strength0
  { gateInst->setDriveStrength( streng1, streng2 ); }
;

pullup_strength  [RefCDOmGateInstantiation gateInst]
  { ECDOmDriveStrength streng1, streng2; TBool tst = TRUE; }
: streng1=strength0 
  streng2=strength1
  { gateInst->setDriveStrength( streng1, streng2 ); }
| streng1=strength1 
  ( streng2=strength0 { tst = FALSE; gateInst->setDriveStrength(streng1, streng2); } )?
  { if( tst ) gateInst->setSingleDriveStrength( streng1 ); }
;


// A.3.3 Primitive terminals
// Empty

// A.3.4 Primitive gate and switch types
cmos_switchtype returns [CDOmGateInstantiation::EPrimitiveType returned]
: K_CMOS { returned = CDOmGateInstantiation::GATE_INST_CMOS; }
| K_RCMOS { returned = CDOmGateInstantiation::GATE_INST_RCMOS; }
;

enable_gatetype returns [CDOmGateInstantiation::EPrimitiveType returned]
: K_BUFIF0 { returned = CDOmGateInstantiation::GATE_INST_BUFIF0; }
| K_BUFIF1 { returned = CDOmGateInstantiation::GATE_INST_BUFIF1; }
| K_NOTIF0 { returned = CDOmGateInstantiation::GATE_INST_NOTIF0; }
| K_NOTIF1 { returned = CDOmGateInstantiation::GATE_INST_NOTIF1; }
;

mos_switchtype returns [CDOmGateInstantiation::EPrimitiveType returned]
: K_NMOS { returned = CDOmGateInstantiation::GATE_INST_NMOS; } 
| K_PMOS { returned = CDOmGateInstantiation::GATE_INST_PMOS; } 
| K_RNMOS { returned = CDOmGateInstantiation::GATE_INST_RNMOS; } 
| K_RPMOS { returned = CDOmGateInstantiation::GATE_INST_RPMOS; }
;

n_input_gatetype returns [CDOmGateInstantiation::EPrimitiveType returned]
: K_AND { returned = CDOmGateInstantiation::GATE_INST_AND; }
| K_NAND { returned = CDOmGateInstantiation::GATE_INST_NAND; }
| K_OR { returned = CDOmGateInstantiation::GATE_INST_OR; }
| K_NOR { returned = CDOmGateInstantiation::GATE_INST_NOR; }
| K_XOR { returned = CDOmGateInstantiation::GATE_INST_XOR; }
| K_XNOR { returned = CDOmGateInstantiation::GATE_INST_XNOR; }
;

n_output_gatetype returns [CDOmGateInstantiation::EPrimitiveType returned] 
: K_BUF { returned = CDOmGateInstantiation::GATE_INST_BUF; }
| K_NOT { returned = CDOmGateInstantiation::GATE_INST_NOT; }
;

pass_enable_switchtype returns [CDOmGateInstantiation::EPrimitiveType returned]
: K_TRANIF0 { returned = CDOmGateInstantiation::GATE_INST_TRANIF0; }
| K_TRANIF1 { returned = CDOmGateInstantiation::GATE_INST_TRANIF1; }
| K_RTRANIF1 { returned = CDOmGateInstantiation::GATE_INST_RTRANIF1; }
| K_RTRANIF0 { returned = CDOmGateInstantiation::GATE_INST_RTRANIF0; }
;

pass_switchtype returns [CDOmGateInstantiation::EPrimitiveType returned]
: K_TRAN { returned = CDOmGateInstantiation::GATE_INST_TRAN; }
| K_RTRAN { returned = CDOmGateInstantiation::GATE_INST_RTRAN; }
;

// A.4 Module and generated instantiation
//PRIORITY 5
// A.4.1 Module instantiation
module_or_udp_instantiation [RefCDOmBase parent] returns [RefCDOmModuleOrUdpInstantiation returnedModuleInstantiation]
  { 
    ECDOmDriveStrength ds1, ds2;
    pair<RefString, int> str;
    RefCDOmExprLink exprLink;
  }
: #(MODULE_OR_UDP_INSTANTIATION
    str=identifier
    { returnedModuleInstantiation = CDOmModuleOrUdpInstantiation::build(str.second,  parent, CDOmExprLink::build(str.second, str.first) ); }
    (drive_strength[ds1, ds2] { returnedModuleInstantiation->setDriveStrength(ds1, ds2); } )? // added for UDP
    (parameter_value_assignment_or_delay2[returnedModuleInstantiation])? // delay2 for UDP
    ( module_instance[returnedModuleInstantiation] )+
  )
;

parameter_value_assignment_or_delay2 [RefCDOmModuleOrUdpInstantiation moduleInstantiation]
: list_of_parameter_assignments_or_delay2[moduleInstantiation]
| delay2[moduleInstantiation]
;

list_of_parameter_assignments_or_delay2 [RefCDOmModuleOrUdpInstantiation moduleInstantiation]
  {
    RefCDOmMinTypMax minTypMax;
    RefString str;
  }
: #(LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2
    ( (minTypMax=mintypmax_expression
        { moduleInstantiation->addOrderedParamAssn( minTypMax ); }
      )+
    | (named_parameter_assignment[str, minTypMax]
        { moduleInstantiation->addNamedParamAssn( str, minTypMax ); }
      )+
    )
  )
;

named_parameter_assignment [RefString &str, RefCDOmMinTypMax &minTypMax]
  {
    minTypMax = RefCDOmMinTypMax();//if there is no minTypMax it should return null
    pair<RefString, int> id;
  }
: #(NAMED_PARAMETER_ASSIGNMENT 
    id=identifier 
    { str = id.first; }
    ( minTypMax=mintypmax_expression )?
  ) //changed expression to mintypmax_expression
;

module_instance [RefCDOmModuleOrUdpInstantiation moduleInstantiation]
  {
    pair<RefString, int> str(RefString(), 0);
    RefCDOmRange rng = RefCDOmRange();
    RefCDOmModuleOrUdpInstance returnedModuleInstance;
  }
: #(mi:MODULE_INSTANCE
    (str=identifier)?
    (rng=range)?
    { returnedModuleInstance = moduleInstantiation->buildModuleInstance(#mi->getLine(),  str.first, rng ); }
    list_of_port_connections[returnedModuleInstance]
  )
  { PRINT_AST(#MODULE_INSTANCE); }
;

list_of_port_connections [RefCDOmModuleOrUdpInstance moduleInstance]
  {
    RefCDOmAttrListCollection attrListColl;
    RefCDOmExpr expr;
    RefString str;
  }
: attrListColl=attrs_opt
  ( ordered_port_connection[expr] 
    { moduleInstance->addPortConnection( attrListColl, expr ); }
    (attrListColl=attrs_opt ordered_port_connection[expr]
      { moduleInstance->addPortConnection( attrListColl, expr ); }
    )*
  | named_port_connection[expr, str] 
    { moduleInstance->addPortConnection( attrListColl, expr, str ); }
    (attrListColl=attrs_opt named_port_connection[expr, str]
      { moduleInstance->addPortConnection( attrListColl, expr, str ); }
    )*
  )
;

ordered_port_connection [RefCDOmExpr &expr]
  { expr = RefCDOmExpr(); }
: #(ORDERED_PORT_CONNECTION (expr=expression)?) // If there is only one empty
      // port connection it means there are no connections at all
;

named_port_connection [RefCDOmExpr &expr, RefString &str]
  { 
    expr = RefCDOmExpr(); 
    pair<RefString, int> id;
  }
: #(NAMED_PORT_CONNECTION 
    id=identifier 
    { str = id.first; }
    (expr=expression)?
  )
;

//PRIORITY 2
// A.4.2 Generated instantiation
generated_instantiation [RefCDOmModuleDecl parent]
: #(kgen:K_GENERATE 
    { RefCDOmGenInst genInst = CDOmGenInst::build(#kgen->getLine(), parent); }
    ( generate_item[genInst] )*
  )
;

generate_item_or_null [RefCDOmBase parent]
  { TBool test = TRUE; }
: #(gion:GENERATE_ITEM_OR_NULL 
    ( generate_item[parent] {test = FALSE;} )? 
    { if( test ) CDOmGenItemNull::build(#gion->getLine(), parent); }
  )
;

generate_item [RefCDOmBase parent]
  {
    RefCDOmAttrListCollection attrListColl;
    RefCDOmAttrHolder attrHolder;
  }
: generate_conditional_statement    [ parent ]
| generate_case_statement           [ parent ]
| generate_loop_statement           [ parent ]
| generate_block                    [ parent ]
| attrListColl=attrs_opt attrHolder=module_or_generate_item [ parent ]
  { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
;

generate_conditional_statement [RefCDOmBase parent]
  { 
    RefCDOmExpr expr; 
    RefCDOmGenItemIf genItemIf;
  }
: #(kif:K_IF expr=expression // constant expression
    { genItemIf = CDOmGenItemIf::build(#kif->getLine(),  parent, expr ); }
    generate_item_or_null [ genItemIf ]
    ( generate_item_or_null [ genItemIf ] )? // ELSE statement
  )
;

generate_case_statement [RefCDOmBase parent]
  {
    RefCDOmGenItemCase genItemCase;
    RefCDOmExpr expr1, expr2;
    RefCDOmListExpr listExpr;
  }
: #(K_CASE expr1=expression // constant expression
    #(gci:GENVAR_CASE_ITEM
      ( expr2=expression
        { listExpr = CDOmListExpr::build(#gci->getLine(), expr2); }
        ( expr2=expression
          { listExpr->addItem(expr2); }
        )*
      | K_DEFAULT { listExpr = RefCDOmListExpr(); }
      )
      { genItemCase = CDOmGenItemCase::build(#gci->getLine(),  parent, expr1, listExpr ); }
      generate_item_or_null[genItemCase]
    )
    ( #(gci1:GENVAR_CASE_ITEM
        ( expr2=expression
          { listExpr = CDOmListExpr::build(#gci1->getLine(), expr2); }
          ( expr2=expression
            { listExpr->addItem(expr2); }
          )*
        | K_DEFAULT 
          { listExpr = RefCDOmListExpr(); }
        )
        { genItemCase->addCaseItem( listExpr ); }
        generate_item_or_null[genItemCase]
      )
    )*
  )
;

generate_loop_statement [RefCDOmBase parent]
  {
    pair<RefString, int> id1, id2, id3;
    RefCDOmExpr expr1, expr2, expr3;
    RefCDOmGenItemLoop itemLoop;
    RefCDOmGenItemBlock itemBlock;
  }
: #(kfor:K_FOR
    #(GENVAR_ASSIGNMENT 
      id1=identifier 
      expr1=expression
    )
    expr2=expression 
    #(GENVAR_ASSIGNMENT 
      id2=identifier 
      expr3=expression
    )
    id3=identifier
    {
      cerr << parent->getType() << endl;
      cerr << TYPE_GEN_INST << endl;
      itemLoop = CDOmGenItemLoop::build(#kfor->getLine(), parent, CDOmExprLink::build(id1.second, id1.first), expr1, expr2, CDOmExprLink::build(id2.second, id2.first), expr3 );
      itemBlock = CDOmGenItemBlock::build(id3.second,  itemLoop, id3.first );
    }
    (generate_item[itemBlock])*
  )
;

generate_block [RefCDOmBase parent]
  {
    pair<RefString, int> id(RefString(), 0);
    RefCDOmGenItemBlock itemBlock;
  }
: #(gb:GENERATE_BLOCK 
    ( id=identifier )? 
    { itemBlock = CDOmGenItemBlock::build(#gb->getLine(),  parent, id.first ); }
    ( generate_item[itemBlock] )*
  )
;

//PRIORITY 2
// A.5 UDP declaration and instantiation
// A.5.1 UDP declaration
udp_declaration [RefCDOmDesign design, RefCDOmAttrListCollection declColl]
  { 
    pair<RefString, int> id; 
    RefCDOmUdpDecl udpDecl;
  }
: #(K_PRIMITIVE 
    id=identifier
    { 
      udpDecl = design->buildUdpDecl(id.second, id.first); 
      if(declColl.get()) udpDecl->setAttrListCollection(declColl);
    }
    ( udp_port_list [udpDecl]
    | udp_declaration_port_list[ udpDecl ]
    )
    ( udp_port_declaration[ udpDecl ] )*
    udp_body[ udpDecl ]
  )
;

// A.5.2 UDP ports
udp_port_list [RefCDOmUdpDecl udpdecl]
  { pair<RefString, int> id; }
: #(UDP_PORT_LIST
    id=identifier 
    { udpdecl->addPort(id.first); }
    ( id=identifier 
      { udpdecl->addPort(id.first); }
    )+
  )
;

udp_declaration_port_list [ RefCDOmUdpDecl udpDecl ]
  { 
    RefCDOmAttrListCollection attrListColl; 
    RefCDOmUdpPortDeclInput portDeclInput;
    RefCDOmUdpPortDeclOutput portDeclOutput;
  }
: #(UDP_DECLARATION_PORT_LIST
    attrListColl=attrs_opt portDeclOutput=udp_output_declaration  [ udpDecl ]
    { if(attrListColl.get()) portDeclOutput->setAttrListCollection(attrListColl); }
    ( attrListColl=attrs_opt portDeclInput=udp_input_declaration [ udpDecl ] 
      { if(attrListColl.get()) portDeclInput->setAttrListCollection(attrListColl); }
    )+
  )
;

udp_port_declaration [RefCDOmUdpDecl udpDecl]
  { 
    RefCDOmAttrListCollection attrListColl; 
    RefCDOmUdpPortDeclInput portDeclInput;
    RefCDOmUdpPortDeclOutput portDeclOutput;
  }
: attrListColl=attrs_opt
  ( portDeclOutput=udp_output_declaration [ udpDecl ] { if(attrListColl.get()) portDeclOutput->setAttrListCollection(attrListColl); }
  | portDeclInput=udp_input_declaration   [ udpDecl ] { if(attrListColl.get()) portDeclInput->setAttrListCollection(attrListColl) ; }
  | portDeclOutput=udp_reg_declaration    [ udpDecl ] { if(attrListColl.get()) portDeclOutput->setAttrListCollection(attrListColl); }
  )
;

udp_output_declaration [RefCDOmUdpDecl udpDecl] returns [ RefCDOmUdpPortDeclOutput returned ]
  {
    pair<RefString, int> id;
    RefCDOmExpr expr = RefCDOmExpr();
  }
: #(K_OUTPUT
    ( id=identifier
      { returned = CDOmUdpPortDeclOutput::build(id.second, udpDecl, CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT, id.first); }
    | K_REG id=identifier 
      ( expr=expression )? // constant expression
      { returned = CDOmUdpPortDeclOutput::build(id.second, udpDecl, CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG, id.first, expr); }
    )
  )
;

udp_input_declaration [RefCDOmUdpDecl udpDecl] returns [RefCDOmUdpPortDeclInput returned]
  { pair<RefString, int> id; }
: #(K_INPUT 
    id=identifier 
    { returned = CDOmUdpPortDeclInput::build(id.second, udpDecl, id.first); }
    ( id=identifier 
      { returned->addPort(id.second, id.first); }
    )*
  )
;

udp_reg_declaration [RefCDOmUdpDecl udpDecl] returns [RefCDOmUdpPortDeclOutput returned]
  { pair<RefString, int> id; }
: #(K_REG 
    id=identifier
    { returned = CDOmUdpPortDeclOutput::build(id.second, udpDecl, CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG, id.first); }
  )
;

// A.5.3 UDP body
udp_body [RefCDOmUdpDecl udpDecl]
: #(K_TABLE
    ( udp_initial_statement[ udpDecl ] )?
    ( udp_table_entry [udpDecl] )+
  )
;

udp_initial_statement [RefCDOmUdpDecl udpDecl]
  { 
    pair<RefString, int> id;
    CDOmUdpInitStmt::EInitVal initVal;
  }
: #(K_INITIAL 
    id=identifier 
    initVal=init_val
    { CDOmUdpInitStmt::build(id.second,  udpDecl, CDOmExprLink::build(id.second, id.first), initVal); }
  )
;

init_val returns [CDOmUdpInitStmt::EInitVal returned]
  { char test; }
: un:UNSIGNED_NUMBER
  { un->getText().size() == 1 }?
  { 
    test = (un->getText())[0]; 
    switch( test ) {
      case '0':
        returned = CDOmUdpInitStmt::INIT_VAL_0; 
        break;
      case '1':
        returned = CDOmUdpInitStmt::INIT_VAL_1;
        break;
      default:
        test = 0;
    }
  }
  { test }?
| #(SIZED_NUMBER
    UNSIGNED_NUMBER
    bn:BASED_NUMBER
    { bn->getNumber()->getStringValue()->size() == 3 }?
    {
      test =  bn->getNumber()->getStringValue()->at(2);
      switch( bn->getNumber()->getStringValue()->at(1)) {
        case 'b':
          switch(test) {
            case '0':
              returned = CDOmUdpInitStmt::INIT_VAL_1b0;
              break;
            case '1':
              returned = CDOmUdpInitStmt::INIT_VAL_1b1;
              break;
            case 'x':
              returned = CDOmUdpInitStmt::INIT_VAL_1bx;
              break;
            case 'X':
              returned = CDOmUdpInitStmt::INIT_VAL_1bX;
              break;
            default:
              test = 0;
          }
          break;
        case 'B':
          switch(test) {
            case '0':
              returned = CDOmUdpInitStmt::INIT_VAL_1B0;
              break;
            case '1':
              returned = CDOmUdpInitStmt::INIT_VAL_1B1;
              break;
            case 'x':
              returned = CDOmUdpInitStmt::INIT_VAL_1Bx;
              break;
            case 'X':
              returned = CDOmUdpInitStmt::INIT_VAL_1BX;
              break;
            default:
              test = 0;
          }
          break;
        default:
          test = 0;
      }
    }
    { test }?
  )
;

udp_table_entry [RefCDOmUdpDecl udpDecl]
  { 
    ECDOmUdpSymbol udpSymbol1 = UDP_SYMBOL_UNDEF, udpSymbol2 = UDP_SYMBOL_UNDEF;
    RefTVec_ECDOmUdpSymbol list1=RefTVec_ECDOmUdpSymbol(), list2=RefTVec_ECDOmUdpSymbol();
    CDOmUdpSeqEntry::ESeqEdgeSymbol edgeSymbol = CDOmUdpSeqEntry::EDGE_UNDEF;
    ECDOmUdpSymbol currState, nextState, temp;
  }
: #(utse:UDP_TABLE_SEQ_ENTRY 
    #(INPUT_LIST 
      ( temp=level_symbol 
        {
          if(edgeSymbol == CDOmUdpSeqEntry::EDGE_UNDEF && udpSymbol2 == UDP_SYMBOL_UNDEF) {
            if(!list1.get())
              list1 = RefTVec_ECDOmUdpSymbol( new TVec_ECDOmUdpSymbol() );
            list1->push_back(temp);
          }
          else {
            if(!list2.get())
              list2 = RefTVec_ECDOmUdpSymbol( new TVec_ECDOmUdpSymbol() );
            list2->push_back(temp);
          }
        }
      | edgeSymbol=edge_indicator[ udpSymbol1, udpSymbol2 ]
      )+
    )
    currState=level_symbol //current_state
    nextState=next_state
    {
      if(edgeSymbol == CDOmUdpSeqEntry::EDGE_UNDEF && udpSymbol2 == UDP_SYMBOL_UNDEF)
        CDOmUdpSeqEntry::buildWithLevelInputList(#utse->getLine(),  udpDecl, currState, nextState, list1 );
      else if( edgeSymbol == CDOmUdpSeqEntry::EDGE_UNDEF )
        CDOmUdpSeqEntry::buildWithEdgeInputList(#utse->getLine(),  udpDecl, currState, nextState, list1, list2, udpSymbol1, udpSymbol2 );
      else
        CDOmUdpSeqEntry::buildWithEdgeInputList(#utse->getLine(),  udpDecl, currState, nextState, list1, list2, edgeSymbol );
    }
  )
| #(utce:UDP_TABLE_COMB_ENTRY 
    { list1 = RefTVec_ECDOmUdpSymbol( new TVec_ECDOmUdpSymbol() ); }
    #(INPUT_LIST 
      ( temp=level_symbol { list1->push_back(temp); } )+
    )
    temp=output_symbol
    { CDOmUdpCombEntry::build(#utce->getLine(),  udpDecl, list1, temp ); }
  )
;

level_symbol returns [ECDOmUdpSymbol returned]
: UDP_0 { returned = UDP_SYMBOL_0; }
| UDP_1 { returned = UDP_SYMBOL_1; }
| s1:UDP_X { if(s1->getText().at(0) == 'x') returned = UDP_SYMBOL_x; else returned = UDP_SYMBOL_X; }
| QUESTION { returned = UDP_SYMBOL_Q; }
| s2:UDP_B { if(s2->getText().at(0) == 'b') returned = UDP_SYMBOL_b; else returned = UDP_SYMBOL_B; }
;

edge_indicator [ECDOmUdpSymbol &retuned1, ECDOmUdpSymbol &retuned2] returns [CDOmUdpSeqEntry::ESeqEdgeSymbol returned]
  { ECDOmUdpSymbol symbol1, symbol2; }
: LPAREN
  retuned1=level_symbol
  retuned2=level_symbol
  { returned = CDOmUdpSeqEntry::EDGE_UNDEF; }
//UDP_Q0 { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_Q; retuned2 = UDP_SYMBOL_0; }
//| UDP_Q1 { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_Q; retuned2 = UDP_SYMBOL_1; }
//| u1:UDP_QX { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_Q; retuned2 = u1->getText().at(1) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; }
//| UDP_QQ { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_Q; retuned2 = UDP_SYMBOL_Q; }
//| UDP_01 { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_0; retuned2 = UDP_SYMBOL_1; }
//| u2:UDP_0X { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_0; retuned2 = u2->getText().at(1) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; }
//| UDP_0Q { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_0; retuned2 = UDP_SYMBOL_Q; }
//| UDP_10 { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_1; retuned2 = UDP_SYMBOL_0; }
//| u3:UDP_1X { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_1; retuned2 = u3->getText().at(1) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; }
//| UDP_1Q { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = UDP_SYMBOL_1; retuned2 = UDP_SYMBOL_Q; }
//| u4:UDP_BX { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = u4->getText().at(0) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; retuned2 = u4->getText().at(1) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; }
//| u5:UDP_X0 { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = u5->getText().at(0) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; retuned2 = UDP_SYMBOL_0; }
//| u6:UDP_X1 { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = u6->getText().at(0) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; retuned2 = UDP_SYMBOL_1; }
//| u7:UDP_XQ { returned = CDOmUdpSeqEntry::EDGE_UNDEF; retuned1 = u7->getText().at(0) == 'x'?UDP_SYMBOL_x:UDP_SYMBOL_X; retuned2 = UDP_SYMBOL_Q; }
| u8:UDP_F { returned = u8->getText().at(0) == 'f'?CDOmUdpSeqEntry::EDGE_f:CDOmUdpSeqEntry::EDGE_F; }
| u9:UDP_R { returned = u9->getText().at(0) == 'r'?CDOmUdpSeqEntry::EDGE_r:CDOmUdpSeqEntry::EDGE_R; }
| u0:UDP_N { returned = u0->getText().at(0) == 'n'?CDOmUdpSeqEntry::EDGE_n:CDOmUdpSeqEntry::EDGE_N; }
| ua:UDP_P { returned = ua->getText().at(0) == 'p'?CDOmUdpSeqEntry::EDGE_p:CDOmUdpSeqEntry::EDGE_P; }
| STAR { returned = CDOmUdpSeqEntry::EDGE_STAR; }
;

next_state returns [ECDOmUdpSymbol returned]
: returned=output_symbol 
| MINUS { returned = UDP_SYMBOL_D; }
;

output_symbol returns [ECDOmUdpSymbol returned]
: UDP_0 { returned = UDP_SYMBOL_0; }
| UDP_1 { returned = UDP_SYMBOL_1; }
| s1:UDP_X { if(s1->getText().at(0) == 'x') returned = UDP_SYMBOL_x; else returned = UDP_SYMBOL_X; }
;

// A.6 Behavioral statements
//PRIORITY 5
// A.6.1 Continuous assignment statements
continuous_assign [RefCDOmBase parent] returns [RefCDOmContAssn returnedContAssn]
  {
    ECDOmDriveStrength ds1 = DRIVE_STRENGTH_UNDEFINED, ds2 = DRIVE_STRENGTH_UNDEFINED;
    RefCDOmAssn assn;
  }
: #(kassign:K_ASSIGN
    (drive_strength[ds1, ds2])? 
    { returnedContAssn = CDOmContAssn::build(#kassign->getLine(),  parent, ds1, ds2 ); }
    (delay3[returnedContAssn])?
    ( assn=assignment
      { returnedContAssn->addNetAssn( assn ); }
    )+
  )
;

assignment returns [RefCDOmAssn returnedAssn]
  {
    RefCDOmExpr my_lvalue;
    RefCDOmExpr expr;
  }
: #(assig:ASSIGNMENT my_lvalue=lvalue expr=expression
    { returnedAssn = CDOmAssn::build(#assig->getLine(),  my_lvalue, expr ); }
  )
;

//PRIORITY 5
// A.6.2 Procedural blocks and assignments
initial_construct [RefCDOmBase parent] returns [RefCDOmInitOrAlways returnedInitOrAlways]
  {
    RefCDOmStmt stmt;
    RefCDOmAttrListCollection attrListColl;
  }
: #(kinitial:K_INITIAL attrListColl=attrs_opt stmt=statement)
  {
    if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
    returnedInitOrAlways = CDOmInitOrAlways::build(#kinitial->getLine(),  parent, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, stmt );
  }
;

always_construct [RefCDOmBase parent] returns [RefCDOmInitOrAlways returnedInitOrAlways]
  {
    RefCDOmStmt stmt;
    RefCDOmAttrListCollection attrListColl;
  }
: #(kalways:K_ALWAYS attrListColl=attrs_opt stmt=statement)
  {
    if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
    returnedInitOrAlways = CDOmInitOrAlways::build(#kalways->getLine(),  parent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, stmt );
  }
  { PRINT_AST(#K_ALWAYS); }
;

blocking_or_nonblocking_assignment returns [RefCDOmStmtAssn returnedStmtAssn]
  {
    RefCDOmExpr my_lvalue;
    RefCDOmExpr expr;
    CDOmStmtAssn::EAssnType assnType;
    bool test = false;
    RefCDOmDelayControl delayControl = RefCDOmDelayControl();
    RefCDOmEventControl eventControl = RefCDOmEventControl();
    RefCDOmExpr exprEventControl = RefCDOmExpr();
  }
: #(bona:BLOCKING_OR_NONBLOCKING_ASSIGNMENT
    my_lvalue=lvalue
    ( ASSIGN { assnType = CDOmStmtAssn::ASSN_BLOCKING     ; }
    | LE     { assnType = CDOmStmtAssn::ASSN_NON_BLOCKING ; }
    ) 
    (delay_or_event_control [delayControl, eventControl, exprEventControl] { test=true; } )?
    expr=expression
    {
      if( test ) {
        if( delayControl.get() )
          returnedStmtAssn = CDOmStmtAssn::buildWithDelayControl(#bona->getLine(),  assnType, my_lvalue, expr, delayControl );
        else
          returnedStmtAssn = CDOmStmtAssn::buildWithEventControl(#bona->getLine(),  assnType, my_lvalue, expr, eventControl, exprEventControl );
      }
      else
        returnedStmtAssn = CDOmStmtAssn::buildSimple(#bona->getLine(), assnType, my_lvalue, expr);
    }
  )
  { PRINT_AST(#BLOCKING_OR_NONBLOCKING_ASSIGNMENT); }
;

procedural_continuous_assignments returns [RefCDOmStmtProcContAssn returnedStmtProcContAssn]
  {
     RefCDOmAssn assn; 
     RefCDOmExpr my_lvalue;
  }
: #(kassign:K_ASSIGN assn=assignment)
  { returnedStmtProcContAssn = CDOmStmtProcContAssn::build(#kassign->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN  , assn      ); }
  { PRINT_AST(#K_ASSIGN); }
| #(kdeassign:K_DEASSIGN my_lvalue=lvalue)
  { returnedStmtProcContAssn = CDOmStmtProcContAssn::build(#kdeassign->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_DEASSIGN, my_lvalue ); }
  { PRINT_AST(#K_DEASSIGN); }
| #(kforce:K_FORCE assn=assignment)
  { returnedStmtProcContAssn = CDOmStmtProcContAssn::build(#kforce->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_FORCE   , assn      ); }
  { PRINT_AST(#K_FORCE); }
| #(krelease:K_RELEASE my_lvalue=lvalue)
  { returnedStmtProcContAssn = CDOmStmtProcContAssn::build(#krelease->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_RELEASE , my_lvalue ); }
  { PRINT_AST(#K_RELEASE); }
;

//PRIORITY 2
// A.6.3 Parallel and sequential blocks
par_block returns [ RefCDOmStmtBlock returnedStmtBlock ]
  {
    pair<RefString, int> str(RefString(), 0);
    RefCDOmAttrListCollection attrListColl;
    RefCDOmStmt stmt;
    bool acceptBlockItemDecl = false;
    RefCDOmAttrHolder attrHolder;
  }
: #(pb:PAR_BLOCK
    (str=identifier {acceptBlockItemDecl = true;} )?
    { returnedStmtBlock = CDOmStmtBlock::build(#pb->getLine(),  CDOmStmtBlock::BLOCK_PARALLEL, str.first ); }
    ( attrListColl=attrs_opt 
      ( attrHolder=block_item_declaration[ returnedStmtBlock ]
        { acceptBlockItemDecl }?
        { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
      | stmt=statement
        {
          acceptBlockItemDecl = false;
          if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
          returnedStmtBlock->addStmt( stmt );
        }
      )
    )*
  )
;

seq_block returns [RefCDOmStmtBlock returnedStmtBlock]
  {
    pair<RefString, int> str(RefString(), 0);
    RefCDOmAttrListCollection attrListColl;
    RefCDOmStmt stmt;
    bool acceptBlockItemDecl = false;
    RefCDOmAttrHolder attrHolder;
  }
: #(sb:SEQ_BLOCK
    (str=identifier {acceptBlockItemDecl = true;} )?
    { returnedStmtBlock = CDOmStmtBlock::build(#sb->getLine(),  CDOmStmtBlock::BLOCK_SEQUENTIAL, str.first ); }
    ( attrListColl=attrs_opt 
      ( attrHolder=block_item_declaration[ returnedStmtBlock ]
        { acceptBlockItemDecl }?
        { if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl ); }
      | stmt=statement 
        {
          acceptBlockItemDecl = false;
          if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
          returnedStmtBlock->addStmt( stmt );
        }
      )
    )*
  )
  { PRINT_AST(#SEQ_BLOCK); }
;

//PRIORITY 5
// A.6.4 Statements
statement returns [RefCDOmStmt returnedStmt]
        {
           RefCDOmAttrListCollection attrList; 
        }
: returnedStmt=blocking_or_nonblocking_assignment
| returnedStmt=case_statement
| returnedStmt=conditional_statement
| returnedStmt=disable_statement
| returnedStmt=event_trigger
| returnedStmt=loop_statement
| returnedStmt=par_block
| returnedStmt=procedural_continuous_assignments
| returnedStmt=procedural_timing_control_statement
| returnedStmt=seq_block
| returnedStmt=system_task_enable
| returnedStmt=task_enable
| returnedStmt=wait_statement
/*
        attrList = attrs_opt
        {
            if(attrList.get()){
                returnedStmt->setAttrListCollection(attrList);
            }
        }
*/
;

statement_or_null returns [RefCDOmStmt returnedStmt]
  { 
    TBool nullStmt = TRUE;
    //RefCDOmAttrListCollection attrList;
  }
: #(son:STATEMENT_OR_NULL 
    (returnedStmt=statement {nullStmt = FALSE;} )?
    {
      if(nullStmt)
        returnedStmt = CDOmStmt::buildNullStmt(#son->getLine());
    }
  )
  { PRINT_AST(#STATEMENT_OR_NULL); }
;

//PRIORITY 2
// A.6.5 Timing control statements
delay_control returns [RefCDOmDelayControl returnedDelayControl]
  {
    RefCDOmMinTypMax minTypMax;
    RefCDOmExpr expr;
    bool fatal = false;
  }
: #(dc:DELAY_CONTROL 
    ( expr=delay_value
      {
        switch( expr->getExprType() ){
          case CDOmExpr::EXPR_NUMBER : 
            returnedDelayControl = CDOmDelayControl::build(#dc->getLine(),  boost::static_pointer_cast<CDOmNumber>   (expr) );
            break;
          case CDOmExpr::EXPR_REAL_NUMBER :
            returnedDelayControl = CDOmDelayControl::build(#dc->getLine(),  boost::static_pointer_cast<CDOmReal>     (expr) );
            break;
          case CDOmExpr::EXPR_HID :
            returnedDelayControl = CDOmDelayControl::build(#dc->getLine(),  boost::static_pointer_cast<CDOmExprLink> (expr) );
            break;

          default:
            fatal = true;
        }
      }
      {!fatal}?
    | minTypMax=mintypmax_expression
      {
        returnedDelayControl = CDOmDelayControl::build(#dc->getLine(), minTypMax);
      }
    )
  )
  { PRINT_AST(#DELAY_CONTROL); }
;

delay_or_event_control [ RefCDOmDelayControl&delayControl, RefCDOmEventControl&eventControl, RefCDOmExpr&exprEventControl ]
: delayControl=delay_control
| eventControl=event_control
| #(K_REPEAT exprEventControl=expression eventControl=event_control)
  { PRINT_AST(#K_REPEAT); }
;

disable_statement returns [RefCDOmStmtDisable returnedStmtDisable]
  { RefCDOmExprLink exprLink; }
: #(kdisable:K_DISABLE exprLink=hierarchical_identifier
    { returnedStmtDisable = CDOmStmtDisable::build(#kdisable->getLine(), exprLink); }
  )
;

event_control returns [ RefCDOmEventControl returnedEventControl ]
  {
    RefCDOmExprLink exprLink;
    RefCDOmEventExpr eventExpr;
  }
: #(ec:EVENT_CONTROL
    ( exprLink=hierarchical_identifier    { returnedEventControl = CDOmEventControl::build(#ec->getLine(),  exprLink  ); }
    | eventExpr=list_of_event_expressions { returnedEventControl = CDOmEventControl::build(#ec->getLine(),  eventExpr ); }
    | STAR                                { returnedEventControl = CDOmEventControl::build(#ec->getLine(),    false   ); }
    | SUPERSTAR                           { returnedEventControl = CDOmEventControl::build(#ec->getLine(),    true    ); }
    )
  )
;

event_trigger returns [RefCDOmStmtEventTrigger returnedStmtDisable]
  { RefCDOmExprLink exprLink; }
: #(et:EVENT_TRIGGER exprLink=expr_primary_identifier
    { returnedStmtDisable = CDOmStmtEventTrigger::build(#et->getLine(), exprLink); }
  )
;

//Comma separated events
//Here, just as below the rule creates a EVENT_EXPR_COMMA object only if there really is such a structure
list_of_event_expressions returns [RefCDOmEventExpr returnedEventExpr]
  { RefCDOmEventExpr ev1, ev2; }
: (returnedEventExpr=or_event_expression)
  (ev1=or_event_expression
    {
      ev2 = returnedEventExpr;
      returnedEventExpr = CDOmEventExpr::build(ev1->getLineNumber(), CDOmEventExpr:: EVENT_EXPR_COMMA, ev2, ev1);
    }
  )*
;

//Events seperated by an or
// I had to do some referice tricks for this rule to create an EVENT_EXPR_EXPR object 
// only if there really is an or expression there
or_event_expression returns [RefCDOmEventExpr returnedEventExpr]
  { RefCDOmEventExpr ev1, ev2; }
: #(OR_EVENT_EXPRESSION
    (returnedEventExpr=event_expression_primary)
    (ev1=event_expression_primary
      {
        ev2 = returnedEventExpr;
        returnedEventExpr = CDOmEventExpr::build(ev1->getLineNumber(), CDOmEventExpr::EVENT_EXPR_OR, ev2, ev1);
      }
    )*
  )
;

event_expression_primary returns [RefCDOmEventExpr returnedEventExpr]
  { RefCDOmExpr expr; }
: expr=expression {returnedEventExpr = CDOmEventExpr::build(expr->getLineNumber(), CDOmEventExpr::EVENT_EXPR_EXPR, expr);}
| kpos:K_POSEDGE expr=expression { returnedEventExpr = CDOmEventExpr::build(#kpos->getLine(), CDOmEventExpr::EVENT_EXPR_POSEDGE, expr); }
| kneg:K_NEGEDGE expr=expression { returnedEventExpr = CDOmEventExpr::build(#kneg->getLine(), CDOmEventExpr::EVENT_EXPR_NEGEDGE, expr); }
;

procedural_timing_control returns [RefCDOmBase returnedBase]
: returnedBase=delay_control
| returnedBase=event_control
;

procedural_timing_control_statement returns [RefCDOmStmt returnedStmt]
  {
    RefCDOmAttrListCollection attrListColl;
    RefCDOmStmt stmt;
    RefCDOmBase base;
    bool fatal = false;
  }
: base=procedural_timing_control
  attrListColl=attrs_opt stmt=statement_or_null
  {
    if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
    switch( base->getType() ) {
      case TYPE_DELAY_CONTROL :
        returnedStmt = CDOmStmtProcTimingControl::buildWithDelayControl(base->getLineNumber(), boost::static_pointer_cast<CDOmDelayControl>(base), stmt);
        break;
      case TYPE_EVENT_CONTROL :
        returnedStmt = CDOmStmtProcTimingControl::buildWithEventControl(base->getLineNumber(), boost::static_pointer_cast<CDOmEventControl>(base), stmt);
        break;
      default :
        fatal = true;
    }
  }
  {!fatal}?
;

wait_statement returns [RefCDOmStmtWait returnedStmtWait]
  {
    RefCDOmExpr expr;
    RefCDOmAttrListCollection attrListColl;
    RefCDOmStmt stmt;
  }
: #(kwait:K_WAIT 
    expr=expression 
    attrListColl=attrs_opt 
    stmt=statement_or_null
    {
      if(attrListColl.get()) stmt->setAttrListCollection(attrListColl);
      returnedStmtWait = CDOmStmtWait::build(#kwait->getLine(), expr, stmt);
    }
  )
;

//PRIORITY 4
// A.6.6 Conditional statements
conditional_statement returns [RefCDOmStmtIf returnedStmtIf]
  {
    RefCDOmExpr expr;
    RefCDOmStmt stmt1;
    RefCDOmStmt stmt2 = RefCDOmStmt(  );
    RefCDOmAttrListCollection attrListColl1;
    RefCDOmAttrListCollection attrListColl2;
  }
: #(kif:K_IF expr=expression
    attrListColl1=attrs_opt 
    stmt1=statement_or_null
    {
      if(attrListColl1.get()) stmt1->setAttrListCollection(attrListColl1);
    }
    ( attrListColl2=attrs_opt 
      stmt2=statement_or_null
      {
        if(attrListColl2.get()) stmt2->setAttrListCollection(attrListColl2);//this is executed only if there really is a attrListColl
      }
    )? // ELSE clause
    { returnedStmtIf = CDOmStmtIf::build(#kif->getLine(), expr, stmt1, stmt2); }
  )
;

//PRIORITY 4
// A.6.7 Case statements
case_statement returns [RefCDOmStmtCase returnedStmtCase]
  {
    RefCDOmListExpr exprList;
    RefCDOmStmt stmt;
    RefCDOmExpr expr;
    CDOmStmtCase::ECaseType caseType;
  }
: #(cs:CASE_STATEMENT
    ( K_CASE  { caseType = CDOmStmtCase::CASE_CASE;   }
    | K_CASEZ { caseType = CDOmStmtCase::CASE_CASE_Z; }
    | K_CASEX { caseType = CDOmStmtCase::CASE_CASE_X; }
    ) 
    expr=expression
    (case_item[exprList, stmt])
    {
      returnedStmtCase = CDOmStmtCase::build(#cs->getLine(), caseType, expr, exprList, stmt);
    }
    (case_item[exprList, stmt]
      {
        returnedStmtCase->addCaseItem(exprList, stmt);
      }
    )*
  )
  { PRINT_AST(#CASE_STATEMENT); }
;

//These function parameters are output parameters, not input params
//They represent a case item
case_item [RefCDOmListExpr& exprList, RefCDOmStmt& stmt]
  { RefCDOmAttrListCollection attrListColl; }
: #(CASE_ITEM
    ( exprList=expression_list 
    | K_DEFAULT
      //NULL expression list means default
      { exprList = RefCDOmListExpr(  ); }
    )
    attrListColl=attrs_opt 
    stmt=statement_or_null
    { if(attrListColl.get()) stmt->setAttrListCollection(attrListColl); }
  )
  { PRINT_AST(#CASE_ITEM); }
;

//PRIORITY 4
// A.6.8 Looping statements
loop_statement returns [RefCDOmStmtLoop returnedStmtLoop]
  {
    RefCDOmStmt stmt;
    RefCDOmExpr expr;
    RefCDOmAssn assn1, assn2;
    RefCDOmAttrListCollection attrListColl;
  }
: #(ls:LOOP_STATEMENT
    ( K_FOREVER attrListColl=attrs_opt stmt=statement 
      {
        if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
        returnedStmtLoop = CDOmStmtLoop::buildForeverStmt(#ls->getLine(), stmt);
      }
    | K_REPEAT expr=expression attrListColl=attrs_opt stmt=statement 
      {
        if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
        returnedStmtLoop = CDOmStmtLoop::buildRepeatStmt(#ls->getLine(), expr, stmt);
      }
    | K_WHILE expr=expression attrListColl=attrs_opt stmt=statement 
      {
        if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
        returnedStmtLoop = CDOmStmtLoop::buildWhileStmt(#ls->getLine(), expr, stmt);
      }
    | K_FOR assn1=assignment expr=expression assn2=assignment attrListColl=attrs_opt stmt=statement 
      {
        if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
        returnedStmtLoop = CDOmStmtLoop::buildForStmt(#ls->getLine(), assn1, expr, assn2, stmt);
      }
    )
  )
  { PRINT_AST(#LOOP_STATEMENT); }
;

//PRIORITY 2
// A.6.9 Task enable statements
system_task_enable returns [RefCDOmStmtTaskEnable returnedStmtTaskEnable]
  {
    RefString name;
    RefCDOmExpr expr = RefCDOmExpr();
  }
: #(ste:SYSTEM_TASK_ENABLE
    name=system_function_name
    { returnedStmtTaskEnable = CDOmStmtTaskEnable::build(#ste->getLine(),  CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, CDOmExprLink::build(#ste->getLine(), name)); }
    (expr=expression)? 
    ( COMMA 
      // COMMA was left in AST to remove ambiguity
      { returnedStmtTaskEnable->addExpr(expr); expr=RefCDOmExpr(); }
      (expr=expression)?
    )*
    { returnedStmtTaskEnable->addExpr(expr);}
  )
;

task_enable returns [RefCDOmStmtTaskEnable returnedStmtTaskEnable]
  {
    RefCDOmExprLink exprLink;
    RefCDOmListExpr exprList = RefCDOmListExpr();
    RefCDOmExpr expr;
  }
: #(te:TASK_ENABLE
    exprLink=hierarchical_identifier 
    { returnedStmtTaskEnable = CDOmStmtTaskEnable::build(#te->getLine(),  CDOmStmtTaskEnable::TASK_ENABLE_TASK, exprLink); }
    ( expr=expression 
      { returnedStmtTaskEnable->addExpr(expr); }
    )*
  )
;

//PRIORITY 1
// A.7 Specify section
// A.7.1 Specify block declaration
specify_block [RefCDOmModuleDecl parent]
  { RefCDOmSpecifyBlock specBlock; }
: #(spec:K_SPECIFY 
    { specBlock = CDOmSpecifyBlock::build(#spec->getLine(), parent); }
    ( specify_item[specBlock] )*
  )
;

specify_item [RefCDOmSpecifyBlock parent]
{
  RefCDOmParamDecl paramDecl;
}
: paramDecl = specparam_declaration       [parent] // in this context specparam_declaration doesn't hold an attribute list collection
| pulsestyle_or_showcancelled_declaration [parent]
| path_declaration                        [parent]
| system_timing_check                     [parent]
;

pulsestyle_or_showcancelled_declaration [RefCDOmSpecifyBlock parent]
  { RefCDOmSpecifyTerminalList specTermList; }
: #(kpo:K_PULSESTYLE_ONEVENT specTermList=list_of_path_terminals)
  { CDOmPulseStyleOrShowCancelledDecl::build(#kpo->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONEVENT, specTermList); }
| #(kpod:K_PULSESTYLE_ONDETECT specTermList=list_of_path_terminals)
  { CDOmPulseStyleOrShowCancelledDecl::build(#kpod->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONDETECT, specTermList); }
| #(ks:K_SHOWCANCELLED specTermList=list_of_path_terminals)
  { CDOmPulseStyleOrShowCancelledDecl::build(#ks->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::SHOWCANCELLED, specTermList); }
| #(kn:K_NOSHOWCANCELLED specTermList=list_of_path_terminals)
  { CDOmPulseStyleOrShowCancelledDecl::build(#kn->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::NOSHOWCANCELLED, specTermList); }
;

// A.7.2 Specify path declarations
path_declaration [RefCDOmSpecifyBlock parent]
: simple_or_edge_sensitive_path_declaration [parent, RefCDOmExpr(), false]
| state_dependent_path_declaration [parent]
;

simple_or_edge_sensitive_path_declaration [RefCDOmSpecifyBlock parent, RefCDOmExpr modPathExpr, TBool isIfNone]
  {
    RefCDOmSpecifyTerminalList specTermList1=RefCDOmSpecifyTerminalList(), specTermList2;
    CDOmPathDecl::EPathDeclType pathType;
    CDOmPathDecl::EPathDeclPolarityOp polOp = CDOmPathDecl::PATH_DECL_NOOP;
    CDOmPathDecl::EPathDeclEdgeIdenfier edge = CDOmPathDecl::PATH_DECL_NOEDGE;
    TBool range;
    RefCDOmMinTypMaxList mintypmaxList;
    CDOmPathDelayValue::EPathStyle pathDelayStyle = CDOmPathDelayValue::PATH_DELAY_WITHOUT_PAREN;
    RefCDOmExpr dataSourceExpr;
    RefCDOmExprLink exprLink1=RefCDOmExprLink(), exprLink2=RefCDOmExprLink(), exprLink3=RefCDOmExprLink();
  }
: #(spd:SIMPLE_PATH_DECLARATION
    exprLink3=specify_terminal_descriptor
    ( exprLink1=specify_terminal_descriptor
      {
        if( !specTermList1.get())
          specTermList1 = CDOmSpecifyTerminalList::build(#spd->getLine(), exprLink3);
        specTermList1->addItem(exprLink1);
      }
    )*
    ( polOp=polarity_operator )?
    ( PPATH 
      { range = true; }
      { !specTermList1.get() }?
    | FPATH 
      { range = false;
        if( !specTermList1.get() )
          specTermList1 = CDOmSpecifyTerminalList::build(#spd->getLine(), exprLink3);
      }
    )
    ( { !range }?
      specTermList2=list_of_path_terminals
    | exprLink2=specify_terminal_descriptor
    )
    ( LPAREN 
      { pathDelayStyle = CDOmPathDelayValue::PATH_DELAY_WITH_PAREN; }
    )?
    mintypmaxList=list_of_path_delay_expressions
  )
  {
    if( modPathExpr.get() )
      pathType = CDOmPathDecl::PATH_DECL_SIMPLE_IF;
    else if( isIfNone )
      pathType = CDOmPathDecl::PATH_DECL_SIMPLE_IFNONE;
    else
      pathType = CDOmPathDecl::PATH_DECL_SIMPLE;
    if( range ) {
      CDOmPathDecl::build(#spd->getLine(),  
        parent,
        pathType,
        exprLink3,
        exprLink2,
        CDOmPathDelayValue::build(#spd->getLine(),  pathDelayStyle, mintypmaxList ),
        polOp,
        edge,
        RefCDOmExpr(), //data_source_expression
        modPathExpr
        );
        }
    else {
      CDOmPathDecl::build(#spd->getLine(),  
        parent,
        pathType,
        specTermList1,
        specTermList2,
        CDOmPathDelayValue::build(#spd->getLine(),  pathDelayStyle, mintypmaxList ),
        polOp,
        edge,
        RefCDOmExpr(), //data_source_expression
        modPathExpr
        );
        }
  }
| #(espd:EDGE_SENSITIVE_PATH_DECLARATION
    ( edge=edge_identifier )?
    exprLink3=specify_terminal_descriptor
    ( exprLink1=specify_terminal_descriptor
      {
        if( !specTermList1.get())
          specTermList1 = CDOmSpecifyTerminalList::build(#espd->getLine(), exprLink3);
        specTermList1->addItem(exprLink1);
      }
    )*
    ( PPATH 
      { range = true; }
      { !specTermList1.get() }?
    | FPATH 
      { range = false;
        if( !specTermList1.get() )
          specTermList1 = CDOmSpecifyTerminalList::build(#espd->getLine(), exprLink3);
      }
    )
    ( { !range }?
      specTermList2=list_of_path_terminals
    | exprLink2=specify_terminal_descriptor
    )
    ( polOp=polarity_operator )?
    dataSourceExpr=expression
    ( LPAREN
      { pathDelayStyle = CDOmPathDelayValue::PATH_DELAY_WITH_PAREN; }
    )? 
    mintypmaxList=list_of_path_delay_expressions
  )
  { !isIfNone }?
  {
    if( modPathExpr.get() )
      pathType = CDOmPathDecl::PATH_DECL_EDGE_IF;
    else
      pathType = CDOmPathDecl::PATH_DECL_EDGE;
    if( range )
      CDOmPathDecl::build(#espd->getLine(),  
        parent,
        pathType,
        exprLink3,
        exprLink2,
        CDOmPathDelayValue::build(#espd->getLine(),  pathDelayStyle, mintypmaxList ),
        polOp,
        edge,
        dataSourceExpr, //data_source_expression
        modPathExpr
        );
    else
      CDOmPathDecl::build(#espd->getLine(),  
        parent,
        pathType,
        specTermList1,
        specTermList2,
        CDOmPathDelayValue::build(#espd->getLine(),  pathDelayStyle, mintypmaxList ),
        polOp,
        edge,
        dataSourceExpr, //data_source_expression
        modPathExpr
        );
  }
;

list_of_path_terminals returns [RefCDOmSpecifyTerminalList returned]
  { RefCDOmExprLink exprLink; }
: exprLink=specify_terminal_descriptor 
  { returned = CDOmSpecifyTerminalList::build(exprLink->getLineNumber(), exprLink); }
  ( exprLink=specify_terminal_descriptor 
    { returned->addItem(exprLink); }
  )*
;

// A.7.3 Specify block terminals
specify_terminal_descriptor returns [RefCDOmExprLink returnedExprLink]
  {
    pair<RefString, int> id;
    RefCDOmRangeExpr rangeExpr;
  }
: #(SPECIFY_TERMINAL_DESCRIPTOR
    id=identifier 
    { returnedExprLink = CDOmExprLink::build(id.second, id.first); }
    ( rangeExpr=range_expression 
      { returnedExprLink->setRangeExpr(rangeExpr); }
    )?
  )
;

// A.7.4 Specify path delays
list_of_path_delay_expressions returns [RefCDOmMinTypMaxList returned]
  { RefCDOmMinTypMax mintypmax; }
: #(lopde:LIST_OF_PATH_DELAY_EXPRESSIONS
    mintypmax=mintypmax_expression
    { returned = CDOmMinTypMaxList::build(#lopde->getLine(), mintypmax); }
    ( mintypmax=mintypmax_expression 
      { returned->addItem(mintypmax); }
    )*
  )
;

edge_identifier returns [CDOmPathDecl::EPathDeclEdgeIdenfier returned]
: K_POSEDGE { returned = CDOmPathDecl::PATH_DECL_POSEDGE; }
| K_NEGEDGE { returned = CDOmPathDecl::PATH_DECL_NEGEDGE; }
;

state_dependent_path_declaration [RefCDOmSpecifyBlock parent]
  { RefCDOmExpr expr; }
: #(K_IF 
    expr=expression 
    simple_or_edge_sensitive_path_declaration [parent, expr, false]
  )
  { PRINT_AST(#K_IF); }
| #(K_IFNONE 
    simple_or_edge_sensitive_path_declaration [parent, RefCDOmExpr(), true]
  ) // ONLY simple
;

polarity_operator returns [CDOmPathDecl::EPathDeclPolarityOp returned]
: #(POLARITY_OPERATOR 
    ( PLUS  { returned=CDOmPathDecl::PATH_DECL_PLUS; }
    | MINUS { returned=CDOmPathDecl::PATH_DECL_MINUS; }
    | PO_NEG { returned=CDOmPathDecl::PATH_DECL_MINUS; }
    | PO_POS { returned=CDOmPathDecl::PATH_DECL_PLUS; }
    )
  )
  { PRINT_AST(#POLARITY_OPERATOR); }
;

// A.7.5 System timing checks
// A.7.5.1 System timing check commands
system_timing_check [ RefCDOmSpecifyBlock parent ]
: setup_timing_check     [parent]
| hold_timing_check      [parent]
| setuphold_timing_check [parent]
| recovery_timing_check  [parent]
| removal_timing_check   [parent]
| recrem_timing_check    [parent]
| skew_timing_check      [parent]
| timeskew_timing_check  [parent]
| fullskew_timing_check  [parent]
| period_timing_check    [parent]
| width_timing_check     [parent]
| nochange_timing_check  [parent]
;

setup_timing_check [ RefCDOmSpecifyBlock parent ]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(kssetup:K_S_SETUP
    ev1=timing_check_event 
    ev2=timing_check_event 
    expr=expression
    ( COMMA 
      ( id=identifier )? 
    )?
  // In all system timing checks
  // COMMA was left in AST to remove ambiguity
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildSetup(#kssetup->getLine(),  parent, ev1, ev2, expr, exprLink );
  }
;

hold_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(kshold:K_S_HOLD
    ev1=timing_check_event 
    ev2=timing_check_event 
    expr=expression
    ( COMMA 
      ( id=identifier )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildHold(#kshold->getLine(),  parent, ev1, ev2, expr, exprLink );
  }
;

setuphold_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr1, expr2; 
    RefCDOmMinTypMax expr3 = RefCDOmMinTypMax(), expr4 = RefCDOmMinTypMax();
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
    RefCDOmDelayedDataOrReference delayedData1 = RefCDOmDelayedDataOrReference(), delayedData2 = RefCDOmDelayedDataOrReference();
  }
: #(ks:K_S_SETUPHOLD
    ev1=timing_check_event 
    ev2=timing_check_event
    expr1=expression 
    expr2=expression
    (COMMA 
      ( id=identifier )?
      (COMMA 
        ( expr3=mintypmax_expression )?
        (COMMA 
          ( expr4=mintypmax_expression )?
          (COMMA 
            ( delayedData1=delayed_data_or_reference )?
            (COMMA 
              ( delayedData2=delayed_data_or_reference )?
            )?
          )?
        )?
      )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildSetuphold(#ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink, expr3, expr4, delayedData1, delayedData2 );
  }
;

recovery_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(ks:K_S_RECOVERY
    ev1=timing_check_event 
    ev2=timing_check_event 
    expr=expression
    (COMMA 
      ( id=identifier )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildRecovery(#ks->getLine(),  parent, ev1, ev2, expr, exprLink );
  }
;

removal_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(ks:K_S_REMOVAL
    ev1=timing_check_event 
    ev2=timing_check_event 
    expr=expression
    (COMMA 
      ( id=identifier )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildRemoval(#ks->getLine(),  parent, ev1, ev2, expr, exprLink );
  }
;

recrem_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr1, expr2;
    RefCDOmMinTypMax mintypmax1 = RefCDOmMinTypMax(), mintypmax2 = RefCDOmMinTypMax();
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
    RefCDOmDelayedDataOrReference delayedData1 = RefCDOmDelayedDataOrReference(), delayedData2 = RefCDOmDelayedDataOrReference();
  }
: #(ks:K_S_RECREM
    ev1=timing_check_event 
    ev2=timing_check_event
    expr1=expression 
    expr2=expression
    (COMMA ( id=identifier )?
      (COMMA ( mintypmax1=mintypmax_expression )?
        (COMMA ( mintypmax2=mintypmax_expression )?
          (COMMA ( delayedData1=delayed_data_or_reference )?
            (COMMA ( delayedData2=delayed_data_or_reference )?
            )?
          )?
        )?
      )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildRecrem(#ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink, mintypmax1, mintypmax2, delayedData1, delayedData2 );
  }
;

skew_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(ks:K_S_SKEW
    ev1=timing_check_event 
    ev2=timing_check_event 
    expr=expression
    (COMMA 
      ( id=identifier )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildSkew(#ks->getLine(),  parent, ev1, ev2, expr, exprLink);
  }
;

timeskew_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr1, expr2;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
    RefCDOmMinTypMax mintypmax;
  }
: #(ks:K_S_TIMESKEW
    ev1=timing_check_event 
    ev2=timing_check_event 
    expr1=expression
    (COMMA ( id=identifier )?
      (COMMA ( expr2=expression )? // constant expression
        (COMMA ( mintypmax=mintypmax_expression )? // constant expression, may be mintypmax
        )?
      )?    
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildTimeskew(#ks->getLine(),  parent, ev1, ev2, expr1, exprLink, expr2, mintypmax);
  }
;

fullskew_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmExpr expr1, expr2, expr3;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
    RefCDOmMinTypMax mintypmax;
  }
: #(ks:K_S_FULLSKEW
    ev1=timing_check_event 
    ev2=timing_check_event
    expr1=expression 
    expr2=expression
    (COMMA ( id=identifier )?
      (COMMA ( expr3=expression )? // constant expression
        (COMMA ( mintypmax=mintypmax_expression )? // constant expression, may be mintypmax
        )?
      )?    
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildFullskew(#ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink, expr3, mintypmax);
  }
;

period_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev;
    RefCDOmExpr expr;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(ks:K_S_PERIOD
    ev=controlled_timing_check_event
    expr=expression
    (COMMA 
      ( id=identifier )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildPeriod(#ks->getLine(),  parent, ev, expr, exprLink );
  }
;

width_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev;
    RefCDOmExpr expr1, expr2;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(ks:K_S_WIDTH
    ev=controlled_timing_check_event
    expr1=expression
    ( COMMA (expr2=expression)? // constant
      ( COMMA 
        ( id=identifier )?
      )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildWidth(#ks->getLine(),  parent, ev, expr1, expr2, exprLink );
  }
;

nochange_timing_check [RefCDOmSpecifyBlock parent]
  {
    RefCDOmTimingCheckEvent ev1, ev2;
    RefCDOmMinTypMax expr1, expr2;
    pair<RefString, int> id(RefString(), 0);
    RefCDOmExprLink exprLink = RefCDOmExprLink();
  }
: #(ks:K_S_NOCHANGE
    ev1=timing_check_event 
    ev2=timing_check_event
    expr1=mintypmax_expression // may be mintypmax
    expr2=mintypmax_expression // may be mintypmax
    (COMMA ( id=identifier )?
    )?
  )
  {
    if( id.first.get())
      exprLink = CDOmExprLink::build(id.second, id.first);
    CDOmSystemTimingCheck::buildNochange(#ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink );
  }
;

// A.7.5.2 System timing check command arguments
delayed_data_or_reference returns [RefCDOmDelayedDataOrReference returned]
  {
    pair<RefString, int> id;
    RefCDOmMinTypMax mintypmaxExpr = RefCDOmMinTypMax();
  }
: #(DELAYED_DATA_OR_REFERENCE
    id=identifier
    ( mintypmaxExpr=mintypmax_expression )? // constant expression, may be mintypmax
  )
  { returned = CDOmDelayedDataOrReference::build(id.second,  CDOmExprLink::build(id.second, id.first), mintypmaxExpr ); }
;

// A.7.5.3 System timing check event definitions
timing_check_event returns [RefCDOmTimingCheckEvent returnedEvent]
  { 
    RefCDOmTimingCheckEventControl timingCheckEventControl = RefCDOmTimingCheckEventControl();
    RefCDOmExpr expr = RefCDOmExpr();
    RefCDOmExprLink specTermDesc;
  }
: #(tce:TIMING_CHECK_EVENT
    ( timingCheckEventControl=timing_check_event_control )?
    specTermDesc=specify_terminal_descriptor
    ( expr=expression )?
  )
  { returnedEvent = CDOmTimingCheckEvent::build(#tce->getLine(), specTermDesc, timingCheckEventControl, expr ); }
;

controlled_timing_check_event returns [ RefCDOmTimingCheckEvent returnedEvent ]
  { 
    RefCDOmTimingCheckEventControl timingCheckEventControl;
    RefCDOmExpr expr = RefCDOmExpr();
    RefCDOmExprLink specTermDesc;
  }
: #(ctce:CONTROLLED_TIMING_CHECK_EVENT
    timingCheckEventControl=timing_check_event_control
    specTermDesc=specify_terminal_descriptor
    ( expr=expression )?
  )
  { returnedEvent = CDOmTimingCheckEvent::build(#ctce->getLine(), specTermDesc, timingCheckEventControl, expr ); }
;

timing_check_event_control returns [RefCDOmTimingCheckEventControl returned]
: kpos:K_POSEDGE { returned = CDOmTimingCheckEventControl::buildPosedge(#kpos->getLine()); }
| kneg:K_NEGEDGE { returned = CDOmTimingCheckEventControl::buildNegedge(#kneg->getLine()); }
| returned=edge_control_specifier
;

edge_control_specifier returns [RefCDOmTimingCheckEventControl returned]
  {
    CDOmTimingCheckEventControl::EEdgeDescriptor edgeDesc;
  }
: #(kedge:K_EDGE 
    { returned = CDOmTimingCheckEventControl::buildEdge(#kedge->getLine()); }
    ( edgeDesc=edge_descriptor 
      {
        returned->addEdgeDescriptor(edgeDesc);
      }
    )+
  )
  { PRINT_AST(#K_EDGE); }
;

edge_descriptor returns [ CDOmTimingCheckEventControl::EEdgeDescriptor returned ]
  {
    string text;
    TBool valid = true;
  }
: ( un:UNSIGNED_NUMBER { text = un->getText(); }
  | id:IDENTIFIER { text = id->getText(); }
  | ed:EDGE_DESC { text = ed->getText(); }
  )
  { text.size() == 2 }?
  {
    switch(text[0]) {
      case '0':
        switch(text[1]) {
          case '1':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_01;
            break;
          case 'x':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0x;
            break;
          case 'X':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0X;
            break;
          case 'z':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0z;
            break;
          case 'Z':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_0Z;
            break;
          default: valid = false;
        }
        break;
      case '1':
        switch(text[1]) {
          case '0':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_10;
            break;
          case 'x':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1x;
            break;
          case 'X':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1X;
            break;
          case 'z':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1z;
            break;
          case 'Z':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_1Z;
            break;
          default: valid = false;
        }
        break;
      case 'x':
        switch(text[1]) {
          case '0':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_x0;
            break;
          case '1':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_x1;
            break;
          default: valid = false;
        }
        break;
      case 'X':
        switch(text[1]) {
          case '0':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_X0;
            break;
          case '1':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_X1;
            break;
          default: valid = false;
        }
        break;
      case 'z':
        switch(text[1]) {
          case '0':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_z0;
            break;
          case '1':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_z1;
            break;
          default: valid = false;
        }
        break;
      case 'Z':
        switch(text[1]) {
          case '0':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_Z0;
            break;
          case '1':
            returned=CDOmTimingCheckEventControl::TIMING_CHECK_EV_KEY_Z1;
            break;
          default: valid = false;
        }
        break;
      default:
        valid = false;
    }
  }
  { valid }?
;

//PRIORITY 5
// A.8 Expressions
// A.8.1 Concatenations
concatenation returns [RefCDOmExprConcat returnedExpr]
  { RefCDOmExpr expr; }
: #(cnc:CONCATENATION 
    ( expr=expression { returnedExpr = CDOmExprConcat::build(#cnc->getLine(), expr); } )
    ( expr=expression { returnedExpr->addExpr(expr); } )*
  )
  { PRINT_AST(#CONCATENATION); }
;

multiple_concatenation returns [RefCDOmExprMultiConcat returnedExpr]
{
  RefCDOmExprConcat exprConcat;
  RefCDOmExpr expr;
}
: #(mc:MULTI_CONCATENATION expr=expression exprConcat=concatenation)
  { 
    PRINT_AST(#MULTI_CONCATENATION); 
    //expr should be constant
    returnedExpr = CDOmExprMultiConcat::build(#mc->getLine(), expr, exprConcat);
  }
;

// A.8.2 Function call
function_call  returns [RefCDOmFunctionCall returnedFunctionCall]
  {
    RefCDOmExprLink exprLink;
    RefCDOmAttrListCollection attrListColl;
    RefCDOmListExpr exprList;
  }
: #(fc:FUNCTION_CALL
    (exprLink=hierarchical_identifier | exprLink=expr_primary_identifier)
    attrListColl=attrs_opt
    exprList=expression_list
    { returnedFunctionCall = CDOmFunctionCall::build(#fc->getLine(),  exprLink, exprList, attrListColl ); }
  )
  { PRINT_AST(#FUNCTION_CALL); }
;

system_function_call returns [RefCDOmFunctionCall returnedFunctionCall]
  {
    RefCDOmListExpr exprList = RefCDOmListExpr();
    RefString str;
  }
: #(sfc:SYSTEM_FUNCTION_CALL
    str=system_function_name 
    ( exprList=expression_list )?
    { returnedFunctionCall = CDOmFunctionCall::build(#sfc->getLine(),  CDOmExprLink::build(#sfc->getLine(), str), exprList ); }
  )
  { PRINT_AST(#SYSTEM_FUNCTION_CALL); }
;

// A.8.3 Expressions
expression_list returns [RefCDOmListExpr exprList]
  { RefCDOmExpr expr; }
: #( el:EXPRESSION_LIST 
    expr = expression 
    { exprList=CDOmListExpr::build(#el->getLine(), expr); }
    ( expr = expression { exprList->addItem(expr); } )*
  )
  { PRINT_AST(#EXPRESSION_LIST); }
;

range_expression returns [RefCDOmRangeExpr rangeExpr]
  {
    RefCDOmExpr expr1, expr2;
    CDOmRangeExpr::ERangeExprType exprType = CDOmRangeExpr::RANGE_EXPR_DOUBLE;
  }
: expr1=expression
  { rangeExpr = CDOmRangeExpr::buildSingleRangeExpr(expr1->getLineNumber(), expr1); }
| #( re:RANGE_EXPRESSION
    expr1=expression
    ( COLON
    | PO_POS { exprType = CDOmRangeExpr::RANGE_EXPR_PLUS; }
    | PO_NEG { exprType = CDOmRangeExpr::RANGE_EXPR_MINUS; }
    )
    expr2=expression
  )
  { rangeExpr = CDOmRangeExpr::buildDoubleRangeExpr(#re->getLine(), expr1, expr2, exprType); }
;

expression returns [RefCDOmExpr expr]
  {
    RefCDOmExpr e1, e2, e3;
    RefCDOmAttrListCollection exprColl;
    RefCDOmExprOp exprOp;
  }
: (
    #(EXPRESSION expr=expression)
    { PRINT_AST(#EXPRESSION); }
  | expr=expr_primary
  | #(root01:U_PLUS  exprColl=attrs_opt e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root01->getLine(), CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root02:U_MINUS exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root02->getLine(), CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root03:LNOT    exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root03->getLine(), CDOmExprOp::OP_UNARY_LOGIC_NOT, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root04:NOT     exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root04->getLine(), CDOmExprOp::OP_UNARY_BITWISE_NOT, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root05:U_AND   exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root05->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_AND, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root06:U_NAND  exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root06->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_NAND, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root07:U_OR    exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root07->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_OR, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root08:U_NOR   exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root08->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_NOR, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root09:U_XOR   exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root09->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_XOR, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root10:U_XNOR  exprColl=attrs_opt  e1=expression)
    { 
      exprOp = CDOmExprOp::build(#root10->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_XNOR, e1);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root11:POW e1=expression exprColl=attrs_opt e2=expression) 
    { 
      exprOp = CDOmExprOp::build(#root11->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_POW, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root12:STAR e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root12->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root13:DIV e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root13->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_DIV, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root14:MOD e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root14->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_MOD, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root15:PLUS e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root15->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root16:MINUS e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root16->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root17:SL e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root17->getLine(), CDOmExprOp::OP_BINARY_SHIFT_LEFT, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root18:SSL e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root18->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root19:SR e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root19->getLine(), CDOmExprOp::OP_BINARY_SHIFT_RIGHT, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root20:SSR e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root20->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root21:LT_ e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root21->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_LESS, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root22:GT e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root22->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_GREATER, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root23:LE e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root23->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root24:GE e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root24->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root25:EQUAL e1=expression exprColl=attrs_opt  e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root25->getLine(), CDOmExprOp::OP_BINARY_EQUALITY_EQ, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root26:NOT_EQ e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root26->getLine(), CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root27:NOT_EQ_CASE e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root27->getLine(), CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root28:EQ_CASE e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root28->getLine(), CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root29:AND e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root29->getLine(), CDOmExprOp::OP_BINARY_BITWISE_AND, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root30:NAND e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root30->getLine(), CDOmExprOp::OP_BINARY_BITWISE_NAND, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root31:XOR e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root31->getLine(), CDOmExprOp::OP_BINARY_BITWISE_XOR, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root32:XNOR e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root32->getLine(), CDOmExprOp::OP_BINARY_BITWISE_XNOR, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root33:OR e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root33->getLine(), CDOmExprOp::OP_BINARY_BITWISE_OR, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root34:NOR e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root34->getLine(), CDOmExprOp::OP_BINARY_BITWISE_NOR, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root35:LAND e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root35->getLine(), CDOmExprOp::OP_BINARY_LOGIC_AND, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root36:LOR e1= expression exprColl=attrs_opt e2=expression)
    { 
      exprOp = CDOmExprOp::build(#root36->getLine(), CDOmExprOp::OP_BINARY_LOGIC_OR, e1, e2);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | #(root37:QUESTION e1= expression exprColl=attrs_opt e2=expression e3= expression)
    { 
      exprOp = CDOmExprOp::build(#root37->getLine(), CDOmExprOp::OP_TERNARY_COND, e1, e2, e3);
      if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
      expr = exprOp;
    }
  | expr=mintypmax_expression
  )
;

expr_primary returns [RefCDOmExpr expr] 
: expr = expr_primary_number
| expr = str
| expr = expr_primary_identifier
| expr = concatenation
| expr = multiple_concatenation
| expr = function_call
| expr = system_function_call
;

//mintypmax_expression is mached only on MINTYPMAX_EXPRESSION token node subtree
//the parser was modifed to create such tree configuration
mintypmax_expression returns [RefCDOmMinTypMax minTypMax]
  {
    RefCDOmExpr expr1, expr2, expr3;
    bool test = false; //used to check if there is one expression or three expressions in the subtree
  }
: #( me:MINTYPMAX_EXPRESSION 
    expr1=expression 
    ( expr2=expression 
      expr3=expression
      {test = true;}
    )?
    { 
      if(test) 
        minTypMax = CDOmMinTypMax::build(#me->getLine(),  expr1, expr2, expr3);
      else
        minTypMax = CDOmMinTypMax::build(#me->getLine(),  expr1);
    }
  )
; 

expr_primary_number  returns [RefCDOmExpr expr] 
: expr=number
;

// A.8.5 Expression left-side values
lvalue returns [RefCDOmExpr returnedLvalue]
  {
    RefCDOmExprLink exprLink; 
    RefCDOmExpr exprLvalue;
  }
: #(lv:LVALUE
    ( returnedLvalue=expr_primary_identifier
    | exprLvalue=lvalue 
      { returnedLvalue = CDOmExprConcat::build(#lv->getLine(),  exprLvalue ); }
      ( exprLvalue=lvalue
        { (boost::static_pointer_cast<CDOmExprConcat>(returnedLvalue))->addExpr( exprLvalue ); }
      )*
    )
  )
  { PRINT_AST(#LVALUE); }
;

// A.8.7 Numbers
//This Adapter class should do the trick and convert the VerilogNumber into CDOmExpr
number returns [RefCDOmExpr returnedExpr]
  { CCDOMAdapter adapter = CCDOMAdapter::getInstance(); }
: returnedExpr=sized_number
| unsignedNumber:UNSIGNED_NUMBER
  { returnedExpr = adapter.convertToCDOmNumberFrom_UNSIGNED_NUMBER(#unsignedNumber->getLine(), #unsignedNumber->getNumber()); }
| basedNumber:BASED_NUMBER
  { returnedExpr = adapter.convertToCDOmNumberFrom_BASED_NUMBER(#basedNumber->getLine(), #basedNumber->getNumber()); }
| realNumber:REAL_NUMBER 
  { returnedExpr = adapter.convertToCDOmRealFrom_REAL_NUMBER(#realNumber->getLine(), #realNumber->getNumber()); }
; 

sized_number returns [RefCDOmNumber returnedNumber]
: #( sn:SIZED_NUMBER
    un:UNSIGNED_NUMBER 
    bn:BASED_NUMBER
  )
  { returnedNumber = CCDOMAdapter::getInstance().convertToCDOmNumberFrom_sized_number(#sn->getLine(), #un->getNumber(), #bn->getNumber()); }
;

// A.8.8 Strings
str returns [RefCDOmString retNumber]
: str:STRING
  { retNumber = CDOmString::build(#str->getLine(),  _RS(#str->getText()), CCDOMAdapter::getInstance().getStringValue( _RS(#str->getText() ) ) ); }
;

//PRIORITY 3
// A.9.1 Attributes
// the rule now creates a new CDOmAttrCollection and adds a CDOmAttrList for every new list
attrs_opt returns [RefCDOmAttrListCollection attrColl]
  { attrColl = RefCDOmAttrListCollection(); }
: ( { if( !attrColl.get() ) attrColl = CDOmAttrListCollection::build(1); }
    attribute_instance [attrColl->buildAttrList(1)] 
  )*
;

attribute_instance [RefCDOmAttrList attrList]
  { 
    pair<RefString, int> name;
    RefCDOmExpr expr;
  }
: #(ATTRIBUTE_INSTANCE
    (
      #(ATTR_SPEC name=identifier
        { expr = RefCDOmExpr(); }
        (  expr=expression )? // constant
        { attrList->addAttr(name.second, name.first, expr); }
      )
    )*
  )
;

//PRIORITY 5
// A.9.3 Identifiers
identifier returns [pair<RefString, int> res] 
: id:IDENTIFIER { res = make_pair(_RS(id->getText()), #id->getLine()); }
| eid:ESCAPED_IDENTIFIER { res = make_pair(_RS(eid->getText()), #eid->getLine()); }
;

hierarchical_identifier returns [RefCDOmExprLink returnedExprLink]
  {
    pair<RefString, int> idName;
    RefCDOmExpr expr;
  }
: #(HIERARCHICAL_IDENTIFIER
    idName = identifier
    ( (expr = expression)? 
      {
        if(returnedExprLink.get() == NULL) {
          returnedExprLink = CDOmExprLink::build(idName.second, idName.first, expr);
        } else {
          returnedExprLink->addHidItem(idName.first, expr);
        }
      }
      idName=identifier
    )* // constant expression
    {
      if(returnedExprLink.get() == NULL) {
        returnedExprLink = CDOmExprLink::build(idName.second, idName.first);
      } else {
        returnedExprLink->addHidItem(idName.first);
      }
    }
  )
;

//The CDOM instantiation requires post instantiations 
// because of this, there is a counter witch indicates the state of the rule
// the meaning of the state is as follows
// count =-1; // start
// count = 0; // initial inside the rule
//            // increment the count ( state ) no building is done
// count = 1; // save temporary
//            // increment the count to the next state, no build is done
// count = 2; // create ExprList with temporary,
//            // add second expr to list, this is done to be in sync with the expressions
//            // this is possible because now we know that the only thing that can follow is a expression of a array indexes
//            // increment count ( state )
// count = 2; // do not increment count (the final case)
//            // add expression to list
// after parsing the sub-rule/rule, some instantiations are needed,
// count = 0; // means we just have to post-build the expression link object with no ranges and  etc.
// count = 1; // ( sub-rule ) we have to post build the expression link with one expression
//            // ( sub-rule ) or add a hid item to the existing expression link with one expression
//            // ( only at the end of the rule ) we have to build the expression link with no expression.
//            // ( only at the end of the rule ) or we have to add a hid item with no expression
//            // ( only at the end of the rule ) build an expression list with one expression and add it to the created expression link
// count > 1; // ( this case is valid only on the after the rule )
//            // we have to build the expression link with no expression
//            // or we have to add a hid item with no expression
//            // after that we have to add the expression list to the expression link
expr_primary_identifier returns[RefCDOmExprLink returnedExprLink]
  {
    pair<RefString, int> str;
    RefCDOmExpr currExpr=RefCDOmExpr(), prevExpr=RefCDOmExpr();
    TInt count = -1;
    RefCDOmListExpr exprList;
  }
: #( EXPR_PRIMARY_IDENTIFIER
    ( 
      {
        if( count == 0 ) {
          if( returnedExprLink.get() ){
            returnedExprLink->addHidItem( str.first );
          }
          else {
            returnedExprLink = CDOmExprLink::build(str.second,  str.first );
          }
        }
        else if( count == 1 ) {
          if( returnedExprLink.get() ) {
            returnedExprLink->addHidItem( str.first, currExpr );
          }
          else {
            returnedExprLink = CDOmExprLink::build(str.second,  str.first, currExpr );
          }
        }
        count = 0;
      }
      str = identifier
      ( 
        currExpr=expression
        {
          if( count == 2 ) {
            exprList->addItem( currExpr );
          }
          else {
            count++;
            if( count == 1 )
              prevExpr = currExpr;
            else if( count == 2 ) {
              exprList = CDOmListExpr::build(prevExpr->getLineNumber(),  prevExpr );
              exprList->addItem( currExpr );
            }
          }
        }
      )*
    )+
    {
      if( returnedExprLink.get() ) {
        returnedExprLink->addHidItem( str.first );
      }
      else {
        returnedExprLink = CDOmExprLink::build(str.second,  str.first );
      }

      if( count == 1 ) {
        returnedExprLink->setArrayIndexes( CDOmListExpr::build(currExpr->getLineNumber(),  currExpr ) );
      }
      else if( count > 1 ) {
        returnedExprLink->setArrayIndexes( exprList );
      }
    }
    ( 
      #( re:RANGE_EXPRESSION
        {
          CDOmRangeExpr::ERangeExprType exprType = CDOmRangeExpr::RANGE_EXPR_DOUBLE;
          RefCDOmRangeExpr rangeExpr;
        }
        currExpr=expression
        ( COLON
        | PO_POS { exprType = CDOmRangeExpr::RANGE_EXPR_PLUS ; }
        | PO_NEG { exprType = CDOmRangeExpr::RANGE_EXPR_MINUS; }
        )
        prevExpr=expression
      )
      { 
        rangeExpr = CDOmRangeExpr::buildDoubleRangeExpr(#re->getLine(), currExpr, prevExpr, exprType);
        returnedExprLink->setRangeExpr(rangeExpr);
      }
    )?
  )
;

system_function_name returns [RefString str]
: stn:SYSTEM_TASK_NAME
  { str = _RS(stn->getText()); }
;

// Extensions
/*
ivl_attribute_extension! 
  {
    RefString id;
    RefCDOmExpr str1, str2;
  }
: #(K_S_ATTRIBUTE id=identifier str1=str str2=str)
  { PRINT_AST(#K_S_ATTRIBUTE); }
;
*/
// End of File
