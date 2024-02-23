//Given the function (we wil move this out of the visitor class):
#include "verilogCodeGen.h"
using namespace NSCdom;
using namespace std;

void CVerilogTestGen::createRandomIdentifier(RefString prefix, TUInt maxIdSize ){
  RefString returned;
  if( prefix.get() )
    returned = RefString( new string( *prefix ) );
  else
    returned = RefString( new string() );

  TUInt size = m_randomNumberGen.createRandomNum( 1, maxIdSize );
  
  TUInt i = 0;
  if( !returned->size() ) {
    returned->push_back( m_identifChars[ m_randomNumberGen.createRandomNum( m_firstLetterIdSize - 1 ) ] );
    ++i;
  }

  for( ; i < size ; ++i )
    returned->push_back( m_identifChars[ m_randomNumberGen.createRandomNum( m_identifChars.size() - 1 ) ] );

  buffout << *returned;
}

CVerilogTestGen::CVerilogTestGen() : counter(0), state(0), buffout(m_out){
  m_out = new char[MAXBUFF_SIZE];
  for( char c = 'A'; c<= 'Z'; ++c ) {
    m_identifChars.push_back(c);
    m_identifChars.push_back(c|0x20);
  }
  m_identifChars.push_back('_');
  m_firstLetterIdSize = m_identifChars.size();
  for( char c = '0'; c<='9'; ++c ) 
    m_identifChars.push_back(c);
  m_identifChars.push_back('$');

  vectOpType.push_back( CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS          ); // = 0x10000001, // +op
  vectOpType.push_back( CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS         ); // = 0x10000002, // -op
  vectOpType.push_back( CDOmExprOp::OP_UNARY_LOGIC_NOT                ); // = 0x10000004, // !op  - logical not
  vectOpType.push_back( CDOmExprOp::OP_UNARY_BITWISE_NOT              ); // = 0x10000008, // ~op  - bitwise not
  vectOpType.push_back( CDOmExprOp::OP_UNARY_REDUCTION_AND            ); // = 0x10000010, // &op  - reduction and
  vectOpType.push_back( CDOmExprOp::OP_UNARY_REDUCTION_NAND           ); // = 0x10000020, // ~&op - rediction nand
  vectOpType.push_back( CDOmExprOp::OP_UNARY_REDUCTION_OR             ); // = 0x10000040, // |op  - reduction or
  vectOpType.push_back( CDOmExprOp::OP_UNARY_REDUCTION_NOR            ); // = 0x10000080, // ~|op - reduction nor
  vectOpType.push_back( CDOmExprOp::OP_UNARY_REDUCTION_XOR            ); // = 0x10000100, // ^op  - reduction xor
  vectOpType.push_back( CDOmExprOp::OP_UNARY_REDUCTION_XNOR           ); // = 0x10000200, // ~^op or ^~op - reduction xnor
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS         ); // = 0x20000001, // a + b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS        ); // = 0x20000002, // a - b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY     ); // = 0x20000004, // a * b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_DIV          ); // = 0x20000008, // a / b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_MOD          ); // = 0x20000010, // a % b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_POW          ); // = 0x20000020, // a ** b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT   ); // = 0x20000040, // a <<< b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT  ); // = 0x20000080, // a >>> b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_EQUALITY_EQ             ); // = 0x20000100, // a == b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ         ); // = 0x20000200, // a != b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE        ); // = 0x20000400, // a === b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE    ); // = 0x20000800, // a !== b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_LOGIC_AND               ); // = 0x20001000, // a && b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_LOGIC_OR                ); // = 0x20002000, // a || b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_RELATIONAL_LESS         ); // = 0x20004000, // a < b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL   ); // = 0x20008000, // a <= b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_RELATIONAL_GREATER      ); // = 0x20010000, // a > b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL); // = 0x20020000, // a >= b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_BITWISE_AND             ); // = 0x20040000, // a & b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_BITWISE_NAND            ); // = 0x20080000, // a ~& b // !!! ???
  vectOpType.push_back( CDOmExprOp::OP_BINARY_BITWISE_OR              ); // = 0x20100000, // a | b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_BITWISE_NOR             ); // = 0x20200000, // a ~| b // !!! ???
  vectOpType.push_back( CDOmExprOp::OP_BINARY_BITWISE_XOR             ); // = 0x20400000, // a ^ b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_BITWISE_XNOR            ); // = 0x20800000, // a ^~ b or a ~^ b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_SHIFT_LEFT              ); // = 0x21000000, // a << b
  vectOpType.push_back( CDOmExprOp::OP_BINARY_SHIFT_RIGHT             ); // = 0x22000000, // a >> b
  vectOpType.push_back( CDOmExprOp::OP_TERNARY_COND                   ); // = 0x40000001  // a ? b : c
}

