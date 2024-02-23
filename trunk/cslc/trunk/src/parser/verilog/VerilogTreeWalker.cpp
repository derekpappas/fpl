/* $ANTLR 2.7.7 (20060906): "verilog.walker.g" -> "VerilogTreeWalker.cpp"$ */
#include "VerilogTreeWalker.hpp"
#include <antlr/Token.hpp>
#include <antlr/AST.hpp>
#include <antlr/NoViableAltException.hpp>
#include <antlr/MismatchedTokenException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/BitSet.hpp>
#line 47 "verilog.walker.g"

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


#line 44 "VerilogTreeWalker.cpp"
VerilogTreeWalker::VerilogTreeWalker()
	: ANTLR_USE_NAMESPACE(antlr)TreeParser() {
}

void VerilogTreeWalker::source_text(RefVerAST _t,
	RefCDOmDesign design
) {
	RefVerAST source_text_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == K_PRIMITIVE || _t->getType() == MODULE_DEF || _t->getType() == ATTRIBUTE_INSTANCE)) {
			description(_t,design);
			_t = _retTree;
		}
		else {
			goto _loop3;
		}
		
	}
	_loop3:;
	} // ( ... )*
	_retTree = _t;
}

void VerilogTreeWalker::description(RefVerAST _t,
	RefCDOmDesign design
) {
	RefVerAST description_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 105 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrColl;
	
#line 80 "VerilogTreeWalker.cpp"
	
	attrColl=attrs_opt(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MODULE_DEF:
	{
		module(_t,design, attrColl);
		_t = _retTree;
		break;
	}
	case K_PRIMITIVE:
	{
		udp_declaration(_t,design, attrColl);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

RefCDOmAttrListCollection  VerilogTreeWalker::attrs_opt(RefVerAST _t) {
#line 3519 "verilog.walker.g"
	RefCDOmAttrListCollection attrColl;
#line 112 "VerilogTreeWalker.cpp"
	RefVerAST attrs_opt_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 3519 "verilog.walker.g"
	attrColl = RefCDOmAttrListCollection();
#line 116 "VerilogTreeWalker.cpp"
	
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == ATTRIBUTE_INSTANCE)) {
#line 3521 "verilog.walker.g"
			if( !attrColl.get() ) attrColl = CDOmAttrListCollection::build(1);
#line 125 "VerilogTreeWalker.cpp"
			attribute_instance(_t,attrColl->buildAttrList(1));
			_t = _retTree;
		}
		else {
			goto _loop744;
		}
		
	}
	_loop744:;
	} // ( ... )*
	_retTree = _t;
	return attrColl;
}

void VerilogTreeWalker::module(RefVerAST _t,
	RefCDOmDesign design, RefCDOmAttrListCollection attrColl
) {
	RefVerAST module_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST mod = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 115 "verilog.walker.g"
	
	pair<RefString, int> name; //Modified by Eugen, name type should be RefString
	RefCDOmModuleDecl moduleDecl;
	CDOmModuleDecl::EKeywordType kw;
	
#line 151 "VerilogTreeWalker.cpp"
	
	RefVerAST __t7 = _t;
	mod = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MODULE_DEF);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_MODULE:
	{
		RefVerAST tmp1_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MODULE);
		_t = _t->getNextSibling();
#line 123 "verilog.walker.g"
		kw = CDOmModuleDecl::KEYWORD_MODULE;
#line 168 "VerilogTreeWalker.cpp"
		break;
	}
	case K_MACROMODULE:
	{
		RefVerAST tmp2_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MACROMODULE);
		_t = _t->getNextSibling();
#line 124 "verilog.walker.g"
		kw = CDOmModuleDecl::KEYWORD_MACROMODULE;
#line 178 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	name=identifier(_t);
	_t = _retTree;
#line 127 "verilog.walker.g"
	
	moduleDecl = design->buildModuleDecl(mod->getLine(), name.first, kw);
	if(attrColl.get()) moduleDecl->setAttrListCollection(attrColl);
	
#line 194 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MODULE_PARAMETER_PORT_LIST:
	{
		module_parameter_port_list(_t,moduleDecl);
		_t = _retTree;
		break;
	}
	case 3:
	case K_ALWAYS:
	case K_ASSIGN:
	case K_DEFPARAM:
	case K_EVENT:
	case K_FUNCTION:
	case K_GENERATE:
	case K_GENVAR:
	case K_INITIAL:
	case K_INOUT:
	case K_INPUT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_OUTPUT:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_SPECIFY:
	case K_SPECPARAM:
	case K_TASK:
	case K_TIME:
	case LIST_OF_PORT_DECLARATIONS:
	case PORT:
	case ATTRIBUTE_INSTANCE:
	case NET_DECLARATION:
	case GATE_INSTANTIATION:
	case MODULE_OR_UDP_INSTANTIATION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case LIST_OF_PORT_DECLARATIONS:
	{
		list_of_port_declarations(_t,moduleDecl);
		_t = _retTree;
		break;
	}
	case PORT:
	{
		list_of_ports(_t,moduleDecl);
		_t = _retTree;
		break;
	}
	case 3:
	case K_ALWAYS:
	case K_ASSIGN:
	case K_DEFPARAM:
	case K_EVENT:
	case K_FUNCTION:
	case K_GENERATE:
	case K_GENVAR:
	case K_INITIAL:
	case K_INOUT:
	case K_INPUT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_OUTPUT:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_SPECIFY:
	case K_SPECPARAM:
	case K_TASK:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	case NET_DECLARATION:
	case GATE_INSTANTIATION:
	case MODULE_OR_UDP_INSTANTIATION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_0.member(_t->getType()))) {
			module_item(_t,moduleDecl);
			_t = _retTree;
		}
		else {
			goto _loop12;
		}
		
	}
	_loop12:;
	} // ( ... )*
	_t = __t7;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::udp_declaration(RefVerAST _t,
	RefCDOmDesign design, RefCDOmAttrListCollection declColl
) {
	RefVerAST udp_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1620 "verilog.walker.g"
	
	pair<RefString, int> id; 
	RefCDOmUdpDecl udpDecl;
	
#line 322 "VerilogTreeWalker.cpp"
	
	RefVerAST __t398 = _t;
	RefVerAST tmp3_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PRIMITIVE);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 1627 "verilog.walker.g"
	
	udpDecl = design->buildUdpDecl(id.second, id.first); 
	if(declColl.get()) udpDecl->setAttrListCollection(declColl);
	
#line 335 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UDP_PORT_LIST:
	{
		udp_port_list(_t,udpDecl);
		_t = _retTree;
		break;
	}
	case UDP_DECLARATION_PORT_LIST:
	{
		udp_declaration_port_list(_t, udpDecl );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_1.member(_t->getType()))) {
			udp_port_declaration(_t, udpDecl );
			_t = _retTree;
		}
		else {
			goto _loop401;
		}
		
	}
	_loop401:;
	} // ( ... )*
	udp_body(_t, udpDecl );
	_t = _retTree;
	_t = __t398;
	_t = _t->getNextSibling();
	_retTree = _t;
}

pair<RefString, int>  VerilogTreeWalker::identifier(RefVerAST _t) {
#line 3544 "verilog.walker.g"
	pair<RefString, int> res;
#line 383 "VerilogTreeWalker.cpp"
	RefVerAST identifier_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST id = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST eid = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	{
		id = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
		_t = _t->getNextSibling();
#line 3545 "verilog.walker.g"
		res = make_pair(_RS(id->getText()), id->getLine());
#line 398 "VerilogTreeWalker.cpp"
		break;
	}
	case ESCAPED_IDENTIFIER:
	{
		eid = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ESCAPED_IDENTIFIER);
		_t = _t->getNextSibling();
#line 3546 "verilog.walker.g"
		res = make_pair(_RS(eid->getText()), eid->getLine());
#line 408 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return res;
}

void VerilogTreeWalker::module_parameter_port_list(RefVerAST _t,
	RefCDOmModuleDecl moduleDecl
) {
	RefVerAST module_parameter_port_list_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST mppl = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 143 "verilog.walker.g"
	
	RefCDOmParamDeclCollection declColl; 
	RefCDOmAttrHolder attrHolder;
	
#line 430 "VerilogTreeWalker.cpp"
	
	RefVerAST __t14 = _t;
	mppl = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MODULE_PARAMETER_PORT_LIST);
	_t = _t->getFirstChild();
#line 149 "verilog.walker.g"
	
	moduleDecl->buildParamDeclCollection(mppl->getLine()); 
	declColl = moduleDecl->getParamDeclCollection();
	
#line 441 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt16=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == K_PARAMETER)) {
			attrHolder=parameter_declaration(_t,declColl);
			_t = _retTree;
		}
		else {
			if ( _cnt16>=1 ) { goto _loop16; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt16++;
	}
	_loop16:;
	}  // ( ... )+
	_t = __t14;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::list_of_port_declarations(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST list_of_port_declarations_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 162 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl;
	RefCDOmPortDecl portDecl;
	
#line 473 "VerilogTreeWalker.cpp"
	
	RefVerAST __t21 = _t;
	RefVerAST tmp4_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LIST_OF_PORT_DECLARATIONS);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt23=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			attrListColl=attrs_opt(_t);
			_t = _retTree;
			portDecl=port_declaration(_t,parent);
			_t = _retTree;
#line 170 "verilog.walker.g"
			if(attrListColl.get()) portDecl->setAttrListCollection(attrListColl);
#line 491 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt23>=1 ) { goto _loop23; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt23++;
	}
	_loop23:;
	}  // ( ... )+
	_t = __t21;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::list_of_ports(RefVerAST _t,
	RefCDOmModuleDecl moduleDecl
) {
	RefVerAST list_of_ports_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{ // ( ... )+
	int _cnt19=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == PORT)) {
			port(_t,moduleDecl);
			_t = _retTree;
		}
		else {
			if ( _cnt19>=1 ) { goto _loop19; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt19++;
	}
	_loop19:;
	}  // ( ... )+
	_retTree = _t;
}

void VerilogTreeWalker::module_item(RefVerAST _t,
	RefCDOmModuleDecl moduleDecl
) {
	RefVerAST module_item_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 228 "verilog.walker.g"
	
	RefCDOmAttrHolder attrHolder;
	RefCDOmAttrListCollection attrListColl;
	
#line 540 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ALWAYS:
	case K_ASSIGN:
	case K_DEFPARAM:
	case K_EVENT:
	case K_FUNCTION:
	case K_GENVAR:
	case K_INITIAL:
	case K_INOUT:
	case K_INPUT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_OUTPUT:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_SPECPARAM:
	case K_TASK:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	case NET_DECLARATION:
	case GATE_INSTANTIATION:
	case MODULE_OR_UDP_INSTANTIATION:
	{
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_INOUT:
		case K_INPUT:
		case K_OUTPUT:
		{
			attrHolder=port_declaration(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		case K_ALWAYS:
		case K_ASSIGN:
		case K_DEFPARAM:
		case K_EVENT:
		case K_FUNCTION:
		case K_GENVAR:
		case K_INITIAL:
		case K_INTEGER:
		case K_REAL:
		case K_REALTIME:
		case K_REG:
		case K_TASK:
		case K_TIME:
		case NET_DECLARATION:
		case GATE_INSTANTIATION:
		case MODULE_OR_UDP_INSTANTIATION:
		{
			attrHolder=module_or_generate_item(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		case K_LOCALPARAM:
		{
			attrHolder=local_parameter_declaration(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		case K_PARAMETER:
		{
			attrHolder=parameter_declaration(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		case K_SPECPARAM:
		{
			attrHolder=specparam_declaration(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 240 "verilog.walker.g"
		if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 630 "VerilogTreeWalker.cpp"
		break;
	}
	case K_GENERATE:
	case K_SPECIFY:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SPECIFY:
		{
			specify_block(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		case K_GENERATE:
		{
			generated_instantiation(_t, moduleDecl );
			_t = _retTree;
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

RefCDOmParamDecl  VerilogTreeWalker::parameter_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 319 "verilog.walker.g"
	RefCDOmParamDecl returnedParamDecl;
#line 673 "VerilogTreeWalker.cpp"
	RefVerAST parameter_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST pr = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 319 "verilog.walker.g"
	
	TBool sgn = FALSE;
	RefCDOmRange rng;
	CDOmParamDecl::EParamType paramType = CDOmParamDecl::PARAM_NA;
	
#line 682 "VerilogTreeWalker.cpp"
	
	RefVerAST __t58 = _t;
	pr = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PARAMETER);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	case RANGE:
	case PARAM_ASSIGNMENT:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp5_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 326 "verilog.walker.g"
			sgn = TRUE;
#line 707 "VerilogTreeWalker.cpp"
			break;
		}
		case RANGE:
		case PARAM_ASSIGNMENT:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			rng=range(_t);
			_t = _retTree;
			break;
		}
		case PARAM_ASSIGNMENT:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 328 "verilog.walker.g"
		
		returnedParamDecl = CDOmParamDecl::build(pr->getLine(), parent, CDOmParamDecl::PARAM_DECL_SIMPLE);
		if (sgn)
		returnedParamDecl->setSigned();
		if (rng.get() != NULL)
		returnedParamDecl->setRange(rng);
		
#line 749 "VerilogTreeWalker.cpp"
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_TIME:
	{
		paramType=parameter_type(_t);
		_t = _retTree;
#line 336 "verilog.walker.g"
		returnedParamDecl = CDOmParamDecl::build(pr->getLine(), parent, CDOmParamDecl::PARAM_DECL_SIMPLE, paramType);
#line 761 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	list_of_param_assignments(_t,returnedParamDecl);
	_t = _retTree;
	_t = __t58;
	_t = _t->getNextSibling();
#line 340 "verilog.walker.g"
	PRINT_AST(K_PARAMETER);
#line 776 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedParamDecl;
}

void VerilogTreeWalker::port(RefVerAST _t,
	RefCDOmModuleDecl moduleDecl
) {
	RefVerAST port_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST pt = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 175 "verilog.walker.g"
	RefCDOmPortItem portItem;
#line 788 "VerilogTreeWalker.cpp"
	
	RefVerAST __t25 = _t;
	pt = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PORT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case PORT_EXPRESSION:
	{
		port_expression(_t,moduleDecl, RefString());
		_t = _retTree;
		break;
	}
	case NAMED_PORT_EXPRESSION:
	{
		named_port_expression(_t,moduleDecl);
		_t = _retTree;
		break;
	}
	case 3:
	{
#line 181 "verilog.walker.g"
		portItem = moduleDecl->buildPortItem(pt->getLine(), CDOmPortItem::PORT_ITEM_EMPTY);
#line 814 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t25;
	_t = _t->getNextSibling();
#line 184 "verilog.walker.g"
	PRINT_AST(PORT);
#line 827 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

RefCDOmPortDecl  VerilogTreeWalker::port_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 220 "verilog.walker.g"
	RefCDOmPortDecl returned;
#line 836 "VerilogTreeWalker.cpp"
	RefVerAST port_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INOUT:
	{
		returned=inout_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INPUT:
	{
		returned=input_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_OUTPUT:
	{
		returned=output_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::port_expression(RefVerAST _t,
	RefCDOmModuleDecl moduleDecl, const RefString named
) {
	RefVerAST port_expression_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST pe = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t30 = _t;
	pe = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PORT_EXPRESSION);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case PORT_REFERENCE:
	{
		port_reference(_t, moduleDecl->buildPortItem(pe->getLine(),  CDOmPortItem::PORT_ITEM_SIMPLE, named) );
		_t = _retTree;
		break;
	}
	case PORT_REFERENCE_CONCAT:
	{
		port_reference_concat(_t, moduleDecl->buildPortItem(pe->getLine(),  CDOmPortItem::PORT_ITEM_CONCAT, named) );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t30;
	_t = _t->getNextSibling();
#line 198 "verilog.walker.g"
	PRINT_AST(PORT_EXPRESSION);
#line 905 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::named_port_expression(RefVerAST _t,
	RefCDOmModuleDecl moduleDecl
) {
	RefVerAST named_port_expression_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 187 "verilog.walker.g"
	pair<RefString, int> named;
#line 915 "VerilogTreeWalker.cpp"
	
	RefVerAST __t28 = _t;
	RefVerAST tmp6_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NAMED_PORT_EXPRESSION);
	_t = _t->getFirstChild();
	named=identifier(_t);
	_t = _retTree;
	port_expression(_t,moduleDecl, named.first);
	_t = _retTree;
	_t = __t28;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::port_reference(RefVerAST _t,
	RefCDOmPortItem portItem
) {
	RefVerAST port_reference_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST pr = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 206 "verilog.walker.g"
	
	pair<RefString, int> name;
	RefCDOmRangeExpr rangeExpr;
	
#line 940 "VerilogTreeWalker.cpp"
	
	RefVerAST __t37 = _t;
	pr = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PORT_REFERENCE);
	_t = _t->getFirstChild();
	name=identifier(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case RANGE_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		rangeExpr=range_expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t37;
	_t = _t->getNextSibling();
#line 212 "verilog.walker.g"
	
	RefCDOmExprLink exprLink = CDOmExprLink::build(pr->getLine(), name.first);
	if( rangeExpr.get() )
	exprLink->setRangeExpr(rangeExpr);
	portItem->addPortExprLink(exprLink);
	
#line 1026 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::port_reference_concat(RefVerAST _t,
	RefCDOmPortItem portItem
) {
	RefVerAST port_reference_concat_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST __t33 = _t;
	RefVerAST tmp7_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PORT_REFERENCE_CONCAT);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt35=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == PORT_REFERENCE)) {
			port_reference(_t,portItem);
			_t = _retTree;
		}
		else {
			if ( _cnt35>=1 ) { goto _loop35; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt35++;
	}
	_loop35:;
	}  // ( ... )+
	_t = __t33;
	_t = _t->getNextSibling();
#line 203 "verilog.walker.g"
	PRINT_AST(tmp7_AST_in);
#line 1060 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

RefCDOmRangeExpr  VerilogTreeWalker::range_expression(RefVerAST _t) {
#line 3181 "verilog.walker.g"
	RefCDOmRangeExpr rangeExpr;
#line 1067 "VerilogTreeWalker.cpp"
	RefVerAST range_expression_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST re = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3181 "verilog.walker.g"
	
	RefCDOmExpr expr1, expr2;
	CDOmRangeExpr::ERangeExprType exprType = CDOmRangeExpr::RANGE_EXPR_DOUBLE;
	
#line 1075 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr1=expression(_t);
		_t = _retTree;
#line 3187 "verilog.walker.g"
		rangeExpr = CDOmRangeExpr::buildSingleRangeExpr(expr1->getLineNumber(), expr1);
#line 1134 "VerilogTreeWalker.cpp"
		break;
	}
	case RANGE_EXPRESSION:
	{
		RefVerAST __t686 = _t;
		re = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE_EXPRESSION);
		_t = _t->getFirstChild();
		expr1=expression(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COLON:
		{
			RefVerAST tmp8_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
			_t = _t->getNextSibling();
			break;
		}
		case PO_POS:
		{
			RefVerAST tmp9_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_POS);
			_t = _t->getNextSibling();
#line 3191 "verilog.walker.g"
			exprType = CDOmRangeExpr::RANGE_EXPR_PLUS;
#line 1163 "VerilogTreeWalker.cpp"
			break;
		}
		case PO_NEG:
		{
			RefVerAST tmp10_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
			_t = _t->getNextSibling();
#line 3192 "verilog.walker.g"
			exprType = CDOmRangeExpr::RANGE_EXPR_MINUS;
#line 1173 "VerilogTreeWalker.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		expr2=expression(_t);
		_t = _retTree;
		_t = __t686;
		_t = _t->getNextSibling();
#line 3196 "verilog.walker.g"
		rangeExpr = CDOmRangeExpr::buildDoubleRangeExpr(re->getLine(), expr1, expr2, exprType);
#line 1188 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return rangeExpr;
}

RefCDOmPortDecl  VerilogTreeWalker::inout_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 368 "verilog.walker.g"
	RefCDOmPortDecl portDecl;
#line 1205 "VerilogTreeWalker.cpp"
	RefVerAST inout_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ino = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 368 "verilog.walker.g"
	
	pair<RefString, int> name;
	ECDOmNetType nt = NET_UNDEFINED;
	TBool sgn = FALSE;
	RefCDOmRange rng;
	
#line 1215 "VerilogTreeWalker.cpp"
	
	RefVerAST __t67 = _t;
	ino = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INOUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_TRI:
	case K_TRI0:
	case K_TRI1:
	case K_TRIAND:
	case K_TRIOR:
	case K_WAND:
	case K_WIRE:
	case K_WOR:
	{
		nt=net_type(_t);
		_t = _retTree;
		break;
	}
	case K_SIGNED:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	{
		RefVerAST tmp11_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
		_t = _t->getNextSibling();
#line 377 "verilog.walker.g"
		sgn = TRUE;
#line 1264 "VerilogTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		rng=range(_t);
		_t = _retTree;
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 379 "verilog.walker.g"
	
	portDecl = CDOmPortDecl::buildNetPortDecl(ino->getLine(),  parent, PORT_INOUT, nt);
	if (sgn)
	portDecl->setSigned();
	if (rng.get() != NULL)
	portDecl->setRange(rng);
	
#line 1308 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt72=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			name=identifier(_t);
			_t = _retTree;
#line 387 "verilog.walker.g"
			portDecl->addPort(name.second, name.first);
#line 1319 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt72>=1 ) { goto _loop72; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt72++;
	}
	_loop72:;
	}  // ( ... )+
	_t = __t67;
	_t = _t->getNextSibling();
	_retTree = _t;
	return portDecl;
}

RefCDOmPortDecl  VerilogTreeWalker::input_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 392 "verilog.walker.g"
	RefCDOmPortDecl portDecl;
#line 1340 "VerilogTreeWalker.cpp"
	RefVerAST input_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST inpt = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 392 "verilog.walker.g"
	
	pair<RefString, int> name;
	ECDOmNetType nt = NET_UNDEFINED;
	TBool sgn = FALSE;
	RefCDOmRange rng;
	
#line 1350 "VerilogTreeWalker.cpp"
	
	RefVerAST __t74 = _t;
	inpt = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_TRI:
	case K_TRI0:
	case K_TRI1:
	case K_TRIAND:
	case K_TRIOR:
	case K_WAND:
	case K_WIRE:
	case K_WOR:
	{
		nt=net_type(_t);
		_t = _retTree;
		break;
	}
	case K_SIGNED:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	{
		RefVerAST tmp12_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
		_t = _t->getNextSibling();
#line 401 "verilog.walker.g"
		sgn = TRUE;
#line 1399 "VerilogTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		rng=range(_t);
		_t = _retTree;
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 403 "verilog.walker.g"
	
	portDecl = CDOmPortDecl::buildNetPortDecl(inpt->getLine(),  parent, PORT_INPUT, nt);
	if (sgn)
	portDecl->setSigned();
	if (rng.get() != NULL)
	portDecl->setRange(rng);
	
#line 1443 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt79=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			name=identifier(_t);
			_t = _retTree;
#line 411 "verilog.walker.g"
			
			portDecl->addPort(name.second, name.first);
			
#line 1456 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt79>=1 ) { goto _loop79; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt79++;
	}
	_loop79:;
	}  // ( ... )+
	_t = __t74;
	_t = _t->getNextSibling();
#line 416 "verilog.walker.g"
	PRINT_AST(K_INPUT);
#line 1470 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return portDecl;
}

RefCDOmPortDecl  VerilogTreeWalker::output_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 419 "verilog.walker.g"
	RefCDOmPortDecl portDecl;
#line 1480 "VerilogTreeWalker.cpp"
	RefVerAST output_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST out = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 419 "verilog.walker.g"
	
	pair<RefString, int> name;
	ECDOmNetType nt = NET_UNDEFINED;
	ECDOmVarType vt = VAR_UNDEFINED;
	TBool sgn = FALSE;
	RefCDOmRange rng;
	RefCDOmExpr expr;
	
#line 1492 "VerilogTreeWalker.cpp"
	
	RefVerAST __t81 = _t;
	out = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_TRI:
	case K_TRI0:
	case K_TRI1:
	case K_TRIAND:
	case K_TRIOR:
	case K_WAND:
	case K_WIRE:
	case K_WOR:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_TRI:
		case K_TRI0:
		case K_TRI1:
		case K_TRIAND:
		case K_TRIOR:
		case K_WAND:
		case K_WIRE:
		case K_WOR:
		{
			nt=net_type(_t);
			_t = _retTree;
			break;
		}
		case K_SIGNED:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp13_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 431 "verilog.walker.g"
			sgn = TRUE;
#line 1560 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			rng=range(_t);
			_t = _retTree;
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 433 "verilog.walker.g"
		
		portDecl = CDOmPortDecl::buildNetPortDecl(out->getLine(), parent, PORT_OUTPUT, nt);
		if (sgn)
		portDecl->setSigned();
		if (rng.get() != NULL)
		portDecl->setRange(rng);
		
#line 1604 "VerilogTreeWalker.cpp"
		{ // ( ... )+
		int _cnt87=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
				name=identifier(_t);
				_t = _retTree;
#line 441 "verilog.walker.g"
				
				portDecl->addPort(name.second, name.first);
				
#line 1617 "VerilogTreeWalker.cpp"
			}
			else {
				if ( _cnt87>=1 ) { goto _loop87; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt87++;
		}
		_loop87:;
		}  // ( ... )+
		break;
	}
	case K_INTEGER:
	case K_REG:
	case K_TIME:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_REG:
		{
			RefVerAST tmp14_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
			_t = _t->getNextSibling();
#line 445 "verilog.walker.g"
			vt = VAR_REG;
#line 1644 "VerilogTreeWalker.cpp"
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case K_SIGNED:
			{
				RefVerAST tmp15_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
				_t = _t->getNextSibling();
#line 446 "verilog.walker.g"
				sgn = TRUE;
#line 1656 "VerilogTreeWalker.cpp"
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			case RANGE:
			case VARIABLE_PORT_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case RANGE:
			{
				rng=range(_t);
				_t = _retTree;
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			case VARIABLE_PORT_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case K_INTEGER:
		case K_TIME:
		{
			vt=output_variable_type(_t);
			_t = _retTree;
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 450 "verilog.walker.g"
		
		portDecl = CDOmPortDecl::buildVarPortDecl(out->getLine(), parent, vt);
		if (sgn)
		portDecl->setSigned();
		if (rng.get() != NULL)
		portDecl->setRange(rng);
		
#line 1717 "VerilogTreeWalker.cpp"
		{ // ( ... )+
		int _cnt93=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				name=identifier(_t);
				_t = _retTree;
#line 458 "verilog.walker.g"
				portDecl->addPort(name.second, name.first);
#line 1731 "VerilogTreeWalker.cpp"
				break;
			}
			case VARIABLE_PORT_IDENTIFIER:
			{
				RefVerAST __t92 = _t;
				RefVerAST tmp16_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),VARIABLE_PORT_IDENTIFIER);
				_t = _t->getFirstChild();
				name=identifier(_t);
				_t = _retTree;
				expr=expression(_t);
				_t = _retTree;
#line 462 "verilog.walker.g"
				
				portDecl->addPort(name.second, name.first, expr);
				
#line 1748 "VerilogTreeWalker.cpp"
				_t = __t92;
				_t = _t->getNextSibling();
				break;
			}
			default:
			{
				if ( _cnt93>=1 ) { goto _loop93; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			}
			_cnt93++;
		}
		_loop93:;
		}  // ( ... )+
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t81;
	_t = _t->getNextSibling();
#line 469 "verilog.walker.g"
	PRINT_AST(K_OUTPUT);
#line 1774 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return portDecl;
}

RefCDOmAttrHolder  VerilogTreeWalker::module_or_generate_item(RefVerAST _t,
	RefCDOmBase parent
) {
#line 246 "verilog.walker.g"
	RefCDOmAttrHolder returned;
#line 1784 "VerilogTreeWalker.cpp"
	RefVerAST module_or_generate_item_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_EVENT:
	case K_FUNCTION:
	case K_GENVAR:
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TASK:
	case K_TIME:
	case NET_DECLARATION:
	{
		returned=module_or_generate_item_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_DEFPARAM:
	{
		returned=parameter_override(_t, parent );
		_t = _retTree;
		break;
	}
	case K_ASSIGN:
	{
		returned=continuous_assign(_t, parent );
		_t = _retTree;
		break;
	}
	case GATE_INSTANTIATION:
	{
		returned=gate_instantiation(_t, parent );
		_t = _retTree;
		break;
	}
	case MODULE_OR_UDP_INSTANTIATION:
	{
		returned=module_or_udp_instantiation(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INITIAL:
	{
		returned=initial_construct(_t, parent );
		_t = _retTree;
		break;
	}
	case K_ALWAYS:
	{
		returned=always_construct(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

RefCDOmParamDecl  VerilogTreeWalker::local_parameter_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 294 "verilog.walker.g"
	RefCDOmParamDecl returnedParamDecl;
#line 1855 "VerilogTreeWalker.cpp"
	RefVerAST local_parameter_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST lp = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 294 "verilog.walker.g"
	
	TBool sgn = FALSE;
	RefCDOmRange rng;
	CDOmParamDecl::EParamType paramType = CDOmParamDecl::PARAM_NA;
	
#line 1864 "VerilogTreeWalker.cpp"
	
	RefVerAST __t53 = _t;
	lp = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_LOCALPARAM);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	case RANGE:
	case PARAM_ASSIGNMENT:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp17_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 302 "verilog.walker.g"
			sgn = TRUE;
#line 1889 "VerilogTreeWalker.cpp"
			break;
		}
		case RANGE:
		case PARAM_ASSIGNMENT:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			rng=range(_t);
			_t = _retTree;
			break;
		}
		case PARAM_ASSIGNMENT:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 304 "verilog.walker.g"
		
		returnedParamDecl = CDOmParamDecl::build(lp->getLine(), parent, CDOmParamDecl::PARAM_DECL_LOCAL);
		if (sgn)
		returnedParamDecl->setSigned();
		if (rng.get() != NULL)
		returnedParamDecl->setRange(rng);
		
#line 1931 "VerilogTreeWalker.cpp"
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_TIME:
	{
		paramType=parameter_type(_t);
		_t = _retTree;
#line 312 "verilog.walker.g"
		returnedParamDecl = CDOmParamDecl::build(lp->getLine(), parent, CDOmParamDecl::PARAM_DECL_LOCAL, paramType);
#line 1943 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	list_of_param_assignments(_t,returnedParamDecl);
	_t = _retTree;
	_t = __t53;
	_t = _t->getNextSibling();
#line 316 "verilog.walker.g"
	PRINT_AST(K_LOCALPARAM);
#line 1958 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedParamDecl;
}

RefCDOmParamDecl  VerilogTreeWalker::specparam_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 343 "verilog.walker.g"
	RefCDOmParamDecl paramDecl;
#line 1968 "VerilogTreeWalker.cpp"
	RefVerAST specparam_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST sp = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 343 "verilog.walker.g"
	
	RefCDOmRange rng;
	
#line 1975 "VerilogTreeWalker.cpp"
	
	RefVerAST __t63 = _t;
	sp = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SPECPARAM);
	_t = _t->getFirstChild();
#line 348 "verilog.walker.g"
	
	paramDecl = CDOmParamDecl::build(sp->getLine(),  parent, CDOmParamDecl::PARAM_DECL_SPEC); 
	
#line 1985 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		rng=range(_t);
		_t = _retTree;
#line 352 "verilog.walker.g"
		paramDecl->setRange(rng);
#line 1996 "VerilogTreeWalker.cpp"
		break;
	}
	case PARAM_ASSIGNMENT:
	case PULSE_CONTROL_SPECPARAM:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	list_of_specparam_assignments(_t,paramDecl);
	_t = _retTree;
	_t = __t63;
	_t = _t->getNextSibling();
#line 356 "verilog.walker.g"
	PRINT_AST(K_SPECPARAM);
#line 2016 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return paramDecl;
}

void VerilogTreeWalker::specify_block(RefVerAST _t,
	RefCDOmModuleDecl parent
) {
	RefVerAST specify_block_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST spec = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2396 "verilog.walker.g"
	RefCDOmSpecifyBlock specBlock;
#line 2028 "VerilogTreeWalker.cpp"
	
	RefVerAST __t533 = _t;
	spec = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SPECIFY);
	_t = _t->getFirstChild();
#line 2399 "verilog.walker.g"
	specBlock = CDOmSpecifyBlock::build(spec->getLine(), parent);
#line 2036 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_3.member(_t->getType()))) {
			specify_item(_t,specBlock);
			_t = _retTree;
		}
		else {
			goto _loop535;
		}
		
	}
	_loop535:;
	} // ( ... )*
	_t = __t533;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::generated_instantiation(RefVerAST _t,
	RefCDOmModuleDecl parent
) {
	RefVerAST generated_instantiation_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kgen = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t364 = _t;
	kgen = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GENERATE);
	_t = _t->getFirstChild();
#line 1505 "verilog.walker.g"
	RefCDOmGenInst genInst = CDOmGenInst::build(kgen->getLine(), parent);
#line 2069 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_4.member(_t->getType()))) {
			generate_item(_t,genInst);
			_t = _retTree;
		}
		else {
			goto _loop366;
		}
		
	}
	_loop366:;
	} // ( ... )*
	_t = __t364;
	_t = _t->getNextSibling();
	_retTree = _t;
}

RefCDOmAttrHolder  VerilogTreeWalker::module_or_generate_item_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 256 "verilog.walker.g"
	RefCDOmAttrHolder returned;
#line 2095 "VerilogTreeWalker.cpp"
	RefVerAST module_or_generate_item_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case NET_DECLARATION:
	{
		returned=net_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_REG:
	{
		returned=reg_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INTEGER:
	{
		returned=integer_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_REAL:
	{
		returned=real_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_TIME:
	{
		returned=time_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_REALTIME:
	{
		returned=realtime_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_EVENT:
	{
		returned=event_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_GENVAR:
	{
		returned=genvar_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_TASK:
	{
		returned=task_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_FUNCTION:
	{
		returned=function_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

 RefCDOmParamOverride  VerilogTreeWalker::parameter_override(RefVerAST _t,
	 RefCDOmBase parent 
) {
#line 269 "verilog.walker.g"
	 RefCDOmParamOverride returnedParamOverride ;
#line 2175 "VerilogTreeWalker.cpp"
	RefVerAST parameter_override_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST da = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 269 "verilog.walker.g"
	
	RefCDOmMinTypMax minTypMax;
	RefCDOmExprLink exprLink;
	
#line 2183 "VerilogTreeWalker.cpp"
	
	RefVerAST __t46 = _t;
	RefVerAST tmp18_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DEFPARAM);
	_t = _t->getFirstChild();
	{
	RefVerAST __t48 = _t;
	da = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DEFPARAM_ASSIGNMENT);
	_t = _t->getFirstChild();
	exprLink=hierarchical_identifier(_t);
	_t = _retTree;
	minTypMax=mintypmax_expression(_t);
	_t = _retTree;
#line 278 "verilog.walker.g"
	returnedParamOverride = CDOmParamOverride::build(da->getLine(),  parent, exprLink, minTypMax );
#line 2200 "VerilogTreeWalker.cpp"
	_t = __t48;
	_t = _t->getNextSibling();
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == DEFPARAM_ASSIGNMENT)) {
			RefVerAST __t50 = _t;
			RefVerAST tmp19_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DEFPARAM_ASSIGNMENT);
			_t = _t->getFirstChild();
			exprLink=hierarchical_identifier(_t);
			_t = _retTree;
			minTypMax=mintypmax_expression(_t);
			_t = _retTree;
#line 284 "verilog.walker.g"
			returnedParamOverride->addParamAssn( exprLink, minTypMax );
#line 2219 "VerilogTreeWalker.cpp"
			_t = __t50;
			_t = _t->getNextSibling();
		}
		else {
			goto _loop51;
		}
		
	}
	_loop51:;
	} // ( ... )*
	_t = __t46;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedParamOverride ;
}

RefCDOmContAssn  VerilogTreeWalker::continuous_assign(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1897 "verilog.walker.g"
	RefCDOmContAssn returnedContAssn;
#line 2241 "VerilogTreeWalker.cpp"
	RefVerAST continuous_assign_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kassign = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1897 "verilog.walker.g"
	
	ECDOmDriveStrength ds1 = DRIVE_STRENGTH_UNDEFINED, ds2 = DRIVE_STRENGTH_UNDEFINED;
	RefCDOmAssn assn;
	
#line 2249 "VerilogTreeWalker.cpp"
	
	RefVerAST __t445 = _t;
	kassign = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ASSIGN);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_HIGHZ0:
	case K_HIGHZ1:
	case K_PULL0:
	case K_PULL1:
	case K_STRONG0:
	case K_STRONG1:
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_WEAK0:
	case K_WEAK1:
	{
		drive_strength(_t,ds1, ds2);
		_t = _retTree;
		break;
	}
	case DELAY:
	case ASSIGNMENT:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1904 "verilog.walker.g"
	returnedContAssn = CDOmContAssn::build(kassign->getLine(),  parent, ds1, ds2 );
#line 2287 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY:
	{
		delay3(_t,returnedContAssn);
		_t = _retTree;
		break;
	}
	case ASSIGNMENT:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt449=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == ASSIGNMENT)) {
			assn=assignment(_t);
			_t = _retTree;
#line 1907 "verilog.walker.g"
			returnedContAssn->addNetAssn( assn );
#line 2318 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt449>=1 ) { goto _loop449; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt449++;
	}
	_loop449:;
	}  // ( ... )+
	_t = __t445;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedContAssn;
}

RefCDOmGateInstantiation  VerilogTreeWalker::gate_instantiation(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1191 "verilog.walker.g"
	RefCDOmGateInstantiation gateInst;
#line 2339 "VerilogTreeWalker.cpp"
	RefVerAST gate_instantiation_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST gi = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1191 "verilog.walker.g"
	
	ECDOmDriveStrength ds1, ds2; 
	CDOmGateInstantiation::EPrimitiveType gateType;
	
#line 2347 "VerilogTreeWalker.cpp"
	
	RefVerAST __t258 = _t;
	gi = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GATE_INSTANTIATION);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_CMOS:
	case K_RCMOS:
	{
		gateType=cmos_switchtype(_t);
		_t = _retTree;
#line 1198 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2364 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,gateInst);
			_t = _retTree;
			break;
		}
		case CMOS_SWITCH_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt262=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == CMOS_SWITCH_INSTANCE)) {
				cmos_switch_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt262>=1 ) { goto _loop262; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt262++;
		}
		_loop262:;
		}  // ( ... )+
		break;
	}
	case K_BUFIF0:
	case K_BUFIF1:
	case K_NOTIF0:
	case K_NOTIF1:
	{
		gateType=enable_gatetype(_t);
		_t = _retTree;
#line 1202 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2413 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_HIGHZ0:
		case K_HIGHZ1:
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			drive_strength(_t,ds1, ds2);
			_t = _retTree;
#line 1203 "verilog.walker.g"
			gateInst->setDriveStrength(ds1, ds2);
#line 2433 "VerilogTreeWalker.cpp"
			break;
		}
		case DELAY:
		case ENABLE_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,gateInst);
			_t = _retTree;
			break;
		}
		case ENABLE_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt266=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == ENABLE_GATE_INSTANCE)) {
				enable_gate_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt266>=1 ) { goto _loop266; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt266++;
		}
		_loop266:;
		}  // ( ... )+
		break;
	}
	case K_NMOS:
	case K_PMOS:
	case K_RNMOS:
	case K_RPMOS:
	{
		gateType=mos_switchtype(_t);
		_t = _retTree;
#line 1207 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2495 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,gateInst);
			_t = _retTree;
			break;
		}
		case MOS_SWITCH_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt269=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == MOS_SWITCH_INSTANCE)) {
				mos_switch_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt269>=1 ) { goto _loop269; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt269++;
		}
		_loop269:;
		}  // ( ... )+
		break;
	}
	case K_AND:
	case K_NAND:
	case K_NOR:
	case K_OR:
	case K_XNOR:
	case K_XOR:
	{
		gateType=n_input_gatetype(_t);
		_t = _retTree;
#line 1211 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2546 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_HIGHZ0:
		case K_HIGHZ1:
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			drive_strength(_t,ds1, ds2);
			_t = _retTree;
#line 1212 "verilog.walker.g"
			gateInst->setDriveStrength(ds1, ds2);
#line 2566 "VerilogTreeWalker.cpp"
			break;
		}
		case DELAY:
		case N_INPUT_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,gateInst);
			_t = _retTree;
			break;
		}
		case N_INPUT_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt273=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == N_INPUT_GATE_INSTANCE)) {
				n_input_gate_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt273>=1 ) { goto _loop273; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt273++;
		}
		_loop273:;
		}  // ( ... )+
		break;
	}
	case K_BUF:
	case K_NOT:
	{
		gateType=n_output_gatetype(_t);
		_t = _retTree;
#line 1216 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2626 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_HIGHZ0:
		case K_HIGHZ1:
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			drive_strength(_t,ds1, ds2);
			_t = _retTree;
#line 1217 "verilog.walker.g"
			gateInst->setDriveStrength(ds1, ds2);
#line 2646 "VerilogTreeWalker.cpp"
			break;
		}
		case DELAY:
		case N_OUTPUT_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,gateInst);
			_t = _retTree;
			break;
		}
		case N_OUTPUT_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt277=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == N_OUTPUT_GATE_INSTANCE)) {
				n_output_gate_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt277>=1 ) { goto _loop277; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt277++;
		}
		_loop277:;
		}  // ( ... )+
		break;
	}
	case K_RTRANIF0:
	case K_RTRANIF1:
	case K_TRANIF0:
	case K_TRANIF1:
	{
		gateType=pass_enable_switchtype(_t);
		_t = _retTree;
#line 1221 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2708 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,gateInst);
			_t = _retTree;
			break;
		}
		case PASS_ENABLE_SWITCH_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt280=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == PASS_ENABLE_SWITCH_INSTANCE)) {
				pass_enable_switch_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt280>=1 ) { goto _loop280; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt280++;
		}
		_loop280:;
		}  // ( ... )+
		break;
	}
	case K_RTRAN:
	case K_TRAN:
	{
		gateType=pass_switchtype(_t);
		_t = _retTree;
#line 1225 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, gateType);
#line 2755 "VerilogTreeWalker.cpp"
		{ // ( ... )+
		int _cnt282=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == PASS_SWITCH_INSTANCE)) {
				pass_switch_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt282>=1 ) { goto _loop282; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt282++;
		}
		_loop282:;
		}  // ( ... )+
		break;
	}
	case K_PULLDOWN:
	{
		RefVerAST tmp20_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PULLDOWN);
		_t = _t->getNextSibling();
