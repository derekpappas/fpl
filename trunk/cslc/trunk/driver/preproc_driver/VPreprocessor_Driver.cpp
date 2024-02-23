#include "VPreprocessor.h"
#include <iostream>
using namespace std;
using namespace NSVerilogPreprocessor;

int main(int argc, char**argv) {
  if( argc != 3 ) {
    cerr << "Bad command line options" << endl;
    cerr << "Usage: preprocessor <inputFilename> <outputFileName> " << endl;
    return(1);
  }
  std::vector<std::string> pathDir;
  pathDir.push_back(string("../"));
  NSVerilogPreprocessor::CPreprocessor x(argv[1], argv[2], pathDir);
  x.start();
  for(std::vector<CTextMacro*>::const_iterator it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it)
    (*it)->debugInfo();
  const NSVerilogPreprocessor::CLineMapProcessor *lineMap = x.getLineMapping();
  lineMap->debugInfo();
  std::vector< std::pair<unsigned long, unsigned int> > *stateVect = x.getStateVect();
  cout << "---------- STATE VECTOR ---------" << endl;
  cout << "\tSize = " << stateVect->size() << endl;
  for( std::vector< std::pair<unsigned long, unsigned int> >::iterator it = stateVect->begin(); it != stateVect->end(); ++it ) {
    cout << "\t\t**************" << endl;
    cout << dec << "\t\tlineNumber = " << " " << showbase << " " << it->first << endl;
    unsigned int temp = it->second;
    cout << "\t\ttimescale = " << (temp>>7) << endl;
    unsigned char val1, val2, val3, val4;
    NSVerilogPreprocessor::CTimeScaleAdapter::getInstance()->getValues(temp>>7, val1, val2, val3, val4 );
    cout << "\t\ttimescale = " << (short)val1 << ' ' << (short)val2 << ' ' << (short)val3 << ' ' << (short)val4 << endl;
    cout << "\t\t";
    temp <<= sizeof(int)*8-16;
    for( unsigned short xxx = 0; xxx < 16; ++xxx) {
      if( temp<<1>>1 == temp )
        cout << '0';
      else
        cout << '1';
      if( xxx%4 == 3 )
        cout << ' ';
      temp=temp<<1;
    }
    cout << endl;
    cout << hex << "\t\tstate      = " << " " << showbase << " " << it->second << endl;
  }
  for( long i = 1; i<6; ++i) {
    vector<TIncludeMap> filePath;
    unsigned long lineNumber;
    lineNumber = lineMap->traceLine(i, filePath);
    cout << endl << "line : " << i << endl;
    cout << "lineNumber = " << lineNumber << endl;
    for(vector<TIncludeMap>::const_iterator it = filePath.begin(); it != filePath.end(); ++it) {
      cout << it->m_fileName << endl;
      cout << it->m_lineNumber << endl;
    }
  }
  return 0;
}
