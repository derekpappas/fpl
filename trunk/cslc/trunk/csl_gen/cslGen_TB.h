#ifndef _CSL_CODE_GEN_H_
#define _CSL_CODE_GEN_H_

#include <vector>
#include <iostream>
using namespace std;

namespace NSCslGen {

const short NAME_SIZE = 1;
const short UNIT_MAX  = 10;
const short SIGN_MAX  = 5;

const short _MAX_WIDTH = 32;

const string signalTypes[16]   = {"trireg", "tri", "wire", "wor", "wand", "trior", "tri0", "tri1", "triand", "supply0", "supply1", "reg", "integer", "real", "realtime", "time"};
const string signalAttr[9]     = {"ATTR_EN", "ATTR_STALL", "ATTR_PE", "ATTR_PS", "ATTR_MS", "ATTR_DEC", "ATTR_CLK", "ATTR_RST", "ATTR_WR_EN"};
const string portDirections[3] = {"input", "output", "inout"};


////////////////////////////////////////////////////////////////////////
class CSLbitrange;
class CSLsignal;
class CSLport;
class CSLinterface;
class CSLinstane;
class CSLunitDecl;
class CSLunitInit;
class CSLunit;
class CSLdesign;
////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////
//class CSLbitrange                                                   //
////////////////////////////////////////////////////////////////////////
class CSLbitrange {
  public:
    string                        m_bName;
    short                         m_bLower;
    short                         m_bUpper;

    CSLbitrange(string name) : m_bName(name) {}
};

////////////////////////////////////////////////////////////////////////
//class CSLsignal                                                     //
////////////////////////////////////////////////////////////////////////
class CSLsignal {
  public:
    string                        m_sName;
    string                        m_sType;
    string                        m_sAttr;
    short                         m_sLower;
    short                         m_sUpper;
    CSLsignal*                    m_sCopyOf;
    CSLbitrange*                  m_sBitrange;

    CSLsignal(string name) : m_sName(name) {}
};

////////////////////////////////////////////////////////////////////////
//class CSLport                                                       //
////////////////////////////////////////////////////////////////////////
class CSLport {
  public:
    string                        m_pName;
    string                        m_pType;
    string                        m_pAttr;
    string                        m_pDir;
    short                         m_pLower;
    short                         m_pUpper;
};

////////////////////////////////////////////////////////////////////////
//class CSLinstance                                                   //
////////////////////////////////////////////////////////////////////////
class CSLinstance {
  public:
    string                        m_iName;
    CSLunit*                      m_iType;
};

////////////////////////////////////////////////////////////////////////
//class CSLinterface                                                  //
////////////////////////////////////////////////////////////////////////
class CSLinterface{
  public:
    string                        m_ifcName;
    vector<CSLport*>              m_ifcPorts;
    vector<CSLinterface*>         m_ifcIfcs;
};

////////////////////////////////////////////////////////////////////////
//class CSLunitDecl                                                   //
////////////////////////////////////////////////////////////////////////
class CSLunitDecl {
  public:
    vector<CSLinstance*>          m_dInsts;
    vector<CSLbitrange*>          m_dBitranges;
    vector<CSLsignal*>            m_dSignals;
    vector<CSLport*>              m_dPorts;
};

////////////////////////////////////////////////////////////////////////
//class CSLunitInit                                                   //
////////////////////////////////////////////////////////////////////////
class CSLunitInit {
  public:
};

////////////////////////////////////////////////////////////////////////
//class CSLunit                                                       //
////////////////////////////////////////////////////////////////////////
class CSLunit {
  public:
    string                        m_uName;
    CSLunitDecl                   m_uDecl;
    CSLunitInit                   m_uInit;

    CSLunit(string name) : m_uName(name) {}
};

////////////////////////////////////////////////////////////////////////
//class CSLgenerator                                                  //
////////////////////////////////////////////////////////////////////////
class CSLgenerator {
  public:
    vector<CSLunit*>              m_units;
    ostream&                      m_out;

    CSLgenerator(ostream& out = cout) : m_out(out) {}

    string randString();

    //check functions
    bool unitNameIsValid(string name);
    bool newNameIsValid(string name, CSLunit* unit);

    //add functions
    void addUnit();
    void addBitrange(CSLunit* unit);
    void addSignal(CSLunit* unit);
    void addPort(CSLunit* unit);

    //random select functions
    CSLbitrange* randSelBitrange(CSLunit* unit);
    CSLsignal* randSelSignal(CSLunit* unit);

    //print functions
    void printComma();

    void printUnitBegin(string name);
    void printUnitEnd();

    void printBitrangeDeclEmpty(string name);
    void printBitrangeDeclBegin(string name);
    void printBitrangeDeclWidth(short width);
    void printBitrangeDeclLower(short lower);
    void printBitrangeDeclUpper(short upper);
    void printBitrangeDeclEnd();

    void printSignalDeclBegin(string name);
    void printSignalDeclType(string type);
    void printSignalDeclWidth(short width);
    void printSignalDeclLower(short lower);
    void printSignalDeclUpper(short upper);
    void printSignalDeclBitr(string bitrName);
    void printSignalDeclCopy(string copyOf);
    void printSignalDeclEnd();

    void printPortDeclBegin(string name);
    void printPortDeclEnd();

    //build functions
    void build();
};

} //NSCslGen

#endif  //_CSL_CODE_GEN_H_
