#include <iostream>
#include <sstream>
#include <fstream>

#include "CSLPreprocessor.h"
#include <cassert>
#include <cstdlib>
#include <cerrno>
using namespace std;

namespace NSCslPreprocessor {
  
// **********************************************
// CPreprocessor class
// **********************************************
void CPreprocessor::handleWS() {
    
  if( c == SPACE_CHAR || c == TAB_CHAR ) {
    while( (c=m_input.top()->peek()) == SPACE_CHAR || c == TAB_CHAR ) m_input.top()->get();
    if( IS_EOF_CHAR(c) ) {
      delete m_input.top();
      m_input.pop();
      if( !m_condDirsModelStack.top()->canEliminate() ) {
        cerr << "Preprocessor error: no endif to if found before end of file:" << m_fileNameStack.back() << endl;
        exit(1);
      }
      delete m_condDirsModelStack.top();
      m_condDirsModelStack.pop();
      m_lineMapper->delFile();
      m_fileNameStack.pop_back();
      return;
    }
    else if( c != NEWLINE_CHAR ) {
      if( prev != NEWLINE_CHAR && prev != SPACE_CHAR && prev != TAB_CHAR )
        if( writeEnable )
          m_output->put(prev=SPACE_CHAR);
      return;
    }
    c = m_input.top()->get();
  }
  // c == NEWLINE_CHAR
  assert( c == NEWLINE_CHAR );
  //  if( prev != NEWLINE_CHAR ) {
  if( c==NEWLINE_CHAR ) {
    if( writeEnable ) {
      m_output->put(prev=NEWLINE_CHAR);
      m_lineMapper->addLine();
    } else {
      m_lineMapper->addLineInputOnly();
    }
  }
  //  }
  //else {
  //    m_lineMapper->addLineInputOnly();
  //}

  m_indentBuffer.clear();
  cleanLine = 1;
  while(1) {
    while( ( c=m_input.top()->peek()) == SPACE_CHAR || c == TAB_CHAR || c == NEWLINE_CHAR) {
      m_input.top()->get();
      m_indentBuffer.push_back(c);
      if ( c == NEWLINE_CHAR ) {
	m_lineMapper->addLine();
      }
    }
    //
    //if( c == NEWLINE_CHAR ) {
    // m_indentBuffer.clear();
    // m_input.top()->get();
    // m_lineMapper->addLineInputOnly();
    // continue;
    //}
    //
    if( IS_EOF_CHAR(c) ) {
      delete m_input.top();
      m_input.pop();
      if( !m_condDirsModelStack.top()->canEliminate() ) {
        cerr << "Preprocessor error: no endif to if found before end of file:" << m_fileNameStack.back() << endl;
        exit(1);
      }
      delete m_condDirsModelStack.top();
      m_condDirsModelStack.pop();
      m_fileNameStack.pop_back();
      m_lineMapper->delFile();
      return;
    }
    break;
  }
  
}

void CPreprocessor::handleWSFirst() {
  
 m_indentBuffer.clear();
 cleanLine = 1;
 while(1) {
    while( (c=m_input.top()->peek()) == SPACE_CHAR || c == TAB_CHAR ) {
      m_input.top()->get();
      m_indentBuffer.push_back(c);
    }
    if( c == NEWLINE_CHAR ) {
      m_indentBuffer.clear();
      m_input.top()->get();
      m_lineMapper->addLineInputOnly();
      continue;
    }
  if( IS_EOF_CHAR(c) ) {
    delete m_input.top();
    m_input.pop();
    if( !m_condDirsModelStack.top()->canEliminate() ) {
      cerr << "Preprocessor error: no endif to if found before end of file:" << m_fileNameStack.back() << endl;
      exit(1);
    }
    delete m_condDirsModelStack.top();
    m_condDirsModelStack.pop();
    m_fileNameStack.pop_back();
    m_lineMapper->delFile();
    return;
  }
  break;
 }
  
}

void CPreprocessor::handleString() { 
  if( writeEnable )
    m_output->put(prev=c);
  cleanLine = 0;
  do {
    c = m_input.top()->get();
    if( m_input.top()->eof() ) {
      cerr << "Preprocessor error: unexpected end of file inside string" << endl;
      exit(1);
    }
    if( c == NEWLINE_CHAR ) {
      cerr << "Preprocessor error: unexpected end of line inside string" << endl;
      exit(1);
    }
    if( c == '\\' && m_input.top()->peek() == '\\' ) {
      if(writeEnable) {
        m_output->put(c);
        m_output->put(c);
      }
      m_input.top()->get();
      prev = 10;
    }
    else if( c == '"' && prev != '\\' ) {
      if( writeEnable )
        m_output->put(prev=c);
      return;
    }
    else if( writeEnable )
      m_output->put(prev=c);
  } while (1);
}

void CPreprocessor::handleEscapedIdentifier() {
  if( writeEnable )
    m_output->put(prev=c);
  while( (c=m_input.top()->peek()) != SPACE_CHAR && c != TAB_CHAR && c != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) ) {
    if( writeEnable )
      m_output->put(prev=m_input.top()->get());
    else
      m_input.top()->get();
  }
}

void CPreprocessor::handleCLikeComment() { 
  m_input.top()->get();
  bool continueFlag = true;
  if( prev != NEWLINE_CHAR ) {
    continueFlag = false;
    while( (c=m_input.top()->get()) != '*' || m_input.top()->peek() != '/' ) {
      if( IS_EOF_CHAR(c) ) {
        cerr << "Unexpected end of file" << endl;
        delete m_input.top();
        m_input.pop();
        if( !m_condDirsModelStack.top()->canEliminate() ) {
          cerr << "Preprocessor error: no endif to if found before end of file:" << m_fileNameStack.back() << endl;
          exit(1);
        }
        delete m_condDirsModelStack.top();
        m_condDirsModelStack.pop();
        m_fileNameStack.pop_back();
        m_lineMapper->delFile();
        if( m_input.empty() ) {
          cerr << "Preprocessor error: unclosed comment" << endl;
          exit(1);
        }
        if( writeEnable )
          m_output->put(prev=NEWLINE_CHAR);
        continueFlag = true;
        break;
      }
      if( c == NEWLINE_CHAR ) {
        if( writeEnable && prev != NEWLINE_CHAR) {
          m_output->put(prev=c);
          m_lineMapper->addLine();
        }
        else
          m_lineMapper->addLineInputOnly();
        cleanLine = 1;
        continueFlag = true;
        break;
      }
    }
  }
  if( continueFlag )
    while( (c=m_input.top()->get()) != '*' || m_input.top()->peek() != '/' ) {
      if( c == NEWLINE_CHAR )
        m_lineMapper->addLineInputOnly();
      if( IS_EOF_CHAR(c) ) {
        delete m_input.top();
        m_input.pop();
        if( !m_condDirsModelStack.top()->canEliminate() ) {
          cerr << "Preprocessor error: no endif to if found before end of file:" << m_fileNameStack.back() << endl;
          exit(1);
        }
        delete m_condDirsModelStack.top();
        m_condDirsModelStack.pop();
        m_fileNameStack.pop_back();
        m_lineMapper->delFile();
        if( m_input.empty() ) {
          cerr << "Preprocessor error: unclosed comment" << endl;
          exit(1);
        }
      }
    }
  c = m_input.top()->get();
  assert(c == '/'); //next char must be '/'
  if( prev != SPACE_CHAR && prev != NEWLINE_CHAR && prev != TAB_CHAR && (c=m_input.top()->peek()) != SPACE_CHAR && c != NEWLINE_CHAR && c != TAB_CHAR && IS_NOT_EOF_CHAR(c))
    if( writeEnable )
      m_output->put(prev=SPACE_CHAR);
}

void CPreprocessor::handleCPPLikeComment() { 
  m_input.top()->get();
  while( (c=m_input.top()->peek()) != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) ) {
    m_input.top()->get();
  }
  if( IS_EOF_CHAR(c) ) {
    if( prev != NEWLINE_CHAR )
      if( writeEnable ) {
        m_output->put(prev=NEWLINE_CHAR);
        m_lineMapper->addLineOutputOnly();
      }
    delete m_input.top();
    m_input.pop();
    if( !m_condDirsModelStack.top()->canEliminate() ) {
      cerr << "Preprocessor error: no endif to if found before end of file:" << m_fileNameStack.back() << endl;
      exit(1);
    }
    delete m_condDirsModelStack.top();
    m_condDirsModelStack.pop();
    m_fileNameStack.pop_back();
    m_lineMapper->delFile();
    return;
  }
}


