#include "designGen.h"

// FIX - write the output to $WORK/test/csl_design_gen

string randString(string name) {
  string randStr = name;

  randStr += rand() % ('9' - '0') + '0';
  randStr += rand() % ('9' - '0') + '0';

  return randStr;
}

unsigned int randNumber() {
  unsigned int randNum = rand() % 3;

  return randNum;
}

unsigned int randNumber(unsigned int n) {
  unsigned int randNum = rand() % n;

  return randNum;
}

////////////////////////////////////////////////////////////////////////////////
// print out the tree of units and instances
////////////////////////////////////////////////////////////////////////////////

void CSLunit::printTree(int lev) {
  for (int i =0; i < lev; i++) {
    cout <<"|";
  }
  cout << *m_unitName <<endl;
  if (m_instances) {
    vector<CSLinstance*>::iterator it = m_instances->begin();
    for (; it< m_instances->end(); ++it) {
      (*it)->getUnit()->printTree(lev+1);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
// Create a new CSLunit
// the unit is added to the unitVector which is a list of units in the design
// the unit is added to the unitMap which is a map of units in the design
////////////////////////////////////////////////////////////////////////////////

CSLunit::CSLunit(DesignGen* dg, string *unitName , EUnitType type ) : m_instances(0), m_final(false), m_isPrinted(false) , m_pageIsPrinted(false), m_type(type) {
  assert(unitName); 
  m_unitName = unitName; 
  m_parentUnitNameMap[*unitName] = true; // add the current unit name to the map which is used to check for cycles

  m_uniqueInstanceNameMap = new map<string, bool>();

  dg->addToUnitVector(this);
  dg->addToUnitMap(this);

  cout << "CSLunit m_unitName = " << *m_unitName << endl;
}

void DesignGen::addToUnitVector(CSLunit* unit) {
  m_unitVector.push_back(unit);
}


////////////////////////////////////////////////////////////////////////////////
// add a unit name to the list of units in the design
// used to make sure that a unit is only created once in the design
// the unit names are generated at the start of the program
////////////////////////////////////////////////////////////////////////////////

void DesignGen::addToUnitMap(CSLunit* unit) {
  string s = unit->getUnitName();;
  map< string, CSLunit* >::iterator i = m_mapUnitNamePtr.find(s);
  if ( i == m_mapUnitNamePtr.end() ) {
    m_mapUnitNamePtr[unit->getUnitName()] = unit;
  }
}

CSLunit::~CSLunit() {
  if (m_instances) {
    vector<CSLinstance*>::iterator it = m_instances->begin();
    for (; it< m_instances->end(); ++it) {
      delete *it;
    }
    delete m_instances;
  }
  delete m_unitName;
  delete m_uniqueInstanceNameMap;
}

////////////////////////////////////////////////////////////////////////////////
// add an instance to a unit
////////////////////////////////////////////////////////////////////////////////

void CSLunit::addInstance(CSLinstance* instance) {
  string instName = instance->getInstanceName();
  cout << "addInstance instanceNameExists instName = " << instName << " instName  = " << instName << " unit ptr =  "<< instance->getUnit() << " instance ptr =  "<< instance<<  endl;
  m_instances->push_back(instance);
  (*m_uniqueInstanceNameMap)[instName] = true;
}

////////////////////////////////////////////////////////////////////////////////
// check if the if the parent unit name exists
// if not the unit cannot be instantiated in the current scope
////////////////////////////////////////////////////////////////////////////////

bool CSLunit::parentUnitNameExists(string unitName) {
  bool exists = false;

  if (! m_parentUnitNameMap.empty()) {
    map< string, bool >::iterator i = m_parentUnitNameMap.find( unitName );
    if ( i != m_parentUnitNameMap.end() ) {
      exists = true;
      cout << "parentUnitNameExists = " << (*i).first << endl;
    }
  }
  return exists;

}

/////////////////////////////////////////////////////////////////////////////////
// each unit needs to know all the ancestors of all instantiations of the unit
// other wise the unit can be instantiated in a design cycle and cause a cslc
// compiler error
////////////////////////////////////////////////////////////////////////////////
 
void CSLunit::addParentUnitName   (string unitName) {
  if (! parentUnitNameExists(unitName)) {
    m_parentUnitNameMap[unitName] = true;
  }     
  cout << "\nm_parentUnitNameMap.size " << m_parentUnitNameMap.size() << " MAX_LEVEL " <<  MAX_LEVEL << endl;

  printParentUnitMap();

}

////////////////////////////////////////////////////////////////////////////////
// print out the CSL code representing the tree of units and instances
////////////////////////////////////////////////////////////////////////////////

void CSLunit::printBegin(ofstream &out) {
  assert(m_unitName != 0);
  switch (m_type) {
    case T_UNIT:  out  << endl << endl << "csl_unit " << *m_unitName << " {" << endl; break;
    case T_RF:  out  << endl << endl << "csl_register_file " << *m_unitName << " {" << endl; break;
    default: assert(0);
  }

  //  assert(m_instances);
  if (m_instances) {
    vector<CSLinstance*>::const_iterator iti = m_instances->begin();
    for (;  iti != m_instances->end(); iti++) {
      out << "  " << (*iti)->getUnit()->getUnitName() << " " << (*iti)->getInstanceName() << ";" << endl;
    }
  }
}

void CSLunit::printMiddleBegin(ofstream &out) {
  out << "\n  " << *m_unitName << "() {" << endl;
}

void CSLunit::printMiddleEnd(ofstream &out) {
  out << "  }" << endl;
}

void CSLunit::printEnd(ofstream &out) {
  out << "};" << endl;
}

void CSLunit::print(ofstream &out) {
  if (m_isPrinted) {
    return;
  }  
  else {

    printBegin      (out);
    printMiddleBegin(out);
    printMiddleEnd  (out);
    printEnd        (out);

    m_isPrinted = true;
    if (!m_instances) { return; }
  }

}

////////////////////////////////////////////////////////////////////////////////
// print out the CSL code representing the tree of pages
////////////////////////////////////////////////////////////////////////////////

void CSLunit::printPageBegin(ofstream &out) {
  assert(m_unitName != 0);
  switch (m_type) {
    case T_UNIT:  out  << endl << endl << "csl_memory_map_page mmp_" << *m_unitName << " {" << endl; break;
    default: assert(0);
  }

  //  assert(m_instances);
  m_pageWidth = 0;
  if (m_instances) {
    vector<CSLinstance*>::const_iterator iti = m_instances->begin();
    for (;  iti != m_instances->end(); iti++) {
      switch((*iti)->getUnit()->m_type) {
        case T_UNIT : out << "  mmp_" << (*iti)->getUnit()->getUnitName() << " " << (*iti)->getInstanceName() << ";" << endl; break;
        case T_RF : m_pageWidth += ((CSLrf*)((*iti)->getUnit()))->getDepth(); break;
        default: assert(0);
      }
    }
  }
}

void CSLunit::printPageMiddleBegin(ofstream &out) {
  out << "\n  mmp_" << *m_unitName << "() {" << endl;

  out << "    set_unit( "<< *m_unitName <<");" << endl;
  if(m_pageWidth > 0) {
    out << "    add_address_range(0, "<< m_pageWidth - 1 <<");" << endl;
  }

  if (m_instances) {
    vector<CSLinstance*>::const_iterator iti = m_instances->begin();
    for (;  iti != m_instances->end(); iti++) {
      switch((*iti)->getUnit()->m_type) {
        case T_UNIT : break;
        case T_RF :   out << "    add("/*<<*m_unitName<<"."*/ << (*iti)->getInstanceName() <<", \"SYM_"<< (*iti)->getInstanceName() << "\");" << endl; break;
        default: assert(0);
      }
    }
  }
}

void CSLunit::printPageMiddleEnd(ofstream &out) {
  out << "  }" << endl;
}

void CSLunit::printPageEnd(ofstream &out) {
  out << "};" << endl;
}

void CSLunit::printPage(ofstream &out) {
  if (m_pageIsPrinted) {
    return;
  }  
  else {

    printPageBegin      (out);
    printPageMiddleBegin(out);
    printPageMiddleEnd  (out);
    printPageEnd        (out);

    m_pageIsPrinted = true;
    if (!m_instances) { return; }
  }

}

////////////////////////////////////////////////////////////////////////////////
// print out the tree of units and instances
////////////////////////////////////////////////////////////////////////////////

void CSLrf::print(ofstream &out) {
  CSLunit::printBegin      (out);
  CSLunit::printMiddleBegin(out);
  out << "    set_width(" << m_width << ");" << endl;
  out << "    set_depth(" << m_depth << ");" << endl;
  CSLunit::printMiddleEnd  (out);
  CSLunit::printEnd        (out);
}

////////////////////////////////////////////////////////////////////////////////
// check if the isntance name exists in the current unit
// there can only be one instance of an instance name in a unit
////////////////////////////////////////////////////////////////////////////////

bool CSLunit::instanceNameExists(string instName) {
  bool exists = true;

  map< string, bool >::iterator i = m_uniqueInstanceNameMap->find( instName );
  if ( i == m_uniqueInstanceNameMap->end() ) {
    exists = false;
  }

  return exists;
}

CSLinstance::CSLinstance(DesignGen* dg, CSLunit* parentUnit, CSLunit* u) 
  : m_unit(u) {
  string s = m_unit->getUnitName();
  m_instanceName = 0;
  while (!m_instanceName) {
    s += "_inst_";
    string instanceName = randString(s);

    if (! parentUnit->instanceNameExists(instanceName)) {
      m_instanceName = new string(instanceName);
    }
  }
  parentUnit->addInstance(this);
}

CSLinstance::~CSLinstance() {
  delete m_instanceName;
}

bool DesignGen::unitNameIsValid(string unitName, vector<CSLunit*> uVector) {
  vector<CSLunit*>::const_iterator it = uVector.begin();
  for (; it != uVector.end(); it++) {
    if ( (*it)->getUnitName() == unitName)
      return false;
  }
  return true;
}

void CSLunit::printUniqueInstanceNameMap() {
  map< string, bool >::iterator it = m_uniqueInstanceNameMap->begin();
  for (; it != m_uniqueInstanceNameMap->end(); ++it) {
    cout << " uniqueInstanceNameMap name = " << (*it).first<< endl;
  }
}

void CSLunit::printParentUnitMap() {
  cout << endl << endl;
  map< string, bool >::iterator it = m_parentUnitNameMap.begin();
  for (; it != m_parentUnitNameMap.end(); ++it) {
    cout << "parentUnitNameMap name = " << (*it).first<< endl;
  }
}

////////////////////////////////////////////////////////////////////////////////
// copy the unit name list
// remove the unit names that are in the parent list (do not instantiate a unit that is already in the parent list)
// select one of the unit names in the remaining list 
// if the unit exists then return a pointer to the existing unit
// else create it and return a pointer to it
// IMPORTANT THE number of units has to be greater than the depth otherwise the 
// getRandomUnit logic will get stuck in an infinite loop at the bottom of the tree
// 1. it is ok for the immediate parent to be the parent of more than one instance of the same unit 
// the new unit must not have a previous instantiation which conflicts with the current instantiation
// and the current parent path must not have any cycles involving the randomly selected unit
// and the instance can't be the same as the parent
////////////////////////////////////////////////////////////////////////////////

CSLunit* DesignGen::getRandomUnit(CSLunit* parentUnit, vector<string> &m_parentList) {

  cout << "getRandomUnit begin" << endl;
  CSLunit* unitPtr = 0;

  string randUnitName = "";                

  vector<string*> uniqueUnitNameListCopy = m_uniqueUnitNameList;
  while (1) {
    unsigned int n = randNumber(uniqueUnitNameListCopy.size());
    randUnitName = *m_uniqueUnitNameList[n];

    bool ok = true;

    if (parentUnit->getUnitName() != randUnitName) { // the instance can't be the same as the parent
      for(int p = 0; p < m_parentList.size(); p++) {
        cout << "*** getRandomUnit parent[" << p << "] = " << m_parentList[p] << " \tchild unit = " << randUnitName  << endl;
        if (m_parentList[p] == randUnitName) { // there is a cycle in the current path
          ok == false;
          cout << "getRandomUnit CONFLICT selected unit = " << randUnitName << " parent unit = " << m_parentList[p] << endl;
        }
      }

      cout << "*** getRandomUnit ok = " << ok << endl;

      if (ok){
        if (! parentUnit->parentUnitNameExists(randUnitName)) { // ancestor unit names can't be in the current unit's instance list
          cout << "getRandomUnit selected unit = " << randUnitName << endl;
          break;
        }
      }
    }
  }

  // if the unit exists then return a pointer to the existing unit

  map< string, CSLunit* >::iterator i = m_mapUnitNamePtr.find( randUnitName );
  if ( i != m_mapUnitNamePtr.end() ) {
    unitPtr = (*i).second;
    cout << "getRandomUnit found unit pointer " << randUnitName << " randUnitName exists unit name = " << unitPtr->getUnitName() << endl;
  }
  else {// else create it and return a pointer to it
    string* unitName = new string(randUnitName);
    int unitType = randNumber(2);
    switch(unitType) {
      case T_UNIT: unitPtr = new CSLunit(this, unitName);  break;// ad the list of parents of the unit that can't be instantiated in the unit
      case T_RF: unitPtr = new CSLrf(this, unitName); ((CSLrf*)unitPtr)->setWidth(32); ((CSLrf*)unitPtr)->setDepth(64); break;
      default : assert(0);
    };
    
    cout << "getRandomUnit created randUnitName " << randUnitName << endl;
  }

  unitPtr->addParentUnitName (randUnitName); // always add the parent to the random unit

  assert(unitPtr);

  return unitPtr;
}

////////////////////////////////////////////////////////////////////////////////
// build the tree of units and instances
// create a new unit
// create a random number of instances in that unit
// traverse into each instance if the unit does not already contain instances
////////////////////////////////////////////////////////////////////////////////

void DesignGen::buildInstanceTree(int level, CSLunit* parentUnit) {
  if (parentUnit->m_type == T_UNIT) {
    unsigned int numChildren = randNumber()+2; 

    cout << "buildInstanceTree begin" << " level = " << level << " numChildren = " << numChildren << endl;

    if ((level <  MAX_LEVEL) && (MAX_INSTANCES > numChildren) && (numChildren > 0) ) { // do not go below the max number of levels

      if ((numChildren > 0) && (! parentUnit->m_instances)) {
        parentUnit->m_instances = new vector<CSLinstance*>();
      }
      m_parentList.push_back(parentUnit->getUnitName());

      for(int i = 0; i < numChildren; i++ ) { // add random instances
        if (parentUnit->m_instances) {

          CSLunit* unit = getRandomUnit(parentUnit, m_parentList);
          assert(unit);
          for(int p = 0; p < m_parentList.size(); p++) { // we now create the parent list for each unit  which prevents design cycles
            unit->addParentUnitName(m_parentList[p]); // add the parents of the current unit to the current unit's parent list
          }

          if (!(unit->getFinal())) { // unit already created 
            unit->setFinal(); // only create the instances for a unit once
            buildInstanceTree(level+1, unit);
          }
          CSLinstance* instance = new CSLinstance(this, parentUnit, unit);
        }
      }

      m_parentList.pop_back();
    }
    cout << "buildInstanceTree end" << " level = " << level << endl;
  }
} 

////////////////////////////////////////////////////////////////////////////////
// create the list of unit names to use in the creation of units randomly
////////////////////////////////////////////////////////////////////////////////

DesignGen::DesignGen() {
  for(int i = 0; i < MAX_UNITS; i++ ) {
    while (1) {
      string randUnitName = string( randString("unit_"));
      string* unitName = 0;
      map< string, bool >::iterator i = m_uniqueUnitNameMap.find( randUnitName );
      if ( i == m_uniqueUnitNameMap.end() ) {
        unitName = new string(randUnitName);
        m_uniqueUnitNameList.push_back(unitName);
        m_uniqueUnitNameMap[*unitName] = true;
        break;
      }
    }
  }

  for(int i = 0; i < MAX_UNITS; i++ ) {
    cout << "uniqueUnitNameList = " << *m_uniqueUnitNameList[i] << endl;
  }

}

DesignGen::~DesignGen() {
  vector<CSLunit*>::iterator it = m_unitVector.begin();
  for (; it < m_unitVector.end(); ++it) {
    delete *it;
  }
  vector<string*>::iterator it1 = m_uniqueUnitNameList.begin();
  for (; it1 < m_uniqueUnitNameList.end(); ++it1) {
    delete *it1;
  }
}

////////////////////////////////////////////////////////////////////////////////
// print the CSL code for each unit out to stdout
////////////////////////////////////////////////////////////////////////////////

void DesignGen::printCslCode(ofstream &out) {
  vector<CSLunit*>::reverse_iterator iti = m_unitVector.rbegin();

  // predeclare all units
  for (;  iti != m_unitVector.rend(); iti++) {
    switch ((*iti)->m_type) {
      case T_UNIT:     out << "csl_unit " << (*iti)->getUnitName()<<";" << endl;           
                       out << "csl_memory_map_page mmp_" << (*iti)->getUnitName()<<";" << endl;           break;
      case T_RF:       out << "csl_register_file " << (*iti)->getUnitName()<<";" << endl;  break;
      default: assert(0);
    }
  }

  // print out each unit
  iti = m_unitVector.rbegin();
  for (;  iti != m_unitVector.rend(); iti++) {
    (*iti)->print(out);
  }

  iti = m_unitVector.rbegin();
  for (;  iti != m_unitVector.rend(); iti++) {
    if ((*iti)->m_type == T_UNIT) {
      (*iti)->printPage(out);
    }
  }
  
  printHierMemMap(out);
}

void DesignGen::printHierMemMap(ofstream& out) {
  out << "\ncsl_memory_map mem_map { \n";
  out << "  mem_map() { \n";
  out << "    set_type(hierarchical); \n";
  out << "  } \n";
  out << "} \n";
}

int main() {

  assert(MAX_LEVEL < MAX_UNITS);

  DesignGen cGen;
  string *s = new string("root");
  CSLunit* root = new CSLunit(&cGen, s);
  const int START_LEVEL = 1;
  cGen.buildInstanceTree(START_LEVEL, root);
  assert(root);

  cout << "Print tree root = " << root->getUnitName() << endl;
  const char* output = "designTree.csl";
  ofstream out(output);
  cGen.printCslCode(out);
  root->printTree(START_LEVEL);
}