#line 1228 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, CDOmGateInstantiation::GATE_INST_PULLDOWN);
#line 2782 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			pulldown_strength(_t, gateInst );
			_t = _retTree;
			break;
		}
		case PULL_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt285=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == PULL_GATE_INSTANCE)) {
				pull_gate_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt285>=1 ) { goto _loop285; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt285++;
		}
		_loop285:;
		}  // ( ... )+
		break;
	}
	case K_PULLUP:
	{
		RefVerAST tmp21_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PULLUP);
		_t = _t->getNextSibling();
#line 1232 "verilog.walker.g"
		gateInst = CDOmGateInstantiation::build(gi->getLine(), parent, CDOmGateInstantiation::GATE_INST_PULLUP);
#line 2836 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			pullup_strength(_t, gateInst );
			_t = _retTree;
			break;
		}
		case PULL_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{ // ( ... )+
		int _cnt288=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == PULL_GATE_INSTANCE)) {
				pull_gate_instance(_t, gateInst );
				_t = _retTree;
			}
			else {
				if ( _cnt288>=1 ) { goto _loop288; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt288++;
		}
		_loop288:;
		}  // ( ... )+
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t258;
	_t = _t->getNextSibling();
	_retTree = _t;
	return gateInst;
}

RefCDOmModuleOrUdpInstantiation  VerilogTreeWalker::module_or_udp_instantiation(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1400 "verilog.walker.g"
	RefCDOmModuleOrUdpInstantiation returnedModuleInstantiation;
#line 2900 "VerilogTreeWalker.cpp"
	RefVerAST module_or_udp_instantiation_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1400 "verilog.walker.g"
	
	ECDOmDriveStrength ds1, ds2;
	pair<RefString, int> str;
	RefCDOmExprLink exprLink;
	
#line 2908 "VerilogTreeWalker.cpp"
	
	RefVerAST __t331 = _t;
	RefVerAST tmp22_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MODULE_OR_UDP_INSTANTIATION);
	_t = _t->getFirstChild();
	str=identifier(_t);
	_t = _retTree;
#line 1408 "verilog.walker.g"
	returnedModuleInstantiation = CDOmModuleOrUdpInstantiation::build(str.second,  parent, CDOmExprLink::build(str.second, str.first) );
#line 2918 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_HIGHZ0:
	case K_HIGHZ1:
	case K_PULL0:
	case K_PULL1:
	case K_STRONG0:
	case K_STRONG1:
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_WEAK0:
	case K_WEAK1:
	{
		drive_strength(_t,ds1, ds2);
		_t = _retTree;
#line 1409 "verilog.walker.g"
		returnedModuleInstantiation->setDriveStrength(ds1, ds2);
#line 2938 "VerilogTreeWalker.cpp"
		break;
	}
	case DELAY:
	case LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2:
	case MODULE_INSTANCE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY:
	case LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2:
	{
		parameter_value_assignment_or_delay2(_t,returnedModuleInstantiation);
		_t = _retTree;
		break;
	}
	case MODULE_INSTANCE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt335=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == MODULE_INSTANCE)) {
			module_instance(_t,returnedModuleInstantiation);
			_t = _retTree;
		}
		else {
			if ( _cnt335>=1 ) { goto _loop335; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt335++;
	}
	_loop335:;
	}  // ( ... )+
	_t = __t331;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedModuleInstantiation;
}

RefCDOmInitOrAlways  VerilogTreeWalker::initial_construct(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1924 "verilog.walker.g"
	RefCDOmInitOrAlways returnedInitOrAlways;
#line 3002 "VerilogTreeWalker.cpp"
	RefVerAST initial_construct_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kinitial = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1924 "verilog.walker.g"
	
	RefCDOmStmt stmt;
	RefCDOmAttrListCollection attrListColl;
	
#line 3010 "VerilogTreeWalker.cpp"
	
	RefVerAST __t453 = _t;
	kinitial = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INITIAL);
	_t = _t->getFirstChild();
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	stmt=statement(_t);
	_t = _retTree;
	_t = __t453;
	_t = _t->getNextSibling();
#line 1930 "verilog.walker.g"
	
	if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
	returnedInitOrAlways = CDOmInitOrAlways::build(kinitial->getLine(),  parent, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, stmt );
	
#line 3027 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedInitOrAlways;
}

RefCDOmInitOrAlways  VerilogTreeWalker::always_construct(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1936 "verilog.walker.g"
	RefCDOmInitOrAlways returnedInitOrAlways;
#line 3037 "VerilogTreeWalker.cpp"
	RefVerAST always_construct_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kalways = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1936 "verilog.walker.g"
	
	RefCDOmStmt stmt;
	RefCDOmAttrListCollection attrListColl;
	
#line 3045 "VerilogTreeWalker.cpp"
	
	RefVerAST __t455 = _t;
	kalways = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ALWAYS);
	_t = _t->getFirstChild();
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	stmt=statement(_t);
	_t = _retTree;
	_t = __t455;
	_t = _t->getNextSibling();
#line 1942 "verilog.walker.g"
	
	if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
	returnedInitOrAlways = CDOmInitOrAlways::build(kalways->getLine(),  parent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, stmt );
	
#line 3062 "VerilogTreeWalker.cpp"
#line 1946 "verilog.walker.g"
	PRINT_AST(K_ALWAYS);
#line 3065 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedInitOrAlways;
}

 RefCDOmNetDecl  VerilogTreeWalker::net_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 524 "verilog.walker.g"
	 RefCDOmNetDecl netDecl ;
#line 3075 "VerilogTreeWalker.cpp"
	RefVerAST net_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ndecl = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST trirg = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 524 "verilog.walker.g"
	
	ECDOmNetType nt = NET_UNDEFINED;
	ECDOmDriveStrength ds1, ds2;
	CDOmNetDecl::EChargeStrength cs;
	CDOmNetDecl::EVectorAccessType vat = CDOmNetDecl::VECTOR_ACCESS_UNDEFINED;
	RefCDOmRange rng;
	
#line 3087 "VerilogTreeWalker.cpp"
	
	RefVerAST __t107 = _t;
	ndecl = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NET_DECLARATION);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SUPPLY0:
	case K_SUPPLY1:
	case K_TRI:
	case K_TRI0:
	case K_TRI1:
	case K_TRIAND:
	case K_TRIOR:
	case K_WAND:
	case K_WIRE:
	case K_WOR:
	{
		nt=net_type(_t);
		_t = _retTree;
#line 534 "verilog.walker.g"
		netDecl = CDOmNetDecl::build(ndecl->getLine(), parent, nt);
#line 3112 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_HIGHZ0:
		case K_HIGHZ1:
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			drive_strength(_t,ds1, ds2);
			_t = _retTree;
#line 535 "verilog.walker.g"
			netDecl->setDriveStrength(ds1, ds2);
#line 3132 "VerilogTreeWalker.cpp"
			break;
		}
		case K_SCALARED:
		case K_SIGNED:
		case K_VECTORED:
		case RANGE:
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SCALARED:
		case K_VECTORED:
		{
			vat=expandrange(_t);
			_t = _retTree;
			break;
		}
		case K_SIGNED:
		case RANGE:
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp23_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 537 "verilog.walker.g"
			netDecl->setSigned();
#line 3187 "VerilogTreeWalker.cpp"
			break;
		}
		case RANGE:
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			rng=range(_t);
			_t = _retTree;
#line 538 "verilog.walker.g"
			netDecl->setRange(rng, vat);
#line 3213 "VerilogTreeWalker.cpp"
			break;
		}
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,netDecl);
			_t = _retTree;
			break;
		}
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		list_of_net_identifiers_or_decl_assignments(_t,netDecl);
		_t = _retTree;
		break;
	}
	case K_TRIREG:
	{
		trirg = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIREG);
		_t = _t->getNextSibling();
#line 542 "verilog.walker.g"
		
		nt = NET_TRIREG;
		netDecl = CDOmNetDecl::build(trirg->getLine(), parent, nt);
		
#line 3263 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_LARGE:
		case K_MEDIUM:
		case K_SMALL:
		{
			cs=charge_strength(_t);
			_t = _retTree;
#line 546 "verilog.walker.g"
			netDecl->setChargeStrength(cs);
#line 3276 "VerilogTreeWalker.cpp"
			break;
		}
		case K_HIGHZ0:
		case K_HIGHZ1:
		case K_PULL0:
		case K_PULL1:
		case K_STRONG0:
		case K_STRONG1:
		case K_SUPPLY0:
		case K_SUPPLY1:
		case K_WEAK0:
		case K_WEAK1:
		{
			drive_strength(_t,ds1, ds2);
			_t = _retTree;
#line 547 "verilog.walker.g"
			netDecl->setDriveStrength(ds1, ds2);
#line 3294 "VerilogTreeWalker.cpp"
			break;
		}
		case K_SCALARED:
		case K_SIGNED:
		case K_VECTORED:
		case RANGE:
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SCALARED:
		case K_VECTORED:
		{
			vat=expandrange(_t);
			_t = _retTree;
			break;
		}
		case K_SIGNED:
		case RANGE:
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp24_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 550 "verilog.walker.g"
			netDecl->setSigned();
#line 3349 "VerilogTreeWalker.cpp"
			break;
		}
		case RANGE:
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			rng=range(_t);
			_t = _retTree;
#line 551 "verilog.walker.g"
			netDecl->setRange(rng, vat);
#line 3375 "VerilogTreeWalker.cpp"
			break;
		}
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		case DELAY:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DELAY:
		{
			delay3(_t,netDecl);
			_t = _retTree;
			break;
		}
		case LIST_OF_NET_IDENTIFIERS:
		case LIST_OF_NET_DECL_ASSIGNMENTS:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		list_of_net_identifiers_or_decl_assignments(_t,netDecl);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t107;
	_t = _t->getNextSibling();
#line 556 "verilog.walker.g"
	PRINT_AST(NET_DECLARATION);
#line 3425 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return netDecl ;
}

RefCDOmVarDecl  VerilogTreeWalker::reg_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 504 "verilog.walker.g"
	RefCDOmVarDecl returnedVarDecl;
#line 3435 "VerilogTreeWalker.cpp"
	RefVerAST reg_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST rg = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 504 "verilog.walker.g"
	
	TBool sgn = FALSE;
	RefCDOmRange rng = RefCDOmRange();
	
#line 3443 "VerilogTreeWalker.cpp"
	
	RefVerAST __t103 = _t;
	rg = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	{
		RefVerAST tmp25_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
		_t = _t->getNextSibling();
#line 510 "verilog.walker.g"
		sgn = TRUE;
#line 3460 "VerilogTreeWalker.cpp"
		break;
	}
	case RANGE:
	case VARIABLE_TYPE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		rng=range(_t);
		_t = _retTree;
		break;
	}
	case VARIABLE_TYPE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 512 "verilog.walker.g"
	
	returnedVarDecl = CDOmVarDecl::build(rg->getLine(), parent, VAR_REG);
	if (sgn)
	returnedVarDecl->setSigned();
	if (rng.get() != NULL)
	returnedVarDecl->setRange(rng);
	
#line 3502 "VerilogTreeWalker.cpp"
	list_of_variable_identifiers(_t,returnedVarDecl);
	_t = _retTree;
	_t = __t103;
	_t = _t->getNextSibling();
#line 521 "verilog.walker.g"
	PRINT_AST(K_REG);
#line 3509 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedVarDecl;
}

RefCDOmVarDecl  VerilogTreeWalker::integer_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 474 "verilog.walker.g"
	RefCDOmVarDecl returnedVarDecl;
#line 3519 "VerilogTreeWalker.cpp"
	RefVerAST integer_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST int_ = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t95 = _t;
	int_ = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
	_t = _t->getFirstChild();
#line 476 "verilog.walker.g"
	returnedVarDecl = CDOmVarDecl::build(int_->getLine(), parent, VAR_INTEGER);
#line 3529 "VerilogTreeWalker.cpp"
	list_of_variable_identifiers(_t,returnedVarDecl);
	_t = _retTree;
	_t = __t95;
	_t = _t->getNextSibling();
#line 479 "verilog.walker.g"
	PRINT_AST(K_INTEGER);
#line 3536 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedVarDecl;
}

RefCDOmVarDecl  VerilogTreeWalker::real_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 482 "verilog.walker.g"
	RefCDOmVarDecl returnedVarDecl;
#line 3546 "VerilogTreeWalker.cpp"
	RefVerAST real_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST rl = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t97 = _t;
	rl = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REAL);
	_t = _t->getFirstChild();
#line 484 "verilog.walker.g"
	returnedVarDecl = CDOmVarDecl::build(rl->getLine(), parent, VAR_REAL);
#line 3556 "VerilogTreeWalker.cpp"
	list_of_variable_identifiers(_t,returnedVarDecl);
	_t = _retTree;
	_t = __t97;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedVarDecl;
}

RefCDOmVarDecl  VerilogTreeWalker::time_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 490 "verilog.walker.g"
	RefCDOmVarDecl returnedVarDecl;
#line 3570 "VerilogTreeWalker.cpp"
	RefVerAST time_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST tm = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t99 = _t;
	tm = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
	_t = _t->getFirstChild();
#line 492 "verilog.walker.g"
	returnedVarDecl = CDOmVarDecl::build(tm->getLine(), parent, VAR_TIME);
#line 3580 "VerilogTreeWalker.cpp"
	list_of_variable_identifiers(_t,returnedVarDecl);
	_t = _retTree;
	_t = __t99;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedVarDecl;
}

 RefCDOmVarDecl  VerilogTreeWalker::realtime_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 497 "verilog.walker.g"
	 RefCDOmVarDecl returnedVarDecl ;
#line 3594 "VerilogTreeWalker.cpp"
	RefVerAST realtime_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST rt = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t101 = _t;
	rt = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REALTIME);
	_t = _t->getFirstChild();
#line 499 "verilog.walker.g"
	returnedVarDecl = CDOmVarDecl::build(rt->getLine(), parent, VAR_REALTIME);
#line 3604 "VerilogTreeWalker.cpp"
	list_of_variable_identifiers(_t,returnedVarDecl);
	_t = _retTree;
	_t = __t101;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedVarDecl ;
}

RefCDOmEventDecl  VerilogTreeWalker::event_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 565 "verilog.walker.g"
	RefCDOmEventDecl returnedEventDecl;
#line 3618 "VerilogTreeWalker.cpp"
	RefVerAST event_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ev = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t121 = _t;
	ev = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_EVENT);
	_t = _t->getFirstChild();
	list_of_event_identifiers(_t, returnedEventDecl, parent, ev->getLine() );
	_t = _retTree;
	_t = __t121;
	_t = _t->getNextSibling();
#line 570 "verilog.walker.g"
	PRINT_AST(K_EVENT);
#line 3632 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedEventDecl;
}

RefCDOmGenvarDecl  VerilogTreeWalker::genvar_declaration(RefVerAST _t,
	 RefCDOmBase parent 
) {
#line 574 "verilog.walker.g"
	RefCDOmGenvarDecl returned;
#line 3642 "VerilogTreeWalker.cpp"
	RefVerAST genvar_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST __t123 = _t;
	RefVerAST tmp26_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_GENVAR);
	_t = _t->getFirstChild();
	returned=list_of_genvar_identifiers(_t, parent );
	_t = _retTree;
	_t = __t123;
	_t = _t->getNextSibling();
#line 577 "verilog.walker.g"
	PRINT_AST(tmp26_AST_in);
#line 3655 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned;
}

 RefCDOmTaskDecl  VerilogTreeWalker::task_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1040 "verilog.walker.g"
	 RefCDOmTaskDecl returnedTaskDecl ;
#line 3665 "VerilogTreeWalker.cpp"
	RefVerAST task_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1040 "verilog.walker.g"
	
	RefCDOmAttrHolder attrHolder;
	pair<RefString, int> name;
	RefCDOmAttrListCollection attrListColl;
	RefCDOmStmt stmt;
	bool isAutomatic = false;
	bool acceptNext = true; 
	
#line 3676 "VerilogTreeWalker.cpp"
	
	RefVerAST __t218 = _t;
	RefVerAST tmp27_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TASK);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_AUTOMATIC:
	{
		RefVerAST tmp28_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AUTOMATIC);
		_t = _t->getNextSibling();
#line 1050 "verilog.walker.g"
		isAutomatic=true;
#line 3693 "VerilogTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	name=identifier(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case TASK_PORT_LIST:
	{
#line 1053 "verilog.walker.g"
		returnedTaskDecl = CDOmTaskDecl::build(name.second,  parent, CDOmTaskDecl::TASK_DECL_WITH_TASK_PORT_LIST, name.first, isAutomatic);
#line 3717 "VerilogTreeWalker.cpp"
		task_port_list(_t, returnedTaskDecl );
		_t = _retTree;
		break;
	}
	case 3:
	case K_EVENT:
	case K_INOUT:
	case K_INPUT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_OUTPUT:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	case STATEMENT_OR_NULL:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1056 "verilog.walker.g"
	
	if( !returnedTaskDecl.get() )
	returnedTaskDecl = CDOmTaskDecl::build(name.second,  parent, CDOmTaskDecl::TASK_DECL_WITHOUT_TASK_PORT_LIST, name.first, isAutomatic);
	
#line 3750 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_5.member(_t->getType()))) {
			attrListColl=attrs_opt(_t);
			_t = _retTree;
			if (!(acceptNext))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException("acceptNext");
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case K_EVENT:
			case K_INOUT:
			case K_INPUT:
			case K_INTEGER:
			case K_LOCALPARAM:
			case K_OUTPUT:
			case K_PARAMETER:
			case K_REAL:
			case K_REALTIME:
			case K_REG:
			case K_TIME:
			{
				attrHolder=task_item_declaration(_t, returnedTaskDecl );
				_t = _retTree;
#line 1063 "verilog.walker.g"
				if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 3780 "VerilogTreeWalker.cpp"
				break;
			}
			case STATEMENT_OR_NULL:
			{
				stmt=statement_or_null(_t);
				_t = _retTree;
#line 1065 "verilog.walker.g"
				
				acceptNext = false;
				if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
				returnedTaskDecl->setStmt( stmt );
				
#line 3793 "VerilogTreeWalker.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
		}
		else {
			goto _loop223;
		}
		
	}
	_loop223:;
	} // ( ... )*
	if (!(!acceptNext))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException("!acceptNext");
	_t = __t218;
	_t = _t->getNextSibling();
#line 1077 "verilog.walker.g"
	PRINT_AST(tmp27_AST_in);
#line 3816 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedTaskDecl ;
}

 RefCDOmFuncDecl  VerilogTreeWalker::function_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 950 "verilog.walker.g"
	 RefCDOmFuncDecl returnedFuncDecl ;
#line 3826 "VerilogTreeWalker.cpp"
	RefVerAST function_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 950 "verilog.walker.g"
	
	bool acceptNext = true;
	bool isAutomatic = false, isSigned = false;
	RefCDOmAttrListCollection attrListColl;
	pair<RefString, int> name;
	RefCDOmRange my_range=RefCDOmRange();
	RefCDOmAttrHolder attrHolder;
	ECDOmVarType varType = VAR_UNDEFINED;
	RefCDOmStmt stmt;
	
#line 3839 "VerilogTreeWalker.cpp"
	
	RefVerAST __t201 = _t;
	RefVerAST tmp29_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FUNCTION);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_AUTOMATIC:
	{
		RefVerAST tmp30_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AUTOMATIC);
		_t = _t->getNextSibling();
#line 962 "verilog.walker.g"
		isAutomatic = true;
#line 3856 "VerilogTreeWalker.cpp"
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_SIGNED:
	case K_TIME:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SIGNED:
	{
		RefVerAST tmp31_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
		_t = _t->getNextSibling();
#line 963 "verilog.walker.g"
		isSigned    = true;
#line 3887 "VerilogTreeWalker.cpp"
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_TIME:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		my_range=range(_t);
		_t = _retTree;
		break;
	}
	case K_INTEGER:
	{
		RefVerAST tmp32_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
		_t = _t->getNextSibling();
#line 965 "verilog.walker.g"
		varType = VAR_INTEGER ;
#line 3923 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REAL:
	{
		RefVerAST tmp33_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REAL);
		_t = _t->getNextSibling();
#line 966 "verilog.walker.g"
		varType = VAR_REAL    ;
#line 3933 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REALTIME:
	{
		RefVerAST tmp34_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REALTIME);
		_t = _t->getNextSibling();
#line 967 "verilog.walker.g"
		varType = VAR_REALTIME;
#line 3943 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TIME:
	{
		RefVerAST tmp35_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
		_t = _t->getNextSibling();
#line 968 "verilog.walker.g"
		varType = VAR_TIME    ;
#line 3953 "VerilogTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	name=identifier(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_EVENT:
	case K_INPUT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	{
#line 971 "verilog.walker.g"
		
		returnedFuncDecl = CDOmFuncDecl::build(name.second,  parent, CDOmFuncDecl::FUNC_DECL_WITHOUT_FUNC_PORT_LIST, name.first, isAutomatic, isSigned); 
		if( my_range.get() )
		returnedFuncDecl->setRange( my_range );
		else if( varType != VAR_UNDEFINED )
		returnedFuncDecl->setVarType( varType );
		
#line 3992 "VerilogTreeWalker.cpp"
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		attrHolder=function_item_declaration(_t, returnedFuncDecl );
		_t = _retTree;
#line 980 "verilog.walker.g"
		if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 3999 "VerilogTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_tokenSet_6.member(_t->getType()))) {
				attrListColl=attrs_opt(_t);
				_t = _retTree;
				if (!( acceptNext ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptNext ");
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case K_EVENT:
				case K_INPUT:
				case K_INTEGER:
				case K_LOCALPARAM:
				case K_PARAMETER:
				case K_REAL:
				case K_REALTIME:
				case K_REG:
				case K_TIME:
				{
					attrHolder=function_item_declaration(_t, returnedFuncDecl );
					_t = _retTree;
#line 984 "verilog.walker.g"
					if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 4027 "VerilogTreeWalker.cpp"
					break;
				}
				case K_ASSIGN:
				case K_DEASSIGN:
				case K_DISABLE:
				case K_FORCE:
				case K_IF:
				case K_RELEASE:
				case K_WAIT:
				case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
				case PAR_BLOCK:
				case SEQ_BLOCK:
				case DELAY_CONTROL:
				case EVENT_CONTROL:
				case CASE_STATEMENT:
				case LOOP_STATEMENT:
				case EVENT_TRIGGER:
				case SYSTEM_TASK_ENABLE:
				case TASK_ENABLE:
				{
					stmt=statement(_t);
					_t = _retTree;
#line 986 "verilog.walker.g"
					
					acceptNext = false;
					if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
					returnedFuncDecl->setFuncStmt( stmt );
					
#line 4056 "VerilogTreeWalker.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
			}
			else {
				goto _loop208;
			}
			
		}
		_loop208:;
		} // ( ... )*
		break;
	}
	case FUNCTION_PORT_LIST:
	{
#line 993 "verilog.walker.g"
		
		returnedFuncDecl = CDOmFuncDecl::build(name.second,  parent, CDOmFuncDecl::FUNC_DECL_WITH_FUNC_PORT_LIST, name.first, isAutomatic, isSigned); 
		if( my_range.get() )
		returnedFuncDecl->setRange( my_range );
		else if( varType != VAR_UNDEFINED )
		returnedFuncDecl->setVarType( varType );
		
#line 4085 "VerilogTreeWalker.cpp"
		function_port_list(_t, returnedFuncDecl );
		_t = _retTree;
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_tokenSet_7.member(_t->getType()))) {
				attrListColl=attrs_opt(_t);
				_t = _retTree;
				if (!(acceptNext))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException("acceptNext");
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case K_EVENT:
				case K_INTEGER:
				case K_LOCALPARAM:
				case K_PARAMETER:
				case K_REAL:
				case K_REALTIME:
				case K_REG:
				case K_TIME:
				{
					attrHolder=block_item_declaration(_t, returnedFuncDecl );
					_t = _retTree;
#line 1004 "verilog.walker.g"
					if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 4114 "VerilogTreeWalker.cpp"
					break;
				}
				case K_ASSIGN:
				case K_DEASSIGN:
				case K_DISABLE:
				case K_FORCE:
				case K_IF:
				case K_RELEASE:
				case K_WAIT:
				case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
				case PAR_BLOCK:
				case SEQ_BLOCK:
				case DELAY_CONTROL:
				case EVENT_CONTROL:
				case CASE_STATEMENT:
				case LOOP_STATEMENT:
				case EVENT_TRIGGER:
				case SYSTEM_TASK_ENABLE:
				case TASK_ENABLE:
				{
					stmt=statement(_t);
					_t = _retTree;
#line 1006 "verilog.walker.g"
					
					acceptNext = false;
					if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
					returnedFuncDecl->setFuncStmt( stmt );
					
#line 4143 "VerilogTreeWalker.cpp"
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
			}
			else {
				goto _loop211;
			}
			
		}
		_loop211:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	if (!( !acceptNext ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !acceptNext ");
	_t = __t201;
	_t = _t->getNextSibling();
#line 1016 "verilog.walker.g"
	PRINT_AST(tmp29_AST_in);
#line 4174 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedFuncDecl ;
}

RefCDOmExprLink  VerilogTreeWalker::hierarchical_identifier(RefVerAST _t) {
#line 3549 "verilog.walker.g"
	RefCDOmExprLink returnedExprLink;
#line 4182 "VerilogTreeWalker.cpp"
	RefVerAST hierarchical_identifier_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 3549 "verilog.walker.g"
	
	pair<RefString, int> idName;
	RefCDOmExpr expr;
	
#line 4189 "VerilogTreeWalker.cpp"
	
	RefVerAST __t753 = _t;
	RefVerAST tmp36_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),HIERARCHICAL_IDENTIFIER);
	_t = _t->getFirstChild();
	idName=identifier(_t);
	_t = _retTree;
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_8.member(_t->getType()))) {
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case EXPRESSION:
			case CONCATENATION:
			case MULTI_CONCATENATION:
			case EXPR_PRIMARY_IDENTIFIER:
			case FUNCTION_CALL:
			case SYSTEM_FUNCTION_CALL:
			case MINTYPMAX_EXPRESSION:
			case SIZED_NUMBER:
			{
				expr=expression(_t);
				_t = _retTree;
				break;
			}
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 3557 "verilog.walker.g"
			
			if(returnedExprLink.get() == NULL) {
			returnedExprLink = CDOmExprLink::build(idName.second, idName.first, expr);
			} else {
			returnedExprLink->addHidItem(idName.first, expr);
			}
			
#line 4279 "VerilogTreeWalker.cpp"
			idName=identifier(_t);
			_t = _retTree;
		}
		else {
			goto _loop756;
		}
		
	}
	_loop756:;
	} // ( ... )*
#line 3566 "verilog.walker.g"
	
	if(returnedExprLink.get() == NULL) {
	returnedExprLink = CDOmExprLink::build(idName.second, idName.first);
	} else {
	returnedExprLink->addHidItem(idName.first);
	}
	
#line 4298 "VerilogTreeWalker.cpp"
	_t = __t753;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedExprLink;
}

RefCDOmMinTypMax  VerilogTreeWalker::mintypmax_expression(RefVerAST _t) {
#line 3447 "verilog.walker.g"
	RefCDOmMinTypMax minTypMax;
#line 4308 "VerilogTreeWalker.cpp"
	RefVerAST mintypmax_expression_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST me = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3447 "verilog.walker.g"
	
	RefCDOmExpr expr1, expr2, expr3;
	bool test = false; //used to check if there is one expression or three expressions in the subtree
	
#line 4316 "VerilogTreeWalker.cpp"
	
	RefVerAST __t730 = _t;
	me = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MINTYPMAX_EXPRESSION);
	_t = _t->getFirstChild();
	expr1=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr2=expression(_t);
		_t = _retTree;
		expr3=expression(_t);
		_t = _retTree;
#line 3456 "verilog.walker.g"
		test = true;
#line 4384 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 3458 "verilog.walker.g"
	
	if(test) 
	minTypMax = CDOmMinTypMax::build(me->getLine(),  expr1, expr2, expr3);
	else
	minTypMax = CDOmMinTypMax::build(me->getLine(),  expr1);
	
#line 4404 "VerilogTreeWalker.cpp"
	_t = __t730;
	_t = _t->getNextSibling();
	_retTree = _t;
	return minTypMax;
}

RefCDOmRange  VerilogTreeWalker::range(RefVerAST _t) {
#line 925 "verilog.walker.g"
	RefCDOmRange rng;
#line 4414 "VerilogTreeWalker.cpp"
	RefVerAST range_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST rn = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 925 "verilog.walker.g"
	RefCDOmExpr lsb, msb;
#line 4419 "VerilogTreeWalker.cpp"
	
	RefVerAST __t195 = _t;
	rn = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE);
	_t = _t->getFirstChild();
	lsb=expression(_t);
	_t = _retTree;
	msb=expression(_t);
	_t = _retTree;
	_t = __t195;
	_t = _t->getNextSibling();
#line 931 "verilog.walker.g"
	
	rng = CDOmRange::build(rn->getLine(), lsb, msb);
	PRINT_AST(RANGE);
	
#line 4436 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return rng;
}

