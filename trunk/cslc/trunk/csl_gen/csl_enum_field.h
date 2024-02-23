#ifndef _CSL_ENUM_FIELD_GEN_H_
#define _CSL_ENUM_FIELD_GEN_H_
//#include <iostream>

#include "csl_gen_base.h"

using namespace std;

namespace NSCSLinterconnect {

class CSLenum : public CSLbase {
    public:
     CSLenum(CSLbasePoint parent, string name);
     ~CSLenum();
     bool buildDecl();

     void print_enum_fr();
     void addEnumItem();
     void print_enum_bk();
    void print();
 };

 class CSLenumItem : public CSLbase {

   private:
     string enum_item;
     int value;

   public:
     CSLenumItem(CSLbasePoint parent, string name);
     ~CSLenumItem();

     bool buildDecl();

     void print_item(string enum_item);
     void print_item_val(string enum_item, int value);
      void print();
     void co();
     void enter();
  
 };

 class CSLfield : public CSLbase {
  
    private:
     short                               m_fieldLower;
     short                               m_fieldUpper;
     short                               m_fieldWidth;
     string                              field_name;

     //get functions
     const short getfieldLower() const;
     const short getfieldUpper() const;
     const short getfieldWidth() const;

  
   public:
     CSLfield(CSLbasePoint parent, string name);
     ~CSLfield();

     void buildDecl( CSLbase* design);
     bool buildDecl(  ) {}
     bool buildSet();
//      void field_object( CSLdesign design);
//      void field_object_lu();

//     void set_enum( CSLdesign design);
    void print();
     // print function
     void printFieldDeclE();
     void printFieldDeclL_U();
     void printFieldDeclW();
 };

}

#endif //_CSL_ENUM_FIELD_GEN_H_
