#ifndef CSL_CODE_GEN_H
#define CSL_CODE_GEN_H

#include <assert.h>
#include <map>
#include <stack>
#include <vector>
#include <fstream>
#include <iostream>
#include <algorithm>
using namespace std;

const string portTypes[3] = {"input", "output", "inout"};
const short NAME_STRINGS_SIZE       = 10;
const short UNIT_VECTOR_SIZE        = 15;
const short PORT_VECTOR_MAX_SIZE    = 10;
const short INSTANCE_MAP_MAX_SIZE   = 3;
const short BITRANGE_MAX_SIZE       = 4;
const short CONNECT_VECTOR_MAX_SIZE = 10;

// IMPORTANT THE number of units has to be greater than the depth otherwise the 
// getRandomUnit logic will get stuck in an infinite loop at the bottom of the tree
const short MAX_LEVEL               = 10; // number of levels in the tree
const short MAX_UNITS               = 45; // number of unique units
const int   MAX_INSTANCES           = 5000; // max number of instances per unit

string randString(string);
unsigned int randNumber();
unsigned int randNumber(unsigned int n);

class CSLinstance;
class DesignGen;

enum EUnitType {
  T_UNIT = 0,
  T_RF = 1
};

class CSLunit {
  private:
    string* m_unitName;
    bool m_final; // unit already created 
    bool m_isPrinted;
    bool m_pageIsPrinted;
    int m_pageWidth;
    map<string, bool>* m_uniqueInstanceNameMap; // unique instance names in this unit
    map<string, bool> m_parentUnitNameMap;      // includes this unit name- map which is used to check for cycles

  public:
    EUnitType m_type;
    vector<CSLinstance*>* m_instances;

    CSLunit(DesignGen*, string *unitName , EUnitType type = T_UNIT);
    virtual ~CSLunit();
    void setUnitName(  string * in) { assert(in);  m_unitName = in; }
    string getUnitName() {  return *m_unitName; }
    void setFinal(){ m_final = true; }
    bool getFinal(){ return m_final; }
    bool instanceNameExists(string);
    void addInstance     (CSLinstance*);

    bool parentUnitNameExists(string);
    void addParentUnitName   (string);

    void printBegin      (ofstream &out);
    void printMiddleBegin(ofstream &out);
    void printMiddleEnd  (ofstream &out);
    void printEnd        (ofstream &out);
    virtual void print           (ofstream &out);

    void printPageBegin      (ofstream &out);
    void printPageMiddleBegin(ofstream &out);
    void printPageMiddleEnd  (ofstream &out);
    void printPageEnd        (ofstream &out);
    void printPage           (ofstream &out);

    void printTree(int lev);

    void printUniqueInstanceNameMap ();
    void printParentUnitMap();
};

class CSLrf : public CSLunit {
  private:
    int m_width;
    int m_depth;

  public:

    CSLrf(DesignGen* dg, string* unitName) : CSLunit(dg, unitName, T_RF) {}
    void print(ofstream &out);
    void setWidth(int w) { m_width = w; }
    void setDepth(int d) { m_depth = d; }
    int  getWidth(     ) { return m_width; }
    int  getDepth(     ) { return m_depth; }

};

class CSLinstance {
  private:
    string * m_instanceName;
    CSLunit* m_unit;

  public:
    CSLinstance(DesignGen* dg, CSLunit* parentUnit, CSLunit* u);
    ~CSLinstance();
    void     setInstanceName(  string * in) { assert(in); m_instanceName = in;}
    string   getInstanceName(  ) { assert(m_instanceName); return *m_instanceName; }
    CSLunit* getUnit(          ) { assert(m_unit); return m_unit; }
    void     setUnit(CSLunit* u) { assert(u);      m_unit = u;    }

};

class DesignGen {
  private:
    vector<string*>    m_uniqueUnitNameList;   // list of unit names avaible to create units
    map<string, bool> m_uniqueUnitNameMap; // map of unit names avaible to create units
    vector<CSLunit*>  m_unitVector;         // list of units created in design
    map   <string, CSLunit*> m_mapUnitNamePtr; // map of units created in design
    vector<string> m_parentList;
  public:
    DesignGen();
    ~DesignGen();
    bool unitNameIsValid(string, vector<CSLunit*> );
    CSLunit* getRandomUnit(CSLunit* parentUnit, vector<string> &m_parentList);
    void buildInstanceTree(int, CSLunit*);
    void printUnitVector(const char*, vector<CSLinstance**> &);
    void printCslCode(ofstream& out);
    void printHierMemMap(ofstream& out);
    void addToUnitVector(CSLunit* unit);
    void addToUnitMap(CSLunit* unit);

};


#endif  //CSL_CODE_GEN_H