CDOmParamDecl::EParamType  VerilogTreeWalker::parameter_type(RefVerAST _t) {
#line 359 "verilog.walker.g"
	CDOmParamDecl::EParamType paramType;
#line 4444 "VerilogTreeWalker.cpp"
	RefVerAST parameter_type_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INTEGER:
	{
		RefVerAST tmp37_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
		_t = _t->getNextSibling();
#line 360 "verilog.walker.g"
		paramType = CDOmParamDecl::PARAM_INTEGER ;
#line 4457 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REAL:
	{
		RefVerAST tmp38_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REAL);
		_t = _t->getNextSibling();
#line 361 "verilog.walker.g"
		paramType = CDOmParamDecl::PARAM_REAL    ;
#line 4467 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REALTIME:
	{
		RefVerAST tmp39_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REALTIME);
		_t = _t->getNextSibling();
#line 362 "verilog.walker.g"
		paramType = CDOmParamDecl::PARAM_REALTIME;
#line 4477 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TIME:
	{
		RefVerAST tmp40_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
		_t = _t->getNextSibling();
#line 363 "verilog.walker.g"
		paramType = CDOmParamDecl::PARAM_TIME    ;
#line 4487 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return paramType;
}

void VerilogTreeWalker::list_of_param_assignments(RefVerAST _t,
	RefCDOmParamDecl paramDecl
) {
	RefVerAST list_of_param_assignments_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{ // ( ... )+
	int _cnt173=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == PARAM_ASSIGNMENT)) {
			param_assignment(_t,paramDecl);
			_t = _retTree;
		}
		else {
			if ( _cnt173>=1 ) { goto _loop173; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt173++;
	}
	_loop173:;
	}  // ( ... )+
	_retTree = _t;
}

void VerilogTreeWalker::list_of_specparam_assignments(RefVerAST _t,
	RefCDOmParamDecl paramDecl
) {
	RefVerAST list_of_specparam_assignments_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{ // ( ... )+
	int _cnt179=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case PARAM_ASSIGNMENT:
		{
			param_assignment(_t,paramDecl);
			_t = _retTree;
			break;
		}
		case PULSE_CONTROL_SPECPARAM:
		{
			pulse_control_specparam(_t,paramDecl);
			_t = _retTree;
			break;
		}
		default:
		{
			if ( _cnt179>=1 ) { goto _loop179; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		}
		_cnt179++;
	}
	_loop179:;
	}  // ( ... )+
	_retTree = _t;
}

ECDOmNetType  VerilogTreeWalker::net_type(RefVerAST _t) {
#line 583 "verilog.walker.g"
	ECDOmNetType res;
#line 4562 "VerilogTreeWalker.cpp"
	RefVerAST net_type_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SUPPLY0:
	{
		RefVerAST tmp41_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY0);
		_t = _t->getNextSibling();
#line 584 "verilog.walker.g"
		res = NET_SUPPLY0;
#line 4575 "VerilogTreeWalker.cpp"
		break;
	}
	case K_SUPPLY1:
	{
		RefVerAST tmp42_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY1);
		_t = _t->getNextSibling();
#line 585 "verilog.walker.g"
		res = NET_SUPPLY1;
#line 4585 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TRI:
	{
		RefVerAST tmp43_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI);
		_t = _t->getNextSibling();
#line 586 "verilog.walker.g"
		res = NET_TRI    ;
#line 4595 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TRIAND:
	{
		RefVerAST tmp44_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIAND);
		_t = _t->getNextSibling();
#line 587 "verilog.walker.g"
		res = NET_TRIAND ;
#line 4605 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TRIOR:
	{
		RefVerAST tmp45_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRIOR);
		_t = _t->getNextSibling();
#line 588 "verilog.walker.g"
		res = NET_TRIOR  ;
#line 4615 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TRI0:
	{
		RefVerAST tmp46_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI0);
		_t = _t->getNextSibling();
#line 589 "verilog.walker.g"
		res = NET_TRI0   ;
#line 4625 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TRI1:
	{
		RefVerAST tmp47_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRI1);
		_t = _t->getNextSibling();
#line 590 "verilog.walker.g"
		res = NET_TRI1   ;
#line 4635 "VerilogTreeWalker.cpp"
		break;
	}
	case K_WIRE:
	{
		RefVerAST tmp48_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WIRE);
		_t = _t->getNextSibling();
#line 591 "verilog.walker.g"
		res = NET_WIRE   ;
#line 4645 "VerilogTreeWalker.cpp"
		break;
	}
	case K_WAND:
	{
		RefVerAST tmp49_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAND);
		_t = _t->getNextSibling();
#line 592 "verilog.walker.g"
		res = NET_WAND   ;
#line 4655 "VerilogTreeWalker.cpp"
		break;
	}
	case K_WOR:
	{
		RefVerAST tmp50_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WOR);
		_t = _t->getNextSibling();
#line 593 "verilog.walker.g"
		res = NET_WOR    ;
#line 4665 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return res;
}

ECDOmVarType  VerilogTreeWalker::output_variable_type(RefVerAST _t) {
#line 596 "verilog.walker.g"
	ECDOmVarType res;
#line 4680 "VerilogTreeWalker.cpp"
	RefVerAST output_variable_type_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INTEGER:
	{
		RefVerAST tmp51_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
		_t = _t->getNextSibling();
#line 597 "verilog.walker.g"
		res = VAR_INTEGER;
#line 4693 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TIME:
	{
		RefVerAST tmp52_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
		_t = _t->getNextSibling();
#line 598 "verilog.walker.g"
		res = VAR_TIME   ;
#line 4703 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return res;
}

RefCDOmExpr  VerilogTreeWalker::expression(RefVerAST _t) {
#line 3199 "verilog.walker.g"
	RefCDOmExpr expr;
#line 4718 "VerilogTreeWalker.cpp"
	RefVerAST expression_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST root01 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root02 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root03 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root04 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root05 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root06 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root07 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root08 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root09 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root10 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root11 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root12 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root13 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root14 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root15 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root16 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root17 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root18 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root19 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root20 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root21 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root22 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root23 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root24 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root25 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root26 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root27 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root28 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root29 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root30 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root31 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root32 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root33 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root34 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root35 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root36 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST root37 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3199 "verilog.walker.g"
	
	RefCDOmExpr e1, e2, e3;
	RefCDOmAttrListCollection exprColl;
	RefCDOmExprOp exprOp;
	
#line 4763 "VerilogTreeWalker.cpp"
	
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case EXPRESSION:
	{
		RefVerAST __t690 = _t;
		RefVerAST tmp53_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPRESSION);
		_t = _t->getFirstChild();
		expr=expression(_t);
		_t = _retTree;
		_t = __t690;
		_t = _t->getNextSibling();
#line 3207 "verilog.walker.g"
		PRINT_AST(tmp53_AST_in);
#line 4781 "VerilogTreeWalker.cpp"
		break;
	}
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case STRING:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case SIZED_NUMBER:
	{
		expr=expr_primary(_t);
		_t = _retTree;
		break;
	}
	case U_PLUS:
	{
		RefVerAST __t691 = _t;
		root01 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_PLUS);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t691;
		_t = _t->getNextSibling();
#line 3210 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root01->getLine(), CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4817 "VerilogTreeWalker.cpp"
		break;
	}
	case U_MINUS:
	{
		RefVerAST __t692 = _t;
		root02 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_MINUS);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t692;
		_t = _t->getNextSibling();
#line 3216 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root02->getLine(), CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4838 "VerilogTreeWalker.cpp"
		break;
	}
	case LNOT:
	{
		RefVerAST __t693 = _t;
		root03 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LNOT);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t693;
		_t = _t->getNextSibling();
#line 3222 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root03->getLine(), CDOmExprOp::OP_UNARY_LOGIC_NOT, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4859 "VerilogTreeWalker.cpp"
		break;
	}
	case NOT:
	{
		RefVerAST __t694 = _t;
		root04 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOT);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t694;
		_t = _t->getNextSibling();
#line 3228 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root04->getLine(), CDOmExprOp::OP_UNARY_BITWISE_NOT, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4880 "VerilogTreeWalker.cpp"
		break;
	}
	case U_AND:
	{
		RefVerAST __t695 = _t;
		root05 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_AND);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t695;
		_t = _t->getNextSibling();
#line 3234 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root05->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_AND, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4901 "VerilogTreeWalker.cpp"
		break;
	}
	case U_NAND:
	{
		RefVerAST __t696 = _t;
		root06 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_NAND);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t696;
		_t = _t->getNextSibling();
#line 3240 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root06->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_NAND, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4922 "VerilogTreeWalker.cpp"
		break;
	}
	case U_OR:
	{
		RefVerAST __t697 = _t;
		root07 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_OR);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t697;
		_t = _t->getNextSibling();
#line 3246 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root07->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_OR, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4943 "VerilogTreeWalker.cpp"
		break;
	}
	case U_NOR:
	{
		RefVerAST __t698 = _t;
		root08 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_NOR);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t698;
		_t = _t->getNextSibling();
#line 3252 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root08->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_NOR, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4964 "VerilogTreeWalker.cpp"
		break;
	}
	case U_XOR:
	{
		RefVerAST __t699 = _t;
		root09 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_XOR);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t699;
		_t = _t->getNextSibling();
#line 3258 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root09->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_XOR, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 4985 "VerilogTreeWalker.cpp"
		break;
	}
	case U_XNOR:
	{
		RefVerAST __t700 = _t;
		root10 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),U_XNOR);
		_t = _t->getFirstChild();
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e1=expression(_t);
		_t = _retTree;
		_t = __t700;
		_t = _t->getNextSibling();
#line 3264 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root10->getLine(), CDOmExprOp::OP_UNARY_REDUCTION_XNOR, e1);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5006 "VerilogTreeWalker.cpp"
		break;
	}
	case POW:
	{
		RefVerAST __t701 = _t;
		root11 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),POW);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t701;
		_t = _t->getNextSibling();
#line 3270 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root11->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_POW, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5029 "VerilogTreeWalker.cpp"
		break;
	}
	case STAR:
	{
		RefVerAST __t702 = _t;
		root12 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STAR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t702;
		_t = _t->getNextSibling();
#line 3276 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root12->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5052 "VerilogTreeWalker.cpp"
		break;
	}
	case DIV:
	{
		RefVerAST __t703 = _t;
		root13 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DIV);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t703;
		_t = _t->getNextSibling();
#line 3282 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root13->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_DIV, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5075 "VerilogTreeWalker.cpp"
		break;
	}
	case MOD:
	{
		RefVerAST __t704 = _t;
		root14 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MOD);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t704;
		_t = _t->getNextSibling();
#line 3288 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root14->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_MOD, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5098 "VerilogTreeWalker.cpp"
		break;
	}
	case PLUS:
	{
		RefVerAST __t705 = _t;
		root15 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PLUS);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t705;
		_t = _t->getNextSibling();
#line 3294 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root15->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5121 "VerilogTreeWalker.cpp"
		break;
	}
	case MINUS:
	{
		RefVerAST __t706 = _t;
		root16 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MINUS);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t706;
		_t = _t->getNextSibling();
#line 3300 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root16->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5144 "VerilogTreeWalker.cpp"
		break;
	}
	case SL:
	{
		RefVerAST __t707 = _t;
		root17 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SL);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t707;
		_t = _t->getNextSibling();
#line 3306 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root17->getLine(), CDOmExprOp::OP_BINARY_SHIFT_LEFT, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5167 "VerilogTreeWalker.cpp"
		break;
	}
	case SSL:
	{
		RefVerAST __t708 = _t;
		root18 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SSL);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t708;
		_t = _t->getNextSibling();
#line 3312 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root18->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5190 "VerilogTreeWalker.cpp"
		break;
	}
	case SR:
	{
		RefVerAST __t709 = _t;
		root19 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t709;
		_t = _t->getNextSibling();
#line 3318 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root19->getLine(), CDOmExprOp::OP_BINARY_SHIFT_RIGHT, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5213 "VerilogTreeWalker.cpp"
		break;
	}
	case SSR:
	{
		RefVerAST __t710 = _t;
		root20 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SSR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t710;
		_t = _t->getNextSibling();
#line 3324 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root20->getLine(), CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5236 "VerilogTreeWalker.cpp"
		break;
	}
	case LT_:
	{
		RefVerAST __t711 = _t;
		root21 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LT_);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t711;
		_t = _t->getNextSibling();
#line 3330 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root21->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_LESS, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5259 "VerilogTreeWalker.cpp"
		break;
	}
	case GT:
	{
		RefVerAST __t712 = _t;
		root22 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GT);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t712;
		_t = _t->getNextSibling();
#line 3336 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root22->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_GREATER, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5282 "VerilogTreeWalker.cpp"
		break;
	}
	case LE:
	{
		RefVerAST __t713 = _t;
		root23 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LE);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t713;
		_t = _t->getNextSibling();
#line 3342 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root23->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5305 "VerilogTreeWalker.cpp"
		break;
	}
	case GE:
	{
		RefVerAST __t714 = _t;
		root24 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GE);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t714;
		_t = _t->getNextSibling();
#line 3348 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root24->getLine(), CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5328 "VerilogTreeWalker.cpp"
		break;
	}
	case EQUAL:
	{
		RefVerAST __t715 = _t;
		root25 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EQUAL);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t715;
		_t = _t->getNextSibling();
#line 3354 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root25->getLine(), CDOmExprOp::OP_BINARY_EQUALITY_EQ, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5351 "VerilogTreeWalker.cpp"
		break;
	}
	case NOT_EQ:
	{
		RefVerAST __t716 = _t;
		root26 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOT_EQ);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t716;
		_t = _t->getNextSibling();
#line 3360 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root26->getLine(), CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5374 "VerilogTreeWalker.cpp"
		break;
	}
	case NOT_EQ_CASE:
	{
		RefVerAST __t717 = _t;
		root27 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOT_EQ_CASE);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t717;
		_t = _t->getNextSibling();
#line 3366 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root27->getLine(), CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5397 "VerilogTreeWalker.cpp"
		break;
	}
	case EQ_CASE:
	{
		RefVerAST __t718 = _t;
		root28 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EQ_CASE);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t718;
		_t = _t->getNextSibling();
#line 3372 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root28->getLine(), CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5420 "VerilogTreeWalker.cpp"
		break;
	}
	case AND:
	{
		RefVerAST __t719 = _t;
		root29 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),AND);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t719;
		_t = _t->getNextSibling();
#line 3378 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root29->getLine(), CDOmExprOp::OP_BINARY_BITWISE_AND, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5443 "VerilogTreeWalker.cpp"
		break;
	}
	case NAND:
	{
		RefVerAST __t720 = _t;
		root30 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NAND);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t720;
		_t = _t->getNextSibling();
#line 3384 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root30->getLine(), CDOmExprOp::OP_BINARY_BITWISE_NAND, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5466 "VerilogTreeWalker.cpp"
		break;
	}
	case XOR:
	{
		RefVerAST __t721 = _t;
		root31 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),XOR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t721;
		_t = _t->getNextSibling();
#line 3390 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root31->getLine(), CDOmExprOp::OP_BINARY_BITWISE_XOR, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5489 "VerilogTreeWalker.cpp"
		break;
	}
	case XNOR:
	{
		RefVerAST __t722 = _t;
		root32 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),XNOR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t722;
		_t = _t->getNextSibling();
#line 3396 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root32->getLine(), CDOmExprOp::OP_BINARY_BITWISE_XNOR, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5512 "VerilogTreeWalker.cpp"
		break;
	}
	case OR:
	{
		RefVerAST __t723 = _t;
		root33 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),OR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t723;
		_t = _t->getNextSibling();
#line 3402 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root33->getLine(), CDOmExprOp::OP_BINARY_BITWISE_OR, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5535 "VerilogTreeWalker.cpp"
		break;
	}
	case NOR:
	{
		RefVerAST __t724 = _t;
		root34 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NOR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t724;
		_t = _t->getNextSibling();
#line 3408 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root34->getLine(), CDOmExprOp::OP_BINARY_BITWISE_NOR, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5558 "VerilogTreeWalker.cpp"
		break;
	}
	case LAND:
	{
		RefVerAST __t725 = _t;
		root35 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LAND);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t725;
		_t = _t->getNextSibling();
#line 3414 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root35->getLine(), CDOmExprOp::OP_BINARY_LOGIC_AND, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5581 "VerilogTreeWalker.cpp"
		break;
	}
	case LOR:
	{
		RefVerAST __t726 = _t;
		root36 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LOR);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		_t = __t726;
		_t = _t->getNextSibling();
#line 3420 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root36->getLine(), CDOmExprOp::OP_BINARY_LOGIC_OR, e1, e2);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5604 "VerilogTreeWalker.cpp"
		break;
	}
	case QUESTION:
	{
		RefVerAST __t727 = _t;
		root37 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),QUESTION);
		_t = _t->getFirstChild();
		e1=expression(_t);
		_t = _retTree;
		exprColl=attrs_opt(_t);
		_t = _retTree;
		e2=expression(_t);
		_t = _retTree;
		e3=expression(_t);
		_t = _retTree;
		_t = __t727;
		_t = _t->getNextSibling();
#line 3426 "verilog.walker.g"
		
		exprOp = CDOmExprOp::build(root37->getLine(), CDOmExprOp::OP_TERNARY_COND, e1, e2, e3);
		if(exprColl.get()) exprOp->setAttrListCollection(exprColl);
		expr = exprOp;
		
#line 5629 "VerilogTreeWalker.cpp"
		break;
	}
	case MINTYPMAX_EXPRESSION:
	{
		expr=mintypmax_expression(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
	return expr;
}

void VerilogTreeWalker::list_of_variable_identifiers(RefVerAST _t,
	RefCDOmVarDecl varDecl
) {
	RefVerAST list_of_variable_identifiers_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{ // ( ... )+
	int _cnt176=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == VARIABLE_TYPE)) {
			variable_type(_t,varDecl);
			_t = _retTree;
		}
		else {
			if ( _cnt176>=1 ) { goto _loop176; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt176++;
	}
	_loop176:;
	}  // ( ... )+
	_retTree = _t;
}

void VerilogTreeWalker::drive_strength(RefVerAST _t,
	ECDOmDriveStrength& ds1, ECDOmDriveStrength& ds2
) {
	RefVerAST drive_strength_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_PULL0:
	case K_STRONG0:
	case K_SUPPLY0:
	case K_WEAK0:
	{
		ds1=strength0(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PULL1:
		case K_STRONG1:
		case K_SUPPLY1:
		case K_WEAK1:
		{
			ds2=strength1(_t);
			_t = _retTree;
			break;
		}
		case K_HIGHZ1:
		{
			ds2=highz1(_t);
			_t = _retTree;
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case K_PULL1:
	case K_STRONG1:
	case K_SUPPLY1:
	case K_WEAK1:
	{
		ds1=strength1(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PULL0:
		case K_STRONG0:
		case K_SUPPLY0:
		case K_WEAK0:
		{
			ds2=strength0(_t);
			_t = _retTree;
			break;
		}
		case K_HIGHZ0:
		{
			ds2=highz0(_t);
			_t = _retTree;
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case K_HIGHZ0:
	{
		ds1=highz0(_t);
		_t = _retTree;
		ds2=strength1(_t);
		_t = _retTree;
		break;
	}
	case K_HIGHZ1:
	{
		ds1=highz1(_t);
		_t = _retTree;
		ds2=strength0(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

CDOmNetDecl::EVectorAccessType  VerilogTreeWalker::expandrange(RefVerAST _t) {
#line 559 "verilog.walker.g"
	CDOmNetDecl::EVectorAccessType vat;
#line 5778 "VerilogTreeWalker.cpp"
	RefVerAST expandrange_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_VECTORED:
	{
		RefVerAST tmp54_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_VECTORED);
		_t = _t->getNextSibling();
#line 560 "verilog.walker.g"
		vat = CDOmNetDecl::VECTOR_ACCESS_VECTORED;
#line 5791 "VerilogTreeWalker.cpp"
		break;
	}
	case K_SCALARED:
	{
		RefVerAST tmp55_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SCALARED);
		_t = _t->getNextSibling();
#line 561 "verilog.walker.g"
		vat = CDOmNetDecl::VECTOR_ACCESS_SCALARED;
#line 5801 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return vat;
}

void VerilogTreeWalker::delay3(RefVerAST _t,
	RefCDOmBase delayHolder
) {
	RefVerAST delay3_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST dl = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 665 "verilog.walker.g"
	
	RefCDOmExpr expr;
	RefCDOmMinTypMax minTypMax;
	bool fatal = false;
	RefCDOmDelay delay;
	
#line 5825 "VerilogTreeWalker.cpp"
	
	RefVerAST __t140 = _t;
	dl = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DELAY);
	_t = _t->getFirstChild();
#line 673 "verilog.walker.g"
	
	switch(delayHolder->getType()) {
	case TYPE_GATE_INSTANTIATION:
	(boost::static_pointer_cast<CDOmGateInstantiation>(delayHolder))->buildDelay(dl->getLine());
	delay = (boost::static_pointer_cast<CDOmGateInstantiation>(delayHolder))->getDelay();
	break;
	case TYPE_CONT_ASSN:
	(boost::static_pointer_cast<CDOmContAssn>(delayHolder))->buildDelay3(dl->getLine());
	delay = (boost::static_pointer_cast<CDOmContAssn>(delayHolder))->getDelay3();
	break;
	case TYPE_NET_DECL:
	(boost::static_pointer_cast<CDOmNetDecl>(delayHolder))->buildDelay3(dl->getLine());
	delay = (boost::static_pointer_cast<CDOmNetDecl>(delayHolder))->getDelay3();
	break;
	default:
	fatal = true;
	}
	
#line 5850 "VerilogTreeWalker.cpp"
	if (!( !fatal ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !fatal ");
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY_VALUE:
	{
		expr=delay_value(_t);
		_t = _retTree;
#line 693 "verilog.walker.g"
		
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
		
#line 5877 "VerilogTreeWalker.cpp"
		if (!(!fatal))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException("!fatal");
		break;
	}
	case MINTYPMAX_EXPRESSION:
	{
		minTypMax=mintypmax_expression(_t);
		_t = _retTree;
#line 709 "verilog.walker.g"
		delay->addMinTypMax(minTypMax);
#line 5888 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case MINTYPMAX_EXPRESSION:
		{
			minTypMax=mintypmax_expression(_t);
			_t = _retTree;
#line 710 "verilog.walker.g"
			delay->addMinTypMax(minTypMax);
#line 5899 "VerilogTreeWalker.cpp"
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINTYPMAX_EXPRESSION:
			{
				minTypMax=mintypmax_expression(_t);
				_t = _retTree;
#line 711 "verilog.walker.g"
				delay->addMinTypMax(minTypMax);
#line 5910 "VerilogTreeWalker.cpp"
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t140;
	_t = _t->getNextSibling();
#line 715 "verilog.walker.g"
	PRINT_AST(DELAY);
#line 5947 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::list_of_net_identifiers_or_decl_assignments(RefVerAST _t,
	RefCDOmNetDecl netDecl
) {
	RefVerAST list_of_net_identifiers_or_decl_assignments_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 774 "verilog.walker.g"
	
	pair<RefString, int> name;
	RefCDOmRangeList rangeList;
	RefCDOmExpr expr;
	
#line 5961 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case LIST_OF_NET_IDENTIFIERS:
	{
		RefVerAST __t152 = _t;
		RefVerAST tmp56_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LIST_OF_NET_IDENTIFIERS);
		_t = _t->getFirstChild();
		{ // ( ... )+
		int _cnt155=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
				name=identifier(_t);
				_t = _retTree;
#line 782 "verilog.walker.g"
				rangeList = RefCDOmRangeList();
#line 5982 "VerilogTreeWalker.cpp"
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case DIMENSION:
				{
					rangeList=list_of_dimensions(_t);
					_t = _retTree;
					break;
				}
				case 3:
				case IDENTIFIER:
				case ESCAPED_IDENTIFIER:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
#line 784 "verilog.walker.g"
				netDecl->addNet(name.second, name.first, rangeList);
#line 6007 "VerilogTreeWalker.cpp"
			}
			else {
				if ( _cnt155>=1 ) { goto _loop155; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt155++;
		}
		_loop155:;
		}  // ( ... )+
		_t = __t152;
		_t = _t->getNextSibling();
		break;
	}
	case LIST_OF_NET_DECL_ASSIGNMENTS:
	{
		RefVerAST __t156 = _t;
		RefVerAST tmp57_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LIST_OF_NET_DECL_ASSIGNMENTS);
		_t = _t->getFirstChild();
		{ // ( ... )+
		int _cnt158=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
				name=identifier(_t);
				_t = _retTree;
				expr=expression(_t);
				_t = _retTree;
#line 789 "verilog.walker.g"
				netDecl->addNet(name.second, name.first, expr);
#line 6039 "VerilogTreeWalker.cpp"
			}
			else {
				if ( _cnt158>=1 ) { goto _loop158; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt158++;
		}
		_loop158:;
		}  // ( ... )+
		_t = __t156;
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

CDOmNetDecl::EChargeStrength  VerilogTreeWalker::charge_strength(RefVerAST _t) {
#line 657 "verilog.walker.g"
	CDOmNetDecl::EChargeStrength cs;
#line 6064 "VerilogTreeWalker.cpp"
	RefVerAST charge_strength_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SMALL:
	{
		RefVerAST tmp58_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SMALL);
		_t = _t->getNextSibling();
#line 658 "verilog.walker.g"
		cs = CDOmNetDecl::CHARGE_STRENGTH_SMALL ;
#line 6077 "VerilogTreeWalker.cpp"
		break;
	}
	case K_MEDIUM:
	{
		RefVerAST tmp59_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_MEDIUM);
		_t = _t->getNextSibling();
#line 659 "verilog.walker.g"
		cs = CDOmNetDecl::CHARGE_STRENGTH_MEDIUM;
#line 6087 "VerilogTreeWalker.cpp"
		break;
	}
	case K_LARGE:
	{
		RefVerAST tmp60_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_LARGE);
		_t = _t->getNextSibling();
#line 660 "verilog.walker.g"
		cs = CDOmNetDecl::CHARGE_STRENGTH_LARGE ;
#line 6097 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return cs;
}

void VerilogTreeWalker::list_of_event_identifiers(RefVerAST _t,
	 RefCDOmEventDecl &eventDecl, RefCDOmBase parent, int lineNumber
) {
	RefVerAST list_of_event_identifiers_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 795 "verilog.walker.g"
	
	RefCDOmRangeList rangeList;
	RefCDOmRange range;
	pair<RefString, int> str;
	
#line 6119 "VerilogTreeWalker.cpp"
	
	{
	str=identifier(_t);
	_t = _retTree;
#line 801 "verilog.walker.g"
	rangeList = RefCDOmRangeList(  );
#line 6126 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == DIMENSION)) {
			range=dimension(_t);
			_t = _retTree;
#line 803 "verilog.walker.g"
			
			if( rangeList.get() )
			rangeList->addItem( range );
			else
			rangeList = CDOmRangeList::build(range->getLineNumber(),  range );
			
#line 6141 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop162;
		}
		
	}
	_loop162:;
	} // ( ... )*
#line 810 "verilog.walker.g"
	eventDecl = CDOmEventDecl::build(str.second,  parent, str.first, rangeList );
#line 6152 "VerilogTreeWalker.cpp"
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			str=identifier(_t);
			_t = _retTree;
#line 812 "verilog.walker.g"
			rangeList = RefCDOmRangeList(  );
#line 6163 "VerilogTreeWalker.cpp"
			{ // ( ... )*
			for (;;) {
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				if ((_t->getType() == DIMENSION)) {
					range=dimension(_t);
					_t = _retTree;
#line 814 "verilog.walker.g"
					
					if( rangeList.get() )
					rangeList->addItem( range );
					else
					rangeList = CDOmRangeList::build(range->getLineNumber(),  range );
					
#line 6178 "VerilogTreeWalker.cpp"
				}
				else {
					goto _loop165;
				}
				
			}
			_loop165:;
			} // ( ... )*
#line 821 "verilog.walker.g"
			eventDecl->addEvent(str.second,  str.first, rangeList );
#line 6189 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop166;
		}
		
	}
	_loop166:;
	} // ( ... )*
	_retTree = _t;
}

RefCDOmGenvarDecl  VerilogTreeWalker::list_of_genvar_identifiers(RefVerAST _t,
	 RefCDOmBase parent 
) {
#line 825 "verilog.walker.g"
	RefCDOmGenvarDecl genvarDecl;
#line 6206 "VerilogTreeWalker.cpp"
	RefVerAST list_of_genvar_identifiers_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 825 "verilog.walker.g"
	pair<RefString, int> name;
#line 6210 "VerilogTreeWalker.cpp"
	
	{
	name=identifier(_t);
	_t = _retTree;
#line 827 "verilog.walker.g"
	genvarDecl = CDOmGenvarDecl::build(name.second,  parent, name.first );
#line 6217 "VerilogTreeWalker.cpp"
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			name=identifier(_t);
			_t = _retTree;
#line 828 "verilog.walker.g"
			genvarDecl->addGenvar(name.second,  name.first );
#line 6228 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop170;
		}
		
	}
	_loop170:;
	} // ( ... )*
	_retTree = _t;
	return genvarDecl;
}

void VerilogTreeWalker::variable_type(RefVerAST _t,
	RefCDOmVarDecl varDecl
) {
	RefVerAST variable_type_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST vt = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 601 "verilog.walker.g"
	
	pair<RefString, int> name;
	RefCDOmExpr expr;
	RefCDOmRangeList rangeList = RefCDOmRangeList();
	
#line 6252 "VerilogTreeWalker.cpp"
	
	RefVerAST __t127 = _t;
	vt = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),VARIABLE_TYPE);
	_t = _t->getFirstChild();
	name=identifier(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case 3:
	case DIMENSION:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case DIMENSION:
		{
			rangeList=list_of_dimensions(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 610 "verilog.walker.g"
		varDecl->addVar((unsigned long)vt->getLine(), name.first, rangeList);
#line 6289 "VerilogTreeWalker.cpp"
		break;
	}
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
#line 612 "verilog.walker.g"
		varDecl->addVar((unsigned long)vt->getLine(), name.first, expr);
#line 6346 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t127;
	_t = _t->getNextSibling();
	_retTree = _t;
}

RefCDOmRangeList  VerilogTreeWalker::list_of_dimensions(RefVerAST _t) {
#line 915 "verilog.walker.g"
	RefCDOmRangeList rangeList;
#line 6363 "VerilogTreeWalker.cpp"
	RefVerAST list_of_dimensions_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 915 "verilog.walker.g"
	RefCDOmRange rng;
#line 6367 "VerilogTreeWalker.cpp"
	
	{
	rng=dimension(_t);
	_t = _retTree;
#line 918 "verilog.walker.g"
	rangeList = CDOmRangeList::build(rng->getLineNumber(), rng);
#line 6374 "VerilogTreeWalker.cpp"
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == DIMENSION)) {
			rng=dimension(_t);
			_t = _retTree;
#line 921 "verilog.walker.g"
			rangeList->addItem(rng);
#line 6385 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop193;
		}
		
	}
	_loop193:;
	} // ( ... )*
	_retTree = _t;
	return rangeList;
}

ECDOmDriveStrength  VerilogTreeWalker::strength0(RefVerAST _t) {
#line 635 "verilog.walker.g"
	ECDOmDriveStrength s0;
#line 6401 "VerilogTreeWalker.cpp"
	RefVerAST strength0_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SUPPLY0:
	{
		RefVerAST tmp61_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY0);
		_t = _t->getNextSibling();
#line 636 "verilog.walker.g"
		s0 = DRIVE_STRENGTH_SUPPLY_0;
#line 6414 "VerilogTreeWalker.cpp"
		break;
	}
	case K_STRONG0:
	{
		RefVerAST tmp62_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STRONG0);
		_t = _t->getNextSibling();
#line 637 "verilog.walker.g"
		s0 = DRIVE_STRENGTH_STRONG_0;
#line 6424 "VerilogTreeWalker.cpp"
		break;
	}
	case K_PULL0:
	{
		RefVerAST tmp63_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PULL0);
		_t = _t->getNextSibling();
#line 638 "verilog.walker.g"
		s0 = DRIVE_STRENGTH_PULL_0  ;
#line 6434 "VerilogTreeWalker.cpp"
		break;
	}
	case K_WEAK0:
	{
		RefVerAST tmp64_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WEAK0);
		_t = _t->getNextSibling();
#line 639 "verilog.walker.g"
		s0 = DRIVE_STRENGTH_WEAK_0  ;
#line 6444 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return s0;
}

ECDOmDriveStrength  VerilogTreeWalker::strength1(RefVerAST _t) {
#line 642 "verilog.walker.g"
	ECDOmDriveStrength s1;
#line 6459 "VerilogTreeWalker.cpp"
	RefVerAST strength1_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SUPPLY1:
	{
		RefVerAST tmp65_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SUPPLY1);
		_t = _t->getNextSibling();
#line 643 "verilog.walker.g"
		s1 = DRIVE_STRENGTH_SUPPLY_1;
#line 6472 "VerilogTreeWalker.cpp"
		break;
	}
	case K_STRONG1:
	{
		RefVerAST tmp66_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_STRONG1);
		_t = _t->getNextSibling();
#line 644 "verilog.walker.g"
		s1 = DRIVE_STRENGTH_STRONG_1;
#line 6482 "VerilogTreeWalker.cpp"
		break;
	}
	case K_PULL1:
	{
		RefVerAST tmp67_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PULL1);
		_t = _t->getNextSibling();
#line 645 "verilog.walker.g"
		s1 = DRIVE_STRENGTH_PULL_1  ;
#line 6492 "VerilogTreeWalker.cpp"
		break;
	}
	case K_WEAK1:
	{
		RefVerAST tmp68_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WEAK1);
		_t = _t->getNextSibling();
#line 646 "verilog.walker.g"
		s1 = DRIVE_STRENGTH_WEAK_1  ;
#line 6502 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return s1;
}

ECDOmDriveStrength  VerilogTreeWalker::highz1(RefVerAST _t) {
#line 653 "verilog.walker.g"
	ECDOmDriveStrength hz1;
#line 6517 "VerilogTreeWalker.cpp"
	RefVerAST highz1_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST tmp69_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_HIGHZ1);
	_t = _t->getNextSibling();
#line 654 "verilog.walker.g"
	hz1 = DRIVE_STRENGTH_HIGHZ_1;
#line 6525 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return hz1;
}

ECDOmDriveStrength  VerilogTreeWalker::highz0(RefVerAST _t) {
#line 649 "verilog.walker.g"
	ECDOmDriveStrength hz0;
#line 6533 "VerilogTreeWalker.cpp"
	RefVerAST highz0_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST tmp70_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_HIGHZ0);
	_t = _t->getNextSibling();
#line 650 "verilog.walker.g"
	hz0 = DRIVE_STRENGTH_HIGHZ_0;
#line 6541 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return hz0;
}

RefCDOmExpr  VerilogTreeWalker::delay_value(RefVerAST _t) {
#line 755 "verilog.walker.g"
	RefCDOmExpr returnedExpr;
#line 6549 "VerilogTreeWalker.cpp"
	RefVerAST delay_value_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST dv = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST un = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST un1 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 755 "verilog.walker.g"
	
	CCDOMAdapter adapter = CCDOMAdapter::getInstance();
	pair<RefString, int> str;
	
#line 6559 "VerilogTreeWalker.cpp"
	
	RefVerAST __t149 = _t;
	dv = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DELAY_VALUE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	{
		un = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
		_t = _t->getNextSibling();
#line 762 "verilog.walker.g"
		returnedExpr = adapter.convertToCDOmNumberFrom_UNSIGNED_NUMBER(un->getLine(), un->getNumber());
#line 6576 "VerilogTreeWalker.cpp"
		break;
	}
	case REAL_NUMBER:
	{
		un1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),REAL_NUMBER);
		_t = _t->getNextSibling();
#line 764 "verilog.walker.g"
		returnedExpr = adapter.convertToCDOmRealFrom_REAL_NUMBER(un1->getLine(), un1->getNumber());
#line 6586 "VerilogTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		str=identifier(_t);
		_t = _retTree;
#line 766 "verilog.walker.g"
		returnedExpr = CDOmExprLink::build(str.second, str.first);
#line 6596 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t149;
	_t = _t->getNextSibling();
#line 769 "verilog.walker.g"
	PRINT_AST(DELAY_VALUE);
#line 6609 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedExpr;
}

void VerilogTreeWalker::delay2(RefVerAST _t,
	RefCDOmModuleOrUdpInstantiation delayHolder
) {
	RefVerAST delay2_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST dl = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 718 "verilog.walker.g"
	
	RefCDOmExpr expr;
	RefCDOmMinTypMax minTypMax;
	RefCDOmDelay delay;
	bool delay2FATAL = true;
	
#line 6626 "VerilogTreeWalker.cpp"
	
	RefVerAST __t145 = _t;
	dl = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DELAY);
	_t = _t->getFirstChild();
#line 726 "verilog.walker.g"
	
	delayHolder->buildDelay2(dl->getLine());
	delay = delayHolder->getDelay2();
	
