#include "CDOM.h"
#include "CDOM_SystemCGenerator.h"

using namespace NSCdomSystemCGenerator;

int main(){
RefCDOmDesign design = CDOmDesign::build();
RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("modname")));
//RefCDOmPortItem portitA = CDOmPortItem::build(10, moduleDecl, PORT_ITEM_SIMPLE, RefString(new std::string("pa")));
RefCDOmPortDecl portitA = CDOmPortDecl::buildNetPortDecl(10, moduleDecl, PORT_INPUT);
portitA->addPort(10, RefString(new std::string("a")));
RefCDOmPortDecl portitB = CDOmPortDecl::buildNetPortDecl(10, moduleDecl, PORT_INPUT);
portitB->addPort(10, RefString(new std::string("b")));

RefCDOmPortDecl portitC = CDOmPortDecl::buildNetPortDecl(10, moduleDecl, PORT_OUTPUT);
portitC->addPort(10, RefString(new std::string("c")));

RefCDOmExprLink op_c = CDOmExprLink::build(10, RefString(new std::string("c")));
RefCDOmExprLink op_a = CDOmExprLink::build(10, RefString(new std::string("a")));
RefCDOmExprLink op_b = CDOmExprLink::build(10, RefString(new std::string("b")));
RefCDOmExprOp plus = CDOmExprOp::build(10, CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS, op_a, op_b);
RefCDOmAssn assn = CDOmAssn::build(10, op_c, plus);
RefCDOmContAssn cassn = CDOmContAssn::build(11, moduleDecl);
cassn->addNetAssn(assn);
//RefCDOmStmtAssn assn_stmt = CDOmStmtAssn::buildSimple(10, CDOmStmtAssn::ASSN_NON_BLOCKING, op_c, plus);
//RefCDOmInitOrAlways initOrAlw = CDOmInitOrAlways::build(10, moduleDecl, CDOmInitOrAlways::INIT_OR_ALWAYS_INIT, assn_stmt);
/*RefCDOmPortDecl portB = CDOmPortDecl::buildVarPortDecl(10, moduleDecl, VAR_REG);
portB->addPort(10, RefString(new std::string("port_d")),RefCDOmExpr(0));
portB->addPort(10, RefString(new std::string("port_e")),RefCDOmExpr(0));

RefCDOmPortDecl portA = CDOmPortDecl::buildNetPortDecl(10, moduleDecl, PORT_INPUT, NET_WIRE);
portA->addPort(10, RefString(new std::string("port_a")),RefCDOmExpr(0));
portA->addPort(10, RefString(new std::string("port_b")),RefCDOmExpr(0));
portA->addPort(10, RefString(new std::string("port_c")),RefCDOmExpr(0));*/

RefCDOmModuleDecl moduleDecl1 = design->buildModuleDecl(10,RefString(new std::string("mod2")));
CSystemCGenerator *cvg = new CSystemCGenerator(std::string("out.sc"));
cvg->enableObjTraversal();
cvg->enableObjBeforeTraversal();
cvg->enableObjAfterTraversal();
//cvg->beforeTraversal(design);
//cvg->inTraversal(design);
//cvg->afterTraversal(design);
design->acceptVisitor(*cvg);
delete cvg;
return 0;
}
