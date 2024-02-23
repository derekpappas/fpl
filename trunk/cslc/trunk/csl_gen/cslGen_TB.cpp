#include "cslGen_TB.h"
using namespace NSCslGen;

////////////////////////////////////////////////////////////////////////
//class CSLgenerator                                                  //
////////////////////////////////////////////////////////////////////////
string CSLgenerator::randString() {
  string str = string();
  str = rand() % ('Z' - 'A') + 'A';
  for (int i = 1; i < NAME_SIZE; i++)
    str += rand() % ('z' - 'a') + 'a';
  
  return str;
}

//check functions
bool CSLgenerator::unitNameIsValid(string name) {
  for (vector<CSLunit*>::const_iterator it = m_units.begin(); it != m_units.end(); it++)
    if ((*it)->m_uName == name)
      return false;
  return true;
}
bool CSLgenerator::newNameIsValid(string name, CSLunit* unit) {
  for (vector<CSLbitrange*>::const_iterator itb = unit->m_uDecl.m_dBitranges.begin(); itb != unit->m_uDecl.m_dBitranges.end(); itb++)
    if ((*itb)->m_bName == name)
      return false;
  for (vector<CSLsignal*>::const_iterator its = unit->m_uDecl.m_dSignals.begin(); its != unit->m_uDecl.m_dSignals.end(); its++)
    if ((*its)->m_sName == name)
      return false;
  return true;
}

//add functions
void CSLgenerator::addUnit() {
  string unitName = randString();
  string signalName;

  if (unitNameIsValid(unitName)) {
    CSLunit* newUnit = new CSLunit(unitName);
    printUnitBegin(unitName);

    addBitrange(newUnit);

    addSignal(newUnit);
    addSignal(newUnit);
    addSignal(newUnit);
    addSignal(newUnit);
    addSignal(newUnit);
    addSignal(newUnit);

    m_units.push_back(newUnit);
    printUnitEnd();
  }
}
void CSLgenerator::addBitrange(CSLunit* unit) {
  string bitrangeName = randString();

  if (newNameIsValid(bitrangeName, unit)) {
    CSLbitrange* newBitrange = new CSLbitrange(bitrangeName);
    short addForm = rand() % 3;

    switch (addForm) {
      case 0: //csl_bitrange name;
        newBitrange->m_bLower = 0;
        newBitrange->m_bUpper = 1;

        printBitrangeDeclEmpty(bitrangeName);
        break;
      case 1: //csl_bitrange name(width);
        newBitrange->m_bLower = 0;
        newBitrange->m_bUpper = rand() % _MAX_WIDTH;

        printBitrangeDeclBegin(bitrangeName);
        printBitrangeDeclWidth(newBitrange->m_bUpper);
        printBitrangeDeclEnd();
        break;
      case 2: //csl_bitrange name(lower, upper);
        newBitrange->m_bLower = rand() % (_MAX_WIDTH / 2);
        newBitrange->m_bUpper = newBitrange->m_bLower + rand() % (_MAX_WIDTH / 2);

        printBitrangeDeclBegin(bitrangeName);
        printBitrangeDeclLower(newBitrange->m_bUpper);
        printComma();
        printBitrangeDeclUpper(newBitrange->m_bUpper);
        printBitrangeDeclEnd();
        break;
    }
    unit->m_uDecl.m_dBitranges.push_back(newBitrange);
  }
}
void CSLgenerator::addSignal(CSLunit* unit) {
  string signalName = randString();

  if (newNameIsValid(signalName, unit)) {
    CSLsignal* newSignal = new CSLsignal(signalName);
    short addForm = rand() % 9;

    switch (addForm) {
      case 0: //csl_signal name();
        newSignal->m_sType = "";
        newSignal->m_sAttr = "";
        newSignal->m_sLower = 0;
        newSignal->m_sUpper = 1;

        printSignalDeclBegin(signalName);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 1: //csl_signal name(sig_type);
        newSignal->m_sType = signalTypes[rand() % 16];
        newSignal->m_sAttr = "";
        newSignal->m_sLower = 0;
        newSignal->m_sUpper = 1;
        printSignalDeclBegin(signalName);
        printSignalDeclType(newSignal->m_sType);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 2: //csl_signal name(width);
        newSignal->m_sType = "";
        newSignal->m_sAttr = "";
        newSignal->m_sLower = 0;
        newSignal->m_sUpper = rand() % _MAX_WIDTH;

        printSignalDeclBegin(signalName);
        printSignalDeclWidth(newSignal->m_sUpper);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 3: //csl_signal name(sig_type, width);
        newSignal->m_sType = signalTypes[rand() % 16];
        newSignal->m_sAttr = "";
        newSignal->m_sLower = 0;
        newSignal->m_sUpper = rand() % _MAX_WIDTH;

        printSignalDeclBegin(signalName);
        printSignalDeclType(newSignal->m_sType);
        printComma();
        printSignalDeclWidth(newSignal->m_sUpper);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 4: //csl_signal name(sig_type, lower, upper);
        newSignal->m_sType = signalTypes[rand() % 16];
        newSignal->m_sAttr = "";
        newSignal->m_sLower = rand() % (_MAX_WIDTH / 2);
        newSignal->m_sUpper = newSignal->m_sLower + rand() % (_MAX_WIDTH / 2);

        printSignalDeclBegin(signalName);
        printSignalDeclType(newSignal->m_sType);
        printComma();
        printSignalDeclLower(newSignal->m_sLower);
        printComma();
        printSignalDeclUpper(newSignal->m_sUpper);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 5: //csl_signal name(lower, upper);
        newSignal->m_sType = "";
        newSignal->m_sAttr = "";
        newSignal->m_sLower = rand() % (_MAX_WIDTH / 2);
        newSignal->m_sUpper = newSignal->m_sLower + rand() % (_MAX_WIDTH / 2);

        printSignalDeclBegin(signalName);
        printSignalDeclLower(newSignal->m_sLower);
        printComma();
        printSignalDeclUpper(newSignal->m_sUpper);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 6: //csl_signal name(sig_type, bitrange);
        newSignal->m_sBitrange = randSelBitrange(unit);
        if (newSignal->m_sBitrange == NULL)
          break;
        newSignal->m_sType = signalTypes[rand() % 16];
        newSignal->m_sAttr = "";
        newSignal->m_sLower = newSignal->m_sBitrange->m_bLower;
        newSignal->m_sUpper = newSignal->m_sBitrange->m_bUpper;

        printSignalDeclBegin(signalName);
        printSignalDeclType(newSignal->m_sType);
        printComma();
        printSignalDeclBitr(newSignal->m_sBitrange->m_bName);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 7: //csl_signal name(bitrange);
        newSignal->m_sBitrange = randSelBitrange(unit);
        if (newSignal->m_sBitrange == NULL)
          break;
        newSignal->m_sType = "";
        newSignal->m_sAttr = "";
        newSignal->m_sLower = newSignal->m_sBitrange->m_bLower;
        newSignal->m_sUpper = newSignal->m_sBitrange->m_bUpper;

        printSignalDeclBegin(signalName);
        printSignalDeclBitr(newSignal->m_sBitrange->m_bName);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
      case 8: //csl_signal name(other_sig);
        newSignal->m_sCopyOf = randSelSignal(unit);
        if (newSignal->m_sBitrange == NULL)
          break;
        newSignal->m_sType = newSignal->m_sCopyOf->m_sType;
        newSignal->m_sAttr = newSignal->m_sCopyOf->m_sAttr;
        newSignal->m_sLower = newSignal->m_sCopyOf->m_sLower;
        newSignal->m_sUpper = newSignal->m_sCopyOf->m_sUpper;

        printSignalDeclBegin(signalName);
        printSignalDeclCopy(newSignal->m_sCopyOf->m_sName);
        printSignalDeclEnd();

        unit->m_uDecl.m_dSignals.push_back(newSignal);
        break;
    }
  }
}

