#include <string>
#include <iostream>
#include <sstream>
#include <iomanip>
#include <stdlib.h>
#include <math.h>

#include "CDOM.h"
#include "VeriNum.h"
#include "CDOM_Visitor.h"
#include "CDOM_Type_Map.h"
#include "CDOM_API.h"
#include "../support/CommonSupport.h"

using namespace std;
using namespace NSCdom;
using namespace NSCdomVisitor;

  //TB removed//
// string* createBinNum(unsigned int width, CDOmNumber::ENumBaseType base, int n) {
//   string* s = new string();

//   unsigned int b; // bit
//   unsigned int m = 1;   

//   cerr << endl;

//   for (int i = width -1; i >= 0; --i) {
//     b = (n >> i) & m;
//     char c[1] = {b +'0'};        
//     string ns = c;
//     s->append(ns);
//     //    cerr << "n = " << n << " i = " << i << " m = " << m << " b = " << b << " ns = " << ns <<  endl;
//   }
//   cerr << " new number = " << *s << endl;

//   return s;  
// }

// string* createOctNum(unsigned int width, CDOmNumber::ENumBaseType base, int n) {
//   ostringstream oss;
//   oss << setbase(8) << n;

//   string* s = new string(oss.str());
 
//   cerr << " new number = " << *s << endl;
//   return s;
// }

// string* createDecNum(unsigned int width, CDOmNumber::ENumBaseType base, int n) {
//   ostringstream oss;
//   oss << setbase(10) << n;

//   string* s = new string(oss.str());
//   cerr << " new number = " << *s << endl;
//   return s;
// }

// string* createHexNum(unsigned int width, CDOmNumber::ENumBaseType base, int n) {
//   ostringstream oss;
//   oss << setbase(16) << n;

//   string* s = new string(oss.str());
//   cerr << " new number = " << *s << endl;

//   return s;
// }

// string* makeNumString(unsigned int width, CDOmNumber::ENumBaseType base, int i) {
//   string* s = 0;

//   //  cerr << "width = " << width << " ";
//   switch(base) {
//   case CDOmNumber::NUM_BASE_BIN: cerr << "Base = BIN"; s = createBinNum(width, base, i); break;
//   case CDOmNumber::NUM_BASE_OCT: cerr << "Base = OCT"; s = createOctNum(width, base, i); break;
//   case CDOmNumber::NUM_BASE_DEC: cerr << "Base = DEC"; s = createDecNum(width, base, i); break;
//   case CDOmNumber::NUM_BASE_HEX: cerr << "Base = HEX"; s = createHexNum(width, base, i); break;
//     //  case CDOmNumber::NUM_BASE_MAX: cerr << "Base = MAX"; s = createMaxNum(width, base, i); break;
//   }
//   cerr << " number = " << i;
//   cerr << " new number = " << *s << endl;

//   return s;
// }



// unsigned int checkNumberList(CDOmNumber::ENumBaseType basea,  CDOmNumber::ENumBaseType baseb, unsigned int width, int lowerRange, int upperRange, bool sign  ) {  
//   int cnt = 0;

//   if ((basea != CDOmNumber::NUM_BASE_DEC) && (baseb != CDOmNumber::NUM_BASE_DEC))  {
//     lowerRange = sign ? -upperRange : 0;
//   }

//   for (int i = lowerRange; i < upperRange; i++) {
//     cerr << "forloop before i = " << i  << endl;
//     RefString numStringA = RefString(makeNumString(width, basea, i));
//     RefString numStringB = RefString(makeNumString(width, baseb, i));
//     RefCDOmVeriNum vn_a = CDOmVeriNum::build(1, basea, numStringA, sign, width); 
//     RefCDOmVeriNum vn_b = CDOmVeriNum::build(2, baseb, numStringB, sign, width);
//     cerr << "forloop after  i = " << i  << endl;