void CPreprocessor::handleDirective() {
  string macroName;
  macroName = CTextMacro::readMacroName( *m_input.top() );
  if( !writeEnable ) {
    if( macroName == m_predefinedMacros[3] ) { //else
      if( !cleanLine ) {
        cerr << "Preprocessor error: else: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: else: invalid use of this directive" << endl;
        exit(1);
      }
      m_condDirsModelStack.top()->addElse();
    }
    else if( macroName == m_predefinedMacros[4] ) { //elsif
      if( !cleanLine ) {
        cerr << "Preprocessor error: elsif: invalid use of this directive" << endl;
        exit(1);
      }
      string param = getIdentifier(m_predefinedMacros[4]);
      m_condDirsModelStack.top()->addElsif(param);
    }
    else if( macroName == m_predefinedMacros[6] ) { //endif
      if( !cleanLine ) {
        cerr << "Preprocessor error: endif: invalid use of this directive" << endl;
        exit(1);
      }
      m_condDirsModelStack.top()->addEndIf();
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: endif: invalid use of this directive" << endl;
        exit(1);
      }
    }
    else if( macroName == m_predefinedMacros[7] ) { //ifdef
      if( !cleanLine ) {
        cerr << "Preprocessor error: ifdef: invalid use of this directive" << endl;
        exit(1);
      }
      string param = getIdentifier(m_predefinedMacros[7]);
      m_condDirsModelStack.top()->addIfDef(param);
    }
    else if( macroName == m_predefinedMacros[8] ) { //ifndef
      if( !cleanLine ) {
        cerr << "Preprocessor error: ifdef: invalid use of this directive" << endl;
        exit(1);
      }
      string param = getIdentifier(m_predefinedMacros[8]);
      m_condDirsModelStack.top()->addIfnDef(param);
    }
  } else {
    if( macroName == m_predefinedMacros[0] ) { //celldefine
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      if( m_state & andMaskCellDef | orMaskCellDef != m_state ) {
        m_state = m_state & andMaskCellDef | orMaskCellDef;
        if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
          m_stateVect->pop_back();
        m_stateVect->push_back(make_pair(m_lineMapper->getCurrentOutputLine(), m_state));
      }
    }
    else if( macroName == m_predefinedMacros[1] ) { //default_nettype
      handleDefaultNettypeDirective();
    }
    else if( macroName == m_predefinedMacros[2] ) { //define
      handleDefineDirective();
    }
    else if( macroName == m_predefinedMacros[3] ) { //else
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: else: invalid use of this directive" << endl;
        exit(1);
      }
      m_condDirsModelStack.top()->addElse();
    }
    else if( macroName == m_predefinedMacros[4] ) { //elsif
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      string param = getIdentifier(m_predefinedMacros[4]);
      m_condDirsModelStack.top()->addElsif(param);
    }
    else if( macroName == m_predefinedMacros[5] ) { //endcelldefine
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: endcelldefine: invalid use of this directive" << endl;
        exit(1);
      }
      if( m_state & andMaskCellUndef | orMaskCellUndef != m_state) {
        m_state = m_state & andMaskCellUndef | orMaskCellUndef;
        if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
          m_stateVect->pop_back();
        m_stateVect->push_back(make_pair(m_lineMapper->getCurrentOutputLine(), m_state));
      }
    }
    else if( macroName == m_predefinedMacros[6] ) { //endif
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: endif: invalid use of this directive" << endl;
        exit(1);
      }
      m_condDirsModelStack.top()->addEndIf();
    }
    else if( macroName == m_predefinedMacros[7] ) { //ifdef
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      string param = getIdentifier(m_predefinedMacros[7]);
      m_condDirsModelStack.top()->addIfDef(param);
    }
    else if( macroName == m_predefinedMacros[8] ) { //ifndef
      if( !cleanLine ) {
        cerr << "Preprocessor error: celldefine: invalid use of this directive" << endl;
        exit(1);
      }
      string param = getIdentifier(m_predefinedMacros[8]);
      m_condDirsModelStack.top()->addIfnDef(param);
    }
    else if( macroName == m_predefinedMacros[9] ) //include
      handleIncludeDirective();
    else if( macroName == m_predefinedMacros[10] ) { //line
      handleLineDirective();
    }
    else if( macroName == m_predefinedMacros[11] ) { //nounconnected_drive
      if( !cleanLine ) {
        cerr << "Preprocessor error: nounconnected_drive: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: nounconnected_drive: invalid use of this directive" << endl;
        exit(1);
      }
      if( m_state & andMaskNoDrive | orMaskNoDrive != m_state) {
        m_state = m_state & andMaskNoDrive | orMaskNoDrive;
        if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
          m_stateVect->pop_back();
        m_stateVect->push_back(make_pair(m_lineMapper->getCurrentOutputLine(), m_state));
      }
    }
    else if( macroName == m_predefinedMacros[12] ) { //resetall
      if( !cleanLine ) {
        cerr << "Preprocessor error: resetall: invalid use of this directive" << endl;
        exit(1);
      }
      if( !lineCleanRest() ) {
        cerr << "Preprocessor error: resetall: invalid use of this directive" << endl;
        exit(1);
      }
      if( m_state & andMaskResetAll | orMaskResetAll != m_state) {
        m_state = m_state & andMaskResetAll | orMaskResetAll;
        if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
          m_stateVect->pop_back();
        m_stateVect->push_back(make_pair(m_lineMapper->getCurrentOutputLine(), m_state));
      }
    }
    else if( macroName == m_predefinedMacros[13] ) { //timescale
      handleTimeScaleDirective();
    }
    else if( macroName == m_predefinedMacros[14] ) { //unconnected_drive
      handleUnconnectedDriveDirective();
    }
    else if( macroName == m_predefinedMacros[15] ) //undef
      handleUndefineDirective();
    else 
      handleDefaultDirective( macroName ); //may be it is a user defined text macro ?
  }
  m_indentBuffer.clear();
}

void CPreprocessor::handleIncludeDirective() { 
  if(!cleanLine) {
    cerr << "Preprocessor error: invalid use of include directive" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: invalid include syntax" << endl;
    exit(1);
  }
  string fileName = readFileName(m_predefinedMacros[9]);
  if( !lineCleanRest() ) {
    cerr << "Preprocessor error: invalid use of include directive" << endl;
    exit(1);
  }
  //Check for loops in the stack
  for( unsigned int i = 0; i < m_fileNameStack.size(); ++i ) {
    if( fileName == m_fileNameStack[i] ) {
      cerr << "Preprocessor error: include loop detected" << endl;
      exit(1);
    }
  }
  m_input.push( new ifstream(fileName.c_str()) );
  if(!m_input.top()->is_open()) {
    for(std::vector<std::string>::iterator it = m_dirpath.begin(); it < m_dirpath.end(); ++it) {
      if(!m_input.top()->is_open()) {
        ifstream* fileP = m_input.top();
        delete fileP;
        m_input.pop();
        std::string concat = *it;
        concat += fileName;
        m_input.push( new ifstream(concat.c_str()));
      }
      else
        break;
    }
  }
  
  if( !m_input.top()->is_open()) {
    cerr << "Preprocessor error: include: cannot open included file: " << fileName << endl;
    exit(1);
  }
  m_fileNameStack.push_back( fileName );
  m_condDirsModelStack.push( new CCondDirectivesModel() );
  m_lineMapper->newFile(fileName );
}

