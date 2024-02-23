#include "ToolsParser.hpp"
#include <iostream>
#include <cstdlib>
#include <iterator>
#include <queue>
using namespace std;
using namespace antlr;

// -----------------------------------------------
// |         class CVerStringTokenizerDollar     |
// -----------------------------------------------
CVerStringTokenizerDollar::CVerStringTokenizerDollar ( string input ) {
  if( input.length() == 0 )
    return;

  //initialize m_ids
  m_ids.push_back(string());
  for( TUInt i = 0; i < input.length(); ++i ) {
    char c;
    if( ( c = input[i] ) == '$' )
      m_ids.push_back(string());
    else
      m_ids[m_ids.size()-1].push_back(c);
  }
}

void myDestroy(antlr::RefAST &ast) {
  if(!ast.get())
    return;
  // std::cerr << "before destroy" << endl;
  std::queue<RefAST> destroyQueue;
  destroyQueue.push(ast);
  ast = 0;
  RefAST temp1, temp2;
  while(!destroyQueue.empty()) {
    temp1 = destroyQueue.front();
    destroyQueue.pop();
    temp2 = temp1->getFirstChild();
    temp1->setFirstChild(RefAST(0));
    if(temp2.get())
      destroyQueue.push(temp2);
    temp2 = temp1->getNextSibling();
    temp1->setNextSibling(RefAST(0));
    if(temp2.get())
      destroyQueue.push(temp2);
    temp1 = 0;
    temp2 = 0;
  }

  //  std::cerr << "after destroy" << endl;
}

//End of file