//     if (vn_a->getValue() != vn_b->getValue()){
//       cerr << "MISMATCH i = " << i << " vn_a = " << vn_a->getValue() << " vn_b = " << vn_b->getValue() << " nsA:: " << *numStringA << " nsB:: " << *numStringB << endl;
//       cnt++;   
//     }
//     else {
//       cerr << "MATCH i = " << i << " vn_a    = " << vn_a->getValue() << " vn_b = " << vn_b->getValue() << " nsA:: " << *numStringA << " nsB:: " << *numStringB << endl;
//     }
    
//   } 
//   return cnt;
// }


// void testCDOmVeriNum() {
//   try {
//     int cnt = 0;
//     int lowerWidth = 1;
//     int upperWidth = 32;


//     for (int w = lowerWidth; w < upperWidth; w++) {
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_BIN, CDOmNumber::NUM_BASE_HEX, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_BIN, CDOmNumber::NUM_BASE_DEC, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_BIN, CDOmNumber::NUM_BASE_OCT, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_OCT, CDOmNumber::NUM_BASE_HEX, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_OCT, CDOmNumber::NUM_BASE_DEC, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_OCT, CDOmNumber::NUM_BASE_BIN, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_DEC, CDOmNumber::NUM_BASE_HEX, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_DEC, CDOmNumber::NUM_BASE_OCT, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_DEC, CDOmNumber::NUM_BASE_BIN, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_HEX, CDOmNumber::NUM_BASE_DEC, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_HEX, CDOmNumber::NUM_BASE_OCT, w, 0, 64, true) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_HEX, CDOmNumber::NUM_BASE_BIN, w, 0, 64, true) !=0  );

//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_BIN, CDOmNumber::NUM_BASE_HEX, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_BIN, CDOmNumber::NUM_BASE_DEC, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_BIN, CDOmNumber::NUM_BASE_OCT, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_OCT, CDOmNumber::NUM_BASE_HEX, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_OCT, CDOmNumber::NUM_BASE_DEC, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_OCT, CDOmNumber::NUM_BASE_BIN, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_DEC, CDOmNumber::NUM_BASE_HEX, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_DEC, CDOmNumber::NUM_BASE_OCT, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_DEC, CDOmNumber::NUM_BASE_BIN, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_HEX, CDOmNumber::NUM_BASE_DEC, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_HEX, CDOmNumber::NUM_BASE_OCT, w, 0, 64, false) !=0  );
//       if( cnt = checkNumberList(CDOmNumber::NUM_BASE_HEX, CDOmNumber::NUM_BASE_BIN, w, 0, 64, false) !=0  );
//     }