void CPreprocessor::handleDefineDirective() {
  if(!cleanLine) {
    cerr << "Preprocessor error: invalid use of define directive" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: invalid define syntax" << endl;
    exit(1);
  }
  string macroName;
  macroName = CTextMacro::readMacroName( *m_input.top() );
  for( vector<string>::iterator it = m_predefinedMacros.begin(); it != m_predefinedMacros.end(); ++it )
    if( macroName == *it ) {
      cerr << "Preprocessor error: can't redefine predefined macro: " << macroName << endl;
      exit(1);
    }
  vector<CTextMacro*>::iterator it;
  for( it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it )
    if(macroName==(*it)->getName()) {
      break;
    }
  vector<string> inputArgs;
  //If the next token in the stream is '(' then this macro has paramteters and we have to parse them
  if( m_input.top()->peek() == '(' ) {
    m_input.top()->get();
    string idName;
    while( 1 ) {
      idName.clear();
      if( lineCleanCommentsAndWS() ) {
        cerr << "Preprocessor error: define: expecting directive argument name, found end of line" << endl;
        exit(1);
      }
      if( !possibleIdFirst(c=m_input.top()->get()) ) {
        cerr << "Preprocessor error: define: directive argument name can't start with: " << c << endl;
        exit(1);
      }
      idName.push_back(c);
      while( possibleId(c=m_input.top()->peek()) )
        idName.push_back(m_input.top()->get());
      inputArgs.push_back(idName);
      if( lineCleanCommentsAndWS() ) {
        cerr << "Preprocessor error: define: expecting directive argument name, found end of line" << endl;
        exit(1);
      }
      if( (c = m_input.top()->get()) == ')') // end of args definition
        break;
      else if( c == ',' ) //next argument
        continue;
      else {
        cerr << "Preprocessor error: define: unexpected token: " << c << endl;
        exit(1);
      }
    }
  }
  if( lineCleanCommentsAndWS() ) {
    // the define is null
    while( (c=m_input.top()->get()) != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) );
    if( it != CTextMacro::definedMacroList.end() )
      (*it)->redefine( vector<string>(), string());
    else
      CTextMacro::definedMacroList.push_back(new CTextMacro(macroName, vector<string>(), string()));
    if( c == NEWLINE_CHAR )
      m_input.top()->putback(NEWLINE_CHAR);
    return;
  }
  string outputFormat;
  char tprev=' ';
  while( (c=m_input.top()->get()) != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) ) {
    if( c == '/' ) {
      if( m_input.top()->peek() == '/' ) {
        m_input.top()->get();
        while( (c=m_input.top()->get()) != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) );
        break;
      }
      if( m_input.top()->peek() == '*' ) {
        m_input.top()->get();
        bool endDefine = false;
        while( (c=m_input.top()->get()) != '*' || m_input.top()->peek() != '/' ) {
          if( c == NEWLINE_CHAR ) {
            endDefine = true;
            m_lineMapper->addLineInputOnly();
          }
          else if( IS_EOF_CHAR(c) ) {
            endDefine = true;
            delete m_input.top();
            m_input.pop();
            m_fileNameStack.pop_back();
            m_lineMapper->delFile();
            if( m_input.empty() ) {
              cerr << "Preprocessor error: unfinished comment" << endl;
              exit(1);
            }
          }
        }
        c=m_input.top()->get();
        assert(c=='/');
        if( endDefine )
          break;
        //If c-like comments are used also as a token delimiter
        //we keep the tokens separated by adding an extra ' ' character to the define output format
        if( m_input.top()->peek() == '\\' ) {
          c = m_input.top()->get();
          if( m_input.top()->peek() == NEWLINE_CHAR ) {
            outputFormat.push_back(m_input.top()->get());
            continue;
          }
          else {
            outputFormat.push_back(tprev=SPACE_CHAR);
            outputFormat.push_back(tprev=c);
            continue;
          }
        }
        else if( tprev != SPACE_CHAR && tprev != TAB_CHAR && m_input.top()->peek() != SPACE_CHAR 
            && m_input.top()->peek() != TAB_CHAR && IS_NOT_EOF_CHAR(m_input.top()->peek()) && m_input.top()->peek() != NEWLINE_CHAR )
          c = SPACE_CHAR;
        else
          continue;
      }
    }
    if( c == '\\' ) {
      //If a '\\' is folowed by a newline, then the macro output format should contain the newline
      if( m_input.top()->peek() == NEWLINE_CHAR ) {
        outputFormat.push_back(m_input.top()->get());
        m_lineMapper->addLineInputOnly();
        continue;
      }
      else {
        if( IS_EOF_CHAR(c) )
          break;
        outputFormat.push_back(c);
        if( c == SPACE_CHAR || c == TAB_CHAR )
          continue;
        while( (c=m_input.top()->get()) != NEWLINE_CHAR && c != SPACE_CHAR && c != TAB_CHAR && IS_NOT_EOF_CHAR(c) ) {
    	    if( c < 32 || c > 126 ) {
    		// Is is a non-text ASCII character
    		cerr << "Preprocessor error: invalid character found. (ASCII Code  " << m_input.top()->peek() << ")" << endl;
    		exit(1);
    	    }
            outputFormat.push_back(c);
        } // end while
        if( c == NEWLINE_CHAR || IS_EOF_CHAR(c) )
          break;
	if( c < 32 || c > 126 ) {
    	    // Is is a non-text ASCII character
    	    cerr << "Preprocessor error: invalid character found. (ASCII Code  " << m_input.top()->peek() << ")" << endl;
    	    exit(1);
    	}
        outputFormat.push_back(c);
      }
      continue;
    }
    if( (c < 32 || c > 126) && c !=NEWLINE_CHAR && c != TAB_CHAR && IS_NOT_EOF_CHAR(c)) {
    	// Is is a non-text ASCII character
	cerr << "Preprocessor error: invalid character found: " << c << endl;
	exit(1);
    }
    outputFormat.push_back(tprev=c);
  }
  //for keeping the indentation we have to put back the newline character into the stream
  if( c == NEWLINE_CHAR )
    m_input.top()->putback(NEWLINE_CHAR);
  if( it != CTextMacro::definedMacroList.end() )
    (*it)->redefine( inputArgs, outputFormat);
  else
    CTextMacro::definedMacroList.push_back(new CTextMacro(macroName, inputArgs, outputFormat));
}

void CPreprocessor::handleUndefineDirective() {
  string macroName = getIdentifier(m_predefinedMacros[15]);
  vector<CTextMacro*>::iterator it;
  for( it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it )
    if( (*it)->getName() == macroName ) {
      delete *it;
      CTextMacro::definedMacroList.erase(it);
      return;
    }
  cout << "Preprocessor warning: can't undefine " << macroName << " macro" << endl;
}

void CPreprocessor::handleLineDirective() {
  int errnoTemp = errno;
  errno = 0;
  if( !cleanLine ) {
    cerr << "Preprocessor error: line directive: invalid use of line directive" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: invalid line directive syntax" << endl;
    exit(1);
  }
  string lineNumberStr;
  if( !isdigit(m_input.top()->peek())) {
    cerr << "Preprocessor error: invalid line syntax, expecting long number, found: " << (char)m_input.top()->peek() << endl;
    exit(1);
  }
  lineNumberStr.push_back(m_input.top()->get());
  while( isdigit(m_input.top()->peek()) )
    lineNumberStr.push_back(m_input.top()->get());
  unsigned long lineNumber = strtoul(lineNumberStr.c_str(), NULL, 10);
  if( lineNumber < 1 ) {
    cerr << "Preprocessor error: line directive: invalid line number - must be positive" << endl;
    exit(1);
  }

  if( errno == ERANGE ) {
    cerr << "Preprocessor error: line directive: invalid line number" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: invalid line directive syntax" << endl;
    exit(1);
  }
  string fileName = readFileName(m_predefinedMacros[10]);
  
  const char* cfileName = fileName.data();
    
  fstream fileHandle;
  fileHandle.open(cfileName, fstream::in);
  if (fileHandle.fail()){
    cerr << "Preprocessor error: invalid include file" << endl;	
    exit(1);
  }
  else{
    fileHandle.close();        
  }
  
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: invalid line directive syntax" << endl;
    exit(1);
  }
  unsigned char level;
  switch (c=m_input.top()->get()) {
    case '0':
      level = 0;
      break;
    case '1':
      level = 1;
      break;
    case '2':
      level = 2;
      break;
    default:
      cerr << "Preprocessor error: invalid line directive syntax reading level, expecting 0, 1 or 2, found:" << c << endl;
      exit(1);
  }
  if( !lineCleanRest() ) {
    cerr << "Preprocessor error: invalid use of line directive" << endl;
    exit(1);
  }
  m_lineMapper->lineMap(lineNumber, fileName, level);
  errno = errnoTemp;
}

void CPreprocessor::readTime(unsigned char &tm, unsigned char &tu) {
  tm = 1;
  if( m_input.top()->get() != '1' ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive" << endl;
    exit(1);
  }
  if( m_input.top()->peek() == '0' ) {
    m_input.top()->get();
    ++tm;
  }
  if( m_input.top()->peek() == '0' ) {
    m_input.top()->get();
    ++tm;
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive" << endl;
    exit(1);
  }
  char tuchar = m_input.top()->get();
  if( tuchar == 's' ) {
    tu = 1;
    return;
  }
  if( m_input.top()->get() != 's' ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive" << endl;
    exit(1);
  }
  switch(tuchar) {
    case 'm':
      tu = 2;
      break;
    case 'u':
      tu = 3;
      break;
    case 'n':
      tu = 4;
      break;
    case 'p':
      tu = 5;
      break;
    case 'f':
      tu = 6;
      break;
    default:
      cerr << "Preprocessor error: timescale: invalid use of this directive" << endl;
      exit(1);
  }
}

void CPreprocessor::handleTimeScaleDirective() { 
  if( !cleanLine ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << (char)m_input.top()->peek() << endl;
    cerr << "Preprocessor error: timescale: invalid use of this directive, expecting time unit" << endl;
    exit(1);
  }
  unsigned char tum, tuu, tpu, tpm;
  readTime(tum, tuu);
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive, expecting / character" << endl;
    exit(1);
  }
  if( m_input.top()->get() != '/' ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive, expecting / characted" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive, expecting time precision" << endl;
    exit(1);
  }
  readTime(tpm, tpu);
  if( !lineCleanRest() ) {
    cerr << "Preprocessor error: timescale: invalid use of this directive" << endl;
    exit(1);
  }
  if( tpu < tuu || tuu == tpu && tum < tpm ) {
    cerr << "Preprocessor error: timescale: invalid time precision must be smaller than time unit" << endl;
    exit(1);
  }
  unsigned int temp1 = CTimeScaleAdapter::getInstance()->getTimeScale(tum, tuu, tpm, tpu) << 7;
  if( m_state & 0x007F | temp1 != m_state ) {
    m_state = m_state & 0x007F | temp1;
    if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
      m_stateVect->pop_back();
    m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
  } 
}