//random select functions
CSLbitrange* CSLgenerator::randSelBitrange(CSLunit* unit) {
  if (unit->m_uDecl.m_dBitranges.empty())
    return NULL;
  return (unit->m_uDecl.m_dBitranges.at(rand() % unit->m_uDecl.m_dBitranges.size()));
}
CSLsignal* CSLgenerator::randSelSignal(CSLunit* unit) {
  if (unit->m_uDecl.m_dSignals.empty())
    return NULL;
  return (unit->m_uDecl.m_dSignals.at(rand() % unit->m_uDecl.m_dSignals.size()));
}

//print functions
void CSLgenerator::printComma() {
  m_out << ", ";
}
void CSLgenerator::printUnitBegin(string name) {
  m_out << "csl_unit " << name << " {\n";
}
void CSLgenerator::printUnitEnd() {
  m_out << "};\n";
}

void CSLgenerator::printBitrangeDeclEmpty(string name) {
  m_out << "  csl_bitrange " << name << ";\n";
}
void CSLgenerator::printBitrangeDeclBegin(string name) {
  m_out << "  csl_bitrange " << name << "(";
}
void CSLgenerator::printBitrangeDeclWidth(short width) {
  m_out << width;
}
void CSLgenerator::printBitrangeDeclLower(short lower) {
  m_out << lower;
}
void CSLgenerator::printBitrangeDeclUpper(short upper) {
  m_out << upper;
}
void CSLgenerator::printBitrangeDeclEnd() {
  m_out << ");\n";
}

void CSLgenerator::printSignalDeclBegin(string name) {
  m_out << "  csl_signal " << name << "(";
}
void CSLgenerator::printSignalDeclType(string type) {
  m_out << type;
}
void CSLgenerator::printSignalDeclWidth(short width) {
  m_out << width;
}
void CSLgenerator::printSignalDeclLower(short lower) {
  m_out << lower;
}
void CSLgenerator::printSignalDeclUpper(short upper) {
  m_out << upper;
}
void CSLgenerator::printSignalDeclBitr(string bitrName) {
  m_out << bitrName;
}
void CSLgenerator::printSignalDeclCopy(string copyOf) {
  m_out << copyOf;
}
void CSLgenerator::printSignalDeclEnd() {
  m_out << ");\n";
}

void CSLgenerator::printPortDeclBegin(string name) {
  m_out << "  csl_port " << name << "(";
}
void CSLgenerator::printPortDeclEnd() {
  m_out << ");\n";
}

//build functions
void CSLgenerator::build() {
  for (int i = 0; i < UNIT_MAX; i++)
    addUnit();
}

int main() {
  srand(time(NULL));
  CSLgenerator gen;
  gen.build();
}