#line 6637 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY_VALUE:
	{
		expr=delay_value(_t);
		_t = _retTree;
#line 731 "verilog.walker.g"
		
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
		
#line 6662 "VerilogTreeWalker.cpp"
		if (!( delay2FATAL ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" delay2FATAL ");
		break;
	}
	case MINTYPMAX_EXPRESSION:
	{
		minTypMax=mintypmax_expression(_t);
		_t = _retTree;
#line 747 "verilog.walker.g"
		delay->addMinTypMax(minTypMax);
#line 6673 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case MINTYPMAX_EXPRESSION:
		{
			minTypMax=mintypmax_expression(_t);
			_t = _retTree;
#line 748 "verilog.walker.g"
			delay->addMinTypMax(minTypMax);
#line 6684 "VerilogTreeWalker.cpp"
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t145;
	_t = _t->getNextSibling();
#line 752 "verilog.walker.g"
	PRINT_AST(DELAY);
#line 6709 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

RefCDOmRange  VerilogTreeWalker::dimension(RefVerAST _t) {
#line 906 "verilog.walker.g"
	RefCDOmRange rng;
#line 6716 "VerilogTreeWalker.cpp"
	RefVerAST dimension_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST dim = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 906 "verilog.walker.g"
	RefCDOmExpr lsb, msb;
#line 6721 "VerilogTreeWalker.cpp"
	
	RefVerAST __t189 = _t;
	dim = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DIMENSION);
	_t = _t->getFirstChild();
	lsb=expression(_t);
	_t = _retTree;
	msb=expression(_t);
	_t = _retTree;
	_t = __t189;
	_t = _t->getNextSibling();
#line 912 "verilog.walker.g"
	rng = CDOmRange::build(dim->getLine(), lsb, msb);
#line 6735 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return rng;
}

void VerilogTreeWalker::param_assignment(RefVerAST _t,
	RefCDOmParamDecl paramDecl
) {
	RefVerAST param_assignment_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 888 "verilog.walker.g"
	
	pair<RefString, int> name;
	RefCDOmMinTypMax minTypMax;
	
#line 6749 "VerilogTreeWalker.cpp"
	
	RefVerAST __t187 = _t;
	RefVerAST tmp71_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PARAM_ASSIGNMENT);
	_t = _t->getFirstChild();
	name=identifier(_t);
	_t = _retTree;
	minTypMax=mintypmax_expression(_t);
	_t = _retTree;
	_t = __t187;
	_t = _t->getNextSibling();
#line 897 "verilog.walker.g"
	paramDecl->addParam(name.second, name.first, minTypMax);
#line 6763 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::pulse_control_specparam(RefVerAST _t,
	 RefCDOmParamDecl paramDecl 
) {
	RefVerAST pulse_control_specparam_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST pcs = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 846 "verilog.walker.g"
	
	RefCDOmRangeExpr rng1 = RefCDOmRangeExpr(  );
	RefCDOmRangeExpr rng2 = RefCDOmRangeExpr(  );
	RefCDOmMinTypMax minTypMax1;
	RefCDOmMinTypMax minTypMax2 = RefCDOmMinTypMax(  );
	pair<RefString, int> str1(RefString(  ), 0);
	pair<RefString, int> str2(RefString(  ), 0);
	RefCDOmExprLink exprLink1, exprLink2;
	
#line 6782 "VerilogTreeWalker.cpp"
	
	RefVerAST __t181 = _t;
	pcs = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PULSE_CONTROL_SPECPARAM);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		str1=identifier(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case EXPRESSION:
		case CONCATENATION:
		case MULTI_CONCATENATION:
		case RANGE_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case FUNCTION_CALL:
		case SYSTEM_FUNCTION_CALL:
		case MINTYPMAX_EXPRESSION:
		case SIZED_NUMBER:
		{
			rng1=range_expression(_t);
			_t = _retTree;
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 860 "verilog.walker.g"
		
		exprLink1 = CDOmExprLink::build(str1.second,  str1.first );
		if( rng1.get() )
		exprLink1->setRangeExpr( rng1 );
		
#line 6873 "VerilogTreeWalker.cpp"
		str2=identifier(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case EXPRESSION:
		case CONCATENATION:
		case MULTI_CONCATENATION:
		case RANGE_EXPRESSION:
		case EXPR_PRIMARY_IDENTIFIER:
		case FUNCTION_CALL:
		case SYSTEM_FUNCTION_CALL:
		case MINTYPMAX_EXPRESSION:
		case SIZED_NUMBER:
		{
			rng2=range_expression(_t);
			_t = _retTree;
			break;
		}
		case ASSIGN:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 867 "verilog.walker.g"
		
		exprLink2 = CDOmExprLink::build(str2.second,  str2.first );
		if( rng2.get() )
		exprLink2->setRangeExpr( rng2 );
		
#line 6951 "VerilogTreeWalker.cpp"
		break;
	}
	case ASSIGN:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	RefVerAST tmp72_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ASSIGN);
	_t = _t->getNextSibling();
	minTypMax1=mintypmax_expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINTYPMAX_EXPRESSION:
	{
		minTypMax2=mintypmax_expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 876 "verilog.walker.g"
	
	if( exprLink1.get() )
	paramDecl->addPulseControl(pcs->getLine(), exprLink1, exprLink2, minTypMax1, minTypMax2 );
	else
	paramDecl->addPulseControl(pcs->getLine(), minTypMax1, minTypMax2 );
	
#line 6996 "VerilogTreeWalker.cpp"
	_t = __t181;
	_t = _t->getNextSibling();
	_retTree = _t;
}

RefCDOmRangeList  VerilogTreeWalker::list_of_ranges(RefVerAST _t) {
#line 937 "verilog.walker.g"
	RefCDOmRangeList rangeList;
#line 7005 "VerilogTreeWalker.cpp"
	RefVerAST list_of_ranges_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 937 "verilog.walker.g"
	RefCDOmRange rng;
#line 7009 "VerilogTreeWalker.cpp"
	
	{
	rng=range(_t);
	_t = _retTree;
#line 940 "verilog.walker.g"
	rangeList = CDOmRangeList::build(rng->getLineNumber(), rng);
#line 7016 "VerilogTreeWalker.cpp"
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == RANGE)) {
			rng=range(_t);
			_t = _retTree;
#line 943 "verilog.walker.g"
			rangeList->addItem(rng);
#line 7027 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop199;
		}
		
	}
	_loop199:;
	} // ( ... )*
	_retTree = _t;
	return rangeList;
}

 RefCDOmAttrHolder   VerilogTreeWalker::function_item_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1019 "verilog.walker.g"
	 RefCDOmAttrHolder  returnedAttrHolder ;
#line 7045 "VerilogTreeWalker.cpp"
	RefVerAST function_item_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_EVENT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TIME:
	{
		returnedAttrHolder=block_item_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INPUT:
	{
		returnedAttrHolder=tf_input_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedAttrHolder ;
}

RefCDOmStmt  VerilogTreeWalker::statement(RefVerAST _t) {
#line 2056 "verilog.walker.g"
	RefCDOmStmt returnedStmt;
#line 7082 "VerilogTreeWalker.cpp"
	RefVerAST statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2056 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrList; 
	
#line 7088 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
	{
		returnedStmt=blocking_or_nonblocking_assignment(_t);
		_t = _retTree;
		break;
	}
	case CASE_STATEMENT:
	{
		returnedStmt=case_statement(_t);
		_t = _retTree;
		break;
	}
	case K_IF:
	{
		returnedStmt=conditional_statement(_t);
		_t = _retTree;
		break;
	}
	case K_DISABLE:
	{
		returnedStmt=disable_statement(_t);
		_t = _retTree;
		break;
	}
	case EVENT_TRIGGER:
	{
		returnedStmt=event_trigger(_t);
		_t = _retTree;
		break;
	}
	case LOOP_STATEMENT:
	{
		returnedStmt=loop_statement(_t);
		_t = _retTree;
		break;
	}
	case PAR_BLOCK:
	{
		returnedStmt=par_block(_t);
		_t = _retTree;
		break;
	}
	case K_ASSIGN:
	case K_DEASSIGN:
	case K_FORCE:
	case K_RELEASE:
	{
		returnedStmt=procedural_continuous_assignments(_t);
		_t = _retTree;
		break;
	}
	case DELAY_CONTROL:
	case EVENT_CONTROL:
	{
		returnedStmt=procedural_timing_control_statement(_t);
		_t = _retTree;
		break;
	}
	case SEQ_BLOCK:
	{
		returnedStmt=seq_block(_t);
		_t = _retTree;
		break;
	}
	case SYSTEM_TASK_ENABLE:
	{
		returnedStmt=system_task_enable(_t);
		_t = _retTree;
		break;
	}
	case TASK_ENABLE:
	{
		returnedStmt=task_enable(_t);
		_t = _retTree;
		break;
	}
	case K_WAIT:
	{
		returnedStmt=wait_statement(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedStmt;
}

void VerilogTreeWalker::function_port_list(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST function_port_list_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1024 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl;
	RefCDOmAttrHolder attrHolder;
	
#line 7193 "VerilogTreeWalker.cpp"
	
	RefVerAST __t214 = _t;
	RefVerAST tmp73_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),FUNCTION_PORT_LIST);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt216=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == K_INPUT || _t->getType() == ATTRIBUTE_INSTANCE)) {
			attrListColl=attrs_opt(_t);
			_t = _retTree;
			attrHolder=tf_input_declaration(_t, parent );
			_t = _retTree;
#line 1032 "verilog.walker.g"
			if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 7211 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt216>=1 ) { goto _loop216; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt216++;
	}
	_loop216:;
	}  // ( ... )+
	_t = __t214;
	_t = _t->getNextSibling();
#line 1035 "verilog.walker.g"
	PRINT_AST(tmp73_AST_in);
#line 7225 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

 RefCDOmAttrHolder  VerilogTreeWalker::block_item_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1177 "verilog.walker.g"
	 RefCDOmAttrHolder returnedAttrHolder ;
#line 7234 "VerilogTreeWalker.cpp"
	RefVerAST block_item_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_REG:
	{
		returnedAttrHolder=reg_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INTEGER:
	{
		returnedAttrHolder=integer_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_TIME:
	{
		returnedAttrHolder=time_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_REAL:
	{
		returnedAttrHolder=real_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_REALTIME:
	{
		returnedAttrHolder=realtime_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_EVENT:
	{
		returnedAttrHolder=event_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_LOCALPARAM:
	{
		returnedAttrHolder=local_parameter_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_PARAMETER:
	{
		returnedAttrHolder=parameter_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedAttrHolder ;
}

 RefCDOmTFPortDecl  VerilogTreeWalker::tf_input_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1107 "verilog.walker.g"
	 RefCDOmTFPortDecl returned ;
#line 7302 "VerilogTreeWalker.cpp"
	RefVerAST tf_input_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST inpt = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1107 "verilog.walker.g"
	
	ECDOmVarType varType=VAR_UNDEFINED;
	RefCDOmRange my_range;
	pair<RefString, int> str;
	
#line 7311 "VerilogTreeWalker.cpp"
	
	RefVerAST __t232 = _t;
	inpt = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_REG:
	case K_SIGNED:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_REG:
		{
			RefVerAST tmp74_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
			_t = _t->getNextSibling();
#line 1114 "verilog.walker.g"
			varType=VAR_REG;
#line 7338 "VerilogTreeWalker.cpp"
			break;
		}
		case K_SIGNED:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1115 "verilog.walker.g"
		returned = CDOmTFPortDecl::build(inpt->getLine(),  parent, PORT_INPUT, varType);
#line 7356 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp75_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 1116 "verilog.walker.g"
			returned->setSigned();
#line 7368 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			my_range=range(_t);
			_t = _retTree;
#line 1117 "verilog.walker.g"
			returned->setRange( my_range );
#line 7393 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_TIME:
	{
		varType=task_port_type(_t);
		_t = _retTree;
#line 1119 "verilog.walker.g"
		
		returned = CDOmTFPortDecl::build(inpt->getLine(),  parent, PORT_INPUT, varType);
		
#line 7420 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt238=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			str=identifier(_t);
			_t = _retTree;
#line 1123 "verilog.walker.g"
			returned->addPort(str.second,  str.first );
#line 7439 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt238>=1 ) { goto _loop238; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt238++;
	}
	_loop238:;
	}  // ( ... )+
	_t = __t232;
	_t = _t->getNextSibling();
#line 1125 "verilog.walker.g"
	PRINT_AST(K_INPUT);
#line 7453 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned ;
}

void VerilogTreeWalker::task_port_list(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST task_port_list_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST __t226 = _t;
	RefVerAST tmp76_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),TASK_PORT_LIST);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt228=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_2.member(_t->getType()))) {
			task_port_item(_t, parent );
			_t = _retTree;
		}
		else {
			if ( _cnt228>=1 ) { goto _loop228; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt228++;
	}
	_loop228:;
	}  // ( ... )+
	_t = __t226;
	_t = _t->getNextSibling();
#line 1091 "verilog.walker.g"
	PRINT_AST(tmp76_AST_in);
#line 7488 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

 RefCDOmAttrHolder  VerilogTreeWalker::task_item_declaration(RefVerAST _t,
	 RefCDOmBase parent 
) {
#line 1080 "verilog.walker.g"
	 RefCDOmAttrHolder returnedAttrHolder ;
#line 7497 "VerilogTreeWalker.cpp"
	RefVerAST task_item_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_EVENT:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TIME:
	{
		returnedAttrHolder=block_item_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INPUT:
	{
		returnedAttrHolder=tf_input_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_OUTPUT:
	{
		returnedAttrHolder=tf_output_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INOUT:
	{
		returnedAttrHolder=tf_inout_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedAttrHolder ;
}

RefCDOmStmt  VerilogTreeWalker::statement_or_null(RefVerAST _t) {
#line 2083 "verilog.walker.g"
	RefCDOmStmt returnedStmt;
#line 7546 "VerilogTreeWalker.cpp"
	RefVerAST statement_or_null_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST son = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2083 "verilog.walker.g"
	
	TBool nullStmt = TRUE;
	//RefCDOmAttrListCollection attrList;
	
#line 7554 "VerilogTreeWalker.cpp"
	
	RefVerAST __t479 = _t;
	son = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STATEMENT_OR_NULL);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ASSIGN:
	case K_DEASSIGN:
	case K_DISABLE:
	case K_FORCE:
	case K_IF:
	case K_RELEASE:
	case K_WAIT:
	case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
	case PAR_BLOCK:
	case SEQ_BLOCK:
	case DELAY_CONTROL:
	case EVENT_CONTROL:
	case CASE_STATEMENT:
	case LOOP_STATEMENT:
	case EVENT_TRIGGER:
	case SYSTEM_TASK_ENABLE:
	case TASK_ENABLE:
	{
		returnedStmt=statement(_t);
		_t = _retTree;
#line 2089 "verilog.walker.g"
		nullStmt = FALSE;
#line 7586 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 2090 "verilog.walker.g"
	
	if(nullStmt)
	returnedStmt = CDOmStmt::buildNullStmt(son->getLine());
	
#line 7604 "VerilogTreeWalker.cpp"
	_t = __t479;
	_t = _t->getNextSibling();
#line 2095 "verilog.walker.g"
	PRINT_AST(STATEMENT_OR_NULL);
#line 7609 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedStmt;
}

 RefCDOmTFPortDecl  VerilogTreeWalker::tf_output_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1128 "verilog.walker.g"
	 RefCDOmTFPortDecl returned ;
#line 7619 "VerilogTreeWalker.cpp"
	RefVerAST tf_output_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST outpt = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1128 "verilog.walker.g"
	
	ECDOmVarType varType=VAR_UNDEFINED;
	RefCDOmRange my_range;
	pair<RefString, int> str;
	
#line 7628 "VerilogTreeWalker.cpp"
	
	RefVerAST __t240 = _t;
	outpt = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_REG:
	case K_SIGNED:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_REG:
		{
			RefVerAST tmp77_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
			_t = _t->getNextSibling();
#line 1135 "verilog.walker.g"
			varType=VAR_REG;
#line 7655 "VerilogTreeWalker.cpp"
			break;
		}
		case K_SIGNED:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1136 "verilog.walker.g"
		returned = CDOmTFPortDecl::build(outpt->getLine(),  parent, PORT_OUTPUT, varType);
#line 7673 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp78_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 1137 "verilog.walker.g"
			returned->setSigned();
#line 7685 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			my_range=range(_t);
			_t = _retTree;
#line 1138 "verilog.walker.g"
			returned->setRange( my_range );
#line 7710 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_TIME:
	{
		varType=task_port_type(_t);
		_t = _retTree;
#line 1140 "verilog.walker.g"
		returned = CDOmTFPortDecl::build(outpt->getLine(),  parent, PORT_OUTPUT, varType);
#line 7735 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt246=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			str=identifier(_t);
			_t = _retTree;
#line 1142 "verilog.walker.g"
			returned->addPort(str.second,  str.first );
#line 7754 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt246>=1 ) { goto _loop246; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt246++;
	}
	_loop246:;
	}  // ( ... )+
	_t = __t240;
	_t = _t->getNextSibling();
#line 1144 "verilog.walker.g"
	PRINT_AST(K_OUTPUT);
#line 7768 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned ;
}

 RefCDOmTFPortDecl  VerilogTreeWalker::tf_inout_declaration(RefVerAST _t,
	RefCDOmBase parent
) {
#line 1147 "verilog.walker.g"
	 RefCDOmTFPortDecl returned ;
#line 7778 "VerilogTreeWalker.cpp"
	RefVerAST tf_inout_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST inout = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1147 "verilog.walker.g"
	
	ECDOmVarType varType=VAR_UNDEFINED;
	RefCDOmRange my_range;
	pair<RefString, int> str;
	
#line 7787 "VerilogTreeWalker.cpp"
	
	RefVerAST __t248 = _t;
	inout = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INOUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_REG:
	case K_SIGNED:
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	case RANGE:
	{
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_REG:
		{
			RefVerAST tmp79_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
			_t = _t->getNextSibling();
#line 1154 "verilog.walker.g"
			varType=VAR_REG;
#line 7814 "VerilogTreeWalker.cpp"
			break;
		}
		case K_SIGNED:
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1155 "verilog.walker.g"
		returned = CDOmTFPortDecl::build(inout->getLine(),  parent, PORT_INOUT, varType);
#line 7832 "VerilogTreeWalker.cpp"
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_SIGNED:
		{
			RefVerAST tmp80_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SIGNED);
			_t = _t->getNextSibling();
#line 1156 "verilog.walker.g"
			returned->setSigned();
#line 7844 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		case RANGE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case RANGE:
		{
			my_range=range(_t);
			_t = _retTree;
#line 1157 "verilog.walker.g"
			returned->setRange( my_range );
#line 7869 "VerilogTreeWalker.cpp"
			break;
		}
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_TIME:
	{
		varType=task_port_type(_t);
		_t = _retTree;
#line 1159 "verilog.walker.g"
		
		returned = CDOmTFPortDecl::build(inout->getLine(),  parent, PORT_INOUT, varType);
		
#line 7896 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt254=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			str=identifier(_t);
			_t = _retTree;
#line 1163 "verilog.walker.g"
			returned->addPort(str.second,  str.first);
#line 7915 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt254>=1 ) { goto _loop254; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt254++;
	}
	_loop254:;
	}  // ( ... )+
	_t = __t248;
	_t = _t->getNextSibling();
#line 1165 "verilog.walker.g"
	PRINT_AST(K_INOUT);
#line 7929 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned ;
}

void VerilogTreeWalker::task_port_item(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST task_port_item_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1094 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl;
	RefCDOmAttrHolder attrHolder;
	
#line 7943 "VerilogTreeWalker.cpp"
	
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INPUT:
	{
		attrHolder=tf_input_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_OUTPUT:
	{
		attrHolder=tf_output_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	case K_INOUT:
	{
		attrHolder=tf_inout_declaration(_t, parent );
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1104 "verilog.walker.g"
	if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 7977 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

 ECDOmVarType  VerilogTreeWalker::task_port_type(RefVerAST _t) {
#line 1168 "verilog.walker.g"
	 ECDOmVarType returned ;
#line 7984 "VerilogTreeWalker.cpp"
	RefVerAST task_port_type_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INTEGER:
	{
		RefVerAST tmp81_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INTEGER);
		_t = _t->getNextSibling();
#line 1169 "verilog.walker.g"
		returned = VAR_INTEGER ;
#line 7997 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REAL:
	{
		RefVerAST tmp82_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REAL);
		_t = _t->getNextSibling();
#line 1170 "verilog.walker.g"
		returned = VAR_REAL    ;
#line 8007 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REALTIME:
	{
		RefVerAST tmp83_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REALTIME);
		_t = _t->getNextSibling();
#line 1171 "verilog.walker.g"
		returned = VAR_REALTIME;
#line 8017 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TIME:
	{
		RefVerAST tmp84_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TIME);
		_t = _t->getNextSibling();
#line 1172 "verilog.walker.g"
		returned = VAR_TIME    ;
#line 8027 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned ;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::cmos_switchtype(RefVerAST _t) {
#line 1352 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8042 "VerilogTreeWalker.cpp"
	RefVerAST cmos_switchtype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_CMOS:
	{
		RefVerAST tmp85_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CMOS);
		_t = _t->getNextSibling();
#line 1353 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_CMOS;
#line 8055 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RCMOS:
	{
		RefVerAST tmp86_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RCMOS);
		_t = _t->getNextSibling();
#line 1354 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_RCMOS;
#line 8065 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::cmos_switch_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST cmos_switch_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1239 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8083 "VerilogTreeWalker.cpp"
	
	RefVerAST __t290 = _t;
	RefVerAST tmp87_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CMOS_SWITCH_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1243 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8114 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1244 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8119 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1245 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8124 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1246 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8129 "VerilogTreeWalker.cpp"
	_t = __t290;
	_t = _t->getNextSibling();
#line 1248 "verilog.walker.g"
	PRINT_AST(tmp87_AST_in);
#line 8134 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::enable_gatetype(RefVerAST _t) {
#line 1357 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8141 "VerilogTreeWalker.cpp"
	RefVerAST enable_gatetype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_BUFIF0:
	{
		RefVerAST tmp88_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BUFIF0);
		_t = _t->getNextSibling();
#line 1358 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_BUFIF0;
#line 8154 "VerilogTreeWalker.cpp"
		break;
	}
	case K_BUFIF1:
	{
		RefVerAST tmp89_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BUFIF1);
		_t = _t->getNextSibling();
#line 1359 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_BUFIF1;
#line 8164 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NOTIF0:
	{
		RefVerAST tmp90_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NOTIF0);
		_t = _t->getNextSibling();
#line 1360 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_NOTIF0;
#line 8174 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NOTIF1:
	{
		RefVerAST tmp91_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NOTIF1);
		_t = _t->getNextSibling();
#line 1361 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_NOTIF1;
#line 8184 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::enable_gate_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST enable_gate_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1251 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8202 "VerilogTreeWalker.cpp"
	
	RefVerAST __t293 = _t;
	RefVerAST tmp92_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ENABLE_GATE_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1255 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8233 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1256 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8238 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1257 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8243 "VerilogTreeWalker.cpp"
	_t = __t293;
	_t = _t->getNextSibling();
	_retTree = _t;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::mos_switchtype(RefVerAST _t) {
#line 1364 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8252 "VerilogTreeWalker.cpp"
	RefVerAST mos_switchtype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_NMOS:
	{
		RefVerAST tmp93_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NMOS);
		_t = _t->getNextSibling();
#line 1365 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_NMOS;
#line 8265 "VerilogTreeWalker.cpp"
		break;
	}
	case K_PMOS:
	{
		RefVerAST tmp94_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PMOS);
		_t = _t->getNextSibling();
#line 1366 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_PMOS;
#line 8275 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RNMOS:
	{
		RefVerAST tmp95_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RNMOS);
		_t = _t->getNextSibling();
#line 1367 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_RNMOS;
#line 8285 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RPMOS:
	{
		RefVerAST tmp96_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RPMOS);
		_t = _t->getNextSibling();
#line 1368 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_RPMOS;
#line 8295 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::mos_switch_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST mos_switch_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1261 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8313 "VerilogTreeWalker.cpp"
	
	RefVerAST __t296 = _t;
	RefVerAST tmp97_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MOS_SWITCH_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1265 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8344 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1266 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8349 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1267 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8354 "VerilogTreeWalker.cpp"
	_t = __t296;
	_t = _t->getNextSibling();
	_retTree = _t;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::n_input_gatetype(RefVerAST _t) {
#line 1371 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8363 "VerilogTreeWalker.cpp"
	RefVerAST n_input_gatetype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_AND:
	{
		RefVerAST tmp98_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_AND);
		_t = _t->getNextSibling();
#line 1372 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_AND;
#line 8376 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NAND:
	{
		RefVerAST tmp99_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NAND);
		_t = _t->getNextSibling();
#line 1373 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_NAND;
#line 8386 "VerilogTreeWalker.cpp"
		break;
	}
	case K_OR:
	{
		RefVerAST tmp100_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OR);
		_t = _t->getNextSibling();
#line 1374 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_OR;
#line 8396 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NOR:
	{
		RefVerAST tmp101_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NOR);
		_t = _t->getNextSibling();
#line 1375 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_NOR;
#line 8406 "VerilogTreeWalker.cpp"
		break;
	}
	case K_XOR:
	{
		RefVerAST tmp102_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_XOR);
		_t = _t->getNextSibling();
#line 1376 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_XOR;
#line 8416 "VerilogTreeWalker.cpp"
		break;
	}
	case K_XNOR:
	{
		RefVerAST tmp103_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_XNOR);
		_t = _t->getNextSibling();
#line 1377 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_XNOR;
#line 8426 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::n_input_gate_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST n_input_gate_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1271 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8444 "VerilogTreeWalker.cpp"
	
	RefVerAST __t299 = _t;
	RefVerAST tmp104_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),N_INPUT_GATE_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1275 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8475 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt302=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_9.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 1276 "verilog.walker.g"
			gateInst->addExpr( expr );
#line 8486 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt302>=1 ) { goto _loop302; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt302++;
	}
	_loop302:;
	}  // ( ... )+
	_t = __t299;
	_t = _t->getNextSibling();
	_retTree = _t;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::n_output_gatetype(RefVerAST _t) {
#line 1380 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8504 "VerilogTreeWalker.cpp"
	RefVerAST n_output_gatetype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_BUF:
	{
		RefVerAST tmp105_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_BUF);
		_t = _t->getNextSibling();
#line 1381 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_BUF;
#line 8517 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NOT:
	{
		RefVerAST tmp106_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NOT);
		_t = _t->getNextSibling();
#line 1382 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_NOT;
#line 8527 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::n_output_gate_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST n_output_gate_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1280 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8545 "VerilogTreeWalker.cpp"
	
	RefVerAST __t304 = _t;
	RefVerAST tmp107_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),N_OUTPUT_GATE_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1284 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8576 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt307=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_9.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 1285 "verilog.walker.g"
			gateInst->addExpr( expr );
#line 8587 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt307>=1 ) { goto _loop307; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt307++;
	}
	_loop307:;
	}  // ( ... )+
	_t = __t304;
	_t = _t->getNextSibling();
	_retTree = _t;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::pass_enable_switchtype(RefVerAST _t) {
#line 1385 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8605 "VerilogTreeWalker.cpp"
	RefVerAST pass_enable_switchtype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_TRANIF0:
	{
		RefVerAST tmp108_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRANIF0);
		_t = _t->getNextSibling();
#line 1386 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_TRANIF0;
#line 8618 "VerilogTreeWalker.cpp"
		break;
	}
	case K_TRANIF1:
	{
		RefVerAST tmp109_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRANIF1);
		_t = _t->getNextSibling();
#line 1387 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_TRANIF1;
#line 8628 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RTRANIF1:
	{
		RefVerAST tmp110_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RTRANIF1);
		_t = _t->getNextSibling();
#line 1388 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_RTRANIF1;
#line 8638 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RTRANIF0:
	{
		RefVerAST tmp111_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RTRANIF0);
		_t = _t->getNextSibling();
#line 1389 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_RTRANIF0;
#line 8648 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::pass_enable_switch_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST pass_enable_switch_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1289 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8666 "VerilogTreeWalker.cpp"
	
	RefVerAST __t309 = _t;
	RefVerAST tmp112_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PASS_ENABLE_SWITCH_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1293 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8697 "VerilogTreeWalker.cpp"
	expr=lvalue(_t);
	_t = _retTree;
#line 1294 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8702 "VerilogTreeWalker.cpp"
	expr=expression(_t);
	_t = _retTree;
#line 1295 "verilog.walker.g"
	gateInst->addExpr( expr );
#line 8707 "VerilogTreeWalker.cpp"
	_t = __t309;
	_t = _t->getNextSibling();
	_retTree = _t;
}