void CPreprocessor::handleUnconnectedDriveDirective() { 
  if( !cleanLine ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
  if( m_input.top()->get() != 'p' ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
  if( m_input.top()->get() != 'u' ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
  if( m_input.top()->get() != 'l' ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
  if( m_input.top()->get() != 'l' ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
  char val;
  val = m_input.top()->get();
  if( !lineCleanRest() ) {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }

  if( val == '1' ) {
    if( m_state & andMaskPull1Drive | orMaskPull1Drive != m_state ) {
      m_state = m_state & andMaskPull1Drive | orMaskPull1Drive;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( val == '0' ) {
    if( m_state & andMaskPull0Drive | orMaskPull0Drive != m_state ) {
      cout << "test" << endl;
      cout << m_state << endl;
      m_state = m_state & andMaskPull0Drive | orMaskPull0Drive;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
      cout << m_state << endl;
    }
  }
  else {
    cerr << "Preprocessor error: unconnected_drive: invalid use of this directive" << endl;
    exit(1);
  }
}

void CPreprocessor::handleDefaultNettypeDirective() {
  if( !cleanLine ) {
    cerr << "Preprocessor error: default_nettype: invalid use of this directive" << endl;
    exit(1);
  }
  string netType = getIdentifier( m_predefinedMacros[1] );
  if( netType == "wire" ) {
    if( m_state & andMaskWire | orMaskWire != m_state ) {
      m_state = m_state & andMaskWire | orMaskWire;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "tri" ) {
    if( m_state & andMaskTri | orMaskTri != m_state ) {
      m_state = m_state & andMaskTri | orMaskTri;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "tri0" ) {
    if( m_state & andMaskTri0 | orMaskTri0 != m_state ) {
      m_state = m_state & andMaskTri0 | orMaskTri0;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "tri1" ) {
    if( m_state & andMaskTri1 | orMaskTri1 != m_state ) {
      m_state = m_state & andMaskTri1 | orMaskTri1;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "wand" ) {
    if( m_state & andMaskWand | orMaskWand != m_state ) {
      m_state = m_state & andMaskWand | orMaskWand;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "triand" ) {
    if( m_state & andMaskTriand | orMaskTriand != m_state ) {
      m_state = m_state & andMaskTriand | orMaskTriand;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "wor" ) {
    if( m_state & andMaskWor | orMaskWor != m_state ) {
      m_state = m_state & andMaskWor | orMaskWor;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "trior" ) {
    if( m_state & andMaskTrior | orMaskTrior != m_state ) {
      m_state = m_state & andMaskTrior | orMaskTrior;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "trireg" ) {
    if( m_state & andMaskTrireg | orMaskTrireg != m_state ) {
      m_state = m_state & andMaskTrireg | orMaskTrireg;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else if( netType == "none" ) {
    if( m_state & andMaskNone | orMaskNone != m_state ) {
      m_state = m_state & andMaskNone | orMaskNone;
      if( !m_stateVect->empty() && m_stateVect->back().first == m_lineMapper->getCurrentOutputLine() )
        m_stateVect->pop_back();
      m_stateVect->push_back( make_pair(m_lineMapper->getCurrentOutputLine(), m_state) );
    }
  }
  else {
    cerr << "Preprocessor error: default_nettype: invalid net type:" << netType << endl;
    exit(1);
  }
}

void CPreprocessor::handleDefaultDirective( string& name ) {
  vector<CTextMacro*>::iterator it;
  for( it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it)
    if( (*it)->getName() == name )
      break;
  if( it == CTextMacro::definedMacroList.end() ) {
    cerr << "Preprocessor error: user directive: directive " << name << " not found" << endl;
    exit(1);
  }

  vector<string> params;
  ostringstream out;
  if( (*it)->getNumberOfArguments() )
    CTextMacro::readParams(*m_input.top(), params);
  for( vector<string>::iterator it = params.begin(); it != params.end(); ++it )
    for( string::iterator strIter = it->begin(); strIter != it->end(); ++strIter )
      if( *strIter == NEWLINE_CHAR )
        m_lineMapper->addLineInputOnly();
  (*it)->toStream(params, out);
  if( !out.str().empty()) {
    //flushing the indentation to the output stream ;)
    if( CPreprocessor::writeEnable && !m_indentBuffer.empty() ) {
      *m_output << m_indentBuffer;
      prev = m_indentBuffer[m_indentBuffer.size()-1];
      m_indentBuffer.clear();
    }
    if( prev != NEWLINE_CHAR && prev != SPACE_CHAR && prev != TAB_CHAR )
      m_output->put(prev=SPACE_CHAR);
    for( string::size_type i = 0; i < out.str().size(); ++i )
      if( out.str()[i] == NEWLINE_CHAR )
        m_lineMapper->addLineOutputOnly();
    *m_output << out.str();
    prev = out.str()[out.str().size()-1];
    if( prev != NEWLINE_CHAR && prev != SPACE_CHAR && prev != TAB_CHAR )
      m_output->put(prev=SPACE_CHAR);
  }
}

int CPreprocessor::lineCleanCommentsAndWS() {
    
  while ( 1 ) {
    c = m_input.top()->peek();
    if( c == SPACE_CHAR || c == TAB_CHAR ) {
      m_input.top()->get();
      continue;
    }
    if( c == '/' ) {
      m_input.top()->get();
      c = m_input.top()->peek();
      if( c == '/' )
        return 1;
      else if( c == '*' ) {
        m_input.top()->get();
        while( (c=m_input.top()->get()) != '*' || m_input.top()->peek() != '/' ) {
          if( IS_EOF_CHAR(c) || c == NEWLINE_CHAR )
            return 2;
        }
        m_input.top()->get();
        continue;
      } else {
        m_input.top()->putback('/');
        return 0;
      }
    }
    if( c == NEWLINE_CHAR || IS_EOF_CHAR(c) )
      return 1;
    break;
  }
  return 0;
}

int CPreprocessor::lineCleanRest() {
  
  while( 1 ) {
    c = m_input.top()->peek();
    if( c == SPACE_CHAR || c == TAB_CHAR ) {
      m_input.top()->get();
      continue;
    }
    else if( c == '/' ) {
      m_input.top()->get();
      c = m_input.top()->peek();
      if( c == '/' ) {
        m_input.top()->get();
        while( (c=m_input.top()->peek()) != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) ) 
          m_input.top()->get();
      } else if( c == '*' ) {
        m_input.top()->get();
        int returnState=0; // checkes if a new line was reached, if so, hehe return ...
        while( (c=m_input.top()->get()) != '*' || m_input.top()->peek() != '/' ) {
          if( IS_EOF_CHAR(c) ) {
            returnState = 1;
            delete m_input.top();
            m_input.pop();
            m_fileNameStack.pop_back();
            m_lineMapper->delFile();
            if( m_input.empty() ) {
              cerr << "Preprocessor error: unfinished comment" << endl;
              exit(1);
            }
          }
          else if( c == NEWLINE_CHAR ) {
            returnState = 1;
            m_lineMapper->addLineInputOnly();
          }
        }
        m_input.top()->get();
        if( returnState )
          return 1;
      } else 
        return 0;
    }
    else if( c == NEWLINE_CHAR || IS_EOF_CHAR(c))
      return 1;
    else
      return 0;
  }
  return 1;
  
}

string CPreprocessor::getIdentifier(string &callingDirective) {
  if(!cleanLine) {
    cerr << "Preprocessor error: invalid use of " << callingDirective << " directive" << endl;
    exit(1);
  }
  if( lineCleanCommentsAndWS() ) {
    cerr << "Preprocessor error: invalid " << callingDirective << " syntax" << endl;
    exit(1);
  }
  string macroName;
  macroName = CTextMacro::readMacroName( *m_input.top() );
  if( !lineCleanRest() ) {
    cerr << "Preprocessor error: invalid use of " << callingDirective << " directive" << endl;
    exit(1);
  }
  return macroName;
}

string CPreprocessor::readFileName(string &callingDirective) {
  string fileName;
  c = m_input.top()->get();
  if( c != '"' ) {
    cerr << "Preprocessor error: " << callingDirective << ": expecting '\"' character, found: " << c << endl;
    exit(1);
  }
  if( m_input.top()->peek() == '"' ) {
    cerr << "Preprocessor error: " << callingDirective << ": fileName can't be null" << endl;
    exit(1);
  }
  while( (c=m_input.top()->get()) != '"' ) {
    if( IS_EOF_CHAR(c) ) {
      cerr << "Preprocessor error: " << callingDirective << ": unexpected end of file" << endl;
      exit(1);
    }
    if( c == NEWLINE_CHAR ) {
      cerr << "Preprocessor error: " << callingDirective << ": unexpected end of line" << endl;
      exit(1);
    }
    fileName.push_back(c);
  }
  return fileName;
}

bool CPreprocessor::writeEnable = true;
vector<int> CPreprocessor::identifierTable = vector<int>();
vector<int> CPreprocessor::identifierTableFirst = vector<int>();

CPreprocessor::CPreprocessor(const char *inputFileName, const char *outputFileName, std::vector<std::string> &includePath) 
  : m_state(0), m_dirpath(includePath), c(SPACE_CHAR), prev(NEWLINE_CHAR), cleanLine(1) {
  for(std::vector<std::string>::iterator it = m_dirpath.begin(); it < m_dirpath.end(); ++it) {
    if(it->at(it->length()-1) != '/' && it->at(it->length()-1) != '\\') {
      it->append(1,'/');
    }
  } 
  identifierTable.assign(128,0);
  identifierTableFirst.assign(128,0);
  for( char c = 0x41; c != 0x5B; ++c ) // 'A'..'Z'  'a'..'z'
    identifierTableFirst[c] = identifierTableFirst[c|0x20] = identifierTable[c] = identifierTable[c|0x20] = 1;
  for( char c = 0x30; c != 0x3A; ++c ) // '0'..'9'
    identifierTable[c] = 1;
  identifierTableFirst[0x5F] = identifierTable[0x5F] = 1; // '_' character
  identifierTableFirst[0x24] = identifierTable[0x24] = 1; // '$' character
  m_input.push(new ifstream(inputFileName));
  if( !*m_input.top() ) {
    cerr << "Can't open file: " << inputFileName << endl;
    exit(1);
  }
  m_fileNameStack.push_back( inputFileName );
  m_condDirsModelStack.push( new CCondDirectivesModel() );

  m_output = new ofstream(outputFileName);
  if( !*m_output ) {
    cerr << "Can't open file: " << outputFileName << endl;
    exit(1);
  }
  //  m_predefinedMacros.push_back( "celldefine"          ); // 0
  //m_predefinedMacros.push_back( "default_nettype"     ); // 1
  m_predefinedMacros.push_back( "define"              ); // 2
  m_predefinedMacros.push_back( "else"                ); // 3
  m_predefinedMacros.push_back( "elsif"               ); // 4
  //m_predefinedMacros.push_back( "endcelldefine"       ); // 5
  m_predefinedMacros.push_back( "endif"               ); // 6
  m_predefinedMacros.push_back( "ifdef"               ); // 7
  m_predefinedMacros.push_back( "ifndef"              ); // 8
  m_predefinedMacros.push_back( "include"             ); // 9
  m_predefinedMacros.push_back( "line"                ); // 10
  //m_predefinedMacros.push_back( "nounconnected_drive" ); // 11
  m_predefinedMacros.push_back( "resetall"            ); // 12
  //m_predefinedMacros.push_back( "timescale"           ); // 13
  //m_predefinedMacros.push_back( "unconnected_drive"   ); // 14
  m_predefinedMacros.push_back( "undef"               ); // 15

  m_lineMapper = new CLineMapProcessor( string(inputFileName));
  m_stateVect = new vector< pair<unsigned long, unsigned int> >;
}

CPreprocessor::~CPreprocessor() {
  m_output->flush();
  delete m_output;
}

void CPreprocessor::start(){
  if( !m_input.empty() ) {
      if( (c=m_input.top()->peek()) == SPACE_CHAR || c == TAB_CHAR )
        handleWSFirst();
      else if( c == MACRO_CHAR ) {
        prev = SPACE_CHAR;
        m_input.top()->get();
        handleDirective();
        prev = NEWLINE_CHAR;
      }
  }
  while( !m_input.empty() ) {
    c = m_input.top()->get();
    if( m_input.top()->eof() ) {
      delete m_input.top();
      m_input.pop();
      m_lineMapper->delFile();
      m_fileNameStack.pop_back();
      continue;
    }
    switch( c ) {
      case MACRO_CHAR:
        handleDirective();
        break;
      case '"':
        //flushing the indentation to the output stream ;)
        if( CPreprocessor::writeEnable && !m_indentBuffer.empty() ) {
          *m_output << m_indentBuffer;
          prev = m_indentBuffer[m_indentBuffer.size()-1];
          m_indentBuffer.clear();
        }
        handleString();
        break;
      case '\\':
        //flushing the indentation to the output stream ;)
        if( CPreprocessor::writeEnable && !m_indentBuffer.empty() ) {
          *m_output << m_indentBuffer;
          prev = m_indentBuffer[m_indentBuffer.size()-1];
          m_indentBuffer.clear();
        }
        cleanLine = 0;
        handleEscapedIdentifier();
        break;
      case NEWLINE_CHAR:
        cleanLine = 1;
      case SPACE_CHAR:
      case TAB_CHAR:
        handleWS();
        break;
      case '/':
        if( m_input.top()->peek() == '*' ) {
          handleCLikeComment();
          break;
        }
        else if( m_input.top()->peek() == '/' ) {
          handleCPPLikeComment();
          break;
        }
      default :
        //flushing the indentation to the output stream ;)
        if( CPreprocessor::writeEnable && !m_indentBuffer.empty() ) {
          *m_output << m_indentBuffer;
          prev = m_indentBuffer[m_indentBuffer.size()-1];
          m_indentBuffer.clear();
        }
        if( writeEnable ) {
          m_output->put(prev=c);
        }
        cleanLine = 0;
    }
  }
  for( vector<CTextMacro*>::iterator it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it)
    delete *it;
  CTextMacro::definedMacroList.clear();
}

// **********************************************
// CTextMacro class
// **********************************************
vector<string> CTextMacro::inProgressStack = vector<string>();

void CTextMacro::validateIdentifierList(const std::vector<std::string> &idList) const { 
  for( unsigned int i=0; i<idList.size(); ++i) {
    if( idList[i].empty() ) {
      cerr << "CTextMacro::validateIdentifierList: Preprocessor error: a macro identifier can't be null" << endl;
      exit(1);
    }
    if( !CPreprocessor::possibleIdFirst(idList[i][0]) ) {
      cerr << "CTextMacro::validateIdentifierList: Preprocessor error: a macro identifier can't start with: " << idList[i][0] << endl;
      exit(1);
    }
    for( unsigned int j=0; j<idList[i].length(); ++j )
      if( !CPreprocessor::possibleId(idList[i][j]) ) {
        cerr << "CTextMacro::validateIdentifierList: Preprocessor error: a macro identifier name can't contain: " << idList[i][j] << endl;
        exit(1);
      }
  }
}

void CTextMacro::validateMacroName(){ 
  if( m_name[0] == '\\' ) {
    for( unsigned int i=1; i < m_name.length(); ++i ) {
      char c;
      if( (c=m_name[i]) == ' ' || c == TAB_CHAR || c == NEWLINE_CHAR ) {
        cerr << "CTextMacro::validateMacroName: Preprocessor error: escaped macro name can't contain white spaces" << endl;
        exit(1);
      }
    }
  }
  else {
    if( !CPreprocessor::possibleIdFirst(m_name[0]) ) {
      cerr << "CTextMacro::validateMacroName: Preprocessor error: macro name can't start with: " << m_name[0] << endl;
      exit(1);
    }
    for( unsigned int i=1; i<m_name.length(); ++i) {
      if( !CPreprocessor::possibleId(m_name[i]) ) {
        cerr << "CTextMacro::validateMacroName: Preprocessor error: macro name can't contain: " << m_name[i] << endl;
        exit(1);
      }
    }
  }
}

void CTextMacro::resolveInput( std::ostream &out, std::istream &in) {
  char c;
  while( 1 ) {
    if( (c=in.get()) == '`' ) {
      string macroName;
      macroName=readMacroName(in);
      vector<CTextMacro*>::iterator it;
      for( it = definedMacroList.begin(); it != definedMacroList.end(); ++it ) {
        if( (*it)->getName() == macroName )
          break;
      }
      if( it == definedMacroList.end() ) {
        cerr << "resolveInput" << endl;
        cerr << "Preprocessor error: user directive: directive " << macroName << " doesn't exist" << endl;
        exit(1);
      }
      vector<string> params;
      if( (*it)->getNumberOfArguments() )
        readParams(in, params); 
      out << (char)SPACE_CHAR;
      (*it)->toStream(params, out);
      out << (char)SPACE_CHAR;
    } else if( c == '\\' ) {
      out.put(c);
      while( (c=in.peek()) != SPACE_CHAR && c != TAB_CHAR && c != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) )
        out.put(in.get());
    } else if( c == '"' ) {
      char prev = 'x';
      out.put(c);
      do {
        c = in.get();
        if( in.eof() ) {
          cerr << "Preprocessor error: unexpected end of file inside string" << endl;
          exit(1);
        }
        if( c == NEWLINE_CHAR ) {
          cerr << "Preprocessor error: unexpected end of file inside string" << endl;
          exit(1);
        }
        else if( c == '"' && prev != '\\' ) {
          out.put(prev=c);
          break;
        }
        out.put(prev=c);
      } while (1);
    } else if( c == '/' ) {
      if( (c=in.peek()) == '/' ) {
        in.get();
        while( (c=in.get()) != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) )
          in.get();
        if( IS_EOF_CHAR(c) )
          return;
        out.put(c);
      } else if( c == '*' ) {
        char prev = 'x';
        in.get();
        while( (c=in.get()) != '/' && prev != '*' )
          prev = c;
      } else
        out.put('/');
    } else if( IS_EOF_CHAR(c) )
      return;
    else
      out.put(c);
  }
}

vector<CTextMacro*> CTextMacro::definedMacroList = vector<CTextMacro*>();

void CTextMacro::readParams( istream& in, std::vector<std::string> &out) {
  char c = in.peek();
  if( c != '(' )
    return;
  in.get();

  bool isNull = true;
  unsigned int braceCount=0, parenCount=0;
  char prev = 'x';
  out.push_back(string());
  while( 1 ) {
    c = in.get();
    if( IS_EOF_CHAR(c) ) {
      cerr << "Preprocessor error: user directive: unexpected end of file while reading input params" << endl;
      exit(1);
    }
    switch(c) {
      case '/':
        if( in.peek() == '/' ) {
          in.get();
          while( (c = in.peek()) != NEWLINE_CHAR ) {
            if(IS_EOF_CHAR(in.get()))
              cerr << "Preprocessor error: user directive: unexpected end of file while reading directives params" << endl;
              exit(1);
            }
        } else if( in.peek() == '*' ) {
          in.get();
          prev = 'x';
          while( prev != '*' || c != '/' ) {
            prev = c;
            c = in.get();
            if( IS_EOF_CHAR(c) ) {
              cerr << "Preprocessor error: user directive: unexpected end of file inside comment" << endl;
              exit(1);
            }
          }
          //A space character will be inserted if c-like comments are use also as token delimiters
          char x;
          if( out.back().size() != 0 )
            if( (x=out.back().at(out.back().size() - 1)) != NEWLINE_CHAR || x != TAB_CHAR || x != SPACE_CHAR 
                || (x=in.peek()) != NEWLINE_CHAR || x != TAB_CHAR || x != SPACE_CHAR )
              out.back().push_back(SPACE_CHAR);
        } else {
          out.back().push_back(c);
          isNull = false;
        }
        break;
      case '"':
        out.back().push_back(c);
        isNull = false;
        while( c != '"' || prev != '\\' ) {
          prev = c;
          c = in.get();
          if( c == NEWLINE_CHAR ) {
            cerr << "Preprocessor error: user directive: unexpected end of line inside string" << endl;
            exit(1);
          }
          if( IS_EOF_CHAR(c) ) {
            cerr << "Preprocessor error: user directive: unexpected end of file inside string" << endl;
            exit(1);
          }
          out.back().push_back(c);
        }
        out.back().push_back(c);
        break;
      case ')':
        if( parenCount == 0 ) {
          if( braceCount != 0 ) {
            cerr << "Preprocessor error: user directive: unexpected ')', unclosed brace " << endl;
            exit(1);
          }
          goto out;
        } else {
          --parenCount;
          out.back().push_back(c);
        }
        break;
      case ',':
        if( braceCount == 0 && parenCount == 0 ) {
          if(!out.back().size()) {
            cerr << "Preprocessor error: user directive: argument expression can't be null" << endl;
            exit(1);
          }
          if( isNull ) {
            cerr << "Preprocessor error: user directive: invalid expression argument" << endl;
            exit(1);
          }
          isNull = true;
          out.push_back(string());
        } else {
          out.back().push_back(c);
          isNull = false;
        }
        break;
      case '(':
        ++parenCount;
        isNull = false;
        out.back().push_back(c);
        break;
      case '{':
        isNull = false;
        ++braceCount;
        out.back().push_back(c);
        break;
      case '}':
        if( braceCount == 0 ) {
          cerr << "Preprocessor error: user directive: unexpected '}', unmatched brace" << endl;
          exit(1);
        }
        --braceCount;
      default:
        if( c != SPACE_CHAR && c != NEWLINE_CHAR && c != TAB_CHAR )
          isNull = false;
        out.back().push_back(c);
    }
  }
  out:
  if( isNull ) {
    cerr << "Preprocessor error: user directive: argument expression can't be null" << endl;
    exit(1);
  }
  else if( out.size() == 1 && !out.back().size() )
    out.pop_back();
  return;
}

string CTextMacro::readMacroName(istream &in) {
  string macroName;
  char c;
  if( in.peek() == '\\' ) {
    macroName.push_back(in.get());
    while( (c=in.peek()) >= 33 && c <= 126  ) {
      macroName.push_back(in.get());
    }
    if( c != TAB_CHAR && c != SPACE_CHAR && c != NEWLINE_CHAR && IS_NOT_EOF_CHAR(c) ) {
      cerr << "Preprocessor error: escaped identifier must end with a white space character" << endl;
      exit(1);
    }
    if( c == TAB_CHAR || c == SPACE_CHAR ) {
      in.get();
    }
  }
  else {
    if( !CPreprocessor::possibleIdFirst(c=in.peek()) ) {
      cerr << "Preprocessor error: identifier name can't start with:" << c << endl;
      exit(1);
    }
    macroName.push_back(in.get());
    while( CPreprocessor::possibleId(c=in.peek()) ) {
      macroName.push_back(in.get());
    }
  }
  return macroName;
}

CTextMacro::CTextMacro(const std::string &name, const std::vector<std::string> &identifierList, const string &outputFormat ) 
  : m_name(name) {
  assert( !name.empty() );
  validateMacroName();
  this->redefine( identifierList, outputFormat );
}

void CTextMacro::redefine( const std::vector<std::string> &identifierList, const string &outputFormat){
  string captured;
  string id;
  m_nrOfArguments = identifierList.size();
  validateIdentifierList( identifierList );
  m_outputvector.clear();
  for( unsigned int i=0; i<outputFormat.length(); ++i) {
    if( CPreprocessor::possibleIdFirst(outputFormat[i]) ) {
      id.clear();
      id.push_back(outputFormat[i]);
      while( ++i < outputFormat.length() && CPreprocessor::possibleId(outputFormat[i]) )
        id.push_back(outputFormat[i]);
      --i;
      unsigned int j;
      for( j = 0; j<identifierList.size(); ++j )
        if( id == identifierList[j] ) {
          if( !captured.empty() ) {
            m_outputvector.push_back( COutputItem(captured) );
            captured.clear();
          }
          m_outputvector.push_back( COutputItem( j ) );
          break;
        }
      if( j == identifierList.size() )
        captured += id;
    } else if(outputFormat[i] == '"') {
      // if a string is detected it is left as it is
      while( 1 ) {
        captured.push_back(outputFormat[i]);
        if( ++i == outputFormat.length() ) {
          cerr << "Preprocessor error: define: unclosed string found" << endl;
          exit(1);
        }
        if( outputFormat[i] == '"' ) {
          captured.push_back('"');
          break;
        }
        if( outputFormat[i] == '\\') {
          if( i+1 == outputFormat.length() ) {
            cerr << "Preprocessor error: define: unclosed string found" << endl;
            exit(1);
          }
          if( outputFormat[i+1] == '"' ) {
            captured.push_back('\\');
            ++i;
          }
        }
      }
    } else {
      captured.push_back(outputFormat[i]);
    }
  }
  if( !captured.empty() )
    m_outputvector.push_back( COutputItem( captured ) );
}

const string& CTextMacro::getName() const {
  return m_name;
}

void CTextMacro::toStream( const vector<string> &params, ostream &out ) {
  for( vector<string>::iterator it = inProgressStack.begin(); it != inProgressStack.end(); ++it )
    if( *it == m_name ) {
      cerr << "Preprocessor error: user directive: macro loop detected" << endl;
      exit(1);
    }
  inProgressStack.push_back(m_name);
  if( params.size() != m_nrOfArguments ) {
    cerr << "CTextMacro::toStream, Preprocessor error: define: wrong number of input arguments: expecting: "
      << m_nrOfArguments << ", found: " << params.size() << endl;
    cerr << "Directive: " << m_name << endl;
    exit(1);
  }
  //Expanding directive params
  vector<string> expandedParams;
  for( vector<string>::const_iterator it = params.begin(); it != params.end(); ++it ) {
    ostringstream paramOutput;
    istringstream paramInput(*it);
    resolveInput( paramOutput, paramInput );
    expandedParams.push_back( paramOutput.str() );
  }
  //Search/replace
  ostringstream dasOutput;
  for( vector<COutputItem>::iterator it = m_outputvector.begin(); it != m_outputvector.end(); ++it ) {
    switch( it->getType() ) {
      case COutputItem::ITEM_TYPE_STRING:
        dasOutput << it->getString();
        break;
      case COutputItem::ITEM_TYPE_IDENTIFIER:
        dasOutput << expandedParams[it->getIdentifier()];
        break;
      default:
        cerr << "CTextMacro::toStream: FATAL ERROR" << endl;
        exit(1);
    }
  }
  istringstream inpt(dasOutput.str());
  resolveInput( out, inpt );
  inProgressStack.pop_back();
}

void CTextMacro::debugInfo() {
  cout << "name: " << getName() << endl;
  cout << "m_nrOfArguments = " << m_nrOfArguments << endl;
  cout << "size = " << m_outputvector.size() << endl;
  for( unsigned int i=0; i<m_outputvector.size(); ++i) {
    cout << "Item: " << i << endl;
    switch( m_outputvector[i].getType() ) {
      case COutputItem::ITEM_TYPE_IDENTIFIER:
        cout << "Type = ITEM_TYPE_IDENTIFIER" << endl;
        cout << "Identifier = " << m_outputvector[i].getIdentifier() << endl;
        break;
      case COutputItem::ITEM_TYPE_STRING:
        cout << "Type = ITEM_TYPE_STRING" << endl;
        cout << "String = *****" << endl;
        cout << m_outputvector[i].getString();
        cout << "***** EndString" << endl;
        break;
      default:
        cerr << "CTextMacro::debugInfo: FATAL ERROR" << endl;
        exit(1);
    }
  }
}

vector<string>::size_type CTextMacro::getNumberOfArguments() const {
  return m_nrOfArguments;
}

// **********************************************
// COutputItem class
// **********************************************
COutputItem::COutputItem( const std::string &value) : m_type(ITEM_TYPE_STRING), m_value(value) { }

COutputItem::COutputItem( unsigned int value) : m_type(ITEM_TYPE_IDENTIFIER), m_identifier(value) { }

COutputItem::EItemType COutputItem::getType() const {
  return m_type;
}

unsigned int COutputItem::getIdentifier() const {
  assert(m_type == ITEM_TYPE_IDENTIFIER);
  return m_identifier;
}

const std::string COutputItem::getString() const {
  assert(m_type == ITEM_TYPE_STRING);
  return m_value;
}

// **********************************************
// CCondDirectivesModel class
// **********************************************
CCondDirectivesModel::CCondDirectiveModel::CCondDirectiveModel( const string& param, EDirIfType type, 
    const vector<CCondDirectivesModel::CCondDirectiveModel>::size_type level) 
  : m_state(STATE_FIRST), m_level(level) {
  vector<CTextMacro*>::iterator it;
  bool found = false;
  for( it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it )
    if( (*it)->getName() == param ) {
      found = true;
      break;
    }
  if( type == DIR_TYPE_IFNDEF ) {
    if( found ) {
      if( CPreprocessor::writeEnable ) {
        CCondDirectivesModel::blockLevel = m_level;
        CPreprocessor::writeEnable = false;
        m_wasAccepted = false;
      }
    }
    else {
      m_wasAccepted = true;
      if( !CPreprocessor::writeEnable && m_level == CCondDirectivesModel::blockLevel) {
        CPreprocessor::writeEnable = true;
      }
    }
  }
  else {
    if( found ) {
      m_wasAccepted = true;
      if( !CPreprocessor::writeEnable && m_level == CCondDirectivesModel::blockLevel) {
        CPreprocessor::writeEnable = true;
      }
    }
    else {
      if( CPreprocessor::writeEnable ) {
        CCondDirectivesModel::blockLevel = m_level;
        CPreprocessor::writeEnable = false;
        m_wasAccepted = false;
      }
    }
  }
}

CCondDirectivesModel::CCondDirectiveModel::~CCondDirectiveModel() {
  if( m_level == CCondDirectivesModel::blockLevel && !CPreprocessor::writeEnable ) {
    CPreprocessor::writeEnable = true;
  }
}

void CCondDirectivesModel::CCondDirectiveModel::toElsif( const string &param) { 
  if( m_state == STATE_ELSE ) {
    cerr << "Preprocessor error: unaccepted `elsif" << endl;
    exit(1);
  }
  m_state = STATE_ELSEIF;
  if( !m_wasAccepted ) {
    vector<CTextMacro*>::iterator it;
    bool found = false;
    for( it = CTextMacro::definedMacroList.begin(); it != CTextMacro::definedMacroList.end(); ++it )
      if( (*it)->getName() == param ) {
        found = true;
        break;
      }
    if( found ) {
      m_wasAccepted = true;
      if( !CPreprocessor::writeEnable && m_level == CCondDirectivesModel::blockLevel) {
        CPreprocessor::writeEnable = true;
      }
    }
    else {
      if( CPreprocessor::writeEnable ) {
        CCondDirectivesModel::blockLevel = m_level;
        CPreprocessor::writeEnable = false;
      }
    }
  }
  else {
    if( CPreprocessor::writeEnable ) {
      CCondDirectivesModel::blockLevel = m_level;
      CPreprocessor::writeEnable = false;
    }
  }
}
void CCondDirectivesModel::CCondDirectiveModel::toElse() {
  if( m_state == STATE_ELSE ) {
    cerr << "Preprocessor error: unaccepted `else" << endl;
    exit(1);
  }
  m_state = STATE_ELSE;
  if( !m_wasAccepted ) {
    m_wasAccepted = true;
    if( !CPreprocessor::writeEnable && m_level == CCondDirectivesModel::blockLevel) {
      CPreprocessor::writeEnable = true;
    }
  }
  else {
    if( CPreprocessor::writeEnable ) {
      CCondDirectivesModel::blockLevel = m_level;
      CPreprocessor::writeEnable = false;
    }
  }
}

CCondDirectivesModel::CCondDirectiveModel::ECondState CCondDirectivesModel::CCondDirectiveModel::getState() const { 
  return m_state; 
}

bool CCondDirectivesModel::CCondDirectiveModel::wasAccepted() const {
  return m_wasAccepted;
}

std::vector<CCondDirectivesModel::CCondDirectiveModel>::size_type CCondDirectivesModel::blockLevel = 1;

void CCondDirectivesModel::addIfDef( std::string &param ) {
  m_condDirStack.push_back( new CCondDirectiveModel(param, DIR_TYPE_IFDEF, m_condDirStack.size() ) );
}

void CCondDirectivesModel::addIfnDef( std::string &param) {
  m_condDirStack.push_back( new CCondDirectiveModel(param, DIR_TYPE_IFNDEF, m_condDirStack.size() ) );
}

void CCondDirectivesModel::addElsif( std::string &param) {
  if( m_condDirStack.empty() ) {
    cerr << "Preprocessor error: elseif: no ifdef to match elseif" << endl;
    exit(1);
  }
  m_condDirStack.back()->toElsif(param);
}

void CCondDirectivesModel::addElse() {
  if( m_condDirStack.empty() ) {
    cerr << "Preprocessor error: else: no ifdef to match else" << endl;
    exit(1);
  }
  m_condDirStack.back()->toElse();
}

void CCondDirectivesModel::addEndIf() {
  if( m_condDirStack.empty() ) {
    cerr << "Preprocessor error: endif: no ifdef to match endif" << endl;
    exit(1);
  }
  delete m_condDirStack.back();
  m_condDirStack.pop_back();
}

// **********************************************
// CLineMapProcessor class
// **********************************************
//#define DEBUG_LINE_MAP
TIncludeMap::TIncludeMap( std::string fileName, unsigned long lineNumber) : m_fileName(fileName), m_lineNumber(lineNumber) {}

TOutputChunk::TOutputChunk(EChunkType type, long stackPoint, unsigned long outputBegin, unsigned long inputBegin, unsigned long inputEnd, unsigned long remStackPoint)
  : m_type(type), m_stackPoint(stackPoint), m_outputBegin(outputBegin), m_inputBegin(inputBegin), m_inputEnd(inputEnd), m_remStackPoint(remStackPoint) {
  if( type = TYPE_ONE_TO_MANY )
    assert( inputEnd == inputBegin );
}

CLineMapProcessor::CLineMapProcessor(std::string fileName, unsigned long inputFileLine) :  m_state(STATE_NONE), m_outputLine(1), m_stackPoint(0), m_remStackPoint(0) {
  m_inputFiles.push_back(fileName);
  m_inputLines.push_back(inputFileLine);
  m_files.push_back( TIncludeMap(fileName, inputFileLine+1) );
}

void CLineMapProcessor::addLine() {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::addLine()" << endl;
#endif
  assert( m_inputLines.size() );
  switch( m_state ) {
    case STATE_ONE_TO_MANY:
      m_map.push_back(TOutputChunk(TOutputChunk::TYPE_ONE_TO_MANY, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back()+1, m_remStackPoint));
      m_remStackPoint = m_stackPoint = 0;
      m_state = STATE_NONE;
      break;
    case STATE_NONE:
      m_state = STATE_ONE_TO_ONE;
      m_inputBegin = m_inputLines.back()+1;
      m_outputBegin = m_outputLine;
    default:;
  }
  ++m_inputLines.back();
  ++m_outputLine;
}

void CLineMapProcessor::addLineInputOnly() {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::addLineInputOnly()" << endl;
#endif
  switch( m_state ) {
    case STATE_ONE_TO_ONE:
      m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_ONE, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back(), m_remStackPoint) );
      m_remStackPoint = m_stackPoint = 0;
      m_state = STATE_NONE;
      break;
    case STATE_ONE_TO_MANY:
      if( m_outputBegin == m_outputLine ) {
        if( m_stackPoint == 0 && !m_map.empty() && m_map.back().m_type == TOutputChunk::TYPE_ONE_TO_ONE && 
            m_map.back().m_inputEnd == m_inputLines.back() - 1 ) {
          m_inputBegin = m_map.back().m_inputBegin;
          m_stackPoint = m_map.back().m_stackPoint;
          m_remStackPoint = m_map.back().m_remStackPoint;
          m_outputBegin = m_map.back().m_outputBegin;
          m_map.pop_back();
          m_state = STATE_ONE_TO_ONE;
          break;
        }
        else {
          m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_MANY, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back() + 1, m_remStackPoint) );
          m_remStackPoint = m_stackPoint = 0;
          m_state = STATE_NONE;
          break;
        }
      }
      else {
        m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_MANY, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back() + 1, m_remStackPoint) );
        m_remStackPoint = m_stackPoint = 0;
        m_state = STATE_NONE;
        break;
      }
    default: ;
  }
  ++m_inputLines.back();
}

void CLineMapProcessor::addLineOutputOnly() {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::addLineOutputOnly()" << endl;
#endif
  switch( m_state ) {
    case STATE_ONE_TO_ONE:
      if( m_inputBegin != m_inputLines.back() + 1 ) {
        m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_ONE, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back(), m_remStackPoint) );
        m_remStackPoint = m_stackPoint = 0;
        m_inputBegin = m_inputLines.back() + 1;
        m_outputBegin = m_outputLine;
      }
      m_state = STATE_ONE_TO_MANY;
      break;
    case STATE_NONE:
      m_state = STATE_ONE_TO_MANY;
      m_inputBegin = m_inputLines.back() + 1;
      m_outputBegin = m_outputLine;
    default: ;
  }
  ++m_outputLine;
}

void CLineMapProcessor::newFile(std::string fileName) {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::newFile()" << endl;
#endif
  for( vector<string>::iterator it = m_inputFiles.begin(); it != m_inputFiles.end(); ++it )
    if( *it == fileName ) {
      cerr << "Preprocessor error: file loop detected with file: " << fileName << endl;
      exit(1);
    }
  switch( m_state ) {
    case STATE_ONE_TO_ONE:
      m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_ONE, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back(), m_remStackPoint) );
      m_remStackPoint = m_stackPoint = 0;
      break;
    case STATE_ONE_TO_MANY:
      m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_MANY, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back(), m_remStackPoint) );
      m_remStackPoint = m_stackPoint = 0;
      break;
    case STATE_NONE:
      if(m_stackPoint < 0) {
        m_remStackPoint = -m_stackPoint;
        m_stackPoint = 0;
      }
      break;
  }
  m_state = STATE_NONE;
  m_files.push_back(TIncludeMap(fileName, m_inputLines.back() + 1));
  m_inputFiles.push_back(fileName);
  m_inputLines.push_back(0);
  ++m_stackPoint;
}

void CLineMapProcessor::delFile() {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::delFile()" << endl;
#endif
  assert( !m_inputFiles.empty() );
  assert( !m_inputLines.empty() );
  switch( m_state ) {
    case STATE_ONE_TO_ONE:
      m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_ONE, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back(), m_remStackPoint) );
      m_remStackPoint = m_stackPoint = 0;
      break;
    case STATE_ONE_TO_MANY:
      m_map.push_back( TOutputChunk(TOutputChunk::TYPE_ONE_TO_MANY, m_stackPoint, m_outputBegin, m_inputBegin, m_inputLines.back(), m_remStackPoint) );
      m_remStackPoint = m_stackPoint = 0;
      break;
    case STATE_NONE:
      if( m_stackPoint == 0 && m_remStackPoint) {
        m_stackPoint = -m_remStackPoint;
        m_remStackPoint = 0;
      }
      else if( m_stackPoint > 0 ) {
        m_files.pop_back();
      }
  }
  m_state = STATE_NONE;
  m_inputLines.pop_back();
  m_inputFiles.pop_back();
  --m_stackPoint;
}
void CLineMapProcessor::lineMap(unsigned long lineNumber, std::string fileName, unsigned char level) {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::lineMap(unsigned long lineNumber, std::string fileName, unsigned char level)" << endl;
#endif
  //TODO
}
unsigned long CLineMapProcessor::traceLine(unsigned long lineNumber, std::vector<TIncludeMap> &filePath) const {
#ifdef DEBUG_LINE_MAP
  printState();
  cerr << "CLineMapProcessor::lineMap(unsigned long lineNumbeceLine(unsigned long lineNumber, std::vector<TIncludeMap> &filePath)" << endl;
#endif
  vector<TIncludeMap>::const_iterator fileIter = m_files.begin();
  filePath.clear();
  filePath.push_back(*fileIter);
  vector<TOutputChunk>::const_iterator it;
  if( !m_map.size() ) {
    return 0;
  }
  for( it = m_map.begin(); it != m_map.end(); ++it) {
    if( it->m_outputBegin > lineNumber ) {
      --it;
      if( it->m_type == TOutputChunk::TYPE_ONE_TO_ONE )
        return lineNumber + it->m_inputBegin - it->m_outputBegin;
      else
        return it->m_inputBegin;
    }
    long tempStackPoint = it->m_stackPoint;
    if( tempStackPoint > 0 ) {
      if( it->m_remStackPoint )
        for( vector<TIncludeMap>::size_type i = 0; i < it->m_remStackPoint; ++i)
          filePath.pop_back();
      for( vector<TIncludeMap>::size_type i = 0; i<tempStackPoint; ++i) {
        ++fileIter;
        filePath.push_back(*fileIter);
      }
    }
    else if( tempStackPoint < 0 ) {
      tempStackPoint = -tempStackPoint;
      for( vector<TIncludeMap>::size_type i = 0; i<tempStackPoint; ++i)
        filePath.pop_back();
    }
  }
  --it;
  if( it->m_type == TOutputChunk::TYPE_ONE_TO_ONE )
    return lineNumber + it->m_inputBegin - it->m_outputBegin;
  else
    return it->m_inputBegin;
}