// //    RefCDOmVeriNum veriNum_a = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1010000100000001")), TRUE);
// //    RefCDOmVeriNum P = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("00000110")), FALSE);
// //    RefCDOmVeriNum S = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("10100000")), FALSE);
// //    RefCDOmVeriNum veriNum_b = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("101")), FALSE);
// //    RefCDOmVeriNum numHex1   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("A101")), FALSE);
// //    RefCDOmVeriNum numHex2   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_HEX, RefString(new std::string("101")), FALSE);
// //    RefCDOmVeriNum numDec1   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("178")), FALSE);
// //    RefCDOmVeriNum numDec2   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("256")), TRUE);
// //    RefCDOmVeriNum numDecZ   = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("ZZ")), FALSE);
// //    RefCDOmVeriNum num2      = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("2")), FALSE);
// //    RefCDOmVeriNum num8      = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("8")), TRUE);
// //    RefCDOmVeriNum num10     = CDOmVeriNum::build(10, 10, 4);
// //    RefCDOmVeriNum num_minus_10  = CDOmVeriNum::build(10, -10);
// //
// //    cerr << "P + S = " << CDOmVeriNum::cast(P->add(S))->getValue() << endl;
// //    RefCDOmVeriNum       res;// = CDOmVeriNum::build(10, CDOmVeriNum::_X, 6);
// //    RefCDOmVeriNum res2 = CDOmVeriNum::cast(numHex1->add(veriNum_b));
// //    res = CDOmVeriNum::cast(veriNum_a->add(veriNum_b));
// //    cerr << "veriNum_a = " << veriNum_a->getValue() << endl;
// //    cerr << "numHex1 = " << numHex1->getValue() << " numHex2 = " << numHex2->getValue() << endl;
// //    std::cerr << "res = " << res->getValue() << "\nres2 = " << res2->getValue() << "\nnumDec1 = " << numDec1->getValue() << endl;
// //    std::cerr << "numDecZ = " << numDecZ->getValue() << endl;
// //    numDecZ->setValue(-102);
// //    cerr << "numDecZ = " << numDecZ->getValue() << endl;
// //    cerr << "numDec2 (= 256) = " << numDec2->getValue() << endl;
// //    numDec2->setValue(-256);
// //    cerr << "numDec2 (= -256) = " << numDec2->getValue() << endl;
// //
// //    RefCDOmNum32 num321 = CDOmNum32::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("129")));
// //    RefCDOmVeriNum num_3 = CDOmVeriNum::build(10, 3);
// //    RefCDOmVeriNum num_min_4 = CDOmVeriNum::build(10, -4);
// //    RefCDOmNum32 num322 = CDOmNum32::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("23")));
// //    RefCDOmNum32 num_neg = CDOmNum32::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("-14")));
// //    cerr << "129 + 23 = " << (num322->add(num321))->getValue() << "\n129 - 14 = " << (num321->add(num_neg))->getValue() << endl;
// //    
// //    //shift
// //    numDecZ = CDOmVeriNum::cast(veriNum_a->shiftLeft(num2));
// //    cerr << "veriNum_a << 2 = " << numDecZ->getValue() << "\nveriNum_a >> 2 = " << CDOmVeriNum::cast(veriNum_a->shiftRight(num2))->getValue() << endl;
// //    cerr << "8 + 2 = " << CDOmVeriNum::cast(num8->add(num2))->getValue() << " = " << CDOmVeriNum::cast(num2->add(num8))->getValue() << endl;
// //    cerr << "num10 = " << num10->getValue() << "\nnum_minus_10 = " << num_minus_10->getValue() << endl;
// //    cerr << "3 x -4 = " << CDOmVeriNum::cast(num_3->multiply(num_min_4))->getValue() << endl;
// //    cerr << "10 x -10 = " << CDOmVeriNum::cast(num10->multiply(num_minus_10))->getValue() << endl;
// //    cerr << "-10 x 2 = " << CDOmVeriNum::cast(num2->multiply(num_minus_10))->getValue() << endl;
// //    cerr << "10 x 2 = " << CDOmVeriNum::cast(num2->multiply(num10))->getValue() << endl;
// //    numDec1 = CDOmVeriNum::cast(numDec1->minus());
// //    cerr << "-10 = " << num_minus_10->getValue() << " -178 = " << numDec1->getValue() << endl;
// //    cerr << "-10 x -178 = " << CDOmVeriNum::cast(num_minus_10->multiply(numDec1))->getValue() << endl;
// //    cerr << "-10 = " << num_minus_10->getValue() << endl;
// //    cerr << "-178 == -178: " << numDec1->equals(-178) << endl;
// //    cerr << "-178 == 334: " << numDec1->equals(334) << endl;
// //    cerr << "10 - (-178) = " << CDOmVeriNum::cast(num10->substract(numDec1))->getValue() << endl;
// //    cerr << "-178 / 10 = " << CDOmVeriNum::cast(numDec1->divide(num10))->getValue() << endl;
// //    cerr << "-255 / 5 = " << CDOmVeriNum::cast(numDec2->divide(veriNum_b))->getValue() << endl;
// //
// //    RefCDOmVeriNum num_min_3 = CDOmVeriNum::build(10, -3);
// //    RefCDOmVeriNum num_5 = CDOmVeriNum::build(10, 5);
// //    RefCDOmVeriNum one = CDOmVeriNum::build(10, 1);
// //    RefCDOmVeriNum mone = CDOmVeriNum::build(10, -1);
// //    RefCDOmVeriNum m14 = CDOmVeriNum::build(10, -14);
// //    RefCDOmVeriNum m10 = CDOmVeriNum::build(10, -10);
// //    RefCDOmVeriNum _one = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_DEC, RefString(new std::string("1")), FALSE);
// //    RefCDOmVeriNum _mone = CDOmVeriNum::build(10, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1")), TRUE);
// //    cerr << "-3 + 5 = " << CDOmVeriNum::cast(num_min_3->add(num_5))->getValue() << " = " << CDOmVeriNum::cast(num_5->add(num_min_3))->getValue() << endl;
// //    cerr << "-3 >> 2 = " << CDOmVeriNum::cast(num_min_3->shiftRight(num2))->getValue() << endl;
// //    cerr << "one = " << one->getValue() << endl;
// //    cerr << "mone = " << mone->getValue() << endl;
// //    cerr << "_one = " << _one->getValue() << endl;
// //    cerr << "_mone = " << _mone->getValue() << endl;
// //    cerr << "-14 >> 1 = " << CDOmVeriNum::cast(m14->shiftRight(one))->getValue() << endl;
// //    cerr << "!-3 = " << CDOmVeriNum::cast(num_min_3->logicNot())->getValue() << endl; 
// //    cerr << "-10 << 1 = " << CDOmVeriNum::cast(m10->shiftLeft(one))->getValue() << endl;
// //    cerr << "-178 % 10 = " << CDOmVeriNum::cast(numDec1->modulo(num10))->getValue() << endl;
    
