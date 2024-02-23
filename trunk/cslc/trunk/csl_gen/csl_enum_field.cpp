#include "csl_enum_field.h"
//#include "csl_gen.h"

using namespace NSCSLinterconnect;

void CSLdesign::addEnum() {
  string enumName = randString();
  if(newNameIsValid(enumName)) {
    CSLenumPoint newEnum = new CSLenum (this, enumName);
    newEnum->buildDecl();
      addChild(newEnum);
  }
}

void CSLdesign::addField() {
  string fieldName = randString();
  if( newNameIsValid(fieldName) ) {
    CSLfieldPoint newField = new CSLfield (this, fieldName);
    newField->buildDecl( (*this) );
      addChild( newField);
  }
}

//=============//
//Class CSlenum//
//=============//

CSLenum::CSLenum (CSLbasePoint parent, string name) :
  CSLbase(CSL_ENUM, parent, name) {}

CSLenum::~CSLenum() {}

bool CSLenum :: buildDecl() {
  int r = rand()% 5 +1;
  for(int i=1; i<=r;i++){
  print_enum_fr();
  addEnumItem();
  print_enum_bk();
  }
}

void CSLenum :: print_enum_fr() {
  m_name = randString();
  (*m_out) << "csl_enum " << m_name << " {\n";
}

void CSLenum :: print_enum_bk() {
    (*m_out) <<"\n};\n";
}

void CSLenum::addEnumItem() {
  string enum_item = randString();
  if(newNameIsValid(enum_item)) {
    CSLenumItemPoint newItem = new CSLenumItem (this, enum_item);
    if(newItem->buildDecl()) {
      addChild(newItem);
    }
    else {
      delete newItem;
    }
  }
}


//=================//
//Class CSLenumItem//
//=================//

CSLenumItem::CSLenumItem(CSLbasePoint parent, string name):
  CSLbase (CSL_ENUM_ITEM, parent, name) {}

CSLenumItem::~CSLenumItem() {}

bool CSLenumItem :: buildDecl() {
  int c = rand() % 2;
  int r = rand() % 50;
  string enum_item;
  int value;
  if(c==0)
    for(int i=1;i<=r;i++){
      enum_item = randString();
      if(i<r){
        print_item(enum_item);co();
      }
      else {
        print_item(enum_item);
      }
    }
  else if (c==1) {      
    for (int i=1; i<=r; i++){
      enum_item = randString();
      value = rand() % 100;
      if(i<r){
        print_item_val(enum_item, value);co();
      }
      else {
        print_item_val(enum_item, value); 
      }
    }
  }
}

void CSLenumItem :: print_item(string enum_item){
    (*m_out) << "\t" << enum_item ;
    }

void CSLenumItem :: print_item_val(string enum_item, int value){
  (*m_out) << "\t" << enum_item << " = " << value ;
}

void CSLenumItem :: co(){
  (*m_out) << ",\n";
}

void CSLenumItem :: enter () {
  (*m_out) << "\n";
}

//==============//
//Class CSLfield//
//==============//

CSLfield::CSLfield(CSLbasePoint parent, string name):
  CSLbase(CSL_FIELD,parent, name),
  m_fieldLower(0),
  m_fieldUpper(1){}

CSLfield ::~CSLfield () {}

//***get functions***
const short CSLfield::getfieldLower() const {
  return m_fieldLower;
}

const short CSLfield::getfieldUpper() const {
  return m_fieldUpper;
}

const short CSLfield::getfieldWidth() const {
  return (m_fieldUpper - m_fieldLower);
}

void CSLfield :: buildDecl(CSLdesign design) {
  int r = rand()% 5 +1;
  int c;
  for(int i=1; i<=r;i++){
    c= rand()% 1;
    if(c==0)
      //    field_object(design);
    else if(c==1)
  buildSet();
  }
}

bool CSLfield::buildSet() {
  short form = rand() % CSL_FIELD_DECL_MAX;
  switch(form){
    case CSL_FIELD_DECL_EMPTY:{  printFieldDeclE(); break; }
    case CSL_FIELD_DECL_LOWER_UPPER: {
      short low = rand() % (MAX_WIDTH / 2);
      short up  = low + rand() % (MAX_WIDTH / 2) + 1;
      // setRange(low, up);
      printFieldDeclL_U();
    }
    case CSL_FIELD_DECL_WIDTH: {
      short width = rand() % (MAX_WIDTH - 1) + 1;
      printFieldDeclW();
    }
    case CSL_FIELD_DECL_COPY: {
      CSLfieldPoint field;
      m_fieldLower = field->getfieldLower();
      m_fieldUpper = field->getfieldUpper();
      break;
    }
   case CSL_FIELD_DECL_MAX: { cerr << "Case field max. Error! " <<endl ; break; }
    default: { cerr << "This could not happen " <<endl; break;}
  }
}

void CSLfield::printFieldDeclE(){
  (*m_out) << "csl_field " <<   getName() << ";\n";
}

void CSLfield::printFieldDeclL_U() {
  (*m_out) << "csl_field " << getName() << "(" << m_fieldLower << ","<< m_fieldUpper << ");\n";
}

void CSLfield::printFieldDeclW() {
  (*m_out) << "csl_field " << getName() << "(" << m_fieldWidth << ");\n";
}



// void CSLfield :: field_object(CSLdesign  design) {
//   string field_name = randString();
//   (*m_out) << "csl_field " << field_name << "{\n";
//   (*m_out) << "\t" << field_name <<" () { \n";
//   // functions generated random
//   set_enum(design);
//   (*m_out) << "\t}\n";
//   (*m_out) << "};\n";
// }

  
// void CSLfield :: set_enum(CSLdesign design) {
//   vector <CSLbase*> :: const_iterator it = design.m_children.begin();
//   for( it; it < design.m_children.end(); it++) {
//     if( (*it) -> m_type == CSL_ENUM )
//       (*m_out) << "\tset_enum("<< (*it) -> m_name <<  ");\n";
//     }
// }

