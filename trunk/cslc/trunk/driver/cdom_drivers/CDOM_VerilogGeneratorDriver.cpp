#include "CDOM.h"
#include "CDOM_VerilogGenerator.h"

using namespace NSCdomVerilogGenerator;

int main(){
RefCDOmDesign design = CDOmDesign::build();
RefCDOmModuleDecl moduleDecl = design->buildModuleDecl(10,RefString(new std::string("modname")));
//RefCDOmPortItem portitA = CDOmPortItem::build(10, moduleDecl, PORT_ITEM_SIMPLE, RefString(new std::string("pa")));
RefCDOmPortItem portitA = moduleDecl->buildPortItem(10, CDOmPortItem::PORT_ITEM_SIMPLE, RefString(new std::string("pa")));
RefCDOmPortItem portitB = moduleDecl->buildPortItem(10, CDOmPortItem::PORT_ITEM_SIMPLE, RefString(new std::string("pb")));

/*RefCDOmPortDecl portB = CDOmPortDecl::buildVarPortDecl(10, moduleDecl, VAR_REG);
portB->addPort(10, RefString(new std::string("port_d")),RefCDOmExpr(0));
portB->addPort(10, RefString(new std::string("port_e")),RefCDOmExpr(0));

RefCDOmPortDecl portA = CDOmPortDecl::buildNetPortDecl(10, moduleDecl, PORT_INPUT, NET_WIRE);
portA->addPort(10, RefString(new std::string("port_a")),RefCDOmExpr(0));
portA->addPort(10, RefString(new std::string("port_b")),RefCDOmExpr(0));
portA->addPort(10, RefString(new std::string("port_c")),RefCDOmExpr(0));*/

RefCDOmModuleDecl moduleDecl1 = design->buildModuleDecl(10,RefString(new std::string("mod2")));
CVerilogGenerator *cvg = new CVerilogGenerator(std::string("out.bla"));
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
