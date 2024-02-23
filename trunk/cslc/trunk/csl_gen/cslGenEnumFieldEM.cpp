#include "cslInterconnectGen_TB.h"
#include "cslGenEnumFieldEM.h"

using namespace std;

namespace NSCSLinterconnect{

void CSLdesign::addEnum() {
  string enumName = randString();
   if (newNameIsValid(enumName)) {
    CSLenumPoint newEnum = new CSLenum(this, enumName);
    if(newEnum -> buildDecl())
    addChild (newEnum);
       else{
     delete newEnum;
   }
  }
}

void CSLdesign::addField() {
  string fieldName = randString();
  int flag;
  if (newNameIsValid(fieldName)) {
    CSLfieldPoint newField = new CSLfield(this, fieldName);
       if(newField -> buildDecl() == true){ 
      addChild (newField);
    }
    else{
      delete newField;
    }
  }
}


//=============//
//Class CSLenum//
//=============//

CSLenum::CSLenum (CSLbase* parent, string name) :
  CSLbase(CSL_ENUM, parent , name) {
}

bool CSLenum :: buildDecl() {
  int c =  rand() % 2;
  for(int i = 1;i <= rand() % 50 + 5 ;i++){
    string name = randString();  
      if(newNameIsValid(name)) {
        CSLenumItemPoint newItem = new CSLenumItem (this, name);
        if(!c)
        newItem->buildDecl();
        addChild(newItem);
      }
    }
  return true;
}

void CSLenum :: print(){
    (*m_out) << "csl_enum " << m_name << " {\n";
    CSLbaseVec_cIter it = m_children.begin();
    for( ; it < m_children.end();it++ ){
      if ((*it) -> m_type == CSL_ENUM_ITEM){
        if(it < m_children.end()-1){
        (*it)-> print();(*m_out)<<",\n";
        }
        else{
        (*it)-> print();(*m_out)<<"\n";
        }
      }
    }
      (*m_out) << "};\n"; 
}

//=================//
//Class CSLenumItem//
//=================//

CSLenumItem::CSLenumItem(CSLbase* parent, string name):
  m_valueF(false),
  CSLbase (CSL_ENUM_ITEM, parent, name) {    
  m_name = name;
 }

bool CSLenumItem :: buildDecl() {
   m_value = rand() % 100;
   m_valueF = true;
}

void CSLenumItem :: print() {
  (*m_out) <<"\t" <<  m_name;
  if ( m_valueF )
    (*m_out) << " = " << m_value ;
}

//==============//
//Class CSLfield//
//==============//

CSLfield :: CSLfield (CSLbase* parent, string name):
  m_enumName   (string("")),
  m_enumNameIt (string("")),
  m_fieldName  (string("")),
  m_bitrName   (string("")),
  m_lower      (string("")),
  m_upper      (string("")),
  m_width      (string("")),
  m_value      (string("")),
  m_lowerIn    (string("")),
  m_upperIn    (string("")),
  m_fieldInName(string("")),
  CSLbase (CSL_FIELD , parent, name){
  m_enumNameF =   false;
  m_enumNameItF = false;
  m_fieldNameF =  false;
  m_bitrNameF =   false;
  m_fieldInNameF= false;
  }

void CSLfield :: genWidth(){
  m_width =  randNumExpr();  
  }

void CSLfield :: genValue(){
  m_value = randNumExpr();
}

void CSLfield :: genLower(){
  m_lower =  randNumExpr();     
}

void CSLfield :: genUpper(){
  m_upper = randNumExpr();  
}

void CSLfield :: genLowerIn(){
  m_lowerIn =  randNumExpr();  
}

void CSLfield :: genUpperIn(){
  m_upperIn =  randNumExpr();  
}

const string CSLfield :: getLower()      const {  
  return m_lower;
}
const string CSLfield :: getUpper()      const {
  return m_upper;
}
const string CSLfield :: getWidth()      const {
  return m_width;
}
const string CSLfield :: getValue()      const {
  return m_value;
}
const string CSLfield :: getLowerIn()    const{
  return m_lowerIn;
}
const string CSLfield :: getUpperIn()    const{
  return m_upperIn;
}
const string CSLfield :: getEnumName()   const {
  return m_enumName;
}
const string CSLfield :: getEnumItName() const {
  return m_enumNameIt;
}
const string CSLfield :: getBitrName()   const {
  return m_bitrName;
}
const string CSLfield :: getFieldName()  const {
  return m_fieldName;
}
const string CSLfield :: getFieldInName()const {
  return m_fieldInName;
}



bool CSLfield :: buildDecl() {
  form = rand() % CSL_FIELD_MAX;
  if(!m_used[form]){
    switch (form) {
      srand(time(NULL));
      case CSL_FIELD_EMPTY:                                                                    break; 
      case CSL_FIELD_COPY :               genName(getParent());   if(m_fieldNameF) m_is = 1; else m_is =0;                          break; 
      case CSL_FIELD_WIDTH:               genWidth();             if(m_width == ("","0")) m_is = 1;else m_is =0;                                         break; 
      case CSL_FIELD_WIDTH_E :            genWidth();           setEnum      (getParent()); if(m_width == ("","0") && m_enumNameF) m_is = 1; else m_is =0;  break; 
      case CSL_FIELD_WIDTH_EI:            genWidth();           setEnumItem  (getParent()); if(m_width == ("","0")  && m_enumNameItF) m_is = 1;else m_is =0;   break; 
      case CSL_FIELD_LOWER_UPPER:         genLower(); genUpper();                           if(m_lower == ("","0") && m_upper == ("","0")) m_is = 1;else m_is =0;   break; 
      case CSL_FIELD_LOWER_UPPER_E:       genLower(); genUpper();setEnum     (getParent()); if(m_lower == ("","0") && m_upper == ("","0") && m_enumNameF) m_is = 1;else m_is =0; break; 
      case CSL_FIELD_LOWER_UPPER_EI:      genLower(); genUpper();setEnumItem (getParent());if(m_lower == ("","0") && m_upper == ("","0") && m_enumNameItF) m_is = 1;else m_is =0;break; 
      case CSL_FIELD_BITR_ENUM:           setBitr(getParent()); setEnum      (getParent()); if(m_enumNameF && m_bitrNameF) m_is = 1;else m_is =0;   break; 
      case CSL_FIELD_BITR_ENUM_IT:        setBitr(getParent()); setEnumItem  (getParent()); if(m_enumNameItF && m_bitrNameF) m_is = 1;else m_is =0;   break; 
      case CSL_FIELD_OBJECT:                     
        form_inst = rand() % 2;
       if(form_inst){
        for ( int i = 0; i < FIELD_INSTANCE_NO; i++) 
          addFieldInst (getParent()); 
          }
        for(int i =0;i<CSL_FIELD_FUNCTION_MAX; i++){
           form_funct = rand() % CSL_FIELD_FUNCTION_MAX; 
         if(!m_used_funct[form_funct]){
           switch(form_funct){
            case CSL_SET_ENUM:            genNext(getParent()); setEnum (getParent());         break; 
            case CSL_SET_ENUM_ITEM:       genPrevious(getParent()); setEnumItem(getParent());  break;   
            case CSL_SET_WIDTH:           genWidth();                                          break; 
            case CSL_SET_VALUE:           genValue();                                          break; 
            case CSL_SET_RANGE:           genLower();  genUpper();                             break; 
            case CSL_SET_BITRANGE:        setBitr(getParent());                                break; 
            case CSL_SET_LOWER_INDEX:     genLowerIn();                                        break; 
            case CSL_SET_UPPER_INDEX:     genUpperIn();                                        break; 
            case CSL_SET_FIELD_POSITION:  genName(getParent());  genWidth();                   break; 
            case CSL_SET_NEXT:            genNext(getParent());                                break;   
            case CSL_SET_PREVIOUS:        genPrevious(getParent());                            break; 
            case CSL_FIELD_FUNCTION_MAX:  cerr << "Error! Case field function max ";           break; 
          }
         m_used_funct[form_funct] = 1; 
        }                                                                                        
        }                                                                                        break; 

      case CSL_FIELD_MAX: {cerr << "Error! Case field max " ;                                    break; 
    
    m_used[form] = 1;
  }
  if(!m_is)
  return true;
  else
    return false;
}

void CSLfield :: genNext(CSLbase* design) {
  CSLbaseVec ch = design -> getChildren();
  CSLbaseVec_cIter it = ch.begin();
  for (; it <ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      CSLbaseVec_cIter it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        if( (*it1) -> getType() == CSL_FIELD_INST) {
          CSLscopedBasePoint obj = randSelObj(CSL_FIELD_INST);
          if(obj.second != NULL){ 
            CSLscopedFieldInstPoint ret = CSLscopedFieldInstPoint(obj.first, static_cast<CSLfieldInstPoint>(obj.second));
            m_fieldInName = obj.second -> getName();
            m_fieldInNameF = true;
          }
        }
      }
    }
  }
}

void CSLfield :: genPrevious(CSLbase* design) {
  CSLbaseVec ch = design -> getChildren();
  CSLbaseVec_cIter it = ch.begin();
  for (; it <ch.end(); it++) {
    if( (*it) -> getType() == CSL_FIELD ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      CSLbaseVec_cIter it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        if( (*it1) -> getType() == CSL_FIELD_INST) {
          CSLscopedBasePoint obj = randSelObj(CSL_FIELD_INST);
          if(obj.second != NULL){ 
            CSLscopedFieldInstPoint ret = CSLscopedFieldInstPoint(obj.first, static_cast<CSLfieldInstPoint>(obj.second));
            m_fieldInName = obj.second -> getName();
            m_fieldInNameF = true;
          }
        }
      }
    }
  }
}

