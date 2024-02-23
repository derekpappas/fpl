#ifndef _CSL_GEN_ENUM_FIELD_H
#define _CSL_GEN_ENUM_FIELD_H

#include <vector>
#include <iostream>
#include <sstream>
#include <string>
#include <fstream>

using namespace std;

namespace NSCSLinterconnect{
  
class CSLenum : public CSLbase {
    public:
     CSLenum(CSLbasePoint parent, string name);
    ~CSLenum() {}

     bool buildDecl();
     void print();
 };

class CSLenumItem : public CSLbase {

   private:
     int m_value;
    bool m_valueF;

   public:
     CSLenumItem(CSLbasePoint parent, string name);
    ~CSLenumItem() {}

     bool buildDecl();
     void print();
 };

class CSLfield : public CSLbase {
    private:
    // get functions for all private vars
    string m_enumName;
    string m_enumNameIt;
    string m_fieldName;
    string m_bitrName;
    string m_fieldInName;

    string m_lower;
    string m_upper;
    string m_width;
    string m_value;
    string m_lowerIn;
    string m_upperIn;
    
    int m_is;
    
    
  public:
    CSLfield(CSLbasePoint parent, string name);
    ~CSLfield() {}

    const string getLower()      const;
    const string getUpper()      const;
    const string getWidth()      const;
    const string getValue()      const;
    const string getLowerIn()    const;
    const string getUpperIn()    const;
    const string getEnumName ()  const;
    const string getEnumItName() const;
    const string getBitrName()   const;
    const string getFieldName()  const;
    const string getFieldInName()const;

    int form;
    int form_funct;
    int form_inst;

    const int CSL_FIELD_MAX = 10; // TODO: FIX ME-DEP 2010-01-15
    const int CSL_FIELD_FUNCTION_MAX = 10; // TODO: FIX ME-DEP 2010-01-15
    int m_used[CSL_FIELD_MAX];
    int m_used_funct[CSL_FIELD_FUNCTION_MAX];

    bool buildDecl();
    void print ();

    void genWidth();
    void genLower();
    void genUpper();
    void genValue();
    void genLowerIn();
    void genUpperIn();

    void genName      (CSLbase* design);
    void addFieldInst (CSLbase* design);
    void setEnum      (CSLbase* design);
    void setEnumItem  (CSLbase* design);
    void setBitr      (CSLbase* design);
    void genNext      (CSLbase* design);
    void genPrevious  (CSLbase* design);
    void setFieldTypes();

    bool m_enumNameF;
    bool m_enumNameItF;
    bool m_fieldNameF;
    bool m_bitrNameF;
    bool m_fieldInNameF;
};

class CSLfieldInst : public CSLbase {
  
  public:
    CSLfieldInst(CSLbasePoint, string name);
    ~CSLfieldInst() {}

    bool buildDecl();
    void print ();
    string instance (string in);
    string m_field_inst;
    vector <string> instNames;
 
  };
}

#endif //_CSL_GEN_ENUM_FIELD_H