CDOmGateInstantiation::EPrimitiveType  VerilogTreeWalker::pass_switchtype(RefVerAST _t) {
#line 1392 "verilog.walker.g"
	CDOmGateInstantiation::EPrimitiveType returned;
#line 8716 "VerilogTreeWalker.cpp"
	RefVerAST pass_switchtype_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_TRAN:
	{
		RefVerAST tmp113_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TRAN);
		_t = _t->getNextSibling();
#line 1393 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_TRAN;
#line 8729 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RTRAN:
	{
		RefVerAST tmp114_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RTRAN);
		_t = _t->getNextSibling();
#line 1394 "verilog.walker.g"
		returned = CDOmGateInstantiation::GATE_INST_RTRAN;
#line 8739 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::pass_switch_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST pass_switch_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1299 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8757 "VerilogTreeWalker.cpp"
	
	RefVerAST __t312 = _t;
	RefVerAST tmp115_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PASS_SWITCH_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1303 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8788 "VerilogTreeWalker.cpp"
	expr=lvalue(_t);
	_t = _retTree;
#line 1304 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8793 "VerilogTreeWalker.cpp"
	_t = __t312;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::pulldown_strength(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST pulldown_strength_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1327 "verilog.walker.g"
	ECDOmDriveStrength streng1, streng2; TBool tst = TRUE;
#line 8805 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_PULL0:
	case K_STRONG0:
	case K_SUPPLY0:
	case K_WEAK0:
	{
		streng1=strength0(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PULL1:
		case K_STRONG1:
		case K_SUPPLY1:
		case K_WEAK1:
		{
			streng2=strength1(_t);
			_t = _retTree;
#line 1330 "verilog.walker.g"
			tst = FALSE; gateInst->setDriveStrength(streng1, streng2);
#line 8830 "VerilogTreeWalker.cpp"
			break;
		}
		case PULL_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1331 "verilog.walker.g"
		if( tst ) gateInst->setSingleDriveStrength( streng1 );
#line 8845 "VerilogTreeWalker.cpp"
		break;
	}
	case K_PULL1:
	case K_STRONG1:
	case K_SUPPLY1:
	case K_WEAK1:
	{
		streng1=strength1(_t);
		_t = _retTree;
		streng2=strength0(_t);
		_t = _retTree;
#line 1334 "verilog.walker.g"
		gateInst->setDriveStrength( streng1, streng2 );
#line 8859 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::pull_gate_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST pull_gate_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1308 "verilog.walker.g"
	RefCDOmExpr expr;
#line 8876 "VerilogTreeWalker.cpp"
	
	RefVerAST __t315 = _t;
	RefVerAST tmp116_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PULL_GATE_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		name_of_gate_instance(_t, gateInst );
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=lvalue(_t);
	_t = _retTree;
#line 1312 "verilog.walker.g"
	gateInst->addLvalue( expr );
#line 8907 "VerilogTreeWalker.cpp"
	_t = __t315;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::pullup_strength(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST pullup_strength_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1337 "verilog.walker.g"
	ECDOmDriveStrength streng1, streng2; TBool tst = TRUE;
#line 8919 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_PULL0:
	case K_STRONG0:
	case K_SUPPLY0:
	case K_WEAK0:
	{
		streng1=strength0(_t);
		_t = _retTree;
		streng2=strength1(_t);
		_t = _retTree;
#line 1341 "verilog.walker.g"
		gateInst->setDriveStrength( streng1, streng2 );
#line 8935 "VerilogTreeWalker.cpp"
		break;
	}
	case K_PULL1:
	case K_STRONG1:
	case K_SUPPLY1:
	case K_WEAK1:
	{
		streng1=strength1(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_PULL0:
		case K_STRONG0:
		case K_SUPPLY0:
		case K_WEAK0:
		{
			streng2=strength0(_t);
			_t = _retTree;
#line 1343 "verilog.walker.g"
			tst = FALSE; gateInst->setDriveStrength(streng1, streng2);
#line 8958 "VerilogTreeWalker.cpp"
			break;
		}
		case PULL_GATE_INSTANCE:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1344 "verilog.walker.g"
		if( tst ) gateInst->setSingleDriveStrength( streng1 );
#line 8973 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::name_of_gate_instance(RefVerAST _t,
	RefCDOmGateInstantiation gateInst
) {
	RefVerAST name_of_gate_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1316 "verilog.walker.g"
	
	pair<RefString, int> id;
	RefCDOmRange rng = RefCDOmRange();
	
#line 8993 "VerilogTreeWalker.cpp"
	
	id=identifier(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		rng=range(_t);
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1323 "verilog.walker.g"
	gateInst->addID( id.first, rng );
#line 9019 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

RefCDOmExpr  VerilogTreeWalker::lvalue(RefVerAST _t) {
#line 3472 "verilog.walker.g"
	RefCDOmExpr returnedLvalue;
#line 9026 "VerilogTreeWalker.cpp"
	RefVerAST lvalue_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST lv = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3472 "verilog.walker.g"
	
	RefCDOmExprLink exprLink; 
	RefCDOmExpr exprLvalue;
	
#line 9034 "VerilogTreeWalker.cpp"
	
	RefVerAST __t734 = _t;
	lv = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LVALUE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case EXPR_PRIMARY_IDENTIFIER:
	{
		returnedLvalue=expr_primary_identifier(_t);
		_t = _retTree;
		break;
	}
	case LVALUE:
	{
		exprLvalue=lvalue(_t);
		_t = _retTree;
#line 3480 "verilog.walker.g"
		returnedLvalue = CDOmExprConcat::build(lv->getLine(),  exprLvalue );
#line 9056 "VerilogTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == LVALUE)) {
				exprLvalue=lvalue(_t);
				_t = _retTree;
#line 3482 "verilog.walker.g"
				(boost::static_pointer_cast<CDOmExprConcat>(returnedLvalue))->addExpr( exprLvalue );
#line 9066 "VerilogTreeWalker.cpp"
			}
			else {
				goto _loop737;
			}
			
		}
		_loop737:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t734;
	_t = _t->getNextSibling();
#line 3486 "verilog.walker.g"
	PRINT_AST(LVALUE);
#line 9087 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedLvalue;
}

void VerilogTreeWalker::parameter_value_assignment_or_delay2(RefVerAST _t,
	RefCDOmModuleOrUdpInstantiation moduleInstantiation
) {
	RefVerAST parameter_value_assignment_or_delay2_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2:
	{
		list_of_parameter_assignments_or_delay2(_t,moduleInstantiation);
		_t = _retTree;
		break;
	}
	case DELAY:
	{
		delay2(_t,moduleInstantiation);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::module_instance(RefVerAST _t,
	RefCDOmModuleOrUdpInstantiation moduleInstantiation
) {
	RefVerAST module_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST mi = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1448 "verilog.walker.g"
	
	pair<RefString, int> str(RefString(), 0);
	RefCDOmRange rng = RefCDOmRange();
	RefCDOmModuleOrUdpInstance returnedModuleInstance;
	
#line 9131 "VerilogTreeWalker.cpp"
	
	RefVerAST __t348 = _t;
	mi = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MODULE_INSTANCE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		str=identifier(_t);
		_t = _retTree;
		break;
	}
	case RANGE:
	case ATTRIBUTE_INSTANCE:
	case ORDERED_PORT_CONNECTION:
	case NAMED_PORT_CONNECTION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE:
	{
		rng=range(_t);
		_t = _retTree;
		break;
	}
	case ATTRIBUTE_INSTANCE:
	case ORDERED_PORT_CONNECTION:
	case NAMED_PORT_CONNECTION:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1457 "verilog.walker.g"
	returnedModuleInstance = moduleInstantiation->buildModuleInstance(mi->getLine(),  str.first, rng );
#line 9185 "VerilogTreeWalker.cpp"
	list_of_port_connections(_t,returnedModuleInstance);
	_t = _retTree;
	_t = __t348;
	_t = _t->getNextSibling();
#line 1460 "verilog.walker.g"
	PRINT_AST(MODULE_INSTANCE);
#line 9192 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::list_of_parameter_assignments_or_delay2(RefVerAST _t,
	RefCDOmModuleOrUdpInstantiation moduleInstantiation
) {
	RefVerAST list_of_parameter_assignments_or_delay2_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1420 "verilog.walker.g"
	
	RefCDOmMinTypMax minTypMax;
	RefString str;
	
#line 9205 "VerilogTreeWalker.cpp"
	
	RefVerAST __t338 = _t;
	RefVerAST tmp117_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINTYPMAX_EXPRESSION:
	{
		{ // ( ... )+
		int _cnt341=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == MINTYPMAX_EXPRESSION)) {
				minTypMax=mintypmax_expression(_t);
				_t = _retTree;
#line 1427 "verilog.walker.g"
				moduleInstantiation->addOrderedParamAssn( minTypMax );
#line 9227 "VerilogTreeWalker.cpp"
			}
			else {
				if ( _cnt341>=1 ) { goto _loop341; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt341++;
		}
		_loop341:;
		}  // ( ... )+
		break;
	}
	case NAMED_PARAMETER_ASSIGNMENT:
	{
		{ // ( ... )+
		int _cnt343=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == NAMED_PARAMETER_ASSIGNMENT)) {
				named_parameter_assignment(_t,str, minTypMax);
				_t = _retTree;
#line 1430 "verilog.walker.g"
				moduleInstantiation->addNamedParamAssn( str, minTypMax );
#line 9251 "VerilogTreeWalker.cpp"
			}
			else {
				if ( _cnt343>=1 ) { goto _loop343; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt343++;
		}
		_loop343:;
		}  // ( ... )+
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t338;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::named_parameter_assignment(RefVerAST _t,
	RefString &str, RefCDOmMinTypMax &minTypMax
) {
	RefVerAST named_parameter_assignment_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1436 "verilog.walker.g"
	
	minTypMax = RefCDOmMinTypMax();//if there is no minTypMax it should return null
	pair<RefString, int> id;
	
#line 9283 "VerilogTreeWalker.cpp"
	
	RefVerAST __t345 = _t;
	RefVerAST tmp118_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NAMED_PARAMETER_ASSIGNMENT);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 1443 "verilog.walker.g"
	str = id.first;
#line 9293 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINTYPMAX_EXPRESSION:
	{
		minTypMax=mintypmax_expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t345;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::list_of_port_connections(RefVerAST _t,
	RefCDOmModuleOrUdpInstance moduleInstance
) {
	RefVerAST list_of_port_connections_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1463 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl;
	RefCDOmExpr expr;
	RefString str;
	
#line 9329 "VerilogTreeWalker.cpp"
	
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case ORDERED_PORT_CONNECTION:
	{
		ordered_port_connection(_t,expr);
		_t = _retTree;
#line 1471 "verilog.walker.g"
		moduleInstance->addPortConnection( attrListColl, expr );
#line 9343 "VerilogTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == ATTRIBUTE_INSTANCE || _t->getType() == ORDERED_PORT_CONNECTION)) {
				attrListColl=attrs_opt(_t);
				_t = _retTree;
				ordered_port_connection(_t,expr);
				_t = _retTree;
#line 1473 "verilog.walker.g"
				moduleInstance->addPortConnection( attrListColl, expr );
#line 9355 "VerilogTreeWalker.cpp"
			}
			else {
				goto _loop354;
			}
			
		}
		_loop354:;
		} // ( ... )*
		break;
	}
	case NAMED_PORT_CONNECTION:
	{
		named_port_connection(_t,expr, str);
		_t = _retTree;
#line 1476 "verilog.walker.g"
		moduleInstance->addPortConnection( attrListColl, expr, str );
#line 9372 "VerilogTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == ATTRIBUTE_INSTANCE || _t->getType() == NAMED_PORT_CONNECTION)) {
				attrListColl=attrs_opt(_t);
				_t = _retTree;
				named_port_connection(_t,expr, str);
				_t = _retTree;
#line 1478 "verilog.walker.g"
				moduleInstance->addPortConnection( attrListColl, expr, str );
#line 9384 "VerilogTreeWalker.cpp"
			}
			else {
				goto _loop356;
			}
			
		}
		_loop356:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::ordered_port_connection(RefVerAST _t,
	RefCDOmExpr &expr
) {
	RefVerAST ordered_port_connection_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1483 "verilog.walker.g"
	expr = RefCDOmExpr();
#line 9410 "VerilogTreeWalker.cpp"
	
	RefVerAST __t358 = _t;
	RefVerAST tmp119_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ORDERED_PORT_CONNECTION);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t358;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::named_port_connection(RefVerAST _t,
	RefCDOmExpr &expr, RefString &str
) {
	RefVerAST named_port_connection_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1489 "verilog.walker.g"
	
	expr = RefCDOmExpr(); 
	pair<RefString, int> id;
	
#line 9498 "VerilogTreeWalker.cpp"
	
	RefVerAST __t361 = _t;
	RefVerAST tmp120_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),NAMED_PORT_CONNECTION);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 1496 "verilog.walker.g"
	str = id.first;
#line 9508 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t361;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::generate_item(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST generate_item_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1518 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl;
	RefCDOmAttrHolder attrHolder;
	
#line 9591 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_IF:
	{
		generate_conditional_statement(_t, parent );
		_t = _retTree;
		break;
	}
	case K_CASE:
	{
		generate_case_statement(_t, parent );
		_t = _retTree;
		break;
	}
	case K_FOR:
	{
		generate_loop_statement(_t, parent );
		_t = _retTree;
		break;
	}
	case GENERATE_BLOCK:
	{
		generate_block(_t, parent );
		_t = _retTree;
		break;
	}
	case K_ALWAYS:
	case K_ASSIGN:
	case K_DEFPARAM:
	case K_EVENT:
	case K_FUNCTION:
	case K_GENVAR:
	case K_INITIAL:
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TASK:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	case NET_DECLARATION:
	case GATE_INSTANTIATION:
	case MODULE_OR_UDP_INSTANTIATION:
	{
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		attrHolder=module_or_generate_item(_t, parent );
		_t = _retTree;
#line 1528 "verilog.walker.g"
		if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 9644 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::generate_item_or_null(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST generate_item_or_null_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST gion = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1510 "verilog.walker.g"
	TBool test = TRUE;
#line 9662 "VerilogTreeWalker.cpp"
	
	RefVerAST __t368 = _t;
	gion = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GENERATE_ITEM_OR_NULL);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ALWAYS:
	case K_ASSIGN:
	case K_CASE:
	case K_DEFPARAM:
	case K_EVENT:
	case K_FOR:
	case K_FUNCTION:
	case K_GENVAR:
	case K_IF:
	case K_INITIAL:
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TASK:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	case NET_DECLARATION:
	case GATE_INSTANTIATION:
	case MODULE_OR_UDP_INSTANTIATION:
	case GENERATE_BLOCK:
	{
		generate_item(_t,parent);
		_t = _retTree;
#line 1513 "verilog.walker.g"
		test = FALSE;
#line 9698 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1514 "verilog.walker.g"
	if( test ) CDOmGenItemNull::build(gion->getLine(), parent);
#line 9713 "VerilogTreeWalker.cpp"
	_t = __t368;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::generate_conditional_statement(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST generate_conditional_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kif = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1531 "verilog.walker.g"
	
	RefCDOmExpr expr; 
	RefCDOmGenItemIf genItemIf;
	
#line 9729 "VerilogTreeWalker.cpp"
	
	RefVerAST __t372 = _t;
	kif = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_IF);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 1537 "verilog.walker.g"
	genItemIf = CDOmGenItemIf::build(kif->getLine(),  parent, expr );
#line 9739 "VerilogTreeWalker.cpp"
	generate_item_or_null(_t, genItemIf );
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case GENERATE_ITEM_OR_NULL:
	{
		generate_item_or_null(_t, genItemIf );
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t372;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::generate_case_statement(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST generate_case_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST gci = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST gci1 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1543 "verilog.walker.g"
	
	RefCDOmGenItemCase genItemCase;
	RefCDOmExpr expr1, expr2;
	RefCDOmListExpr listExpr;
	
#line 9779 "VerilogTreeWalker.cpp"
	
	RefVerAST __t375 = _t;
	RefVerAST tmp121_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CASE);
	_t = _t->getFirstChild();
	expr1=expression(_t);
	_t = _retTree;
	RefVerAST __t376 = _t;
	gci = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GENVAR_CASE_ITEM);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr2=expression(_t);
		_t = _retTree;
#line 1552 "verilog.walker.g"
		listExpr = CDOmListExpr::build(gci->getLine(), expr2);
#line 9849 "VerilogTreeWalker.cpp"
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_tokenSet_9.member(_t->getType()))) {
				expr2=expression(_t);
				_t = _retTree;
#line 1554 "verilog.walker.g"
				listExpr->addItem(expr2);
#line 9859 "VerilogTreeWalker.cpp"
			}
			else {
				goto _loop379;
			}
			
		}
		_loop379:;
		} // ( ... )*
		break;
	}
	case K_DEFAULT:
	{
		RefVerAST tmp122_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DEFAULT);
		_t = _t->getNextSibling();
#line 1556 "verilog.walker.g"
		listExpr = RefCDOmListExpr();
#line 9877 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1558 "verilog.walker.g"
	genItemCase = CDOmGenItemCase::build(gci->getLine(),  parent, expr1, listExpr );
#line 9888 "VerilogTreeWalker.cpp"
	generate_item_or_null(_t,genItemCase);
	_t = _retTree;
	_t = __t376;
	_t = _t->getNextSibling();
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == GENVAR_CASE_ITEM)) {
			RefVerAST __t381 = _t;
			gci1 = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GENVAR_CASE_ITEM);
			_t = _t->getFirstChild();
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case EXPRESSION:
			case CONCATENATION:
			case MULTI_CONCATENATION:
			case EXPR_PRIMARY_IDENTIFIER:
			case FUNCTION_CALL:
			case SYSTEM_FUNCTION_CALL:
			case MINTYPMAX_EXPRESSION:
			case SIZED_NUMBER:
			{
				expr2=expression(_t);
				_t = _retTree;
#line 1563 "verilog.walker.g"
				listExpr = CDOmListExpr::build(gci1->getLine(), expr2);
#line 9960 "VerilogTreeWalker.cpp"
				{ // ( ... )*
				for (;;) {
					if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					if ((_tokenSet_9.member(_t->getType()))) {
						expr2=expression(_t);
						_t = _retTree;
#line 1565 "verilog.walker.g"
						listExpr->addItem(expr2);
#line 9970 "VerilogTreeWalker.cpp"
					}
					else {
						goto _loop384;
					}
					
				}
				_loop384:;
				} // ( ... )*
				break;
			}
			case K_DEFAULT:
			{
				RefVerAST tmp123_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DEFAULT);
				_t = _t->getNextSibling();
#line 1568 "verilog.walker.g"
				listExpr = RefCDOmListExpr();
#line 9988 "VerilogTreeWalker.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 1570 "verilog.walker.g"
			genItemCase->addCaseItem( listExpr );
#line 9999 "VerilogTreeWalker.cpp"
			generate_item_or_null(_t,genItemCase);
			_t = _retTree;
			_t = __t381;
			_t = _t->getNextSibling();
		}
		else {
			goto _loop385;
		}
		
	}
	_loop385:;
	} // ( ... )*
	_t = __t375;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::generate_loop_statement(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST generate_loop_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kfor = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1577 "verilog.walker.g"
	
	pair<RefString, int> id1, id2, id3;
	RefCDOmExpr expr1, expr2, expr3;
	RefCDOmGenItemLoop itemLoop;
	RefCDOmGenItemBlock itemBlock;
	
#line 10029 "VerilogTreeWalker.cpp"
	
	RefVerAST __t387 = _t;
	kfor = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FOR);
	_t = _t->getFirstChild();
	RefVerAST __t388 = _t;
	RefVerAST tmp124_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GENVAR_ASSIGNMENT);
	_t = _t->getFirstChild();
	id1=identifier(_t);
	_t = _retTree;
	expr1=expression(_t);
	_t = _retTree;
	_t = __t388;
	_t = _t->getNextSibling();
	expr2=expression(_t);
	_t = _retTree;
	RefVerAST __t389 = _t;
	RefVerAST tmp125_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GENVAR_ASSIGNMENT);
	_t = _t->getFirstChild();
	id2=identifier(_t);
	_t = _retTree;
	expr3=expression(_t);
	_t = _retTree;
	_t = __t389;
	_t = _t->getNextSibling();
	id3=identifier(_t);
	_t = _retTree;
#line 1595 "verilog.walker.g"
	
	cerr << parent->getType() << endl;
	cerr << TYPE_GEN_INST << endl;
	itemLoop = CDOmGenItemLoop::build(kfor->getLine(), parent, CDOmExprLink::build(id1.second, id1.first), expr1, expr2, CDOmExprLink::build(id2.second, id2.first), expr3 );
	itemBlock = CDOmGenItemBlock::build(id3.second,  itemLoop, id3.first );
	
#line 10066 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_4.member(_t->getType()))) {
			generate_item(_t,itemBlock);
			_t = _retTree;
		}
		else {
			goto _loop391;
		}
		
	}
	_loop391:;
	} // ( ... )*
	_t = __t387;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::generate_block(RefVerAST _t,
	RefCDOmBase parent
) {
	RefVerAST generate_block_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST gb = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1605 "verilog.walker.g"
	
	pair<RefString, int> id(RefString(), 0);
	RefCDOmGenItemBlock itemBlock;
	
#line 10097 "VerilogTreeWalker.cpp"
	
	RefVerAST __t393 = _t;
	gb = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),GENERATE_BLOCK);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		id=identifier(_t);
		_t = _retTree;
		break;
	}
	case 3:
	case K_ALWAYS:
	case K_ASSIGN:
	case K_CASE:
	case K_DEFPARAM:
	case K_EVENT:
	case K_FOR:
	case K_FUNCTION:
	case K_GENVAR:
	case K_IF:
	case K_INITIAL:
	case K_INTEGER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_TASK:
	case K_TIME:
	case ATTRIBUTE_INSTANCE:
	case NET_DECLARATION:
	case GATE_INSTANTIATION:
	case MODULE_OR_UDP_INSTANTIATION:
	case GENERATE_BLOCK:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 1612 "verilog.walker.g"
	itemBlock = CDOmGenItemBlock::build(gb->getLine(),  parent, id.first );
#line 10147 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_4.member(_t->getType()))) {
			generate_item(_t,itemBlock);
			_t = _retTree;
		}
		else {
			goto _loop396;
		}
		
	}
	_loop396:;
	} // ( ... )*
	_t = __t393;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::udp_port_list(RefVerAST _t,
	RefCDOmUdpDecl udpdecl
) {
	RefVerAST udp_port_list_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1640 "verilog.walker.g"
	pair<RefString, int> id;
#line 10174 "VerilogTreeWalker.cpp"
	
	RefVerAST __t403 = _t;
	RefVerAST tmp126_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_PORT_LIST);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 1644 "verilog.walker.g"
	udpdecl->addPort(id.first);
#line 10184 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt405=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1646 "verilog.walker.g"
			udpdecl->addPort(id.first);
#line 10195 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt405>=1 ) { goto _loop405; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt405++;
	}
	_loop405:;
	}  // ( ... )+
	_t = __t403;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::udp_declaration_port_list(RefVerAST _t,
	 RefCDOmUdpDecl udpDecl 
) {
	RefVerAST udp_declaration_port_list_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1651 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl; 
	RefCDOmUdpPortDeclInput portDeclInput;
	RefCDOmUdpPortDeclOutput portDeclOutput;
	
#line 10220 "VerilogTreeWalker.cpp"
	
	RefVerAST __t407 = _t;
	RefVerAST tmp127_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_DECLARATION_PORT_LIST);
	_t = _t->getFirstChild();
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	portDeclOutput=udp_output_declaration(_t, udpDecl );
	_t = _retTree;
#line 1659 "verilog.walker.g"
	if(attrListColl.get()) portDeclOutput->setAttrListCollection(attrListColl);
#line 10232 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt409=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == K_INPUT || _t->getType() == ATTRIBUTE_INSTANCE)) {
			attrListColl=attrs_opt(_t);
			_t = _retTree;
			portDeclInput=udp_input_declaration(_t, udpDecl );
			_t = _retTree;
#line 1661 "verilog.walker.g"
			if(attrListColl.get()) portDeclInput->setAttrListCollection(attrListColl);
#line 10245 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt409>=1 ) { goto _loop409; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt409++;
	}
	_loop409:;
	}  // ( ... )+
	_t = __t407;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::udp_port_declaration(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
	RefVerAST udp_port_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1666 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl; 
	RefCDOmUdpPortDeclInput portDeclInput;
	RefCDOmUdpPortDeclOutput portDeclOutput;
	
#line 10270 "VerilogTreeWalker.cpp"
	
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_OUTPUT:
	{
		portDeclOutput=udp_output_declaration(_t, udpDecl );
		_t = _retTree;
#line 1673 "verilog.walker.g"
		if(attrListColl.get()) portDeclOutput->setAttrListCollection(attrListColl);
#line 10284 "VerilogTreeWalker.cpp"
		break;
	}
	case K_INPUT:
	{
		portDeclInput=udp_input_declaration(_t, udpDecl );
		_t = _retTree;
#line 1674 "verilog.walker.g"
		if(attrListColl.get()) portDeclInput->setAttrListCollection(attrListColl) ;
#line 10293 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REG:
	{
		portDeclOutput=udp_reg_declaration(_t, udpDecl );
		_t = _retTree;
#line 1675 "verilog.walker.g"
		if(attrListColl.get()) portDeclOutput->setAttrListCollection(attrListColl);
#line 10302 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::udp_body(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
	RefVerAST udp_body_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST __t423 = _t;
	RefVerAST tmp128_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_TABLE);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_INITIAL:
	{
		udp_initial_statement(_t, udpDecl );
		_t = _retTree;
		break;
	}
	case UDP_TABLE_SEQ_ENTRY:
	case UDP_TABLE_COMB_ENTRY:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )+
	int _cnt426=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == UDP_TABLE_SEQ_ENTRY || _t->getType() == UDP_TABLE_COMB_ENTRY)) {
			udp_table_entry(_t,udpDecl);
			_t = _retTree;
		}
		else {
			if ( _cnt426>=1 ) { goto _loop426; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt426++;
	}
	_loop426:;
	}  // ( ... )+
	_t = __t423;
	_t = _t->getNextSibling();
	_retTree = _t;
}

 RefCDOmUdpPortDeclOutput  VerilogTreeWalker::udp_output_declaration(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
#line 1679 "verilog.walker.g"
	 RefCDOmUdpPortDeclOutput returned ;
#line 10371 "VerilogTreeWalker.cpp"
	RefVerAST udp_output_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1679 "verilog.walker.g"
	
	pair<RefString, int> id;
	RefCDOmExpr expr = RefCDOmExpr();
	
#line 10378 "VerilogTreeWalker.cpp"
	
	RefVerAST __t413 = _t;
	RefVerAST tmp129_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_OUTPUT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		id=identifier(_t);
		_t = _retTree;
#line 1686 "verilog.walker.g"
		returned = CDOmUdpPortDeclOutput::build(id.second, udpDecl, CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT, id.first);
#line 10395 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REG:
	{
		RefVerAST tmp130_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
		_t = _t->getNextSibling();
		id=identifier(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case EXPRESSION:
		case CONCATENATION:
		case MULTI_CONCATENATION:
		case EXPR_PRIMARY_IDENTIFIER:
		case FUNCTION_CALL:
		case SYSTEM_FUNCTION_CALL:
		case MINTYPMAX_EXPRESSION:
		case SIZED_NUMBER:
		{
			expr=expression(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
#line 1689 "verilog.walker.g"
		returned = CDOmUdpPortDeclOutput::build(id.second, udpDecl, CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG, id.first, expr);
#line 10475 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t413;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returned ;
}

RefCDOmUdpPortDeclInput  VerilogTreeWalker::udp_input_declaration(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
#line 1694 "verilog.walker.g"
	RefCDOmUdpPortDeclInput returned;
#line 10495 "VerilogTreeWalker.cpp"
	RefVerAST udp_input_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1694 "verilog.walker.g"
	pair<RefString, int> id;
#line 10499 "VerilogTreeWalker.cpp"
	
	RefVerAST __t417 = _t;
	RefVerAST tmp131_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INPUT);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 1698 "verilog.walker.g"
	returned = CDOmUdpPortDeclInput::build(id.second, udpDecl, id.first);
#line 10509 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
			id=identifier(_t);
			_t = _retTree;
#line 1700 "verilog.walker.g"
			returned->addPort(id.second, id.first);
#line 10519 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop419;
		}
		
	}
	_loop419:;
	} // ( ... )*
	_t = __t417;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returned;
}

RefCDOmUdpPortDeclOutput  VerilogTreeWalker::udp_reg_declaration(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
#line 1705 "verilog.walker.g"
	RefCDOmUdpPortDeclOutput returned;
#line 10539 "VerilogTreeWalker.cpp"
	RefVerAST udp_reg_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1705 "verilog.walker.g"
	pair<RefString, int> id;
#line 10543 "VerilogTreeWalker.cpp"
	
	RefVerAST __t421 = _t;
	RefVerAST tmp132_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REG);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 1709 "verilog.walker.g"
	returned = CDOmUdpPortDeclOutput::build(id.second, udpDecl, CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG, id.first);
#line 10553 "VerilogTreeWalker.cpp"
	_t = __t421;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::udp_initial_statement(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
	RefVerAST udp_initial_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 1721 "verilog.walker.g"
	
	pair<RefString, int> id;
	CDOmUdpInitStmt::EInitVal initVal;
	
#line 10569 "VerilogTreeWalker.cpp"
	
	RefVerAST __t428 = _t;
	RefVerAST tmp133_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_INITIAL);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	initVal=init_val(_t);
	_t = _retTree;
#line 1729 "verilog.walker.g"
	CDOmUdpInitStmt::build(id.second,  udpDecl, CDOmExprLink::build(id.second, id.first), initVal);
#line 10581 "VerilogTreeWalker.cpp"
	_t = __t428;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::udp_table_entry(RefVerAST _t,
	RefCDOmUdpDecl udpDecl
) {
	RefVerAST udp_table_entry_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST utse = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST utce = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1802 "verilog.walker.g"
	
	ECDOmUdpSymbol udpSymbol1 = UDP_SYMBOL_UNDEF, udpSymbol2 = UDP_SYMBOL_UNDEF;
	RefTVec_ECDOmUdpSymbol list1=RefTVec_ECDOmUdpSymbol(), list2=RefTVec_ECDOmUdpSymbol();
	CDOmUdpSeqEntry::ESeqEdgeSymbol edgeSymbol = CDOmUdpSeqEntry::EDGE_UNDEF;
	ECDOmUdpSymbol currState, nextState, temp;
	
#line 10600 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UDP_TABLE_SEQ_ENTRY:
	{
		RefVerAST __t432 = _t;
		utse = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_TABLE_SEQ_ENTRY);
		_t = _t->getFirstChild();
		RefVerAST __t433 = _t;
		RefVerAST tmp134_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),INPUT_LIST);
		_t = _t->getFirstChild();
		{ // ( ... )+
		int _cnt435=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UDP_B:
			case UDP_X:
			case UDP_0:
			case UDP_1:
			case QUESTION:
			{
				temp=level_symbol(_t);
				_t = _retTree;
#line 1812 "verilog.walker.g"
				
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
				
#line 10642 "VerilogTreeWalker.cpp"
				break;
			}
			case UDP_F:
			case UDP_R:
			case UDP_N:
			case UDP_P:
			case LPAREN:
			case STAR:
			{
				edgeSymbol=edge_indicator(_t, udpSymbol1, udpSymbol2 );
				_t = _retTree;
				break;
			}
			default:
			{
				if ( _cnt435>=1 ) { goto _loop435; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			}
			_cnt435++;
		}
		_loop435:;
		}  // ( ... )+
		_t = __t433;
		_t = _t->getNextSibling();
		currState=level_symbol(_t);
		_t = _retTree;
		nextState=next_state(_t);
		_t = _retTree;
#line 1829 "verilog.walker.g"
		
		if(edgeSymbol == CDOmUdpSeqEntry::EDGE_UNDEF && udpSymbol2 == UDP_SYMBOL_UNDEF)
		CDOmUdpSeqEntry::buildWithLevelInputList(utse->getLine(),  udpDecl, currState, nextState, list1 );
		else if( edgeSymbol == CDOmUdpSeqEntry::EDGE_UNDEF )
		CDOmUdpSeqEntry::buildWithEdgeInputList(utse->getLine(),  udpDecl, currState, nextState, list1, list2, udpSymbol1, udpSymbol2 );
		else
		CDOmUdpSeqEntry::buildWithEdgeInputList(utse->getLine(),  udpDecl, currState, nextState, list1, list2, edgeSymbol );
		
#line 10680 "VerilogTreeWalker.cpp"
		_t = __t432;
		_t = _t->getNextSibling();
		break;
	}
	case UDP_TABLE_COMB_ENTRY:
	{
		RefVerAST __t436 = _t;
		utce = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_TABLE_COMB_ENTRY);
		_t = _t->getFirstChild();
#line 1839 "verilog.walker.g"
		list1 = RefTVec_ECDOmUdpSymbol( new TVec_ECDOmUdpSymbol() );
#line 10693 "VerilogTreeWalker.cpp"
		RefVerAST __t437 = _t;
		RefVerAST tmp135_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),INPUT_LIST);
		_t = _t->getFirstChild();
		{ // ( ... )+
		int _cnt439=0;
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_tokenSet_10.member(_t->getType()))) {
				temp=level_symbol(_t);
				_t = _retTree;
#line 1841 "verilog.walker.g"
				list1->push_back(temp);
#line 10708 "VerilogTreeWalker.cpp"
			}
			else {
				if ( _cnt439>=1 ) { goto _loop439; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
			}
			
			_cnt439++;
		}
		_loop439:;
		}  // ( ... )+
		_t = __t437;
		_t = _t->getNextSibling();
		temp=output_symbol(_t);
		_t = _retTree;
#line 1844 "verilog.walker.g"
		CDOmUdpCombEntry::build(utce->getLine(),  udpDecl, list1, temp );
#line 10724 "VerilogTreeWalker.cpp"
		_t = __t436;
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

CDOmUdpInitStmt::EInitVal  VerilogTreeWalker::init_val(RefVerAST _t) {
#line 1733 "verilog.walker.g"
	CDOmUdpInitStmt::EInitVal returned;
#line 10740 "VerilogTreeWalker.cpp"
	RefVerAST init_val_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST un = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST bn = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1733 "verilog.walker.g"
	char test;
#line 10746 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	{
		un = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
		_t = _t->getNextSibling();
		if (!( un->getText().size() == 1 ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" un->getText().size() == 1 ");
#line 1737 "verilog.walker.g"
		
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
		
#line 10772 "VerilogTreeWalker.cpp"
		if (!( test ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" test ");
		break;
	}
	case SIZED_NUMBER:
	{
		RefVerAST __t430 = _t;
		RefVerAST tmp136_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SIZED_NUMBER);
		_t = _t->getFirstChild();
		RefVerAST tmp137_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
		_t = _t->getNextSibling();
		bn = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BASED_NUMBER);
		_t = _t->getNextSibling();
		if (!( bn->getNumber()->getStringValue()->size() == 3 ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" bn->getNumber()->getStringValue()->size() == 3 ");
#line 1755 "verilog.walker.g"
		
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
		
#line 10835 "VerilogTreeWalker.cpp"
		if (!( test ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" test ");
		_t = __t430;
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

ECDOmUdpSymbol  VerilogTreeWalker::level_symbol(RefVerAST _t) {
#line 1848 "verilog.walker.g"
	ECDOmUdpSymbol returned;
#line 10854 "VerilogTreeWalker.cpp"
	RefVerAST level_symbol_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST s1 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST s2 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UDP_0:
	{
		RefVerAST tmp138_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_0);
		_t = _t->getNextSibling();
#line 1849 "verilog.walker.g"
		returned = UDP_SYMBOL_0;
#line 10869 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_1:
	{
		RefVerAST tmp139_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_1);
		_t = _t->getNextSibling();
#line 1850 "verilog.walker.g"
		returned = UDP_SYMBOL_1;
#line 10879 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_X:
	{
		s1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_X);
		_t = _t->getNextSibling();
#line 1851 "verilog.walker.g"
		if(s1->getText().at(0) == 'x') returned = UDP_SYMBOL_x; else returned = UDP_SYMBOL_X;
#line 10889 "VerilogTreeWalker.cpp"
		break;
	}
	case QUESTION:
	{
		RefVerAST tmp140_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),QUESTION);
		_t = _t->getNextSibling();
#line 1852 "verilog.walker.g"
		returned = UDP_SYMBOL_Q;
#line 10899 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_B:
	{
		s2 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_B);
		_t = _t->getNextSibling();
#line 1853 "verilog.walker.g"
		if(s2->getText().at(0) == 'b') returned = UDP_SYMBOL_b; else returned = UDP_SYMBOL_B;
#line 10909 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

CDOmUdpSeqEntry::ESeqEdgeSymbol  VerilogTreeWalker::edge_indicator(RefVerAST _t,
	ECDOmUdpSymbol &retuned1, ECDOmUdpSymbol &retuned2
) {
#line 1856 "verilog.walker.g"
	CDOmUdpSeqEntry::ESeqEdgeSymbol returned;
#line 10926 "VerilogTreeWalker.cpp"
	RefVerAST edge_indicator_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST u8 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST u9 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST u0 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST ua = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1856 "verilog.walker.g"
	ECDOmUdpSymbol symbol1, symbol2;
#line 10934 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case LPAREN:
	{
		RefVerAST tmp141_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LPAREN);
		_t = _t->getNextSibling();
		retuned1=level_symbol(_t);
		_t = _retTree;
		retuned2=level_symbol(_t);
		_t = _retTree;
#line 1861 "verilog.walker.g"
		returned = CDOmUdpSeqEntry::EDGE_UNDEF;
#line 10950 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_F:
	{
		u8 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_F);
		_t = _t->getNextSibling();
#line 1876 "verilog.walker.g"
		returned = u8->getText().at(0) == 'f'?CDOmUdpSeqEntry::EDGE_f:CDOmUdpSeqEntry::EDGE_F;
#line 10960 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_R:
	{
		u9 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_R);
		_t = _t->getNextSibling();
#line 1877 "verilog.walker.g"
		returned = u9->getText().at(0) == 'r'?CDOmUdpSeqEntry::EDGE_r:CDOmUdpSeqEntry::EDGE_R;
#line 10970 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_N:
	{
		u0 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_N);
		_t = _t->getNextSibling();
#line 1878 "verilog.walker.g"
		returned = u0->getText().at(0) == 'n'?CDOmUdpSeqEntry::EDGE_n:CDOmUdpSeqEntry::EDGE_N;
#line 10980 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_P:
	{
		ua = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_P);
		_t = _t->getNextSibling();
#line 1879 "verilog.walker.g"
		returned = ua->getText().at(0) == 'p'?CDOmUdpSeqEntry::EDGE_p:CDOmUdpSeqEntry::EDGE_P;
#line 10990 "VerilogTreeWalker.cpp"
		break;
	}
	case STAR:
	{
		RefVerAST tmp142_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STAR);
		_t = _t->getNextSibling();
#line 1880 "verilog.walker.g"
		returned = CDOmUdpSeqEntry::EDGE_STAR;
#line 11000 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

ECDOmUdpSymbol  VerilogTreeWalker::next_state(RefVerAST _t) {
#line 1883 "verilog.walker.g"
	ECDOmUdpSymbol returned;
#line 11015 "VerilogTreeWalker.cpp"
	RefVerAST next_state_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UDP_X:
	case UDP_0:
	case UDP_1:
	{
		returned=output_symbol(_t);
		_t = _retTree;
		break;
	}
	case MINUS:
	{
		RefVerAST tmp143_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MINUS);
		_t = _t->getNextSibling();
#line 1885 "verilog.walker.g"
		returned = UDP_SYMBOL_D;
#line 11036 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

ECDOmUdpSymbol  VerilogTreeWalker::output_symbol(RefVerAST _t) {
#line 1888 "verilog.walker.g"
	ECDOmUdpSymbol returned;
#line 11051 "VerilogTreeWalker.cpp"
	RefVerAST output_symbol_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST s1 = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UDP_0:
	{
		RefVerAST tmp144_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_0);
		_t = _t->getNextSibling();
#line 1889 "verilog.walker.g"
		returned = UDP_SYMBOL_0;
#line 11065 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_1:
	{
		RefVerAST tmp145_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_1);
		_t = _t->getNextSibling();
#line 1890 "verilog.walker.g"
		returned = UDP_SYMBOL_1;
#line 11075 "VerilogTreeWalker.cpp"
		break;
	}
	case UDP_X:
	{
		s1 = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UDP_X);
		_t = _t->getNextSibling();
#line 1891 "verilog.walker.g"
		if(s1->getText().at(0) == 'x') returned = UDP_SYMBOL_x; else returned = UDP_SYMBOL_X;
#line 11085 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

RefCDOmAssn  VerilogTreeWalker::assignment(RefVerAST _t) {
#line 1912 "verilog.walker.g"
	RefCDOmAssn returnedAssn;
#line 11100 "VerilogTreeWalker.cpp"
	RefVerAST assignment_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST assig = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1912 "verilog.walker.g"
	
	RefCDOmExpr my_lvalue;
	RefCDOmExpr expr;
	
#line 11108 "VerilogTreeWalker.cpp"
	
	RefVerAST __t451 = _t;
	assig = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ASSIGNMENT);
	_t = _t->getFirstChild();
	my_lvalue=lvalue(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
#line 1918 "verilog.walker.g"
	returnedAssn = CDOmAssn::build(assig->getLine(),  my_lvalue, expr );
#line 11120 "VerilogTreeWalker.cpp"
	_t = __t451;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedAssn;
}

RefCDOmStmtAssn  VerilogTreeWalker::blocking_or_nonblocking_assignment(RefVerAST _t) {
#line 1949 "verilog.walker.g"
	RefCDOmStmtAssn returnedStmtAssn;
#line 11130 "VerilogTreeWalker.cpp"
	RefVerAST blocking_or_nonblocking_assignment_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST bona = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1949 "verilog.walker.g"
	
	RefCDOmExpr my_lvalue;
	RefCDOmExpr expr;
	CDOmStmtAssn::EAssnType assnType;
	bool test = false;
	RefCDOmDelayControl delayControl = RefCDOmDelayControl();
	RefCDOmEventControl eventControl = RefCDOmEventControl();
	RefCDOmExpr exprEventControl = RefCDOmExpr();
	
#line 11143 "VerilogTreeWalker.cpp"
	
	RefVerAST __t457 = _t;
	bona = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BLOCKING_OR_NONBLOCKING_ASSIGNMENT);
	_t = _t->getFirstChild();
	my_lvalue=lvalue(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case ASSIGN:
	{
		RefVerAST tmp146_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ASSIGN);
		_t = _t->getNextSibling();
#line 1961 "verilog.walker.g"
		assnType = CDOmStmtAssn::ASSN_BLOCKING     ;
#line 11162 "VerilogTreeWalker.cpp"
		break;
	}
	case LE:
	{
		RefVerAST tmp147_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LE);
		_t = _t->getNextSibling();
#line 1962 "verilog.walker.g"
		assnType = CDOmStmtAssn::ASSN_NON_BLOCKING ;
#line 11172 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_REPEAT:
	case DELAY_CONTROL:
	case EVENT_CONTROL:
	{
		delay_or_event_control(_t,delayControl, eventControl, exprEventControl);
		_t = _retTree;
#line 1964 "verilog.walker.g"
		test=true;
#line 11193 "VerilogTreeWalker.cpp"
		break;
	}
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=expression(_t);
	_t = _retTree;
#line 1966 "verilog.walker.g"
	
	if( test ) {
	if( delayControl.get() )
	returnedStmtAssn = CDOmStmtAssn::buildWithDelayControl(bona->getLine(),  assnType, my_lvalue, expr, delayControl );
	else
	returnedStmtAssn = CDOmStmtAssn::buildWithEventControl(bona->getLine(),  assnType, my_lvalue, expr, eventControl, exprEventControl );
	}
	else
	returnedStmtAssn = CDOmStmtAssn::buildSimple(bona->getLine(), assnType, my_lvalue, expr);
	
#line 11267 "VerilogTreeWalker.cpp"
	_t = __t457;
	_t = _t->getNextSibling();
#line 1977 "verilog.walker.g"
	PRINT_AST(BLOCKING_OR_NONBLOCKING_ASSIGNMENT);
#line 11272 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedStmtAssn;
}

void VerilogTreeWalker::delay_or_event_control(RefVerAST _t,
	 RefCDOmDelayControl&delayControl, RefCDOmEventControl&eventControl, RefCDOmExpr&exprEventControl 
) {
	RefVerAST delay_or_event_control_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY_CONTROL:
	{
		delayControl=delay_control(_t);
		_t = _retTree;
		break;
	}
	case EVENT_CONTROL:
	{
		eventControl=event_control(_t);
		_t = _retTree;
		break;
	}
	case K_REPEAT:
	{
		RefVerAST __t485 = _t;
		RefVerAST tmp148_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REPEAT);
		_t = _t->getFirstChild();
		exprEventControl=expression(_t);
		_t = _retTree;
		eventControl=event_control(_t);
		_t = _retTree;
		_t = __t485;
		_t = _t->getNextSibling();
#line 2138 "verilog.walker.g"
		PRINT_AST(tmp148_AST_in);
#line 11311 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

RefCDOmStmtProcContAssn  VerilogTreeWalker::procedural_continuous_assignments(RefVerAST _t) {
#line 1980 "verilog.walker.g"
	RefCDOmStmtProcContAssn returnedStmtProcContAssn;
#line 11325 "VerilogTreeWalker.cpp"
	RefVerAST procedural_continuous_assignments_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kassign = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST kdeassign = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST kforce = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST krelease = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 1980 "verilog.walker.g"
	
	RefCDOmAssn assn; 
	RefCDOmExpr my_lvalue;
	
#line 11336 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_ASSIGN:
	{
		RefVerAST __t461 = _t;
		kassign = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_ASSIGN);
		_t = _t->getFirstChild();
		assn=assignment(_t);
		_t = _retTree;
		_t = __t461;
		_t = _t->getNextSibling();
#line 1986 "verilog.walker.g"
		returnedStmtProcContAssn = CDOmStmtProcContAssn::build(kassign->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_ASSIGN  , assn      );
#line 11353 "VerilogTreeWalker.cpp"
#line 1987 "verilog.walker.g"
		PRINT_AST(K_ASSIGN);
#line 11356 "VerilogTreeWalker.cpp"
		break;
	}
	case K_DEASSIGN:
	{
		RefVerAST __t462 = _t;
		kdeassign = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DEASSIGN);
		_t = _t->getFirstChild();
		my_lvalue=lvalue(_t);
		_t = _retTree;
		_t = __t462;
		_t = _t->getNextSibling();
#line 1989 "verilog.walker.g"
		returnedStmtProcContAssn = CDOmStmtProcContAssn::build(kdeassign->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_DEASSIGN, my_lvalue );
#line 11371 "VerilogTreeWalker.cpp"
#line 1990 "verilog.walker.g"
		PRINT_AST(K_DEASSIGN);
#line 11374 "VerilogTreeWalker.cpp"
		break;
	}
	case K_FORCE:
	{
		RefVerAST __t463 = _t;
		kforce = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FORCE);
		_t = _t->getFirstChild();
		assn=assignment(_t);
		_t = _retTree;
		_t = __t463;
		_t = _t->getNextSibling();
#line 1992 "verilog.walker.g"
		returnedStmtProcContAssn = CDOmStmtProcContAssn::build(kforce->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_FORCE   , assn      );
#line 11389 "VerilogTreeWalker.cpp"
#line 1993 "verilog.walker.g"
		PRINT_AST(K_FORCE);
#line 11392 "VerilogTreeWalker.cpp"
		break;
	}
	case K_RELEASE:
	{
		RefVerAST __t464 = _t;
		krelease = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_RELEASE);
		_t = _t->getFirstChild();
		my_lvalue=lvalue(_t);
		_t = _retTree;
		_t = __t464;
		_t = _t->getNextSibling();
#line 1995 "verilog.walker.g"
		returnedStmtProcContAssn = CDOmStmtProcContAssn::build(krelease->getLine(),  CDOmStmtProcContAssn::PROC_CONT_ASSN_RELEASE , my_lvalue );
#line 11407 "VerilogTreeWalker.cpp"
#line 1996 "verilog.walker.g"
		PRINT_AST(K_RELEASE);
#line 11410 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedStmtProcContAssn;
}

 RefCDOmStmtBlock  VerilogTreeWalker::par_block(RefVerAST _t) {
#line 2001 "verilog.walker.g"
	 RefCDOmStmtBlock returnedStmtBlock ;
#line 11425 "VerilogTreeWalker.cpp"
	RefVerAST par_block_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST pb = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2001 "verilog.walker.g"
	
	pair<RefString, int> str(RefString(), 0);
	RefCDOmAttrListCollection attrListColl;
	RefCDOmStmt stmt;
	bool acceptBlockItemDecl = false;
	RefCDOmAttrHolder attrHolder;
	
#line 11436 "VerilogTreeWalker.cpp"
	
	RefVerAST __t466 = _t;
	pb = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PAR_BLOCK);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		str=identifier(_t);
		_t = _retTree;