//   } catch(const NSBase::Exception &e) {
//     cerr << "Exception " << e.what() << endl;
//   }
// }

// CDOmNumber::ENumBaseType randomBase(){
//   int base = rand()%4;
//   RefCDOmNumber baseNo;
//   switch(base){
//     case 0:{
//       return CDOmNumber::NUM_BASE_BIN;
//       break;
//     }
//     case 1:{
//       return CDOmNumber::NUM_BASE_OCT;
//       break;
//     }
//     case 2:{
//       return CDOmNumber::NUM_BASE_DEC;
//       break;
//     }
//     case 3:{
//       return CDOmNumber::NUM_BASE_HEX;
//       break;
//     }
//   }
//   //  return baseNo;
// }

// void setBit(RefCDOmVeriNum vn){
//   int i;
//   cerr<<"vn = "<<*(vn->getValueAsString())<<endl;
//   for( i= 0; i < 32; ++i ){
//     int bit = rand()%6;
//     switch(bit){
//       case 0: {
//         vn->setBit(rand()%32, CDOmBitArray::_X);
//         break;
//       }
//       case 1: {
//         vn->setBit(rand()%32, CDOmBitArray::_Z);
//         break;
//       }
//       case 2: {
//         vn->setBit(rand()%32, CDOmBitArray::_0);
//         break;
//       }
//       case 3: {
//         vn->setBit(rand()%32, CDOmBitArray::_1);
//         break;
//       }
//     }
//   }
// }


// void testCDOmVeriNum1(){
//   srand(time(0));

//   RefCDOmDesign design = CDOmDesign::build();
//   int x = rand()%10000;
//   int y = rand()%10000;
//   int z = rand()%10000;
 
//   bool sign = true;
//   string *num = 0;
//   //  num = createBinNum(32, CDOmNumber::NUM_BASE_HEX, 544);
//   //num = makeNumString(32, CDOmNumber::NUM_BASE_BIN, x);
//   //  cerr << "num = " << *num << endl;
    

// //   CDOmNumber::ENumBaseType base_a = CDOmNumber::NUM_BASE_BIN; //randomBase();    
// //   CDOmNumber::ENumBaseType base_b = CDOmNumber::NUM_BASE_BIN; //randomBase();    

// //    string* num_a = 0;
// //    num_a = makeNumString(32, CDOmNumber::NUM_BASE_BIN, x);
// //    cerr << "num_a = " << *num_a <<" x=" << x << "base = "<< base_a  <<endl;
  
// //    RefString numStringA = RefString(makeNumString(32, base_a, x));
// //    RefCDOmVeriNum vn_a = CDOmVeriNum::build(3, base_a, numStringA, sign, 32);

// //   int x = 1;
// //   int y = 0;
  

//   cerr<<"\n-----*********The initial numbers are**********----\n";
//   cerr<<"x="<<x<<endl;
//   cerr<<"y="<<y<<endl<<endl;