unsigned long CLineMapProcessor::getCurrentOutputLine() const {
  return m_outputLine;
}

void CLineMapProcessor::debugInfo() const {
  cout << "The map is: " << endl;
  cout << "\tSize:" << m_map.size() << endl;
  for( vector<TOutputChunk>::const_iterator it = m_map.begin(); it != m_map.end(); ++it) {
    cout << "\t****************" << endl;
    cout << "\t\ttype         = " << it->m_type << endl;
    cout << "\t\tstack point  = " << it->m_stackPoint << endl;
    cout << "\t\trem point    = " << it->m_remStackPoint << endl;
    cout << "\t\toutput begin = " << it->m_outputBegin << endl;
    cout << "\t\tinput begin  = " << it->m_inputBegin << endl;
    cout << "\t\tinput end    = " << it->m_inputEnd << endl;
  }
  cout << "The intput file are: " << endl;
  cout << "\tSize: " << m_files.size() << endl;
  for( vector<TIncludeMap>::const_iterator it = m_files.begin(); it != m_files.end(); ++it ) {
    cout << "\t****************" << endl;
    cout << "\t\tFile name   = " << it->m_fileName << endl;
    cout << "\t\tLine number = " << it->m_lineNumber << endl;
  }
}

void CLineMapProcessor::printState() const {
  cerr << "\tm_state = ";
  switch( m_state ) {
    case STATE_NONE:        cerr << "STATE_NONE"       ; break;
    case STATE_ONE_TO_ONE:  cerr << "STATE_ONE_TO_ONE" ; break;
    case STATE_ONE_TO_MANY: cerr << "STATE_ONE_TO_MANY";
  }
  cerr << endl;
  cerr << "\tm_inputLines.size() = " << m_inputLines.size()                 << endl;
  cerr << "\tm_inputLines[top]   = " << m_inputLines[m_inputLines.size()-1] << endl;
  cerr << "\tm_inputFiles[top]   = " << m_inputFiles[m_inputFiles.size()-1] << endl;
  cerr << "\tm_outputLine        = " << m_outputLine                        << endl;
  cerr << "\tm_outputBegin       = " << m_outputBegin                       << endl;
  cerr << "\tm_inputBegin        = " << m_inputBegin                        << endl;
  cerr << "\tm_stackPoint        = " << m_stackPoint                        << endl;
  cerr << "\tm_remStackPoint     = " << m_remStackPoint                     << endl;
}