#line 2010 "verilog.walker.g"
		acceptBlockItemDecl = true;
#line 11453 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	case K_ASSIGN:
	case K_DEASSIGN:
	case K_DISABLE:
	case K_EVENT:
	case K_FORCE:
	case K_IF:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_RELEASE:
	case K_TIME:
	case K_WAIT:
	case ATTRIBUTE_INSTANCE:
	case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
	case PAR_BLOCK:
	case SEQ_BLOCK:
	case DELAY_CONTROL:
	case EVENT_CONTROL:
	case CASE_STATEMENT:
	case LOOP_STATEMENT:
	case EVENT_TRIGGER:
	case SYSTEM_TASK_ENABLE:
	case TASK_ENABLE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 2011 "verilog.walker.g"
	returnedStmtBlock = CDOmStmtBlock::build(pb->getLine(),  CDOmStmtBlock::BLOCK_PARALLEL, str.first );
#line 11494 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_7.member(_t->getType()))) {
			attrListColl=attrs_opt(_t);
			_t = _retTree;
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case K_EVENT:
			case K_INTEGER:
			case K_LOCALPARAM:
			case K_PARAMETER:
			case K_REAL:
			case K_REALTIME:
			case K_REG:
			case K_TIME:
			{
				attrHolder=block_item_declaration(_t, returnedStmtBlock );
				_t = _retTree;
				if (!( acceptBlockItemDecl ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptBlockItemDecl ");
#line 2015 "verilog.walker.g"
				if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 11521 "VerilogTreeWalker.cpp"
				break;
			}
			case K_ASSIGN:
			case K_DEASSIGN:
			case K_DISABLE:
			case K_FORCE:
			case K_IF:
			case K_RELEASE:
			case K_WAIT:
			case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
			case PAR_BLOCK:
			case SEQ_BLOCK:
			case DELAY_CONTROL:
			case EVENT_CONTROL:
			case CASE_STATEMENT:
			case LOOP_STATEMENT:
			case EVENT_TRIGGER:
			case SYSTEM_TASK_ENABLE:
			case TASK_ENABLE:
			{
				stmt=statement(_t);
				_t = _retTree;
#line 2017 "verilog.walker.g"
				
				acceptBlockItemDecl = false;
				if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
				returnedStmtBlock->addStmt( stmt );
				
#line 11550 "VerilogTreeWalker.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
		}
		else {
			goto _loop470;
		}
		
	}
	_loop470:;
	} // ( ... )*
	_t = __t466;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtBlock ;
}

RefCDOmStmtBlock  VerilogTreeWalker::seq_block(RefVerAST _t) {
#line 2027 "verilog.walker.g"
	RefCDOmStmtBlock returnedStmtBlock;
#line 11576 "VerilogTreeWalker.cpp"
	RefVerAST seq_block_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST sb = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2027 "verilog.walker.g"
	
	pair<RefString, int> str(RefString(), 0);
	RefCDOmAttrListCollection attrListColl;
	RefCDOmStmt stmt;
	bool acceptBlockItemDecl = false;
	RefCDOmAttrHolder attrHolder;
	
#line 11587 "VerilogTreeWalker.cpp"
	
	RefVerAST __t472 = _t;
	sb = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SEQ_BLOCK);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case IDENTIFIER:
	case ESCAPED_IDENTIFIER:
	{
		str=identifier(_t);
		_t = _retTree;
#line 2036 "verilog.walker.g"
		acceptBlockItemDecl = true;
#line 11604 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	case K_ASSIGN:
	case K_DEASSIGN:
	case K_DISABLE:
	case K_EVENT:
	case K_FORCE:
	case K_IF:
	case K_INTEGER:
	case K_LOCALPARAM:
	case K_PARAMETER:
	case K_REAL:
	case K_REALTIME:
	case K_REG:
	case K_RELEASE:
	case K_TIME:
	case K_WAIT:
	case ATTRIBUTE_INSTANCE:
	case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
	case PAR_BLOCK:
	case SEQ_BLOCK:
	case DELAY_CONTROL:
	case EVENT_CONTROL:
	case CASE_STATEMENT:
	case LOOP_STATEMENT:
	case EVENT_TRIGGER:
	case SYSTEM_TASK_ENABLE:
	case TASK_ENABLE:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 2037 "verilog.walker.g"
	returnedStmtBlock = CDOmStmtBlock::build(sb->getLine(),  CDOmStmtBlock::BLOCK_SEQUENTIAL, str.first );
#line 11645 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_7.member(_t->getType()))) {
			attrListColl=attrs_opt(_t);
			_t = _retTree;
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case K_EVENT:
			case K_INTEGER:
			case K_LOCALPARAM:
			case K_PARAMETER:
			case K_REAL:
			case K_REALTIME:
			case K_REG:
			case K_TIME:
			{
				attrHolder=block_item_declaration(_t, returnedStmtBlock );
				_t = _retTree;
				if (!( acceptBlockItemDecl ))
					throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" acceptBlockItemDecl ");
#line 2041 "verilog.walker.g"
				if(attrListColl.get()) attrHolder->setAttrListCollection( attrListColl );
#line 11672 "VerilogTreeWalker.cpp"
				break;
			}
			case K_ASSIGN:
			case K_DEASSIGN:
			case K_DISABLE:
			case K_FORCE:
			case K_IF:
			case K_RELEASE:
			case K_WAIT:
			case BLOCKING_OR_NONBLOCKING_ASSIGNMENT:
			case PAR_BLOCK:
			case SEQ_BLOCK:
			case DELAY_CONTROL:
			case EVENT_CONTROL:
			case CASE_STATEMENT:
			case LOOP_STATEMENT:
			case EVENT_TRIGGER:
			case SYSTEM_TASK_ENABLE:
			case TASK_ENABLE:
			{
				stmt=statement(_t);
				_t = _retTree;
#line 2043 "verilog.walker.g"
				
				acceptBlockItemDecl = false;
				if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
				returnedStmtBlock->addStmt( stmt );
				
#line 11701 "VerilogTreeWalker.cpp"
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
		}
		else {
			goto _loop476;
		}
		
	}
	_loop476:;
	} // ( ... )*
	_t = __t472;
	_t = _t->getNextSibling();
#line 2051 "verilog.walker.g"
	PRINT_AST(SEQ_BLOCK);
#line 11722 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedStmtBlock;
}

RefCDOmStmtCase  VerilogTreeWalker::case_statement(RefVerAST _t) {
#line 2280 "verilog.walker.g"
	RefCDOmStmtCase returnedStmtCase;
#line 11730 "VerilogTreeWalker.cpp"
	RefVerAST case_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST cs = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2280 "verilog.walker.g"
	
	RefCDOmListExpr exprList;
	RefCDOmStmt stmt;
	RefCDOmExpr expr;
	CDOmStmtCase::ECaseType caseType;
	
#line 11740 "VerilogTreeWalker.cpp"
	
	RefVerAST __t511 = _t;
	cs = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CASE_STATEMENT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_CASE:
	{
		RefVerAST tmp149_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CASE);
		_t = _t->getNextSibling();
#line 2288 "verilog.walker.g"
		caseType = CDOmStmtCase::CASE_CASE;
#line 11757 "VerilogTreeWalker.cpp"
		break;
	}
	case K_CASEZ:
	{
		RefVerAST tmp150_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CASEZ);
		_t = _t->getNextSibling();
#line 2289 "verilog.walker.g"
		caseType = CDOmStmtCase::CASE_CASE_Z;
#line 11767 "VerilogTreeWalker.cpp"
		break;
	}
	case K_CASEX:
	{
		RefVerAST tmp151_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_CASEX);
		_t = _t->getNextSibling();
#line 2290 "verilog.walker.g"
		caseType = CDOmStmtCase::CASE_CASE_X;
#line 11777 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	expr=expression(_t);
	_t = _retTree;
	{
	case_item(_t,exprList, stmt);
	_t = _retTree;
	}
#line 2294 "verilog.walker.g"
	
	returnedStmtCase = CDOmStmtCase::build(cs->getLine(), caseType, expr, exprList, stmt);
	
#line 11796 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == CASE_ITEM)) {
			case_item(_t,exprList, stmt);
			_t = _retTree;
#line 2298 "verilog.walker.g"
			
			returnedStmtCase->addCaseItem(exprList, stmt);
			
#line 11808 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop515;
		}
		
	}
	_loop515:;
	} // ( ... )*
	_t = __t511;
	_t = _t->getNextSibling();
#line 2303 "verilog.walker.g"
	PRINT_AST(CASE_STATEMENT);
#line 11821 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedStmtCase;
}

RefCDOmStmtIf  VerilogTreeWalker::conditional_statement(RefVerAST _t) {
#line 2254 "verilog.walker.g"
	RefCDOmStmtIf returnedStmtIf;
#line 11829 "VerilogTreeWalker.cpp"
	RefVerAST conditional_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kif = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2254 "verilog.walker.g"
	
	RefCDOmExpr expr;
	RefCDOmStmt stmt1;
	RefCDOmStmt stmt2 = RefCDOmStmt(  );
	RefCDOmAttrListCollection attrListColl1;
	RefCDOmAttrListCollection attrListColl2;
	
#line 11840 "VerilogTreeWalker.cpp"
	
	RefVerAST __t508 = _t;
	kif = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_IF);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
	attrListColl1=attrs_opt(_t);
	_t = _retTree;
	stmt1=statement_or_null(_t);
	_t = _retTree;
#line 2265 "verilog.walker.g"
	
	if(attrListColl1.get()) stmt1->setAttrListCollection(attrListColl1);
	
#line 11856 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case ATTRIBUTE_INSTANCE:
	case STATEMENT_OR_NULL:
	{
		attrListColl2=attrs_opt(_t);
		_t = _retTree;
		stmt2=statement_or_null(_t);
		_t = _retTree;
#line 2270 "verilog.walker.g"
		
		if(attrListColl2.get()) stmt2->setAttrListCollection(attrListColl2);//this is executed only if there really is a attrListColl
		
#line 11872 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 2274 "verilog.walker.g"
	returnedStmtIf = CDOmStmtIf::build(kif->getLine(), expr, stmt1, stmt2);
#line 11887 "VerilogTreeWalker.cpp"
	_t = __t508;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtIf;
}

RefCDOmStmtDisable  VerilogTreeWalker::disable_statement(RefVerAST _t) {
#line 2141 "verilog.walker.g"
	RefCDOmStmtDisable returnedStmtDisable;
#line 11897 "VerilogTreeWalker.cpp"
	RefVerAST disable_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kdisable = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2141 "verilog.walker.g"
	RefCDOmExprLink exprLink;
#line 11902 "VerilogTreeWalker.cpp"
	
	RefVerAST __t487 = _t;
	kdisable = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DISABLE);
	_t = _t->getFirstChild();
	exprLink=hierarchical_identifier(_t);
	_t = _retTree;
#line 2144 "verilog.walker.g"
	returnedStmtDisable = CDOmStmtDisable::build(kdisable->getLine(), exprLink);
#line 11912 "VerilogTreeWalker.cpp"
	_t = __t487;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtDisable;
}

RefCDOmStmtEventTrigger  VerilogTreeWalker::event_trigger(RefVerAST _t) {
#line 2162 "verilog.walker.g"
	RefCDOmStmtEventTrigger returnedStmtDisable;
#line 11922 "VerilogTreeWalker.cpp"
	RefVerAST event_trigger_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST et = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2162 "verilog.walker.g"
	RefCDOmExprLink exprLink;
#line 11927 "VerilogTreeWalker.cpp"
	
	RefVerAST __t492 = _t;
	et = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EVENT_TRIGGER);
	_t = _t->getFirstChild();
	exprLink=expr_primary_identifier(_t);
	_t = _retTree;
#line 2165 "verilog.walker.g"
	returnedStmtDisable = CDOmStmtEventTrigger::build(et->getLine(), exprLink);
#line 11937 "VerilogTreeWalker.cpp"
	_t = __t492;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtDisable;
}

RefCDOmStmtLoop  VerilogTreeWalker::loop_statement(RefVerAST _t) {
#line 2325 "verilog.walker.g"
	RefCDOmStmtLoop returnedStmtLoop;
#line 11947 "VerilogTreeWalker.cpp"
	RefVerAST loop_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ls = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2325 "verilog.walker.g"
	
	RefCDOmStmt stmt;
	RefCDOmExpr expr;
	RefCDOmAssn assn1, assn2;
	RefCDOmAttrListCollection attrListColl;
	
#line 11957 "VerilogTreeWalker.cpp"
	
	RefVerAST __t520 = _t;
	ls = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LOOP_STATEMENT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_FOREVER:
	{
		RefVerAST tmp152_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FOREVER);
		_t = _t->getNextSibling();
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		stmt=statement(_t);
		_t = _retTree;
#line 2334 "verilog.walker.g"
		
		if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
		returnedStmtLoop = CDOmStmtLoop::buildForeverStmt(ls->getLine(), stmt);
		
#line 11981 "VerilogTreeWalker.cpp"
		break;
	}
	case K_REPEAT:
	{
		RefVerAST tmp153_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_REPEAT);
		_t = _t->getNextSibling();
		expr=expression(_t);
		_t = _retTree;
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		stmt=statement(_t);
		_t = _retTree;
#line 2339 "verilog.walker.g"
		
		if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
		returnedStmtLoop = CDOmStmtLoop::buildRepeatStmt(ls->getLine(), expr, stmt);
		
#line 12000 "VerilogTreeWalker.cpp"
		break;
	}
	case K_WHILE:
	{
		RefVerAST tmp154_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WHILE);
		_t = _t->getNextSibling();
		expr=expression(_t);
		_t = _retTree;
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		stmt=statement(_t);
		_t = _retTree;
#line 2344 "verilog.walker.g"
		
		if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
		returnedStmtLoop = CDOmStmtLoop::buildWhileStmt(ls->getLine(), expr, stmt);
		
#line 12019 "VerilogTreeWalker.cpp"
		break;
	}
	case K_FOR:
	{
		RefVerAST tmp155_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_FOR);
		_t = _t->getNextSibling();
		assn1=assignment(_t);
		_t = _retTree;
		expr=expression(_t);
		_t = _retTree;
		assn2=assignment(_t);
		_t = _retTree;
		attrListColl=attrs_opt(_t);
		_t = _retTree;
		stmt=statement(_t);
		_t = _retTree;
#line 2349 "verilog.walker.g"
		
		if(attrListColl.get()) stmt->setAttrListCollection( attrListColl );
		returnedStmtLoop = CDOmStmtLoop::buildForStmt(ls->getLine(), assn1, expr, assn2, stmt);
		
#line 12042 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t520;
	_t = _t->getNextSibling();
#line 2355 "verilog.walker.g"
	PRINT_AST(LOOP_STATEMENT);
#line 12055 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedStmtLoop;
}

RefCDOmStmt  VerilogTreeWalker::procedural_timing_control_statement(RefVerAST _t) {
#line 2210 "verilog.walker.g"
	RefCDOmStmt returnedStmt;
#line 12063 "VerilogTreeWalker.cpp"
	RefVerAST procedural_timing_control_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2210 "verilog.walker.g"
	
	RefCDOmAttrListCollection attrListColl;
	RefCDOmStmt stmt;
	RefCDOmBase base;
	bool fatal = false;
	
#line 12072 "VerilogTreeWalker.cpp"
	
	base=procedural_timing_control(_t);
	_t = _retTree;
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	stmt=statement_or_null(_t);
	_t = _retTree;
#line 2219 "verilog.walker.g"
	
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
	
#line 12094 "VerilogTreeWalker.cpp"
	if (!(!fatal))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException("!fatal");
	_retTree = _t;
	return returnedStmt;
}

RefCDOmStmtTaskEnable  VerilogTreeWalker::system_task_enable(RefVerAST _t) {
#line 2360 "verilog.walker.g"
	RefCDOmStmtTaskEnable returnedStmtTaskEnable;
#line 12104 "VerilogTreeWalker.cpp"
	RefVerAST system_task_enable_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ste = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2360 "verilog.walker.g"
	
	RefString name;
	RefCDOmExpr expr = RefCDOmExpr();
	
#line 12112 "VerilogTreeWalker.cpp"
	
	RefVerAST __t523 = _t;
	ste = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SYSTEM_TASK_ENABLE);
	_t = _t->getFirstChild();
	name=system_function_name(_t);
	_t = _retTree;
#line 2367 "verilog.walker.g"
	returnedStmtTaskEnable = CDOmStmtTaskEnable::build(ste->getLine(),  CDOmStmtTaskEnable::TASK_ENABLE_SYSTEM, CDOmExprLink::build(ste->getLine(), name));
#line 12122 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	case COMMA:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == COMMA)) {
			RefVerAST tmp156_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
			_t = _t->getNextSibling();
#line 2371 "verilog.walker.g"
			returnedStmtTaskEnable->addExpr(expr); expr=RefCDOmExpr();
#line 12202 "VerilogTreeWalker.cpp"
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case EXPRESSION:
			case CONCATENATION:
			case MULTI_CONCATENATION:
			case EXPR_PRIMARY_IDENTIFIER:
			case FUNCTION_CALL:
			case SYSTEM_FUNCTION_CALL:
			case MINTYPMAX_EXPRESSION:
			case SIZED_NUMBER:
			{
				expr=expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case COMMA:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
		}
		else {
			goto _loop527;
		}
		
	}
	_loop527:;
	} // ( ... )*
#line 2374 "verilog.walker.g"
	returnedStmtTaskEnable->addExpr(expr);
#line 12282 "VerilogTreeWalker.cpp"
	_t = __t523;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtTaskEnable;
}

RefCDOmStmtTaskEnable  VerilogTreeWalker::task_enable(RefVerAST _t) {
#line 2378 "verilog.walker.g"
	RefCDOmStmtTaskEnable returnedStmtTaskEnable;
#line 12292 "VerilogTreeWalker.cpp"
	RefVerAST task_enable_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST te = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2378 "verilog.walker.g"
	
	RefCDOmExprLink exprLink;
	RefCDOmListExpr exprList = RefCDOmListExpr();
	RefCDOmExpr expr;
	
#line 12301 "VerilogTreeWalker.cpp"
	
	RefVerAST __t529 = _t;
	te = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),TASK_ENABLE);
	_t = _t->getFirstChild();
	exprLink=hierarchical_identifier(_t);
	_t = _retTree;
#line 2386 "verilog.walker.g"
	returnedStmtTaskEnable = CDOmStmtTaskEnable::build(te->getLine(),  CDOmStmtTaskEnable::TASK_ENABLE_TASK, exprLink);
#line 12311 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_9.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 2388 "verilog.walker.g"
			returnedStmtTaskEnable->addExpr(expr);
#line 12321 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop531;
		}
		
	}
	_loop531:;
	} // ( ... )*
	_t = __t529;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtTaskEnable;
}

RefCDOmStmtWait  VerilogTreeWalker::wait_statement(RefVerAST _t) {
#line 2235 "verilog.walker.g"
	RefCDOmStmtWait returnedStmtWait;
#line 12339 "VerilogTreeWalker.cpp"
	RefVerAST wait_statement_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kwait = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2235 "verilog.walker.g"
	
	RefCDOmExpr expr;
	RefCDOmAttrListCollection attrListColl;
	RefCDOmStmt stmt;
	
#line 12348 "VerilogTreeWalker.cpp"
	
	RefVerAST __t506 = _t;
	kwait = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_WAIT);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	stmt=statement_or_null(_t);
	_t = _retTree;
#line 2245 "verilog.walker.g"
	
	if(attrListColl.get()) stmt->setAttrListCollection(attrListColl);
	returnedStmtWait = CDOmStmtWait::build(kwait->getLine(), expr, stmt);
	
#line 12365 "VerilogTreeWalker.cpp"
	_t = __t506;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedStmtWait;
}

RefCDOmDelayControl  VerilogTreeWalker::delay_control(RefVerAST _t) {
#line 2100 "verilog.walker.g"
	RefCDOmDelayControl returnedDelayControl;
#line 12375 "VerilogTreeWalker.cpp"
	RefVerAST delay_control_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST dc = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2100 "verilog.walker.g"
	
	RefCDOmMinTypMax minTypMax;
	RefCDOmExpr expr;
	bool fatal = false;
	
#line 12384 "VerilogTreeWalker.cpp"
	
	RefVerAST __t482 = _t;
	dc = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DELAY_CONTROL);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY_VALUE:
	{
		expr=delay_value(_t);
		_t = _retTree;
#line 2108 "verilog.walker.g"
		
		switch( expr->getExprType() ){
		case CDOmExpr::EXPR_NUMBER : 
		returnedDelayControl = CDOmDelayControl::build(dc->getLine(),  boost::static_pointer_cast<CDOmNumber>   (expr) );
		break;
		case CDOmExpr::EXPR_REAL_NUMBER :
		returnedDelayControl = CDOmDelayControl::build(dc->getLine(),  boost::static_pointer_cast<CDOmReal>     (expr) );
		break;
		case CDOmExpr::EXPR_HID :
		returnedDelayControl = CDOmDelayControl::build(dc->getLine(),  boost::static_pointer_cast<CDOmExprLink> (expr) );
		break;
		
		default:
		fatal = true;
		}
		
#line 12415 "VerilogTreeWalker.cpp"
		if (!(!fatal))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException("!fatal");
		break;
	}
	case MINTYPMAX_EXPRESSION:
	{
		minTypMax=mintypmax_expression(_t);
		_t = _retTree;
#line 2126 "verilog.walker.g"
		
		returnedDelayControl = CDOmDelayControl::build(dc->getLine(), minTypMax);
		
#line 12428 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t482;
	_t = _t->getNextSibling();
#line 2131 "verilog.walker.g"
	PRINT_AST(DELAY_CONTROL);
#line 12441 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedDelayControl;
}

 RefCDOmEventControl  VerilogTreeWalker::event_control(RefVerAST _t) {
#line 2148 "verilog.walker.g"
	 RefCDOmEventControl returnedEventControl ;
#line 12449 "VerilogTreeWalker.cpp"
	RefVerAST event_control_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ec = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2148 "verilog.walker.g"
	
	RefCDOmExprLink exprLink;
	RefCDOmEventExpr eventExpr;
	
#line 12457 "VerilogTreeWalker.cpp"
	
	RefVerAST __t489 = _t;
	ec = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EVENT_CONTROL);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case HIERARCHICAL_IDENTIFIER:
	{
		exprLink=hierarchical_identifier(_t);
		_t = _retTree;
#line 2154 "verilog.walker.g"
		returnedEventControl = CDOmEventControl::build(ec->getLine(),  exprLink  );
#line 12473 "VerilogTreeWalker.cpp"
		break;
	}
	case OR_EVENT_EXPRESSION:
	{
		eventExpr=list_of_event_expressions(_t);
		_t = _retTree;
#line 2155 "verilog.walker.g"
		returnedEventControl = CDOmEventControl::build(ec->getLine(),  eventExpr );
#line 12482 "VerilogTreeWalker.cpp"
		break;
	}
	case STAR:
	{
		RefVerAST tmp157_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STAR);
		_t = _t->getNextSibling();
#line 2156 "verilog.walker.g"
		returnedEventControl = CDOmEventControl::build(ec->getLine(),    false   );
#line 12492 "VerilogTreeWalker.cpp"
		break;
	}
	case SUPERSTAR:
	{
		RefVerAST tmp158_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SUPERSTAR);
		_t = _t->getNextSibling();
#line 2157 "verilog.walker.g"
		returnedEventControl = CDOmEventControl::build(ec->getLine(),    true    );
#line 12502 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t489;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedEventControl ;
}

RefCDOmEventExpr  VerilogTreeWalker::list_of_event_expressions(RefVerAST _t) {
#line 2171 "verilog.walker.g"
	RefCDOmEventExpr returnedEventExpr;
#line 12520 "VerilogTreeWalker.cpp"
	RefVerAST list_of_event_expressions_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2171 "verilog.walker.g"
	RefCDOmEventExpr ev1, ev2;
#line 12524 "VerilogTreeWalker.cpp"
	
	{
	returnedEventExpr=or_event_expression(_t);
	_t = _retTree;
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == OR_EVENT_EXPRESSION)) {
			ev1=or_event_expression(_t);
			_t = _retTree;
#line 2175 "verilog.walker.g"
			
			ev2 = returnedEventExpr;
			returnedEventExpr = CDOmEventExpr::build(ev1->getLineNumber(), CDOmEventExpr:: EVENT_EXPR_COMMA, ev2, ev1);
			
#line 12542 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop496;
		}
		
	}
	_loop496:;
	} // ( ... )*
	_retTree = _t;
	return returnedEventExpr;
}

RefCDOmExprLink  VerilogTreeWalker::expr_primary_identifier(RefVerAST _t) {
#line 3601 "verilog.walker.g"
	RefCDOmExprLink returnedExprLink;
#line 12558 "VerilogTreeWalker.cpp"
	RefVerAST expr_primary_identifier_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST re = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3601 "verilog.walker.g"
	
	pair<RefString, int> str;
	RefCDOmExpr currExpr=RefCDOmExpr(), prevExpr=RefCDOmExpr();
	TInt count = -1;
	RefCDOmListExpr exprList;
	
#line 12568 "VerilogTreeWalker.cpp"
	
	RefVerAST __t758 = _t;
	RefVerAST tmp159_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPR_PRIMARY_IDENTIFIER);
	_t = _t->getFirstChild();
	{ // ( ... )+
	int _cnt762=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == IDENTIFIER || _t->getType() == ESCAPED_IDENTIFIER)) {
#line 3610 "verilog.walker.g"
			
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
			
#line 12600 "VerilogTreeWalker.cpp"
			str=identifier(_t);
			_t = _retTree;
			{ // ( ... )*
			for (;;) {
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				if ((_tokenSet_9.member(_t->getType()))) {
					currExpr=expression(_t);
					_t = _retTree;
#line 3632 "verilog.walker.g"
					
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
					
#line 12625 "VerilogTreeWalker.cpp"
				}
				else {
					goto _loop761;
				}
				
			}
			_loop761:;
			} // ( ... )*
		}
		else {
			if ( _cnt762>=1 ) { goto _loop762; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt762++;
	}
	_loop762:;
	}  // ( ... )+
#line 3648 "verilog.walker.g"
	
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
	
#line 12659 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case RANGE_EXPRESSION:
	{
		RefVerAST __t764 = _t;
		re = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),RANGE_EXPRESSION);
		_t = _t->getFirstChild();
#line 3665 "verilog.walker.g"
		
		CDOmRangeExpr::ERangeExprType exprType = CDOmRangeExpr::RANGE_EXPR_DOUBLE;
		RefCDOmRangeExpr rangeExpr;
		
#line 12675 "VerilogTreeWalker.cpp"
		currExpr=expression(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COLON:
		{
			RefVerAST tmp160_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COLON);
			_t = _t->getNextSibling();
			break;
		}
		case PO_POS:
		{
			RefVerAST tmp161_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_POS);
			_t = _t->getNextSibling();
#line 3671 "verilog.walker.g"
			exprType = CDOmRangeExpr::RANGE_EXPR_PLUS ;
#line 12696 "VerilogTreeWalker.cpp"
			break;
		}
		case PO_NEG:
		{
			RefVerAST tmp162_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
			_t = _t->getNextSibling();
#line 3672 "verilog.walker.g"
			exprType = CDOmRangeExpr::RANGE_EXPR_MINUS;
#line 12706 "VerilogTreeWalker.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		prevExpr=expression(_t);
		_t = _retTree;
		_t = __t764;
		_t = _t->getNextSibling();
#line 3676 "verilog.walker.g"
		
		rangeExpr = CDOmRangeExpr::buildDoubleRangeExpr(re->getLine(), currExpr, prevExpr, exprType);
		returnedExprLink->setRangeExpr(rangeExpr);
		
#line 12724 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t758;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedExprLink;
}

RefCDOmEventExpr  VerilogTreeWalker::or_event_expression(RefVerAST _t) {
#line 2185 "verilog.walker.g"
	RefCDOmEventExpr returnedEventExpr;
#line 12746 "VerilogTreeWalker.cpp"
	RefVerAST or_event_expression_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2185 "verilog.walker.g"
	RefCDOmEventExpr ev1, ev2;
#line 12750 "VerilogTreeWalker.cpp"
	
	RefVerAST __t498 = _t;
	RefVerAST tmp163_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),OR_EVENT_EXPRESSION);
	_t = _t->getFirstChild();
	{
	returnedEventExpr=event_expression_primary(_t);
	_t = _retTree;
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_11.member(_t->getType()))) {
			ev1=event_expression_primary(_t);
			_t = _retTree;
#line 2190 "verilog.walker.g"
			
			ev2 = returnedEventExpr;
			returnedEventExpr = CDOmEventExpr::build(ev1->getLineNumber(), CDOmEventExpr::EVENT_EXPR_OR, ev2, ev1);
			
#line 12772 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop501;
		}
		
	}
	_loop501:;
	} // ( ... )*
	_t = __t498;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedEventExpr;
}

RefCDOmEventExpr  VerilogTreeWalker::event_expression_primary(RefVerAST _t) {
#line 2198 "verilog.walker.g"
	RefCDOmEventExpr returnedEventExpr;
#line 12790 "VerilogTreeWalker.cpp"
	RefVerAST event_expression_primary_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kpos = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST kneg = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2198 "verilog.walker.g"
	RefCDOmExpr expr;
#line 12796 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
#line 2200 "verilog.walker.g"
		returnedEventExpr = CDOmEventExpr::build(expr->getLineNumber(), CDOmEventExpr::EVENT_EXPR_EXPR, expr);
#line 12855 "VerilogTreeWalker.cpp"
		break;
	}
	case K_POSEDGE:
	{
		kpos = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_POSEDGE);
		_t = _t->getNextSibling();
		expr=expression(_t);
		_t = _retTree;
#line 2201 "verilog.walker.g"
		returnedEventExpr = CDOmEventExpr::build(kpos->getLine(), CDOmEventExpr::EVENT_EXPR_POSEDGE, expr);
#line 12867 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NEGEDGE:
	{
		kneg = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NEGEDGE);
		_t = _t->getNextSibling();
		expr=expression(_t);
		_t = _retTree;
#line 2202 "verilog.walker.g"
		returnedEventExpr = CDOmEventExpr::build(kneg->getLine(), CDOmEventExpr::EVENT_EXPR_NEGEDGE, expr);
#line 12879 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedEventExpr;
}

RefCDOmBase  VerilogTreeWalker::procedural_timing_control(RefVerAST _t) {
#line 2205 "verilog.walker.g"
	RefCDOmBase returnedBase;
#line 12894 "VerilogTreeWalker.cpp"
	RefVerAST procedural_timing_control_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case DELAY_CONTROL:
	{
		returnedBase=delay_control(_t);
		_t = _retTree;
		break;
	}
	case EVENT_CONTROL:
	{
		returnedBase=event_control(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedBase;
}

void VerilogTreeWalker::case_item(RefVerAST _t,
	RefCDOmListExpr& exprList, RefCDOmStmt& stmt
) {
	RefVerAST case_item_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2308 "verilog.walker.g"
	RefCDOmAttrListCollection attrListColl;
#line 12927 "VerilogTreeWalker.cpp"
	
	RefVerAST __t517 = _t;
	RefVerAST tmp164_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CASE_ITEM);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case EXPRESSION_LIST:
	{
		exprList=expression_list(_t);
		_t = _retTree;
		break;
	}
	case K_DEFAULT:
	{
		RefVerAST tmp165_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_DEFAULT);
		_t = _t->getNextSibling();
#line 2314 "verilog.walker.g"
		exprList = RefCDOmListExpr(  );
#line 12950 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	stmt=statement_or_null(_t);
	_t = _retTree;
#line 2318 "verilog.walker.g"
	if(attrListColl.get()) stmt->setAttrListCollection(attrListColl);
#line 12965 "VerilogTreeWalker.cpp"
	_t = __t517;
	_t = _t->getNextSibling();
#line 2320 "verilog.walker.g"
	PRINT_AST(tmp164_AST_in);
#line 12970 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

RefCDOmListExpr  VerilogTreeWalker::expression_list(RefVerAST _t) {
#line 3171 "verilog.walker.g"
	RefCDOmListExpr exprList;
#line 12977 "VerilogTreeWalker.cpp"
	RefVerAST expression_list_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST el = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3171 "verilog.walker.g"
	RefCDOmExpr expr;
#line 12982 "VerilogTreeWalker.cpp"
	
	RefVerAST __t682 = _t;
	el = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EXPRESSION_LIST);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
#line 3175 "verilog.walker.g"
	exprList=CDOmListExpr::build(el->getLine(), expr);
#line 12992 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_9.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 3176 "verilog.walker.g"
			exprList->addItem(expr);
#line 13002 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop684;
		}
		
	}
	_loop684:;
	} // ( ... )*
	_t = __t682;
	_t = _t->getNextSibling();