void CSLfield :: genName(CSLbase* design){
CSLbaseVec_cIter it = design -> m_children.begin();
  for(; it < design -> m_children.end(); it++){
    if( (*it) -> m_type == CSL_FIELD){
      CSLscopedBasePoint obj = randSelObj(CSL_FIELD);
      if(obj.second != NULL){ 
      CSLscopedFieldPoint ret = CSLscopedFieldPoint(obj.first, static_cast<CSLfieldPoint>(obj.second));
      m_fieldName = obj.second -> getName();
      m_fieldNameF = true;
    }
   }
  }
}


void CSLfield :: setEnum (CSLbase* design) {
  CSLbaseVec_cIter it = design -> m_children.begin();
  for(; it < design -> m_children.end(); it++){
    if( (*it) -> m_type == CSL_ENUM){
      CSLscopedBasePoint obj = randSelObj(CSL_ENUM);
      if(obj.second != NULL){ 
      CSLscopedEnumPoint ret = CSLscopedEnumPoint(obj.first, static_cast<CSLenumPoint>(obj.second));
      m_enumName = obj.second -> getName();
      m_enumNameF = true;
      }}
  }
}

void CSLfield::setEnumItem(CSLbase* design) {
  int flag;
  CSLbaseVec ch = design -> getChildren();
  CSLbaseVec_cIter it = ch.begin();
  for (; it <ch.end(); it++) {
    if( (*it) -> getType() == CSL_ENUM ) {
      CSLbaseVec ch1 = (*it) -> getChildren();
      CSLbaseVec_cIter it1 = ch1.begin();
      for (; it1 < ch1.end(); it1++) {
        if( (*it1) -> getType() == CSL_ENUM_ITEM ) {
          CSLscopedBasePoint obj = randSelObj(CSL_ENUM_ITEM);
          if(obj.second != NULL){ 
            CSLscopedEnumItemPoint ret = CSLscopedEnumItemPoint(obj.first, static_cast<CSLenumItemPoint>(obj.second));
            m_enumNameIt = obj.second -> getName();
            m_enumNameItF = true;
          }
        }
      }
    }
  }
}