//   //  int op = rand()%25;
//     int op = 11;
//     cerr<<"Operator "<<op<<endl;

  
//   int width;

//   int flag_a = rand()%2;// flag = 0 => vn = negative
//   int flag_b = rand()%2;// flag = 1 => vn = positive
//   int flag_c = rand()%2;


//     width = rand()%32;
//   //  sign = rand()%2;

//     CDOmNumber::ENumBaseType base_a = randomBase();        
//     CDOmNumber::ENumBaseType base_b = randomBase();      
//     CDOmNumber::ENumBaseType base_c = randomBase();      
//     CDOmNumber::ENumBaseType base_s = randomBase();    

//     //*** vn_a declaration ***

//     RefString numStringA = RefString(makeNumString(32, base_a, x));
//     RefCDOmVeriNum vn_a = CDOmVeriNum::build(3, base_a, numStringA, sign, 32);

//         if(flag_a == 0){
//           vn_a = CDOmVeriNum::cast(vn_a->minus());
//         }
//         // setBit(vn_a);
//  int i;
//  //  cerr<<"vn = "<<vn->getValue()<<endl;
//   for( i= 0; i < 32; ++i ){
//     int bit = rand()%6;
//     switch(bit){
//       case 0: {
//         vn_a->setBit(rand()%32, CDOmBitArray::_X);
//         break;
//       }
//       case 1: {
//         vn_a->setBit(rand()%32, CDOmBitArray::_Z);
//         break;
//       }
//       case 2: {
//         vn_a->setBit(rand()%32, CDOmBitArray::_0);
//         break;
//       }
//       case 3: {
//         vn_a->setBit(rand()%32, CDOmBitArray::_1);
//         break;
//       }
//     }
//   }

//     cerr<<"a = "<<*(vn_a->getValueAsString())<<endl;

//   width = rand()%32;
//   //  sign = rand()%2;


//     //*** vn_b declaration ***  
//     RefString numStringB = RefString(makeNumString(32, base_b, y));
//     RefCDOmVeriNum vn_b = CDOmVeriNum::build(4, base_b, numStringB, sign, 32);
  

// //     RefString numStringB = RefString(makeNumString(32, CDOmNumber::NUM_BASE_HEX, y));
// //     RefCDOmVeriNum vn_b = CDOmVeriNum::build(4, CDOmNumber::NUM_BASE_HEX, numStringB, sign, 32);

//        if(flag_b == 0){
//        vn_b = CDOmVeriNum::cast(vn_b->minus());
//        }
//         setBit(vn_b);

//     cerr<<"b = "<<*(vn_b->getValueAsString())<<endl;


//     //*** vn_c declaration ***
//     RefString numStringC = RefString(makeNumString(32, base_c, z));
//     RefCDOmVeriNum vn_c = CDOmVeriNum::build(3, base_c, numStringC, sign, 32);
  
//     if(flag_c == 0){
//       vn_c = CDOmVeriNum::cast(vn_c->minus());
//     }
//         setBit(vn_c);
//     cerr<<"c = "<<*(vn_c->getValueAsString())<<endl;

//     RefString numStringS = RefString(makeNumString(32, base_s, 5));
//     RefCDOmVeriNum vn_s = CDOmVeriNum::build(3, base_s, numStringS, sign, 32);
//     cerr<<"s = "<<*(vn_s->getValueAsString())<<endl;