#line 3178 "verilog.walker.g"
	PRINT_AST(EXPRESSION_LIST);
#line 13015 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return exprList;
}

RefString  VerilogTreeWalker::system_function_name(RefVerAST _t) {
#line 3684 "verilog.walker.g"
	RefString str;
#line 13023 "VerilogTreeWalker.cpp"
	RefVerAST system_function_name_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST stn = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	stn = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SYSTEM_TASK_NAME);
	_t = _t->getNextSibling();
#line 3686 "verilog.walker.g"
	str = _RS(stn->getText());
#line 13032 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return str;
}

void VerilogTreeWalker::specify_item(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST specify_item_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2404 "verilog.walker.g"
	
	RefCDOmParamDecl paramDecl;
	
#line 13045 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_SPECPARAM:
	{
		paramDecl=specparam_declaration(_t,parent);
		_t = _retTree;
		break;
	}
	case K_NOSHOWCANCELLED:
	case K_PULSESTYLE_ONDETECT:
	case K_PULSESTYLE_ONEVENT:
	case K_SHOWCANCELLED:
	{
		pulsestyle_or_showcancelled_declaration(_t,parent);
		_t = _retTree;
		break;
	}
	case K_IF:
	case K_IFNONE:
	case EDGE_SENSITIVE_PATH_DECLARATION:
	case SIMPLE_PATH_DECLARATION:
	{
		path_declaration(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_SETUP:
	case K_S_HOLD:
	case K_S_SETUPHOLD:
	case K_S_RECOVERY:
	case K_S_REMOVAL:
	case K_S_RECREM:
	case K_S_SKEW:
	case K_S_TIMESKEW:
	case K_S_FULLSKEW:
	case K_S_PERIOD:
	case K_S_WIDTH:
	case K_S_NOCHANGE:
	{
		system_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::pulsestyle_or_showcancelled_declaration(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST pulsestyle_or_showcancelled_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kpo = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST kpod = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST kn = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2414 "verilog.walker.g"
	RefCDOmSpecifyTerminalList specTermList;
#line 13109 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_PULSESTYLE_ONEVENT:
	{
		RefVerAST __t538 = _t;
		kpo = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PULSESTYLE_ONEVENT);
		_t = _t->getFirstChild();
		specTermList=list_of_path_terminals(_t);
		_t = _retTree;
		_t = __t538;
		_t = _t->getNextSibling();
#line 2417 "verilog.walker.g"
		CDOmPulseStyleOrShowCancelledDecl::build(kpo->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONEVENT, specTermList);
#line 13126 "VerilogTreeWalker.cpp"
		break;
	}
	case K_PULSESTYLE_ONDETECT:
	{
		RefVerAST __t539 = _t;
		kpod = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_PULSESTYLE_ONDETECT);
		_t = _t->getFirstChild();
		specTermList=list_of_path_terminals(_t);
		_t = _retTree;
		_t = __t539;
		_t = _t->getNextSibling();
#line 2419 "verilog.walker.g"
		CDOmPulseStyleOrShowCancelledDecl::build(kpod->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::PULSESTYLE_ONDETECT, specTermList);
#line 13141 "VerilogTreeWalker.cpp"
		break;
	}
	case K_SHOWCANCELLED:
	{
		RefVerAST __t540 = _t;
		ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_SHOWCANCELLED);
		_t = _t->getFirstChild();
		specTermList=list_of_path_terminals(_t);
		_t = _retTree;
		_t = __t540;
		_t = _t->getNextSibling();
#line 2421 "verilog.walker.g"
		CDOmPulseStyleOrShowCancelledDecl::build(ks->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::SHOWCANCELLED, specTermList);
#line 13156 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NOSHOWCANCELLED:
	{
		RefVerAST __t541 = _t;
		kn = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NOSHOWCANCELLED);
		_t = _t->getFirstChild();
		specTermList=list_of_path_terminals(_t);
		_t = _retTree;
		_t = __t541;
		_t = _t->getNextSibling();
#line 2423 "verilog.walker.g"
		CDOmPulseStyleOrShowCancelledDecl::build(kn->getLine(), parent, CDOmPulseStyleOrShowCancelledDecl::NOSHOWCANCELLED, specTermList);
#line 13171 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::path_declaration(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST path_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case EDGE_SENSITIVE_PATH_DECLARATION:
	case SIMPLE_PATH_DECLARATION:
	{
		simple_or_edge_sensitive_path_declaration(_t,parent, RefCDOmExpr(), false);
		_t = _retTree;
		break;
	}
	case K_IF:
	case K_IFNONE:
	{
		state_dependent_path_declaration(_t,parent);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::system_timing_check(RefVerAST _t,
	 RefCDOmSpecifyBlock parent 
) {
	RefVerAST system_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_S_SETUP:
	{
		setup_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_HOLD:
	{
		hold_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_SETUPHOLD:
	{
		setuphold_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_RECOVERY:
	{
		recovery_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_REMOVAL:
	{
		removal_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_RECREM:
	{
		recrem_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_SKEW:
	{
		skew_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_TIMESKEW:
	{
		timeskew_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_FULLSKEW:
	{
		fullskew_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_PERIOD:
	{
		period_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_WIDTH:
	{
		width_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	case K_S_NOCHANGE:
	{
		nochange_timing_check(_t,parent);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

RefCDOmSpecifyTerminalList  VerilogTreeWalker::list_of_path_terminals(RefVerAST _t) {
#line 2569 "verilog.walker.g"
	RefCDOmSpecifyTerminalList returned;
#line 13303 "VerilogTreeWalker.cpp"
	RefVerAST list_of_path_terminals_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2569 "verilog.walker.g"
	RefCDOmExprLink exprLink;
#line 13307 "VerilogTreeWalker.cpp"
	
	exprLink=specify_terminal_descriptor(_t);
	_t = _retTree;
#line 2572 "verilog.walker.g"
	returned = CDOmSpecifyTerminalList::build(exprLink->getLineNumber(), exprLink);
#line 13313 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR)) {
			exprLink=specify_terminal_descriptor(_t);
			_t = _retTree;
#line 2574 "verilog.walker.g"
			returned->addItem(exprLink);
#line 13323 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop561;
		}
		
	}
	_loop561:;
	} // ( ... )*
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::simple_or_edge_sensitive_path_declaration(RefVerAST _t,
	RefCDOmSpecifyBlock parent, RefCDOmExpr modPathExpr, TBool isIfNone
) {
	RefVerAST simple_or_edge_sensitive_path_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST spd = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST espd = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2432 "verilog.walker.g"
	
	RefCDOmSpecifyTerminalList specTermList1=RefCDOmSpecifyTerminalList(), specTermList2;
	CDOmPathDecl::EPathDeclType pathType;
	CDOmPathDecl::EPathDeclPolarityOp polOp = CDOmPathDecl::PATH_DECL_NOOP;
	CDOmPathDecl::EPathDeclEdgeIdenfier edge = CDOmPathDecl::PATH_DECL_NOEDGE;
	TBool range;
	RefCDOmMinTypMaxList mintypmaxList;
	CDOmPathDelayValue::EPathStyle pathDelayStyle = CDOmPathDelayValue::PATH_DELAY_WITHOUT_PAREN;
	RefCDOmExpr dataSourceExpr;
	RefCDOmExprLink exprLink1=RefCDOmExprLink(), exprLink2=RefCDOmExprLink(), exprLink3=RefCDOmExprLink();
	
#line 13354 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case SIMPLE_PATH_DECLARATION:
	{
		RefVerAST __t544 = _t;
		spd = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SIMPLE_PATH_DECLARATION);
		_t = _t->getFirstChild();
		exprLink3=specify_terminal_descriptor(_t);
		_t = _retTree;
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR)) {
				exprLink1=specify_terminal_descriptor(_t);
				_t = _retTree;
#line 2447 "verilog.walker.g"
				
				if( !specTermList1.get())
				specTermList1 = CDOmSpecifyTerminalList::build(spd->getLine(), exprLink3);
				specTermList1->addItem(exprLink1);
				
#line 13380 "VerilogTreeWalker.cpp"
			}
			else {
				goto _loop546;
			}
			
		}
		_loop546:;
		} // ( ... )*
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case POLARITY_OPERATOR:
		{
			polOp=polarity_operator(_t);
			_t = _retTree;
			break;
		}
		case PPATH:
		case FPATH:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case PPATH:
		{
			RefVerAST tmp166_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PPATH);
			_t = _t->getNextSibling();
#line 2455 "verilog.walker.g"
			range = true;
#line 13421 "VerilogTreeWalker.cpp"
			if (!( !specTermList1.get() ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !specTermList1.get() ");
			break;
		}
		case FPATH:
		{
			RefVerAST tmp167_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),FPATH);
			_t = _t->getNextSibling();
#line 2458 "verilog.walker.g"
			range = false;
			if( !specTermList1.get() )
			specTermList1 = CDOmSpecifyTerminalList::build(spd->getLine(), exprLink3);
			
#line 13436 "VerilogTreeWalker.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if (((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR))&&( !range )) {
			specTermList2=list_of_path_terminals(_t);
			_t = _retTree;
		}
		else if ((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR)) {
			exprLink2=specify_terminal_descriptor(_t);
			_t = _retTree;
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case LPAREN:
		{
			RefVerAST tmp168_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LPAREN);
			_t = _t->getNextSibling();
#line 2468 "verilog.walker.g"
			pathDelayStyle = CDOmPathDelayValue::PATH_DELAY_WITH_PAREN;
#line 13472 "VerilogTreeWalker.cpp"
			break;
		}
		case LIST_OF_PATH_DELAY_EXPRESSIONS:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		mintypmaxList=list_of_path_delay_expressions(_t);
		_t = _retTree;
		_t = __t544;
		_t = _t->getNextSibling();
#line 2472 "verilog.walker.g"
		
		if( modPathExpr.get() )
		pathType = CDOmPathDecl::PATH_DECL_SIMPLE_IF;
		else if( isIfNone )
		pathType = CDOmPathDecl::PATH_DECL_SIMPLE_IFNONE;
		else
		pathType = CDOmPathDecl::PATH_DECL_SIMPLE;
		if( range ) {
		CDOmPathDecl::build(spd->getLine(),  
		parent,
		pathType,
		exprLink3,
		exprLink2,
		CDOmPathDelayValue::build(spd->getLine(),  pathDelayStyle, mintypmaxList ),
		polOp,
		edge,
		RefCDOmExpr(), //data_source_expression
		modPathExpr
		);
		}
		else {
		CDOmPathDecl::build(spd->getLine(),  
		parent,
		pathType,
		specTermList1,
		specTermList2,
		CDOmPathDelayValue::build(spd->getLine(),  pathDelayStyle, mintypmaxList ),
		polOp,
		edge,
		RefCDOmExpr(), //data_source_expression
		modPathExpr
		);
		}
		
#line 13524 "VerilogTreeWalker.cpp"
		break;
	}
	case EDGE_SENSITIVE_PATH_DECLARATION:
	{
		RefVerAST __t551 = _t;
		espd = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EDGE_SENSITIVE_PATH_DECLARATION);
		_t = _t->getFirstChild();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case K_NEGEDGE:
		case K_POSEDGE:
		{
			edge=edge_identifier(_t);
			_t = _retTree;
			break;
		}
		case SPECIFY_TERMINAL_DESCRIPTOR:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		exprLink3=specify_terminal_descriptor(_t);
		_t = _retTree;
		{ // ( ... )*
		for (;;) {
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			if ((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR)) {
				exprLink1=specify_terminal_descriptor(_t);
				_t = _retTree;
#line 2510 "verilog.walker.g"
				
				if( !specTermList1.get())
				specTermList1 = CDOmSpecifyTerminalList::build(espd->getLine(), exprLink3);
				specTermList1->addItem(exprLink1);
				
#line 13569 "VerilogTreeWalker.cpp"
			}
			else {
				goto _loop554;
			}
			
		}
		_loop554:;
		} // ( ... )*
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case PPATH:
		{
			RefVerAST tmp169_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PPATH);
			_t = _t->getNextSibling();
#line 2517 "verilog.walker.g"
			range = true;
#line 13589 "VerilogTreeWalker.cpp"
			if (!( !specTermList1.get() ))
				throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !specTermList1.get() ");
			break;
		}
		case FPATH:
		{
			RefVerAST tmp170_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),FPATH);
			_t = _t->getNextSibling();
#line 2520 "verilog.walker.g"
			range = false;
			if( !specTermList1.get() )
			specTermList1 = CDOmSpecifyTerminalList::build(espd->getLine(), exprLink3);
			
#line 13604 "VerilogTreeWalker.cpp"
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if (((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR))&&( !range )) {
			specTermList2=list_of_path_terminals(_t);
			_t = _retTree;
		}
		else if ((_t->getType() == SPECIFY_TERMINAL_DESCRIPTOR)) {
			exprLink2=specify_terminal_descriptor(_t);
			_t = _retTree;
		}
		else {
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case POLARITY_OPERATOR:
		{
			polOp=polarity_operator(_t);
			_t = _retTree;
			break;
		}
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case EXPRESSION:
		case CONCATENATION:
		case MULTI_CONCATENATION:
		case EXPR_PRIMARY_IDENTIFIER:
		case FUNCTION_CALL:
		case SYSTEM_FUNCTION_CALL:
		case MINTYPMAX_EXPRESSION:
		case SIZED_NUMBER:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		dataSourceExpr=expression(_t);
		_t = _retTree;
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case LPAREN:
		{
			RefVerAST tmp171_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LPAREN);
			_t = _t->getNextSibling();
#line 2532 "verilog.walker.g"
			pathDelayStyle = CDOmPathDelayValue::PATH_DELAY_WITH_PAREN;
#line 13710 "VerilogTreeWalker.cpp"
			break;
		}
		case LIST_OF_PATH_DELAY_EXPRESSIONS:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		mintypmaxList=list_of_path_delay_expressions(_t);
		_t = _retTree;
		_t = __t551;
		_t = _t->getNextSibling();
		if (!( !isIfNone ))
			throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" !isIfNone ");
#line 2537 "verilog.walker.g"
		
		if( modPathExpr.get() )
		pathType = CDOmPathDecl::PATH_DECL_EDGE_IF;
		else
		pathType = CDOmPathDecl::PATH_DECL_EDGE;
		if( range )
		CDOmPathDecl::build(espd->getLine(),  
		parent,
		pathType,
		exprLink3,
		exprLink2,
		CDOmPathDelayValue::build(espd->getLine(),  pathDelayStyle, mintypmaxList ),
		polOp,
		edge,
		dataSourceExpr, //data_source_expression
		modPathExpr
		);
		else
		CDOmPathDecl::build(espd->getLine(),  
		parent,
		pathType,
		specTermList1,
		specTermList2,
		CDOmPathDelayValue::build(espd->getLine(),  pathDelayStyle, mintypmaxList ),
		polOp,
		edge,
		dataSourceExpr, //data_source_expression
		modPathExpr
		);
		
#line 13760 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

void VerilogTreeWalker::state_dependent_path_declaration(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST state_dependent_path_declaration_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2610 "verilog.walker.g"
	RefCDOmExpr expr;
#line 13777 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_IF:
	{
		RefVerAST __t571 = _t;
		RefVerAST tmp172_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_IF);
		_t = _t->getFirstChild();
		expr=expression(_t);
		_t = _retTree;
		simple_or_edge_sensitive_path_declaration(_t,parent, expr, false);
		_t = _retTree;
		_t = __t571;
		_t = _t->getNextSibling();
#line 2616 "verilog.walker.g"
		PRINT_AST(tmp172_AST_in);
#line 13796 "VerilogTreeWalker.cpp"
		break;
	}
	case K_IFNONE:
	{
		RefVerAST __t572 = _t;
		RefVerAST tmp173_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_IFNONE);
		_t = _t->getFirstChild();
		simple_or_edge_sensitive_path_declaration(_t,parent, RefCDOmExpr(), true);
		_t = _retTree;
		_t = __t572;
		_t = _t->getNextSibling();
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
}

RefCDOmExprLink  VerilogTreeWalker::specify_terminal_descriptor(RefVerAST _t) {
#line 2579 "verilog.walker.g"
	RefCDOmExprLink returnedExprLink;
#line 13822 "VerilogTreeWalker.cpp"
	RefVerAST specify_terminal_descriptor_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2579 "verilog.walker.g"
	
	pair<RefString, int> id;
	RefCDOmRangeExpr rangeExpr;
	
#line 13829 "VerilogTreeWalker.cpp"
	
	RefVerAST __t563 = _t;
	RefVerAST tmp174_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SPECIFY_TERMINAL_DESCRIPTOR);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
#line 2586 "verilog.walker.g"
	returnedExprLink = CDOmExprLink::build(id.second, id.first);
#line 13839 "VerilogTreeWalker.cpp"
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case RANGE_EXPRESSION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		rangeExpr=range_expression(_t);
		_t = _retTree;
#line 2588 "verilog.walker.g"
		returnedExprLink->setRangeExpr(rangeExpr);
#line 13899 "VerilogTreeWalker.cpp"
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t563;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returnedExprLink;
}

CDOmPathDecl::EPathDeclPolarityOp  VerilogTreeWalker::polarity_operator(RefVerAST _t) {
#line 2622 "verilog.walker.g"
	CDOmPathDecl::EPathDeclPolarityOp returned;
#line 13921 "VerilogTreeWalker.cpp"
	RefVerAST polarity_operator_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	RefVerAST __t574 = _t;
	RefVerAST tmp175_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),POLARITY_OPERATOR);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case PLUS:
	{
		RefVerAST tmp176_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PLUS);
		_t = _t->getNextSibling();
#line 2624 "verilog.walker.g"
		returned=CDOmPathDecl::PATH_DECL_PLUS;
#line 13939 "VerilogTreeWalker.cpp"
		break;
	}
	case MINUS:
	{
		RefVerAST tmp177_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MINUS);
		_t = _t->getNextSibling();
#line 2625 "verilog.walker.g"
		returned=CDOmPathDecl::PATH_DECL_MINUS;
#line 13949 "VerilogTreeWalker.cpp"
		break;
	}
	case PO_NEG:
	{
		RefVerAST tmp178_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_NEG);
		_t = _t->getNextSibling();
#line 2626 "verilog.walker.g"
		returned=CDOmPathDecl::PATH_DECL_MINUS;
#line 13959 "VerilogTreeWalker.cpp"
		break;
	}
	case PO_POS:
	{
		RefVerAST tmp179_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),PO_POS);
		_t = _t->getNextSibling();
#line 2627 "verilog.walker.g"
		returned=CDOmPathDecl::PATH_DECL_PLUS;
#line 13969 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t574;
	_t = _t->getNextSibling();
#line 2630 "verilog.walker.g"
	PRINT_AST(tmp175_AST_in);
#line 13982 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned;
}

RefCDOmMinTypMaxList  VerilogTreeWalker::list_of_path_delay_expressions(RefVerAST _t) {
#line 2594 "verilog.walker.g"
	RefCDOmMinTypMaxList returned;
#line 13990 "VerilogTreeWalker.cpp"
	RefVerAST list_of_path_delay_expressions_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST lopde = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2594 "verilog.walker.g"
	RefCDOmMinTypMax mintypmax;
#line 13995 "VerilogTreeWalker.cpp"
	
	RefVerAST __t566 = _t;
	lopde = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),LIST_OF_PATH_DELAY_EXPRESSIONS);
	_t = _t->getFirstChild();
	mintypmax=mintypmax_expression(_t);
	_t = _retTree;
#line 2598 "verilog.walker.g"
	returned = CDOmMinTypMaxList::build(lopde->getLine(), mintypmax);
#line 14005 "VerilogTreeWalker.cpp"
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == MINTYPMAX_EXPRESSION)) {
			mintypmax=mintypmax_expression(_t);
			_t = _retTree;
#line 2600 "verilog.walker.g"
			returned->addItem(mintypmax);
#line 14015 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop568;
		}
		
	}
	_loop568:;
	} // ( ... )*
	_t = __t566;
	_t = _t->getNextSibling();
	_retTree = _t;
	return returned;
}

CDOmPathDecl::EPathDeclEdgeIdenfier  VerilogTreeWalker::edge_identifier(RefVerAST _t) {
#line 2605 "verilog.walker.g"
	CDOmPathDecl::EPathDeclEdgeIdenfier returned;
#line 14033 "VerilogTreeWalker.cpp"
	RefVerAST edge_identifier_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_POSEDGE:
	{
		RefVerAST tmp180_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_POSEDGE);
		_t = _t->getNextSibling();
#line 2606 "verilog.walker.g"
		returned = CDOmPathDecl::PATH_DECL_POSEDGE;
#line 14046 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NEGEDGE:
	{
		RefVerAST tmp181_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NEGEDGE);
		_t = _t->getNextSibling();
#line 2607 "verilog.walker.g"
		returned = CDOmPathDecl::PATH_DECL_NEGEDGE;
#line 14056 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

void VerilogTreeWalker::setup_timing_check(RefVerAST _t,
	 RefCDOmSpecifyBlock parent 
) {
	RefVerAST setup_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kssetup = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2650 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 14080 "VerilogTreeWalker.cpp"
	
	RefVerAST __t578 = _t;
	kssetup = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_SETUP);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp182_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t578;
	_t = _t->getNextSibling();
#line 2667 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildSetup(kssetup->getLine(),  parent, ev1, ev2, expr, exprLink );
	
#line 14142 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::hold_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST hold_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kshold = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2674 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 14158 "VerilogTreeWalker.cpp"
	
	RefVerAST __t582 = _t;
	kshold = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_HOLD);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp183_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t582;
	_t = _t->getNextSibling();
#line 2689 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildHold(kshold->getLine(),  parent, ev1, ev2, expr, exprLink );
	
#line 14220 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::setuphold_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST setuphold_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2696 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr1, expr2; 
	RefCDOmMinTypMax expr3 = RefCDOmMinTypMax(), expr4 = RefCDOmMinTypMax();
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	RefCDOmDelayedDataOrReference delayedData1 = RefCDOmDelayedDataOrReference(), delayedData2 = RefCDOmDelayedDataOrReference();
	
#line 14238 "VerilogTreeWalker.cpp"
	
	RefVerAST __t586 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_SETUPHOLD);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr1=expression(_t);
	_t = _retTree;
	expr2=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp184_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COMMA:
		{
			RefVerAST tmp185_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
			_t = _t->getNextSibling();
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINTYPMAX_EXPRESSION:
			{
				expr3=mintypmax_expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case COMMA:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COMMA:
			{
				RefVerAST tmp186_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
				_t = _t->getNextSibling();
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINTYPMAX_EXPRESSION:
				{
					expr4=mintypmax_expression(_t);
					_t = _retTree;
					break;
				}
				case 3:
				case COMMA:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case COMMA:
				{
					RefVerAST tmp187_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
					_t = _t->getNextSibling();
					{
					if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case DELAYED_DATA_OR_REFERENCE:
					{
						delayedData1=delayed_data_or_reference(_t);
						_t = _retTree;
						break;
					}
					case 3:
					case COMMA:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
					{
					if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case COMMA:
					{
						RefVerAST tmp188_AST_in = _t;
						match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
						_t = _t->getNextSibling();
						{
						if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
							_t = ASTNULL;
						switch ( _t->getType()) {
						case DELAYED_DATA_OR_REFERENCE:
						{
							delayedData2=delayed_data_or_reference(_t);
							_t = _retTree;
							break;
						}
						case 3:
						{
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
						}
						}
						}
						break;
					}
					case 3:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
					break;
				}
				case 3:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t586;
	_t = _t->getNextSibling();
#line 2726 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildSetuphold(ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink, expr3, expr4, delayedData1, delayedData2 );
	
#line 14470 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::recovery_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST recovery_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2733 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 14486 "VerilogTreeWalker.cpp"
	
	RefVerAST __t598 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_RECOVERY);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp189_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t598;
	_t = _t->getNextSibling();
#line 2748 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildRecovery(ks->getLine(),  parent, ev1, ev2, expr, exprLink );
	
#line 14548 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::removal_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST removal_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2755 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 14564 "VerilogTreeWalker.cpp"
	
	RefVerAST __t602 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_REMOVAL);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp190_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t602;
	_t = _t->getNextSibling();
#line 2770 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildRemoval(ks->getLine(),  parent, ev1, ev2, expr, exprLink );
	
#line 14626 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::recrem_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST recrem_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2777 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr1, expr2;
	RefCDOmMinTypMax mintypmax1 = RefCDOmMinTypMax(), mintypmax2 = RefCDOmMinTypMax();
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	RefCDOmDelayedDataOrReference delayedData1 = RefCDOmDelayedDataOrReference(), delayedData2 = RefCDOmDelayedDataOrReference();
	
#line 14644 "VerilogTreeWalker.cpp"
	
	RefVerAST __t606 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_RECREM);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr1=expression(_t);
	_t = _retTree;
	expr2=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp191_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COMMA:
		{
			RefVerAST tmp192_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
			_t = _t->getNextSibling();
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case MINTYPMAX_EXPRESSION:
			{
				mintypmax1=mintypmax_expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case COMMA:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COMMA:
			{
				RefVerAST tmp193_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
				_t = _t->getNextSibling();
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINTYPMAX_EXPRESSION:
				{
					mintypmax2=mintypmax_expression(_t);
					_t = _retTree;
					break;
				}
				case 3:
				case COMMA:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case COMMA:
				{
					RefVerAST tmp194_AST_in = _t;
					match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
					_t = _t->getNextSibling();
					{
					if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case DELAYED_DATA_OR_REFERENCE:
					{
						delayedData1=delayed_data_or_reference(_t);
						_t = _retTree;
						break;
					}
					case 3:
					case COMMA:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
					{
					if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
						_t = ASTNULL;
					switch ( _t->getType()) {
					case COMMA:
					{
						RefVerAST tmp195_AST_in = _t;
						match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
						_t = _t->getNextSibling();
						{
						if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
							_t = ASTNULL;
						switch ( _t->getType()) {
						case DELAYED_DATA_OR_REFERENCE:
						{
							delayedData2=delayed_data_or_reference(_t);
							_t = _retTree;
							break;
						}
						case 3:
						{
							break;
						}
						default:
						{
							throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
						}
						}
						}
						break;
					}
					case 3:
					{
						break;
					}
					default:
					{
						throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
					}
					}
					}
					break;
				}
				case 3:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t606;
	_t = _t->getNextSibling();
#line 2802 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildRecrem(ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink, mintypmax1, mintypmax2, delayedData1, delayedData2 );
	
#line 14876 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::skew_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST skew_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2809 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 14892 "VerilogTreeWalker.cpp"
	
	RefVerAST __t618 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_SKEW);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp196_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t618;
	_t = _t->getNextSibling();
#line 2824 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildSkew(ks->getLine(),  parent, ev1, ev2, expr, exprLink);
	
#line 14954 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::timeskew_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST timeskew_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2831 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr1, expr2;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	RefCDOmMinTypMax mintypmax;
	
#line 14971 "VerilogTreeWalker.cpp"
	
	RefVerAST __t622 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_TIMESKEW);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr1=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp197_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COMMA:
		{
			RefVerAST tmp198_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
			_t = _t->getNextSibling();
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case EXPRESSION:
			case CONCATENATION:
			case MULTI_CONCATENATION:
			case EXPR_PRIMARY_IDENTIFIER:
			case FUNCTION_CALL:
			case SYSTEM_FUNCTION_CALL:
			case MINTYPMAX_EXPRESSION:
			case SIZED_NUMBER:
			{
				expr2=expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case COMMA:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COMMA:
			{
				RefVerAST tmp199_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
				_t = _t->getNextSibling();
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINTYPMAX_EXPRESSION:
				{
					mintypmax=mintypmax_expression(_t);
					_t = _retTree;
					break;
				}
				case 3:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t622;
	_t = _t->getNextSibling();
#line 2850 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildTimeskew(ks->getLine(),  parent, ev1, ev2, expr1, exprLink, expr2, mintypmax);
	
#line 15165 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::fullskew_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST fullskew_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2857 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmExpr expr1, expr2, expr3;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	RefCDOmMinTypMax mintypmax;
	
#line 15182 "VerilogTreeWalker.cpp"
	
	RefVerAST __t630 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_FULLSKEW);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr1=expression(_t);
	_t = _retTree;
	expr2=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp200_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COMMA:
		{
			RefVerAST tmp201_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
			_t = _t->getNextSibling();
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case EXPRESSION:
			case CONCATENATION:
			case MULTI_CONCATENATION:
			case EXPR_PRIMARY_IDENTIFIER:
			case FUNCTION_CALL:
			case SYSTEM_FUNCTION_CALL:
			case MINTYPMAX_EXPRESSION:
			case SIZED_NUMBER:
			{
				expr3=expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			case COMMA:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case COMMA:
			{
				RefVerAST tmp202_AST_in = _t;
				match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
				_t = _t->getNextSibling();
				{
				if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
					_t = ASTNULL;
				switch ( _t->getType()) {
				case MINTYPMAX_EXPRESSION:
				{
					mintypmax=mintypmax_expression(_t);
					_t = _retTree;
					break;
				}
				case 3:
				{
					break;
				}
				default:
				{
					throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
				}
				}
				}
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t630;
	_t = _t->getNextSibling();
#line 2877 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildFullskew(ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink, expr3, mintypmax);
	
#line 15378 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::period_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST period_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2884 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev;
	RefCDOmExpr expr;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 15394 "VerilogTreeWalker.cpp"
	
	RefVerAST __t638 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_PERIOD);
	_t = _t->getFirstChild();
	ev=controlled_timing_check_event(_t);
	_t = _retTree;
	expr=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp203_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t638;
	_t = _t->getNextSibling();
#line 2898 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildPeriod(ks->getLine(),  parent, ev, expr, exprLink );
	
#line 15454 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::width_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST width_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2905 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev;
	RefCDOmExpr expr1, expr2;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 15470 "VerilogTreeWalker.cpp"
	
	RefVerAST __t642 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_WIDTH);
	_t = _t->getFirstChild();
	ev=controlled_timing_check_event(_t);
	_t = _retTree;
	expr1=expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp204_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case UNSIGNED_NUMBER:
		case REAL_NUMBER:
		case BASED_NUMBER:
		case MINUS:
		case QUESTION:
		case PLUS:
		case LNOT:
		case NOT:
		case AND:
		case NAND:
		case OR:
		case NOR:
		case XOR:
		case XNOR:
		case STAR:
		case POW:
		case DIV:
		case MOD:
		case EQUAL:
		case NOT_EQ:
		case NOT_EQ_CASE:
		case EQ_CASE:
		case LAND:
		case LOR:
		case LT_:
		case LE:
		case GT:
		case GE:
		case SL:
		case SSL:
		case SR:
		case SSR:
		case STRING:
		case U_PLUS:
		case U_MINUS:
		case U_AND:
		case U_NAND:
		case U_OR:
		case U_NOR:
		case U_XOR:
		case U_XNOR:
		case EXPRESSION:
		case CONCATENATION:
		case MULTI_CONCATENATION:
		case EXPR_PRIMARY_IDENTIFIER:
		case FUNCTION_CALL:
		case SYSTEM_FUNCTION_CALL:
		case MINTYPMAX_EXPRESSION:
		case SIZED_NUMBER:
		{
			expr2=expression(_t);
			_t = _retTree;
			break;
		}
		case 3:
		case COMMA:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case COMMA:
		{
			RefVerAST tmp205_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
			_t = _t->getNextSibling();
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case IDENTIFIER:
			case ESCAPED_IDENTIFIER:
			{
				id=identifier(_t);
				_t = _retTree;
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t642;
	_t = _t->getNextSibling();
#line 2921 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildWidth(ks->getLine(),  parent, ev, expr1, expr2, exprLink );
	
#line 15620 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

void VerilogTreeWalker::nochange_timing_check(RefVerAST _t,
	RefCDOmSpecifyBlock parent
) {
	RefVerAST nochange_timing_check_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ks = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2928 "verilog.walker.g"
	
	RefCDOmTimingCheckEvent ev1, ev2;
	RefCDOmMinTypMax expr1, expr2;
	pair<RefString, int> id(RefString(), 0);
	RefCDOmExprLink exprLink = RefCDOmExprLink();
	
#line 15636 "VerilogTreeWalker.cpp"
	
	RefVerAST __t648 = _t;
	ks = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_S_NOCHANGE);
	_t = _t->getFirstChild();
	ev1=timing_check_event(_t);
	_t = _retTree;
	ev2=timing_check_event(_t);
	_t = _retTree;
	expr1=mintypmax_expression(_t);
	_t = _retTree;
	expr2=mintypmax_expression(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case COMMA:
	{
		RefVerAST tmp206_AST_in = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),COMMA);
		_t = _t->getNextSibling();
		{
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		switch ( _t->getType()) {
		case IDENTIFIER:
		case ESCAPED_IDENTIFIER:
		{
			id=identifier(_t);
			_t = _retTree;
			break;
		}
		case 3:
		{
			break;
		}
		default:
		{
			throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
		}
		}
		}
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t648;
	_t = _t->getNextSibling();
#line 2943 "verilog.walker.g"
	
	if( id.first.get())
	exprLink = CDOmExprLink::build(id.second, id.first);
	CDOmSystemTimingCheck::buildNochange(ks->getLine(),  parent, ev1, ev2, expr1, expr2, exprLink );
	
#line 15700 "VerilogTreeWalker.cpp"
	_retTree = _t;
}

RefCDOmTimingCheckEvent  VerilogTreeWalker::timing_check_event(RefVerAST _t) {
#line 2964 "verilog.walker.g"
	RefCDOmTimingCheckEvent returnedEvent;
#line 15707 "VerilogTreeWalker.cpp"
	RefVerAST timing_check_event_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST tce = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2964 "verilog.walker.g"
	
	RefCDOmTimingCheckEventControl timingCheckEventControl = RefCDOmTimingCheckEventControl();
	RefCDOmExpr expr = RefCDOmExpr();
	RefCDOmExprLink specTermDesc;
	
#line 15716 "VerilogTreeWalker.cpp"
	
	RefVerAST __t655 = _t;
	tce = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),TIMING_CHECK_EVENT);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_EDGE:
	case K_NEGEDGE:
	case K_POSEDGE:
	{
		timingCheckEventControl=timing_check_event_control(_t);
		_t = _retTree;
		break;
	}
	case SPECIFY_TERMINAL_DESCRIPTOR:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	specTermDesc=specify_terminal_descriptor(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t655;
	_t = _t->getNextSibling();
#line 2975 "verilog.walker.g"
	returnedEvent = CDOmTimingCheckEvent::build(tce->getLine(), specTermDesc, timingCheckEventControl, expr );
#line 15818 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedEvent;
}

RefCDOmDelayedDataOrReference  VerilogTreeWalker::delayed_data_or_reference(RefVerAST _t) {
#line 2951 "verilog.walker.g"
	RefCDOmDelayedDataOrReference returned;
#line 15826 "VerilogTreeWalker.cpp"
	RefVerAST delayed_data_or_reference_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 2951 "verilog.walker.g"
	
	pair<RefString, int> id;
	RefCDOmMinTypMax mintypmaxExpr = RefCDOmMinTypMax();
	
#line 15833 "VerilogTreeWalker.cpp"
	
	RefVerAST __t652 = _t;
	RefVerAST tmp207_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),DELAYED_DATA_OR_REFERENCE);
	_t = _t->getFirstChild();
	id=identifier(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case MINTYPMAX_EXPRESSION:
	{
		mintypmaxExpr=mintypmax_expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t652;
	_t = _t->getNextSibling();
#line 2960 "verilog.walker.g"
	returned = CDOmDelayedDataOrReference::build(id.second,  CDOmExprLink::build(id.second, id.first), mintypmaxExpr );
#line 15865 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned;
}

 RefCDOmTimingCheckEvent  VerilogTreeWalker::controlled_timing_check_event(RefVerAST _t) {
#line 2978 "verilog.walker.g"
	 RefCDOmTimingCheckEvent returnedEvent ;
#line 15873 "VerilogTreeWalker.cpp"
	RefVerAST controlled_timing_check_event_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST ctce = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2978 "verilog.walker.g"
	
	RefCDOmTimingCheckEventControl timingCheckEventControl;
	RefCDOmExpr expr = RefCDOmExpr();
	RefCDOmExprLink specTermDesc;
	
#line 15882 "VerilogTreeWalker.cpp"
	
	RefVerAST __t659 = _t;
	ctce = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CONTROLLED_TIMING_CHECK_EVENT);
	_t = _t->getFirstChild();
	timingCheckEventControl=timing_check_event_control(_t);
	_t = _retTree;
	specTermDesc=specify_terminal_descriptor(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case MINUS:
	case QUESTION:
	case PLUS:
	case LNOT:
	case NOT:
	case AND:
	case NAND:
	case OR:
	case NOR:
	case XOR:
	case XNOR:
	case STAR:
	case POW:
	case DIV:
	case MOD:
	case EQUAL:
	case NOT_EQ:
	case NOT_EQ_CASE:
	case EQ_CASE:
	case LAND:
	case LOR:
	case LT_:
	case LE:
	case GT:
	case GE:
	case SL:
	case SSL:
	case SR:
	case SSR:
	case STRING:
	case U_PLUS:
	case U_MINUS:
	case U_AND:
	case U_NAND:
	case U_OR:
	case U_NOR:
	case U_XOR:
	case U_XNOR:
	case EXPRESSION:
	case CONCATENATION:
	case MULTI_CONCATENATION:
	case EXPR_PRIMARY_IDENTIFIER:
	case FUNCTION_CALL:
	case SYSTEM_FUNCTION_CALL:
	case MINTYPMAX_EXPRESSION:
	case SIZED_NUMBER:
	{
		expr=expression(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	_t = __t659;
	_t = _t->getNextSibling();
#line 2989 "verilog.walker.g"
	returnedEvent = CDOmTimingCheckEvent::build(ctce->getLine(), specTermDesc, timingCheckEventControl, expr );
#line 15964 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedEvent ;
}

RefCDOmTimingCheckEventControl  VerilogTreeWalker::timing_check_event_control(RefVerAST _t) {
#line 2992 "verilog.walker.g"
	RefCDOmTimingCheckEventControl returned;
#line 15972 "VerilogTreeWalker.cpp"
	RefVerAST timing_check_event_control_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kpos = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST kneg = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case K_POSEDGE:
	{
		kpos = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_POSEDGE);
		_t = _t->getNextSibling();
#line 2993 "verilog.walker.g"
		returned = CDOmTimingCheckEventControl::buildPosedge(kpos->getLine());
#line 15987 "VerilogTreeWalker.cpp"
		break;
	}
	case K_NEGEDGE:
	{
		kneg = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_NEGEDGE);
		_t = _t->getNextSibling();
#line 2994 "verilog.walker.g"
		returned = CDOmTimingCheckEventControl::buildNegedge(kneg->getLine());
#line 15997 "VerilogTreeWalker.cpp"
		break;
	}
	case K_EDGE:
	{
		returned=edge_control_specifier(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returned;
}

RefCDOmTimingCheckEventControl  VerilogTreeWalker::edge_control_specifier(RefVerAST _t) {
#line 2998 "verilog.walker.g"
	RefCDOmTimingCheckEventControl returned;
#line 16018 "VerilogTreeWalker.cpp"
	RefVerAST edge_control_specifier_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST kedge = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 2998 "verilog.walker.g"
	
	CDOmTimingCheckEventControl::EEdgeDescriptor edgeDesc;
	
#line 16025 "VerilogTreeWalker.cpp"
	
	RefVerAST __t663 = _t;
	kedge = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),K_EDGE);
	_t = _t->getFirstChild();
#line 3003 "verilog.walker.g"
	returned = CDOmTimingCheckEventControl::buildEdge(kedge->getLine());
#line 16033 "VerilogTreeWalker.cpp"
	{ // ( ... )+
	int _cnt665=0;
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == UNSIGNED_NUMBER || _t->getType() == EDGE_DESC || _t->getType() == IDENTIFIER)) {
			edgeDesc=edge_descriptor(_t);
			_t = _retTree;
#line 3005 "verilog.walker.g"
			
			returned->addEdgeDescriptor(edgeDesc);
			
#line 16046 "VerilogTreeWalker.cpp"
		}
		else {
			if ( _cnt665>=1 ) { goto _loop665; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));}
		}
		
		_cnt665++;
	}
	_loop665:;
	}  // ( ... )+
	_t = __t663;
	_t = _t->getNextSibling();
#line 3010 "verilog.walker.g"
	PRINT_AST(K_EDGE);
#line 16060 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returned;
}

 CDOmTimingCheckEventControl::EEdgeDescriptor  VerilogTreeWalker::edge_descriptor(RefVerAST _t) {
#line 3013 "verilog.walker.g"
	 CDOmTimingCheckEventControl::EEdgeDescriptor returned ;
#line 16068 "VerilogTreeWalker.cpp"
	RefVerAST edge_descriptor_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST un = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST id = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST ed = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3013 "verilog.walker.g"
	
	string text;
	TBool valid = true;
	
#line 16078 "VerilogTreeWalker.cpp"
	
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	{
		un = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
		_t = _t->getNextSibling();
#line 3018 "verilog.walker.g"
		text = un->getText();
#line 16091 "VerilogTreeWalker.cpp"
		break;
	}
	case IDENTIFIER:
	{
		id = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),IDENTIFIER);
		_t = _t->getNextSibling();
#line 3019 "verilog.walker.g"
		text = id->getText();
#line 16101 "VerilogTreeWalker.cpp"
		break;
	}
	case EDGE_DESC:
	{
		ed = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),EDGE_DESC);
		_t = _t->getNextSibling();