void CSLfield :: setBitr (CSLbase* design) {
  CSLbaseVec_cIter it = design -> m_children.begin();
  for(; it < design -> m_children.end(); it++){
    if( (*it) -> m_type == CSL_BITRANGE){
      CSLscopedBasePoint obj = randSelObj(CSL_BITRANGE);
      if(obj.second != NULL){ 
        CSLscopedBitrangePoint ret = CSLscopedBitrangePoint(obj.first, static_cast<CSLbitrangePoint>(obj.second));
        m_bitrName  = obj.second -> getName();
        m_bitrNameF = true;
      }
    }
  }
}
 
void CSLfield :: addFieldInst(CSLbase* design) {
  int flag;
  CSLbaseVec_cIter it = design -> m_children.begin();
  for (; it < design -> m_children.end(); it++) {
    if( (*it) -> m_type == CSL_FIELD) {
      flag = rand()%2;
      if( flag ) {
        string name(string(""));
        name.append(randString());
        if (newNameIsValid(name)) {
          CSLfieldInst* fieldInst = new CSLfieldInst(this, name);
          fieldInst -> buildDecl();
          fieldInst -> m_field_inst = (*it) -> m_name;
          addChild(fieldInst);
        }
      }
    }
  }     
}    
 
void CSLfield :: print (){
    if(m_used[form]){
      switch(form) {
        case CSL_FIELD_EMPTY :         { (*m_out) << "csl_field " << getName() <<";\n";                                                                                         break; }
        case CSL_FIELD_COPY:           { if (m_fieldNameF)  (*m_out) << "csl_field " << getName() << "(" << getFieldName() <<  ");\n";                                          break; }
        case CSL_FIELD_WIDTH:          { if(m_width!=("0",""))    (*m_out) << "csl_field " << getName() << "("<< getWidth() << ");\n";                                                break; }
        case CSL_FIELD_WIDTH_E:        { if(m_enumNameF)    (*m_out) << "csl_field " << getName() << "("<< getWidth() << "," << getEnumName() <<  ");\n";                       break; }  
        case CSL_FIELD_WIDTH_EI:       { if (m_enumNameItF) (*m_out) << "csl_field " << getName() << "("<< getWidth() << "," <<  getEnumItName() <<  ");\n";                    break; }
        case CSL_FIELD_LOWER_UPPER:    { if(m_upper!=("0","") && m_upper != ("0","")) (*m_out) << "csl_field " << getName() << "(" << getLower() << "," << getUpper() << ");\n";            break; }
        case CSL_FIELD_LOWER_UPPER_E:  { if(m_enumNameF)    (*m_out) << "csl_field " << getName() << "(" << getLower() << "," << getUpper() << "," << getEnumName() << ");\n";  break; }
        case CSL_FIELD_LOWER_UPPER_EI: { if(m_enumNameItF)  (*m_out) << "csl_field " << getName() << "(" << getLower() << "," << getUpper() << "," << getEnumItName() << ");\n";break; }
        case CSL_FIELD_BITR_ENUM:      { if (m_enumNameF && m_bitrNameF)  (*m_out) << "csl_field "<<getName() << "(" << getBitrName() << "," << getEnumName() << ");\n";        break; }   
        case CSL_FIELD_BITR_ENUM_IT:   { if (m_enumNameItF && m_bitrNameF)(*m_out) << "csl_field "<<getName() << "(" << m_bitrName << "," << getEnumItName() << ");\n";         break; }   
        case CSL_FIELD_OBJECT: {
          (*m_out) << "csl_field " << m_name << "{\n";
          CSLbaseVec_cIter it =  m_children.begin();
          if(form_inst){         
          for (; it < m_children.end(); it++) {
            if ((*it) -> m_type == CSL_FIELD_INST) {
              (*it) -> print();
            }
          }
          }
          (*m_out) << "\t" << m_name << "() {\n" ;
          for (int i=0; i< CSL_FIELD_FUNCTION_MAX; i++){       
            if (m_used_funct[i]){
              switch(i) {
                case CSL_SET_ENUM:           { if(m_enumNameF) { if(!form_inst){       (*m_out) << "\tset_enum(" << getEnumName() << ");\n";}
                else  if (form_inst && m_fieldInNameF)  (*m_out) << "\t" << getFieldInName() << ".set_enum(" << getEnumName () << ");\n";}                         break; }
                case CSL_SET_ENUM_ITEM:    { if(m_enumNameItF){ if (!form_inst){     (*m_out) << "\tset_enum_item(" << getEnumItName() << ");\n"; }            
                  else if (form_inst && m_fieldInNameF)  (*m_out) << "\t" << getFieldInName() << ".set_enum_item(" << getEnumItName () << ");\n"; }                break; }
                case CSL_SET_WIDTH:          { if(m_width!=("0",""))              (*m_out) << "\tset_width(" << getWidth() << ");\n";                              break; }
                case CSL_SET_VALUE:          { if(m_value!=("0",""))               (*m_out) << "\tset_value(" << getValue() << ");\n";                             break; } 
                case CSL_SET_RANGE:          { if(m_lower!=("0","") && m_upper!=("0",""))(*m_out) << "\tset_range(" << getLower() << "," << getUpper() << ");\n";  break; }
                case CSL_SET_BITRANGE:       { if(m_bitrNameF)                (*m_out) << "\tset_bitrange(" << getBitrName() << ");\n";                            break; }
                case CSL_SET_LOWER_INDEX:    { if(m_lowerIn!=("","0"))         (*m_out) << "\tset_lower_index(" << getLowerIn() << ");\n";                         break; }
                case CSL_SET_UPPER_INDEX:    { if(m_upperIn!=("","0"))         (*m_out) << "\tset_upper_index(" << getUpperIn() << ");\n";                         break; }
                case CSL_SET_FIELD_POSITION: { if(m_width!=("0","") && m_fieldNameF)(*m_out) << "\tset_field_position(" << getFieldName() << "," <<getWidth() << ");\n";break; } 
                case CSL_SET_NEXT:           { if(m_fieldInNameF)             (*m_out) << "\tset_next(" << getFieldInName() << "," << getFieldInName() << ");\n";  break; } 
                case CSL_SET_PREVIOUS:       { if(m_fieldInNameF)             (*m_out) << "\tset_previous(" << getFieldInName()<< "," <<getFieldInName() << ");\n";break; } 
                case CSL_FIELD_FUNCTION_MAX: { cerr << "Error! Case field function max - print ";                                                                  break; } 
                default:                     { cerr << "Error! Case default field function - print ";                                                              break; }
              }
            }
           }
           (*m_out) << "\t}" << "\n};\n";                                                                                                                         break; }
        case CSL_FIELD_MAX : { cerr <<"Error! Case field max - print ";                                                                                           break; }
        default: { cerr << "Error! Case default field - print ";                                                                                                  break; }
     }
  }
}

//==================//
//Class CSLfieldInst//
//==================//

CSLfieldInst :: CSLfieldInst(CSLbase* parent, string name):
  CSLbase (CSL_FIELD_INST, parent, name),
  m_field_inst (string ("")) {
  }

bool CSLfieldInst :: buildDecl() {
 CSLbaseVec_cIter  it =  m_children.begin();
 for (; it < m_children.end(); it++) {
   if( (*it) -> m_type == CSL_FIELD) {
       m_field_inst = (*it) -> m_name;
   }
 }
 return true;
}

void CSLfieldInst :: print () {
  (*m_out) <<"\t" << m_field_inst << " " << m_name<< ";\n";
}

}