//     cerr<<"\n-----*********The result is**********----\n";
//     switch(op){
//       case 0: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".add("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->add(vn_b)))->getValueAsString())<<endl;
//         std::cerr<<x<<"+"<<y<<"="<<x+y<<std::endl;
//         break;
//       }
//       case 1: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".substract("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->substract(vn_b)))->getValueAsString())<<endl;
//         std::cerr<<x<<"-"<<y<<"="<<x-y<<std::endl;
//         break;
//       }
//       case 2: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".multiply("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->multiply(vn_b)))->getValueAsString())<<endl;
//         std::cerr<<x<<"*"<<y<<"="<<x*y<<std::endl;
//         break;
//       }
//       case 3: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".divide("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->divide(vn_b)))->getValueAsString())<<endl;
//         std::cerr<<x<<"/"<<y<<"="<<x/y<<std::endl;
//         break;
//       }
//       case 4: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".modulo("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->modulo(vn_b)))->getValueAsString())<<endl;
//         std::cerr<<x<<"%"<<y<<"="<<x%y<<std::endl;
//         break;
//       }
//       case 5: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".power("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->power(vn_b)))->getValueAsString())<<endl;
//         std::cerr<<x<<"^"<<y<<"="<<pow(x,y)<<std::endl;
//         break;
//       }
//       case 6: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".shiftLeft("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->shiftLeft(vn_b)))->getValueAsString())<<endl;
//         break;
//       }     
//       case 7: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".binaryShiftLeft("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->binaryShiftLeft(vn_s)))->getValueAsString())<<endl;
//         break;
//       }
//       case 8: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".shiftRight("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->shiftRight(vn_s)))->getValueAsString())<<endl;
//         break;
//       }
//       case 9: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".equality("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->equality(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 10: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".notEquality("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->notEquality(vn_b)))->getValueAsString())<<endl;
//         break;
//       }   
//       case 11: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".equalityEqualCase("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->equalityEqualCase(vn_a)))->getValueAsString())<<endl;
//         break;
//       }
//       case 12: {
//         cerr<<"\n***"<<*(vn_a->getValueAsString())<<".equalityNotEqualCase("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->equalityNotEqualCase(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 13: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".logicAnd("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->logicAnd(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 14: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".logicOr("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->logicOr(vn_b)))->getValueAsString())<<endl;
//         break;        
//       }
//       case 15: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".relationalLess("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->relationalLess(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 16: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".relationalLessEqual("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->relationalLessEqual(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 17: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".relationalGreater("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->relationalGreater(vn_a)))->getValueAsString())<<endl;
//         break;
//       }
//       case 18: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".relationalGreaterEqual("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->relationalGreaterEqual(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 19: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseAnd("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseAnd(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 20: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseNand("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseNand(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 21: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseOr("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseOr(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 22: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseNor("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseNor(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 23: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseXor("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseXor(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 24: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseXor("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseXnor(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 25: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".binaryShiftRight("<<*(vn_b->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->binaryShiftRight(vn_b)))->getValueAsString())<<endl;
//         break;
//       }
//       case 26: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".maxValue() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->maxValue()))->getValueAsString())<<endl;
//         break;
//       }
//       case 27: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".plus() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->plus()))->getValueAsString())<<endl;
//         break;
//       }
//       case 28: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".minus() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->minus()))->getValueAsString())<<endl;
//         break;
//       }
//       case 29: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".logicNot() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->logicNot()))->getValueAsString())<<endl;
//         break;
//       }
//       case 30: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".bitwiseNot() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->bitwiseNot()))->getValueAsString())<<endl;
//         break;
//       }
//       case 31: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".reductionAnd() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->reductionAnd()))->getValueAsString())<<endl;
//         break;
//       }
//       case 32: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".reductionNand() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->reductionNand()))->getValueAsString())<<endl;
//         break;
//       }
//       case 33: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".reductionOr() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->reductionOr()))->getValueAsString())<<endl;
//         break;
//       }
//       case 34: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".reductionXor() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->reductionXor()))->getValueAsString())<<endl;
//         break;
//       }
//       case 35: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".reductionXnor() ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->reductionXnor()))->getValueAsString())<<endl;
//         break;
//       }
//       case 36: {
//         cerr<<"\n*** "<<*(vn_a->getValueAsString())<<".ternaryCondition("<<*(vn_b->getValueAsString())<<", "<<*(vn_c->getValueAsString())<<") ***\n";
//         cerr<<*(CDOmVeriNum::cast((vn_a->ternaryCondition(vn_b, vn_c)))->getValueAsString())<<endl;
//         break;
//       }


//     }
// }
  //~TB removed//

int main() {
  const int n = 3;

  //  testCDOmVeriNum();

  //TB removed//
//   testCDOmVeriNum1();
  //~TB removed//

  return 0;
}