// **********************************************
// CTimeScaleAdapter class
// **********************************************
CTimeScaleAdapter* CTimeScaleAdapter::m_instance = NULL;

CTimeScaleAdapter::CTimeScaleAdapter() {
  unsigned int counter = 0;
  for( unsigned char it1 = 0; it1 < 3; ++it1 )
    for( unsigned char it2 = 0; it2 < 6; ++it2 )
      for( unsigned char it3 = 0; it3 < 3; ++it3 )
        for( unsigned char it4 = 0; it4 < 6; ++it4 ) {
          m_values[counter].timeUnitMagnitude      = it1+1;
          m_values[counter].timeUnitUnit           = it2+1;
          m_values[counter].timePrecisionMagnitude = it3+1;
          m_values[counter].timePrecisionUnit      = it4+1;
          m_timeScales[it1][it2][it3][it4] = ++counter;
        }
}

CTimeScaleAdapter* CTimeScaleAdapter::getInstance() {
  if( !m_instance )
    m_instance = new CTimeScaleAdapter;
  return m_instance;
}

unsigned int CTimeScaleAdapter::getTimeScale(unsigned char timeUnitMagnitude, unsigned char timeUnitUnit, unsigned char timePrecisionMagnitude, unsigned char timePrecisionUnit) {
  assert(      timeUnitMagnitude <= 4 );
  assert( timePrecisionMagnitude <= 4 );
  assert(           timeUnitUnit <= 7 );
  assert(      timePrecisionUnit <= 7 );
  if( timeUnitMagnitude      == 0 ||
      timeUnitUnit           == 0 ||
      timePrecisionMagnitude == 0 ||
      timePrecisionUnit      == 0
    )
    return 0;
  if( timeUnitMagnitude      == 4 ||
      timeUnitUnit           == 7 ||
      timePrecisionMagnitude == 4 ||
      timePrecisionUnit      == 7
    )
    return 325;
  assert(timeUnitUnit < timePrecisionUnit || timeUnitUnit == timePrecisionUnit && timePrecisionMagnitude <= timeUnitMagnitude);
  return m_timeScales[timeUnitMagnitude-1][timeUnitUnit-1][timePrecisionMagnitude-1][timePrecisionUnit-1];
}

void CTimeScaleAdapter::getValues( unsigned int timeScale, unsigned char &timeUnitMagnitude, 
    unsigned char &timeUnitUnit, unsigned char &timePrecisionMagnitude, unsigned char &timePrecisionUnit) { 
  assert( timeScale <= 325 );
  if( timeScale == 0 ) {
    timeUnitMagnitude      = 0;
    timeUnitUnit           = 0;
    timePrecisionMagnitude = 0;
    timePrecisionUnit      = 0;
    return;
  }
  if( timeScale == 325 ) {
    timeUnitMagnitude      = 4;
    timeUnitUnit           = 7;
    timePrecisionMagnitude = 4;
    timePrecisionUnit      = 7;
    return;
  }
  timeUnitMagnitude      = m_values[timeScale-1].timeUnitMagnitude;
  timeUnitUnit           = m_values[timeScale-1].timeUnitUnit;
  timePrecisionMagnitude = m_values[timeScale-1].timePrecisionMagnitude;
  timePrecisionUnit      = m_values[timeScale-1].timePrecisionUnit;
}

}
