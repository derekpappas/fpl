#include <iostream>
#include <iterator>
#include "CSLOM.h"
#include "CSLOM_Visitor.h"

#include "unit.h"
#include "gui_cslom_visitor.h"

#define TABBING 4

GuiCVisitorTraversal::GuiCVisitorTraversal() {
    tabbing = 0;
}

GuiCVisitorTraversal::~GuiCVisitorTraversal() { }

void GuiCVisitorTraversal::beforeTraversal(const NSCSLOm::RefCSLOmDesign& design) {
    cout << "CSLOmDesign" << endl;
    tabbing+=TABBING;
}

void GuiCVisitorTraversal::beforeTraversal(const NSCSLOm::RefCSLOmUnitDecl& unitDecl) {
    if ((*(unitDecl->getName())).find("*") == string::npos &&
        (*(unitDecl->getName())).find("default") == string::npos) {
        for (int i=0; i<tabbing; i++) cout << " ";
        cout << "CSLOmUnitDecl: " << *(unitDecl->getName()) << endl;

        UnitObjectRef pUnitObject = NULL;
        UnitObjectRef pParentObject = NULL;
        UnitObjectContainer::getInstance()->getObject(vectorParentNames, &pParentObject);
        pUnitObject = UnitObjectContainer::getInstance()->createObject(*(unitDecl->getName()), "", pParentObject);
    }
    tabbing+=TABBING;
}

void GuiCVisitorTraversal::beforeTraversal(const NSCSLOm::RefCSLOmUnitInstance& unitInst) {
    if ((*(unitInst->getName())).find("*") == string::npos &&
        (*(unitInst->getName())).find("default") == string::npos) {
        for (int i=0; i<tabbing; i++) cout << " ";
        cout << "CSLOmUnitInstance: " << *(unitInst->getName()) << endl;
    }
    tabbing+=TABBING;
}

void GuiCVisitorTraversal::beforeTraversal(const NSCSLOm::RefCSLOmInterface& interface) {
    if ((*(interface->getName())).find("*") == string::npos &&
        (*(interface->getName())).find("default") == string::npos) {
        for (int i=0; i<tabbing; i++) cout << " ";
        cout << "CSLOmInterface: " << *(interface->getName()) << endl;
    }
    tabbing+=TABBING;
}

void GuiCVisitorTraversal::beforeTraversal(const NSCSLOm::RefCSLOmPortDecl& portDecl) {
    for (int i=0; i<tabbing; i++) cout << " ";
    cout << "CSLOmPortDecl: " << *(portDecl->getName()) << endl;
    tabbing+=TABBING;
}

void GuiCVisitorTraversal::afterTraversal(const NSCSLOm::RefCSLOmDesign& design) {
    tabbing-=TABBING;
}

void GuiCVisitorTraversal::afterTraversal(const NSCSLOm::RefCSLOmUnitDecl& unitDecl) {
    tabbing-=TABBING;
}

void GuiCVisitorTraversal::afterTraversal(const NSCSLOm::RefCSLOmUnitInstance& unitInst) {
    tabbing-=TABBING;
}

void GuiCVisitorTraversal::afterTraversal(const NSCSLOm::RefCSLOmInterface& interface) {
    tabbing-=TABBING;
}

void GuiCVisitorTraversal::afterTraversal(const NSCSLOm::RefCSLOmPortDecl& portDecl) {
    tabbing-=TABBING;
}