void CVerilogTestGen::createOpString(CDOmExprOp::EOpType ot) {
  switch(ot) {
    case CDOmExprOp::OP_UNARY_ARITHMETIC_PLUS           : buffout << " + "  ; break; 
    case CDOmExprOp::OP_UNARY_ARITHMETIC_MINUS          : buffout << " - "  ; break; 
    case CDOmExprOp::OP_UNARY_LOGIC_NOT                 : buffout << " ! "  ; break; 
    case CDOmExprOp::OP_UNARY_BITWISE_NOT               : buffout << " ~ "  ; break; 
    case CDOmExprOp::OP_UNARY_REDUCTION_AND             : buffout << " & "  ; break; 
    case CDOmExprOp::OP_UNARY_REDUCTION_NAND            : buffout << " ~& " ; break; 
    case CDOmExprOp::OP_UNARY_REDUCTION_OR              : buffout << " | "  ; break; 
    case CDOmExprOp::OP_UNARY_REDUCTION_NOR             : buffout << " ~| " ; break; 
    case CDOmExprOp::OP_UNARY_REDUCTION_XOR             : buffout << " ^ "  ; break; 
    case CDOmExprOp::OP_UNARY_REDUCTION_XNOR            : buffout << " ~^ " ; break; 
    case CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS          : buffout << " + "  ; break; 
    case CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS         : buffout << " - "  ; break; 
    case CDOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY      : buffout << " * "  ; break; 
    case CDOmExprOp::OP_BINARY_ARITHMETIC_DIV           : buffout << " / "  ; break; 
    case CDOmExprOp::OP_BINARY_ARITHMETIC_MOD           : buffout << " % "  ; break; 
    case CDOmExprOp::OP_BINARY_EQUALITY_EQ              : buffout << " == " ; break; 
    case CDOmExprOp::OP_BINARY_EQUALITY_NOT_EQ          : buffout << " != " ; break; 
    case CDOmExprOp::OP_BINARY_IDENTITY_EQ_CASE         : buffout << " === "; break;  // FIX?
    case CDOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE     : buffout << " !== "; break;  // FIX?
    case CDOmExprOp::OP_BINARY_LOGIC_AND                : buffout << " && " ; break; 
    case CDOmExprOp::OP_BINARY_LOGIC_OR                 : buffout << " || " ; break; 
    case CDOmExprOp::OP_BINARY_RELATIONAL_LESS          : buffout << " < "  ; break; 
    case CDOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL    : buffout << " <= " ; break; 
    case CDOmExprOp::OP_BINARY_RELATIONAL_GREATER       : buffout << " > "  ; break; 
    case CDOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL : buffout << " >= " ; break; 
    case CDOmExprOp::OP_BINARY_BITWISE_AND              : buffout << " & "  ; break; 
    case CDOmExprOp::OP_BINARY_BITWISE_NAND             : buffout << " &~ " ; break;  // reversed to distinguish from unary ops
    case CDOmExprOp::OP_BINARY_BITWISE_OR               : buffout << " | "  ; break; 
    case CDOmExprOp::OP_BINARY_BITWISE_NOR              : buffout << " |~ " ; break; 
    case CDOmExprOp::OP_BINARY_BITWISE_XOR              : buffout << " ^ "  ; break; 
    case CDOmExprOp::OP_BINARY_BITWISE_XNOR             : buffout << " ^~ " ; break; 
    case CDOmExprOp::OP_BINARY_SHIFT_LEFT               : buffout << " << " ; break; 
    case CDOmExprOp::OP_BINARY_SHIFT_RIGHT              : buffout << " >> " ; break; 
    case CDOmExprOp::OP_TERNARY_COND                    : buffout << " ? "  ; break; 
    default                                             : buffout << "UNKNOWN OPERATOR";
  }
}

void CVerilogTestGen::createRandomExpr() {
  CDOmExprOp::EOpType rndOp = vectOpType[m_randomNumberGen.createRandomNum(vectOpType.size()-1)];
  if( rndOp & CDOmExprOp::OP_UNARY_MASK ) {
    createOpString( rndOp );
    createRandomIdentifier();
    buffout << ';' << endl;;
  } else if ( rndOp & CDOmExprOp::OP_BINARY_MASK ) {
    createRandomIdentifier();
    createOpString( rndOp );
    createRandomIdentifier();
    buffout << ';' << endl;
  } else if (rndOp & CDOmExprOp::OP_TERNARY_MASK ) {
    createRandomIdentifier();
    buffout << " ? ";
    createRandomIdentifier();
    buffout << " : ";
    createRandomIdentifier();
    buffout << ';' << endl;
  }
}
    
/*
string genVerilogCode::createExpr() {
//  if( state == DEF_RANDOM )
  string e =  createVar() + vc->getOpString() + createVar();
  return e;  
}
*/
// expressions can be generated

// genVerilogCode * vc = new genVerilogCode();
/*
string genVerilogCode getOpString(unsigned int i ) { return veo[i]; }

unsigned int genVerilogCode::uniqueNum() {
 return uid++; // uid is a member of genVerilogCode
}

string genVerilogCode::createVar() {
  string v =  var + uniqueNum();
  return v;  
}

string genVerilogCode::createStmtAssn() {
  string s =  createVar() + " = " + createVar();
  return s;  
}

// fix syntax
string genVerilogCode::createAlwaysBlock( vector<string> vs, string portList) {
  string a =  "always @(" + createVar() + portList + " ) begin" + std::endl;
  string:iterator i;
  foreach (i = vs.begin(), i < vs.end(), i++) {
    s+= i + ";" + std::endl;
  }
  s += "end" + std::endl;
  return a;  
}
*/