#line 3020 "verilog.walker.g"
		text = ed->getText();
#line 16111 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	if (!( text.size() == 2 ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" text.size() == 2 ");
#line 3023 "verilog.walker.g"
	
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
	
#line 16213 "VerilogTreeWalker.cpp"
	if (!( valid ))
		throw ANTLR_USE_NAMESPACE(antlr)SemanticException(" valid ");
	_retTree = _t;
	return returned ;
}

RefCDOmExprConcat  VerilogTreeWalker::concatenation(RefVerAST _t) {
#line 3119 "verilog.walker.g"
	RefCDOmExprConcat returnedExpr;
#line 16223 "VerilogTreeWalker.cpp"
	RefVerAST concatenation_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST cnc = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3119 "verilog.walker.g"
	RefCDOmExpr expr;
#line 16228 "VerilogTreeWalker.cpp"
	
	RefVerAST __t669 = _t;
	cnc = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),CONCATENATION);
	_t = _t->getFirstChild();
	{
	expr=expression(_t);
	_t = _retTree;
#line 3122 "verilog.walker.g"
	returnedExpr = CDOmExprConcat::build(cnc->getLine(), expr);
#line 16239 "VerilogTreeWalker.cpp"
	}
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_tokenSet_9.member(_t->getType()))) {
			expr=expression(_t);
			_t = _retTree;
#line 3123 "verilog.walker.g"
			returnedExpr->addExpr(expr);
#line 16250 "VerilogTreeWalker.cpp"
		}
		else {
			goto _loop672;
		}
		
	}
	_loop672:;
	} // ( ... )*
	_t = __t669;
	_t = _t->getNextSibling();
#line 3125 "verilog.walker.g"
	PRINT_AST(CONCATENATION);
#line 16263 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedExpr;
}

RefCDOmExprMultiConcat  VerilogTreeWalker::multiple_concatenation(RefVerAST _t) {
#line 3128 "verilog.walker.g"
	RefCDOmExprMultiConcat returnedExpr;
#line 16271 "VerilogTreeWalker.cpp"
	RefVerAST multiple_concatenation_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST mc = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3128 "verilog.walker.g"
	
	RefCDOmExprConcat exprConcat;
	RefCDOmExpr expr;
	
#line 16279 "VerilogTreeWalker.cpp"
	
	RefVerAST __t674 = _t;
	mc = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),MULTI_CONCATENATION);
	_t = _t->getFirstChild();
	expr=expression(_t);
	_t = _retTree;
	exprConcat=concatenation(_t);
	_t = _retTree;
	_t = __t674;
	_t = _t->getNextSibling();
#line 3134 "verilog.walker.g"
	
	PRINT_AST(MULTI_CONCATENATION); 
	//expr should be constant
	returnedExpr = CDOmExprMultiConcat::build(mc->getLine(), expr, exprConcat);
	
#line 16297 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedExpr;
}

RefCDOmFunctionCall  VerilogTreeWalker::function_call(RefVerAST _t) {
#line 3142 "verilog.walker.g"
	RefCDOmFunctionCall returnedFunctionCall;
#line 16305 "VerilogTreeWalker.cpp"
	RefVerAST function_call_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST fc = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3142 "verilog.walker.g"
	
	RefCDOmExprLink exprLink;
	RefCDOmAttrListCollection attrListColl;
	RefCDOmListExpr exprList;
	
#line 16314 "VerilogTreeWalker.cpp"
	
	RefVerAST __t676 = _t;
	fc = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),FUNCTION_CALL);
	_t = _t->getFirstChild();
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case HIERARCHICAL_IDENTIFIER:
	{
		exprLink=hierarchical_identifier(_t);
		_t = _retTree;
		break;
	}
	case EXPR_PRIMARY_IDENTIFIER:
	{
		exprLink=expr_primary_identifier(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
	attrListColl=attrs_opt(_t);
	_t = _retTree;
	exprList=expression_list(_t);
	_t = _retTree;
#line 3152 "verilog.walker.g"
	returnedFunctionCall = CDOmFunctionCall::build(fc->getLine(),  exprLink, exprList, attrListColl );
#line 16348 "VerilogTreeWalker.cpp"
	_t = __t676;
	_t = _t->getNextSibling();
#line 3154 "verilog.walker.g"
	PRINT_AST(FUNCTION_CALL);
#line 16353 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedFunctionCall;
}

RefCDOmFunctionCall  VerilogTreeWalker::system_function_call(RefVerAST _t) {
#line 3157 "verilog.walker.g"
	RefCDOmFunctionCall returnedFunctionCall;
#line 16361 "VerilogTreeWalker.cpp"
	RefVerAST system_function_call_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST sfc = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3157 "verilog.walker.g"
	
	RefCDOmListExpr exprList = RefCDOmListExpr();
	RefString str;
	
#line 16369 "VerilogTreeWalker.cpp"
	
	RefVerAST __t679 = _t;
	sfc = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SYSTEM_FUNCTION_CALL);
	_t = _t->getFirstChild();
	str=system_function_name(_t);
	_t = _retTree;
	{
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case EXPRESSION_LIST:
	{
		exprList=expression_list(_t);
		_t = _retTree;
		break;
	}
	case 3:
	{
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	}
#line 3165 "verilog.walker.g"
	returnedFunctionCall = CDOmFunctionCall::build(sfc->getLine(),  CDOmExprLink::build(sfc->getLine(), str), exprList );
#line 16399 "VerilogTreeWalker.cpp"
	_t = __t679;
	_t = _t->getNextSibling();
#line 3167 "verilog.walker.g"
	PRINT_AST(SYSTEM_FUNCTION_CALL);
#line 16404 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedFunctionCall;
}

RefCDOmExpr  VerilogTreeWalker::expr_primary(RefVerAST _t) {
#line 3435 "verilog.walker.g"
	RefCDOmExpr expr;
#line 16412 "VerilogTreeWalker.cpp"
	RefVerAST expr_primary_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case UNSIGNED_NUMBER:
	case REAL_NUMBER:
	case BASED_NUMBER:
	case SIZED_NUMBER:
	{
		expr=expr_primary_number(_t);
		_t = _retTree;
		break;
	}
	case STRING:
	{
		expr=str(_t);
		_t = _retTree;
		break;
	}
	case EXPR_PRIMARY_IDENTIFIER:
	{
		expr=expr_primary_identifier(_t);
		_t = _retTree;
		break;
	}
	case CONCATENATION:
	{
		expr=concatenation(_t);
		_t = _retTree;
		break;
	}
	case MULTI_CONCATENATION:
	{
		expr=multiple_concatenation(_t);
		_t = _retTree;
		break;
	}
	case FUNCTION_CALL:
	{
		expr=function_call(_t);
		_t = _retTree;
		break;
	}
	case SYSTEM_FUNCTION_CALL:
	{
		expr=system_function_call(_t);
		_t = _retTree;
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return expr;
}

RefCDOmExpr  VerilogTreeWalker::expr_primary_number(RefVerAST _t) {
#line 3467 "verilog.walker.g"
	RefCDOmExpr expr;
#line 16475 "VerilogTreeWalker.cpp"
	RefVerAST expr_primary_number_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	
	expr=number(_t);
	_t = _retTree;
	_retTree = _t;
	return expr;
}

RefCDOmString  VerilogTreeWalker::str(RefVerAST _t) {
#line 3511 "verilog.walker.g"
	RefCDOmString retNumber;
#line 16487 "VerilogTreeWalker.cpp"
	RefVerAST str_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST str = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	str = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),STRING);
	_t = _t->getNextSibling();
#line 3513 "verilog.walker.g"
	retNumber = CDOmString::build(str->getLine(),  _RS(str->getText()), CCDOMAdapter::getInstance().getStringValue( _RS(str->getText() ) ) );
#line 16496 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return retNumber;
}

RefCDOmExpr  VerilogTreeWalker::number(RefVerAST _t) {
#line 3491 "verilog.walker.g"
	RefCDOmExpr returnedExpr;
#line 16504 "VerilogTreeWalker.cpp"
	RefVerAST number_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST unsignedNumber = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST basedNumber = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST realNumber = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
#line 3491 "verilog.walker.g"
	CCDOMAdapter adapter = CCDOMAdapter::getInstance();
#line 16511 "VerilogTreeWalker.cpp"
	
	if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
		_t = ASTNULL;
	switch ( _t->getType()) {
	case SIZED_NUMBER:
	{
		returnedExpr=sized_number(_t);
		_t = _retTree;
		break;
	}
	case UNSIGNED_NUMBER:
	{
		unsignedNumber = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
		_t = _t->getNextSibling();
#line 3495 "verilog.walker.g"
		returnedExpr = adapter.convertToCDOmNumberFrom_UNSIGNED_NUMBER(unsignedNumber->getLine(), unsignedNumber->getNumber());
#line 16529 "VerilogTreeWalker.cpp"
		break;
	}
	case BASED_NUMBER:
	{
		basedNumber = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BASED_NUMBER);
		_t = _t->getNextSibling();
#line 3497 "verilog.walker.g"
		returnedExpr = adapter.convertToCDOmNumberFrom_BASED_NUMBER(basedNumber->getLine(), basedNumber->getNumber());
#line 16539 "VerilogTreeWalker.cpp"
		break;
	}
	case REAL_NUMBER:
	{
		realNumber = _t;
		match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),REAL_NUMBER);
		_t = _t->getNextSibling();
#line 3499 "verilog.walker.g"
		returnedExpr = adapter.convertToCDOmRealFrom_REAL_NUMBER(realNumber->getLine(), realNumber->getNumber());
#line 16549 "VerilogTreeWalker.cpp"
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
	}
	}
	_retTree = _t;
	return returnedExpr;
}

RefCDOmNumber  VerilogTreeWalker::sized_number(RefVerAST _t) {
#line 3502 "verilog.walker.g"
	RefCDOmNumber returnedNumber;
#line 16564 "VerilogTreeWalker.cpp"
	RefVerAST sized_number_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	RefVerAST sn = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST un = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	RefVerAST bn = RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST);
	
	RefVerAST __t740 = _t;
	sn = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),SIZED_NUMBER);
	_t = _t->getFirstChild();
	un = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),UNSIGNED_NUMBER);
	_t = _t->getNextSibling();
	bn = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),BASED_NUMBER);
	_t = _t->getNextSibling();
	_t = __t740;
	_t = _t->getNextSibling();
#line 3507 "verilog.walker.g"
	returnedNumber = CCDOMAdapter::getInstance().convertToCDOmNumberFrom_sized_number(sn->getLine(), un->getNumber(), bn->getNumber());
#line 16584 "VerilogTreeWalker.cpp"
	_retTree = _t;
	return returnedNumber;
}

void VerilogTreeWalker::attribute_instance(RefVerAST _t,
	RefCDOmAttrList attrList
) {
	RefVerAST attribute_instance_AST_in = (_t == RefVerAST(ASTNULL)) ? RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) : _t;
#line 3526 "verilog.walker.g"
	
	pair<RefString, int> name;
	RefCDOmExpr expr;
	
#line 16598 "VerilogTreeWalker.cpp"
	
	RefVerAST __t746 = _t;
	RefVerAST tmp208_AST_in = _t;
	match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ATTRIBUTE_INSTANCE);
	_t = _t->getFirstChild();
	{ // ( ... )*
	for (;;) {
		if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
			_t = ASTNULL;
		if ((_t->getType() == ATTR_SPEC)) {
			RefVerAST __t748 = _t;
			RefVerAST tmp209_AST_in = _t;
			match(ANTLR_USE_NAMESPACE(antlr)RefAST(_t),ATTR_SPEC);
			_t = _t->getFirstChild();
			name=identifier(_t);
			_t = _retTree;
#line 3534 "verilog.walker.g"
			expr = RefCDOmExpr();
#line 16617 "VerilogTreeWalker.cpp"
			{
			if (_t == RefVerAST(ANTLR_USE_NAMESPACE(antlr)nullAST) )
				_t = ASTNULL;
			switch ( _t->getType()) {
			case UNSIGNED_NUMBER:
			case REAL_NUMBER:
			case BASED_NUMBER:
			case MINUS:
			case QUESTION:
			case PLUS:
			case LNOT:
			case NOT:
			case AND:
			case NAND:
			case OR:
			case NOR:
			case XOR:
			case XNOR:
			case STAR:
			case POW:
			case DIV:
			case MOD:
			case EQUAL:
			case NOT_EQ:
			case NOT_EQ_CASE:
			case EQ_CASE:
			case LAND:
			case LOR:
			case LT_:
			case LE:
			case GT:
			case GE:
			case SL:
			case SSL:
			case SR:
			case SSR:
			case STRING:
			case U_PLUS:
			case U_MINUS:
			case U_AND:
			case U_NAND:
			case U_OR:
			case U_NOR:
			case U_XOR:
			case U_XNOR:
			case EXPRESSION:
			case CONCATENATION:
			case MULTI_CONCATENATION:
			case EXPR_PRIMARY_IDENTIFIER:
			case FUNCTION_CALL:
			case SYSTEM_FUNCTION_CALL:
			case MINTYPMAX_EXPRESSION:
			case SIZED_NUMBER:
			{
				expr=expression(_t);
				_t = _retTree;
				break;
			}
			case 3:
			{
				break;
			}
			default:
			{
				throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(ANTLR_USE_NAMESPACE(antlr)RefAST(_t));
			}
			}
			}
#line 3536 "verilog.walker.g"
			attrList->addAttr(name.second, name.first, expr);
#line 16688 "VerilogTreeWalker.cpp"
			_t = __t748;
			_t = _t->getNextSibling();
		}
		else {
			goto _loop750;
		}
		
	}
	_loop750:;
	} // ( ... )*
	_t = __t746;
	_t = _t->getNextSibling();
	_retTree = _t;
}

void VerilogTreeWalker::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& )
{
}
const char* VerilogTreeWalker::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"\"always\"",
	"\"and\"",
	"\"assign\"",
	"\"automatic\"",
	"\"begin\"",
	"\"buf\"",
	"\"bufif0\"",
	"\"bufif1\"",
	"\"case\"",
	"\"casex\"",
	"\"casez\"",
	"\"cmos\"",
	"\"deassign\"",
	"\"default\"",
	"\"defparam\"",
	"\"disable\"",
	"\"edge\"",
	"\"else\"",
	"\"end\"",
	"\"endcase\"",
	"\"endfunction\"",
	"\"endgenerate\"",
	"\"endmodule\"",
	"\"endprimitive\"",
	"\"endspecify\"",
	"K_ENDTABLE",
	"\"endtask\"",
	"\"event\"",
	"\"for\"",
	"\"force\"",
	"\"forever\"",
	"\"fork\"",
	"\"function\"",
	"\"generate\"",
	"\"genvar\"",
	"\"highz0\"",
	"\"highz1\"",
	"\"if\"",
	"\"ifnone\"",
	"\"initial\"",
	"\"inout\"",
	"\"input\"",
	"\"integer\"",
	"\"join\"",
	"\"large\"",
	"\"localparam\"",
	"\"macromodule\"",
	"\"medium\"",
	"\"module\"",
	"\"nand\"",
	"\"negedge\"",
	"\"nmos\"",
	"\"nor\"",
	"\"noshowcancelled\"",
	"\"not\"",
	"\"notif0\"",
	"\"notif1\"",
	"\"or\"",
	"\"output\"",
	"\"parameter\"",
	"\"pmos\"",
	"\"posedge\"",
	"\"primitive\"",
	"\"pull0\"",
	"\"pull1\"",
	"\"pulldown\"",
	"\"pullup\"",
	"\"pulsestyle_ondetect\"",
	"\"pulsestyle_onevent\"",
	"\"rcmos\"",
	"\"real\"",
	"\"realtime\"",
	"\"reg\"",
	"\"release\"",
	"\"repeat\"",
	"\"rnmos\"",
	"\"rpmos\"",
	"\"rtran\"",
	"\"rtranif0\"",
	"\"rtranif1\"",
	"\"scalared\"",
	"\"showcancelled\"",
	"\"signed\"",
	"\"small\"",
	"\"specify\"",
	"\"specparam\"",
	"\"strong0\"",
	"\"strong1\"",
	"\"supply0\"",
	"\"supply1\"",
	"K_TABLE",
	"\"task\"",
	"\"time\"",
	"\"tran\"",
	"\"tranif0\"",
	"\"tranif1\"",
	"\"tri\"",
	"\"tri0\"",
	"\"tri1\"",
	"\"triand\"",
	"\"trior\"",
	"\"trireg\"",
	"\"vectored\"",
	"\"wait\"",
	"\"wand\"",
	"\"weak0\"",
	"\"weak1\"",
	"\"while\"",
	"\"wire\"",
	"\"wor\"",
	"\"xnor\"",
	"\"xor\"",
	"\"$setup\"",
	"\"$hold\"",
	"\"$setuphold\"",
	"\"$recovery\"",
	"\"$removal\"",
	"\"$recrem\"",
	"\"$skew\"",
	"\"$timeskew\"",
	"\"$fullskew\"",
	"\"$period\"",
	"\"$width\"",
	"\"$nochange\"",
	"\"$attribute\"",
	"PSTAR",
	"UNSIGNED_NUMBER",
	"REAL_NUMBER",
	"BASED_NUMBER",
	"PATHPULSE",
	"UDP_Q0",
	"UDP_Q1",
	"UDP_QX",
	"UDP_QQ",
	"UDP_01",
	"UDP_0X",
	"UDP_0Q",
	"UDP_10",
	"UDP_1X",
	"UDP_1Q",
	"UDP_BX",
	"UDP_X0",
	"UDP_X1",
	"UDP_XQ",
	"UDP_B",
	"UDP_F",
	"UDP_R",
	"UDP_X",
	"UDP_N",
	"UDP_P",
	"UDP_0",
	"UDP_1",
	"BACKTICK",
	"AT",
	"COLON",
	"COMMA",
	"DOT",
	"ASSIGN",
	"MINUS",
	"LBRACK",
	"RBRACK",
	"LCRULY",
	"RCRULY",
	"LPAREN",
	"RPAREN",
	"POUND",
	"QUESTION",
	"SEMI",
	"PLUS",
	"LNOT",
	"NOT",
	"AND",
	"NAND",
	"OR",
	"NOR",
	"XOR",
	"XNOR",
	"STAR",
	"POW",
	"DIV",
	"MOD",
	"EQUAL",
	"NOT_EQ",
	"NOT_EQ_CASE",
	"EQ_CASE",
	"LAND",
	"TAND",
	"LOR",
	"LT_",
	"LE",
	"GT",
	"GE",
	"SL",
	"SSL",
	"SR",
	"SSR",
	"TRIGGER",
	"PPATH",
	"FPATH",
	"STARP",
	"PO_POS",
	"PO_NEG",
	"SUPERSTAR",
	"EDGE_DESC",
	"W",
	"END_OF_LINE",
	"VOCAB",
	"ALPHA",
	"DIGIT",
	"NZ_DIGIT",
	"BIN_DIGIT",
	"OCT_DIGIT",
	"HEX_DIGIT",
	"XZ_DIGIT",
	"IDENTIFIER",
	"ESCAPED_IDENTIFIER",
	"STRING",
	"NZ_UNSIGNED_NUMBER",
	"REAL_NUMBER_EXP",
	"SIGN",
	"EXP",
	"XZ_NUMBER",
	"BIN_NUMBER",
	"OCT_NUMBER",
	"HEX_NUMBER",
	"NUMBER",
	"BASED_NUMBER_HEADER",
	"SYSTEM_TASK_NAME",
	"FILENAME",
	"LINE_NUMBER",
	"HASH_LINE",
	"DIRECTIVE",
	"WS",
	"SL_COMMENT",
	"ML_COMMENT",
	"MODULE_DEF",
	"MODULE_PARAMETER_PORT_LIST",
	"LIST_OF_PORT_DECLARATIONS",
	"OUTPUT_VARIABLE_TYPE",
	"RANGE",
	"LIST_OF_VARIABLE_PORT_IDENTIFIERS",
	"PORT_REFERENCE",
	"PORT_REFERENCE_CONCAT",
	"NAMED_PORT_EXPRESSION",
	"PORT",
	"PORT_EXPRESSION",
	"ATTRIBUTE_INSTANCE",
	"ATTR_SPEC",
	"DIMENSION",
	"VARIABLE_PORT_IDENTIFIER",
	"DEFPARAM_ASSIGNMENT",
	"PARAM_ASSIGNMENT",
	"U_PLUS",
	"U_MINUS",
	"U_AND",
	"U_NAND",
	"U_OR",
	"U_NOR",
	"U_XOR",
	"U_XNOR",
	"EXPRESSION",
	"EXPRESSION_LIST",
	"CONCATENATION",
	"MULTI_CONCATENATION",
	"RANGE_EXPRESSION",
	"EXPR_PRIMARY_IDENTIFIER",
	"FUNCTION_CALL",
	"SYSTEM_FUNCTION_CALL",
	"HIERARCHICAL_IDENTIFIER",
	"MINTYPMAX_EXPRESSION",
	"LIST_OF_NET_IDENTIFIERS",
	"LIST_OF_NET_DECL_ASSIGNMENTS",
	"DELAY",
	"DELAY_VALUE",
	"VARIABLE_TYPE",
	"NET_DECLARATION",
	"LVALUE",
	"ASSIGNMENT",
	"BLOCKING_OR_NONBLOCKING_ASSIGNMENT",
	"PAR_BLOCK",
	"SEQ_BLOCK",
	"DELAY_CONTROL",
	"EVENT_CONTROL",
	"EVENT_EXPRESSION_PRIMARY",
	"OR_EVENT_EXPRESSION",
	"CASE_STATEMENT",
	"CASE_ITEM",
	"LOOP_STATEMENT",
	"EVENT_TRIGGER",
	"SYSTEM_TASK_ENABLE",
	"TASK_ENABLE",
	"TASK_PORT_LIST",
	"FUNCTION_PORT_LIST",
	"GATE_INSTANTIATION",
	"CMOS_SWITCH_INSTANCE",
	"ENABLE_GATE_INSTANCE",
	"MOS_SWITCH_INSTANCE",
	"N_INPUT_GATE_INSTANCE",
	"N_OUTPUT_GATE_INSTANCE",
	"PASS_ENABLE_SWITCH_INSTANCE",
	"PASS_SWITCH_INSTANCE",
	"PULL_GATE_INSTANCE",
	"MODULE_OR_UDP_INSTANTIATION",
	"LIST_OF_PARAMETER_ASSIGNMENTS_OR_DELAY2",
	"NAMED_PARAMETER_ASSIGNMENT",
	"MODULE_INSTANCE",
	"ORDERED_PORT_CONNECTION",
	"NAMED_PORT_CONNECTION",
	"GENERATE_ITEM_OR_NULL",
	"GENVAR_CASE_ITEM",
	"GENVAR_ASSIGNMENT",
	"GENERATE_BLOCK",
	"EDGE_SENSITIVE_PATH_DECLARATION",
	"SIMPLE_PATH_DECLARATION",
	"SPECIFY_TERMINAL_DESCRIPTOR",
	"LIST_OF_PATH_DELAY_EXPRESSIONS",
	"DELAYED_DATA_OR_REFERENCE",
	"TIMING_CHECK_EVENT",
	"CONTROLLED_TIMING_CHECK_EVENT",
	"SIZED_NUMBER",
	"STATEMENT_OR_NULL",
	"POLARITY_OPERATOR",
	"UDP_PORT_LIST",
	"UDP_DECLARATION_PORT_LIST",
	"UDP_TABLE_SEQ_ENTRY",
	"UDP_TABLE_COMB_ENTRY",
	"INPUT_LIST",
	"PULSE_CONTROL_SPECPARAM",
	"MY_TOKEN",
	"TICK",
	0
};

const unsigned long VerilogTreeWalker::_tokenSet_0_data_[] = { 2147745872UL, 3221387376UL, 2197822464UL, 1UL, 0UL, 0UL, 0UL, 67108864UL, 8388608UL, 262656UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "always" "assign" "defparam" "event" "function" "generate" "genvar" 
// "initial" "inout" "input" "integer" "localparam" "output" "parameter" 
// "real" "realtime" "reg" "specify" "specparam" "task" "time" ATTRIBUTE_INSTANCE 
// NET_DECLARATION GATE_INSTANTIATION MODULE_OR_UDP_INSTANTIATION 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_0(_tokenSet_0_data_,20);
const unsigned long VerilogTreeWalker::_tokenSet_1_data_[] = { 0UL, 1073750016UL, 4096UL, 0UL, 0UL, 0UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "input" "output" "reg" ATTRIBUTE_INSTANCE 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_1(_tokenSet_1_data_,16);
const unsigned long VerilogTreeWalker::_tokenSet_2_data_[] = { 0UL, 1073754112UL, 0UL, 0UL, 0UL, 0UL, 0UL, 67108864UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "inout" "input" "output" ATTRIBUTE_INSTANCE 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_2(_tokenSet_2_data_,16);
const unsigned long VerilogTreeWalker::_tokenSet_3_data_[] = { 0UL, 33555968UL, 35651968UL, 4293918720UL, 0UL, 0UL, 0UL, 0UL, 0UL, 805306368UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "if" "ifnone" "noshowcancelled" "pulsestyle_ondetect" "pulsestyle_onevent" 
// "showcancelled" "specparam" "$setup" "$hold" "$setuphold" "$recovery" 
// "$removal" "$recrem" "$skew" "$timeskew" "$fullskew" "$period" "$width" 
// "$nochange" EDGE_SENSITIVE_PATH_DECLARATION SIMPLE_PATH_DECLARATION 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_3(_tokenSet_3_data_,20);
const unsigned long VerilogTreeWalker::_tokenSet_4_data_[] = { 2147749968UL, 19025UL, 2147490816UL, 1UL, 0UL, 0UL, 0UL, 67108864UL, 8388608UL, 134480384UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "always" "assign" "case" "defparam" "event" "for" "function" "genvar" 
// "if" "initial" "integer" "real" "realtime" "reg" "task" "time" ATTRIBUTE_INSTANCE 
// NET_DECLARATION GATE_INSTANTIATION MODULE_OR_UDP_INSTANTIATION GENERATE_BLOCK 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_4(_tokenSet_4_data_,20);
const unsigned long VerilogTreeWalker::_tokenSet_5_data_[] = { 2147483648UL, 3221385216UL, 7168UL, 1UL, 0UL, 0UL, 0UL, 67108864UL, 0UL, 0UL, 16UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "event" "inout" "input" "integer" "localparam" "output" "parameter" 
// "real" "realtime" "reg" "time" ATTRIBUTE_INSTANCE STATEMENT_OR_NULL 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_5(_tokenSet_5_data_,24);
const unsigned long VerilogTreeWalker::_tokenSet_6_data_[] = { 2148073536UL, 2147639810UL, 15360UL, 2049UL, 0UL, 0UL, 0UL, 67108864UL, 2080374784UL, 122UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "assign" "deassign" "disable" "event" "force" "if" "input" "integer" 
// "localparam" "parameter" "real" "realtime" "reg" "release" "time" "wait" 
// ATTRIBUTE_INSTANCE BLOCKING_OR_NONBLOCKING_ASSIGNMENT PAR_BLOCK SEQ_BLOCK 
// DELAY_CONTROL EVENT_CONTROL CASE_STATEMENT LOOP_STATEMENT EVENT_TRIGGER 
// SYSTEM_TASK_ENABLE TASK_ENABLE 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_6(_tokenSet_6_data_,20);
const unsigned long VerilogTreeWalker::_tokenSet_7_data_[] = { 2148073536UL, 2147631618UL, 15360UL, 2049UL, 0UL, 0UL, 0UL, 67108864UL, 2080374784UL, 122UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "assign" "deassign" "disable" "event" "force" "if" "integer" "localparam" 
// "parameter" "real" "realtime" "reg" "release" "time" "wait" ATTRIBUTE_INSTANCE 
// BLOCKING_OR_NONBLOCKING_ASSIGNMENT PAR_BLOCK SEQ_BLOCK DELAY_CONTROL 
// EVENT_CONTROL CASE_STATEMENT LOOP_STATEMENT EVENT_TRIGGER SYSTEM_TASK_ENABLE 
// TASK_ENABLE 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_7(_tokenSet_7_data_,20);
const unsigned long VerilogTreeWalker::_tokenSet_8_data_[] = { 0UL, 0UL, 0UL, 0UL, 28UL, 3221222404UL, 469762303UL, 0UL, 191999UL, 0UL, 8UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UNSIGNED_NUMBER REAL_NUMBER BASED_NUMBER MINUS QUESTION PLUS LNOT NOT 
// AND NAND OR NOR XOR XNOR STAR POW DIV MOD EQUAL NOT_EQ NOT_EQ_CASE EQ_CASE 
// LAND LOR LT_ LE GT GE SL SSL SR SSR IDENTIFIER ESCAPED_IDENTIFIER STRING 
// U_PLUS U_MINUS U_AND U_NAND U_OR U_NOR U_XOR U_XNOR EXPRESSION CONCATENATION 
// MULTI_CONCATENATION EXPR_PRIMARY_IDENTIFIER FUNCTION_CALL SYSTEM_FUNCTION_CALL 
// MINTYPMAX_EXPRESSION SIZED_NUMBER 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_8(_tokenSet_8_data_,24);
const unsigned long VerilogTreeWalker::_tokenSet_9_data_[] = { 0UL, 0UL, 0UL, 0UL, 28UL, 3221222404UL, 268435711UL, 0UL, 191999UL, 0UL, 8UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UNSIGNED_NUMBER REAL_NUMBER BASED_NUMBER MINUS QUESTION PLUS LNOT NOT 
// AND NAND OR NOR XOR XNOR STAR POW DIV MOD EQUAL NOT_EQ NOT_EQ_CASE EQ_CASE 
// LAND LOR LT_ LE GT GE SL SSL SR SSR STRING U_PLUS U_MINUS U_AND U_NAND 
// U_OR U_NOR U_XOR U_XNOR EXPRESSION CONCATENATION MULTI_CONCATENATION 
// EXPR_PRIMARY_IDENTIFIER FUNCTION_CALL SYSTEM_FUNCTION_CALL MINTYPMAX_EXPRESSION 
// SIZED_NUMBER 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_9(_tokenSet_9_data_,24);
const unsigned long VerilogTreeWalker::_tokenSet_10_data_[] = { 0UL, 0UL, 0UL, 0UL, 210763776UL, 1024UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// UDP_B UDP_X UDP_0 UDP_1 QUESTION 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_10(_tokenSet_10_data_,12);
const unsigned long VerilogTreeWalker::_tokenSet_11_data_[] = { 0UL, 4194304UL, 2UL, 0UL, 28UL, 3221222404UL, 268435711UL, 0UL, 191999UL, 0UL, 8UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL, 0UL };
// "negedge" "posedge" UNSIGNED_NUMBER REAL_NUMBER BASED_NUMBER MINUS QUESTION 
// PLUS LNOT NOT AND NAND OR NOR XOR XNOR STAR POW DIV MOD EQUAL NOT_EQ 
// NOT_EQ_CASE EQ_CASE LAND LOR LT_ LE GT GE SL SSL SR SSR STRING U_PLUS 
// U_MINUS U_AND U_NAND U_OR U_NOR U_XOR U_XNOR EXPRESSION CONCATENATION 
// MULTI_CONCATENATION EXPR_PRIMARY_IDENTIFIER FUNCTION_CALL SYSTEM_FUNCTION_CALL 
// MINTYPMAX_EXPRESSION SIZED_NUMBER 
const ANTLR_USE_NAMESPACE(antlr)BitSet VerilogTreeWalker::_tokenSet_11(_tokenSet_11_data_,24);


