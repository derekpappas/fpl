#ifndef _CSL_PREPROCESSOR
#define _CSL_PREPROCESSOR

#include <iostream>
#include <fstream>
#include <stack>
#include <vector>
#include <string>
#include <cassert>
#include <utility>

#define MACRO_CHAR   0x60
#define SPACE_CHAR   0x20
#define TAB_CHAR     0x09
#define NEWLINE_CHAR 0x0A

#define IS_EOF_CHAR(c) !istream::traits_type::not_eof(c)
#define IS_NOT_EOF_CHAR(c) istream::traits_type::not_eof(c)

namespace NSCslPreprocessor {

const unsigned int andMaskCellDef    = 0xFFFF;
const unsigned int orMaskCellDef     = 0x0040;
const unsigned int andMaskCellUndef  = 0xFFBF;
const unsigned int orMaskCellUndef   = 0x0000;

const unsigned int andMaskNoDrive    = 0xFFCF;
const unsigned int orMaskNoDrive     = 0x0000;
const unsigned int andMaskPull1Drive = 0xFFDF;
const unsigned int orMaskPull1Drive  = 0x0010;
const unsigned int andMaskPull0Drive = 0xFFEF;
const unsigned int orMaskPull0Drive  = 0x0020;

const unsigned int andMaskWire       = 0xFFF0;
const unsigned int orMaskWire        = 0x0000;
const unsigned int andMaskTri        = 0xFFF1;
const unsigned int orMaskTri         = 0x0001;
const unsigned int andMaskTri0       = 0xFFF2;
const unsigned int orMaskTri0        = 0x0002;
const unsigned int andMaskTri1       = 0xFFF3;
const unsigned int orMaskTri1        = 0x0003;
const unsigned int andMaskWand       = 0xFFF4;
const unsigned int orMaskWand        = 0x0004;
const unsigned int andMaskTriand     = 0xFFF5;
const unsigned int orMaskTriand      = 0x0005;
const unsigned int andMaskWor        = 0xFFF6;
const unsigned int orMaskWor         = 0x0006;
const unsigned int andMaskTrior      = 0xFFF7;
const unsigned int orMaskTrior       = 0x0007;
const unsigned int andMaskTrireg     = 0xFFF8;
const unsigned int orMaskTrireg      = 0x0008;
const unsigned int andMaskNone       = 0xFFF9;
const unsigned int orMaskNone        = 0x0009;

const unsigned int andMaskResetAll   = 0x0000;
const unsigned int orMaskResetAll    = 0xA280;

class CPreprocessor;
class CTextMacro;
class COutputItem;
class CCondDirectivesModel;

// **********************************************
// CConditionalDirectivesModel class
// **********************************************
class CCondDirectivesModel {
    enum EDirIfType { DIR_TYPE_IFDEF, DIR_TYPE_IFNDEF };
  private:
    class CCondDirectiveModel {
      public:
        enum ECondState { STATE_FIRST, STATE_ELSEIF, STATE_ELSE };
      private:
        ECondState m_state;
        bool m_wasAccepted;
        std::vector<CCondDirectiveModel>::size_type m_level;
      public:
        CCondDirectiveModel( const std::string&, EDirIfType, const std::vector<CCondDirectiveModel>::size_type );
        ~CCondDirectiveModel();
        void toElsif( const std::string& );
        void toElse();

        ECondState getState() const;
        bool wasAccepted() const;
    };
    std::vector<CCondDirectiveModel*> m_condDirStack;
    static std::vector<CCondDirectiveModel>::size_type blockLevel;
  public:
    CCondDirectivesModel() : m_condDirStack(std::vector<CCondDirectiveModel*>()) { }
    ~CCondDirectivesModel() { assert(canEliminate()); }
    void addIfDef( std::string& );
    void addIfnDef( std::string& );
    void addElsif( std::string& );
    void addElse();
    void addEndIf();
    bool canEliminate() const { return m_condDirStack.empty(); }
};

struct TIncludeMap {
  std::string m_fileName;
  unsigned long m_lineNumber;
  TIncludeMap( std::string fileName, unsigned long lineNumber);
};

struct TOutputChunk {
    enum EChunkType { TYPE_ONE_TO_MANY, TYPE_ONE_TO_ONE };
    EChunkType m_type;
    long m_stackPoint;
    unsigned long m_remStackPoint;
    unsigned long m_outputBegin;
    unsigned long m_inputBegin;
    unsigned long m_inputEnd;
    TOutputChunk(EChunkType type, long stackPoint, unsigned long outputBegin, unsigned long inputBegin, unsigned long inputEnd, 
        unsigned long remStackPoint);
};

// **********************************************
// CTimeScaleAdapter class
// **********************************************
class CTimeScaleAdapter {
  private:
    static CTimeScaleAdapter* m_instance;
    CTimeScaleAdapter();
    struct TValues {
      unsigned char timeUnitMagnitude;
      unsigned char timeUnitUnit;
      unsigned char timePrecisionMagnitude;
      unsigned char timePrecisionUnit;
    };
    TValues m_values[324];
    unsigned int m_timeScales[3][6][3][6];
  public:
    static CTimeScaleAdapter* getInstance();
    unsigned int getTimeScale(unsigned char timeUnitMagnitude, unsigned char timeUnitUnit, unsigned char timePrecisionMagnitude, unsigned char timePrecisionUnit);
    void getValues( unsigned int timeScale, unsigned char &timeUnitMagnitude, unsigned char &timeUnitUnit, unsigned char &timePrecisionMagnitude, unsigned char &timePrecisionUnit);
};

// **********************************************
// CLineMapProcessor class
// **********************************************
class CLineMapProcessor {
  enum EState { STATE_NONE, STATE_ONE_TO_MANY, STATE_ONE_TO_ONE };
  private:
    EState m_state;
    std::vector<TOutputChunk> m_map;
    std::vector<TIncludeMap> m_files;
    std::vector<unsigned long> m_inputLines;
    std::vector<std::string> m_inputFiles;
    unsigned long m_outputLine;
    unsigned long m_outputBegin;
    unsigned long m_inputBegin;
    long m_stackPoint;
    unsigned long m_remStackPoint;
  public:
    CLineMapProcessor(std::string fileName, unsigned long inputFileLine = 0);
    /**
     * This method adds a input line and a output line to the mapping
     */
    void addLine();
    /**
     * This method doesn't map the input line to any of the output lines
     */
    void addLineInputOnly();
    /**
     * This method maps the added output line to the last added input line
     * If the previous input line was added with addLineInputOnly that line will be mapped
     */
    void addLineOutputOnly();
    /**
     * This method adds a file to the input file stack
     */
    void newFile(std::string fileName);
    /**
     * This method removes a file from the input file stack
     */
    void delFile();
    /**
     * This method is used to map with the line directive
     */
    void lineMap(unsigned long lineNumber, std::string fileName, unsigned char level);
    unsigned long getCurrentOutputLine() const;
    /**
     * This method is used to calculate the original position of a line in the input file from the line in the output file
     * @lineNumber The number of the output line
     * @filePath The returned calculated file path
     */
    unsigned long traceLine(unsigned long lineNumber, std::vector<TIncludeMap> &filePath) const;
    void debugInfo() const;
    void printState() const;
};

// **********************************************
// CPreprocessor class
// **********************************************
/**
 * This class implements the functionality of the verilog preprocessor.
 * it also strips the code of comments and irelevant white spaces,
 * keeping the indentation of the code intact.
 * The macroes aren't expanded inside strings
 * This class checks for erros is macros and 
 * also check for errors like unclosed comments at the end of files
 */

class CPreprocessor {
  private:
    unsigned int m_state;
    std::vector<std::string> m_dirpath;
    std::vector< std::pair<unsigned long, unsigned int> > *m_stateVect;
    std::stack<CCondDirectivesModel*> m_condDirsModelStack;
    std::vector<std::string> m_predefinedMacros;
    std::string m_indentBuffer;
    CLineMapProcessor *m_lineMapper;
    /**
     * The c character has no special meaning and is used by different methids in different ways
     * The prev character however should always tell what was the last character to be written 
     * in the output stream.
     * Each method that writes to the stream should set the prev character
     * it is used mostly to identify whether tha last character was a WS or not
     */
    char c, prev;
    /**
     * This class member may be set to 1 or 0 only.
     * It indicates if the current output line is clean or not
     * A line is clean if there were no n0n-whitespace characters written on it
     * This is usefull when a directive line `include is used not at the begining of the line
     * because it would be illegal to use `include in a line that is not clean
     */
    int cleanLine;
    /**
     * This is the stack of the input file streams
     * A stack is neccessary because all included files should be parsed in a LIFO order
     */
    std::stack<std::ifstream*> m_input;
    /**
     * This is the stack of input file names. This stack is necessary to determine include loops
     * This stack is of vector type because a some moment in time it should be traversed as a vector
     */
    std::vector<std::string> m_fileNameStack;
    /**
     * This is the verilog output file
     */
    std::ofstream *m_output;
    
    /**
     * This method handles all the white spaces and puts only the relevant WS (including new lines)
     * it also implements the indentation keeping at the begining of a line
     */
    void handleWS();
    void handleWSFirst();
    /**
     * This method hadles the strings found a file. If a eol or eof was found in a string it exit with and error 
     */
    void handleString();
    /**
     * This method reads an escaped identifier from the stream
     * This is needed because an escaped identifier can contain the '`' character
     */
    void handleEscapedIdentifier();
    /**
     * This method handles a C like comment through more than one file in the file stack
     * this was a c like comment might expand through more than one file
     * It also puts a space character in the output stream if the comment separates two tokens
     * if the comment expands through more than one line, it put a new line in the output stream,
     * but only if the line the comment started in wasn't clean
     */
    void handleCLikeComment();
    /**
     * This method handles a CPP like comment ( // comment ) to a eol or eof
     * This method shouldn't alter the output stream
     */
    void handleCPPLikeComment();
    /**
     * This method reads a directive and determens to which directive handle to pass it
     */
    void handleDirective();

    /**
     * This method handles a include directive, reads the file name,
     * check of the line was clean and clears the rest of the line
     * It tryes to open the input file, exit with and error if the file creates a loop of can't be opened
     * if the file was succesfully opened it add it to the input stream stack and filename stack for further parsing
     */
    void handleIncludeDirective();
    /**
     * This method resolves a define directive by adding it's model to the current defined directives models vector
     */
    void handleDefineDirective();
    /**
     * This method removes a defined directive from the defined model vector
     */
    void handleUndefineDirective();
    /**
     * This method handles the line directive
     */
    void handleLineDirective();
    void readTime(unsigned char &tm, unsigned char &tu);
    void handleTimeScaleDirective();
    void handleUnconnectedDriveDirective();
    void handleDefaultNettypeDirective();
    /**
     * This method handles a macro defined earlier with define
     * and exits with an error is the gived directive doen't exist
     * @name the name of the macro you wish to handle
     */
    void handleDefaultDirective(std::string &name);

    /**
     * This method proceses the current line until the first non-white, non-clike comment character 
     * it returns an error if a newline or eof was found in the line, also it returns an error if a // comment was found
     * @return 0 if error 1 if success
     */
    int lineCleanCommentsAndWS();
    /**
     * This method parses the current line to it's end returns an error if a non-white non-comment character was found
     * @return 0 if error, 1 if success
     */
    int lineCleanRest();
    /**
     * This method reads one identifier and clears the line of comments, it exits with an error if the line is not clean
     * @returns a simple identifier or an escaped identifier read by CTextMacro::readMacroName(std::istream&) method
     */
    std::string getIdentifier(std::string &callingDirective);

    /**
     * This method reads a filename from the stream
     */
    std::string readFileName(std::string &callingDirective);
    /**
     * These are tables with all the possible ascii characters ( there size must be 256 )
     * for each character the vector contains a value of 1 or 0 ( true or false )
     * For the first table (identifierTable) true at character x means that x can be the nth character in the identifier's name with n=2..
     * For the second table (identifierTableFirst) true at character x means that x can be the first character in the identifier's name
     */
    static std::vector<int> identifierTable, identifierTableFirst;
  public:
    static bool writeEnable;
    static int possibleIdFirst(char c) {
      if (!(c > 0 && c < 127))
        return 0;
      else 
        return identifierTableFirst[c];
    }
    static int possibleId(char c) {
      if (!(c > 0 && c < 127))
        return 0;
      else 
        return identifierTable[c];
    }
    /**
     * This is the constructor if the CPreprocessor class
     * @inputFileName the name of the input verilog file
     * @outputFileName the name of the ouput file name
     */
    CPreprocessor(const char* inputFileName, const char* outputFileName, std::vector<std::string> &includePath);
    virtual ~CPreprocessor();
    /**
     * This method starts the preprocessor parsing logic and builds the output file
     */
    void start();
    std::vector<int> getIdTable() { return identifierTable; }
    std::vector<int> getIdTableFirst() { return identifierTableFirst; }
    const CLineMapProcessor* getLineMapping() { return m_lineMapper; }
    std::vector< std::pair<unsigned long, unsigned int> >* getStateVect() const {return m_stateVect;}
};

// **********************************************
// CTextMacro class
// **********************************************
/**
 * This class holds the memory model of a defined macro
 * it implements the recursive logic of verilog macroes
 * and identifier replacement
 * This class should be instantiated when a macro is defined
 * When a macro is redefined
 * destroyed when a macro is undefined
 * and used when a macro is called
 */
class CTextMacro {
  private:
    /**
     * This vector is used to determine loops inside macroes
     */
    static std::vector<std::string> inProgressStack;
    /**
     * Holds the name of the macro
     */
    std::string m_name;
    /**
     * Holds the number of arguments the macro takes
     */
    std::vector<std::string>::size_type m_nrOfArguments;
    /**
     * This is the mamory mapping of the defined macro
     * the vector holds the mapping the the original order,
     * and when an output is needed for a specified expression
     * all you do is to traverse the vector
     */
    std::vector<COutputItem> m_outputvector;

    void validateIdentifierList(const std::vector<std::string> &idList) const;
    void validateMacroName();
  public:
    static void resolveInput( std::ostream &out, std::istream &in);
    static std::vector<CTextMacro*> definedMacroList;
    static void readParams( std::istream &in, std::vector<std::string> &out);
    static std::string readMacroName( std::istream &);
    /**
     * The constructor of CTextMacro
     * @name The name of the directive ( escaped or simple )
     * @identifierList The list of define params
     * @outputFormat The output format of the define directive
     * @idTable A vector containig 1 for valid chars and 0 for invalid id name chars for an identifier name
     * @idTableFirst A vector containig 1 for valid chars and 0 for invalid id name chars for the first letter in the identifier's name
     */
    CTextMacro(const std::string &name, const std::vector<std::string> &identifierList, const std::string &outputFormat );
    /**
     * This method is same as the constructor, with the only difference that you can't redefine a macro's name
     * @identifierList The list of define params
     * @outputFormat The output format of the define directive
    */
    void redefine(const std::vector<std::string> &identifierList, const std::string &outputFormat);

    /**
     * Returns the name of the macro
     */
    const std::string& getName() const;
    /**
     * This is the output method for the macro for a given expression
     * @identifiers a vector of input macro params
     * @macroDependencyList the vector of solved macro dependencies of this macro
     * @out The output stream
     */
    void toStream( const std::vector<std::string> &params, std::ostream &out );
    void debugInfo();
    std::vector<std::string>::size_type getNumberOfArguments() const;
};

// **********************************************
// COutputItem class
// **********************************************
/**
 * This class holds the description of one output item in a direnctive
 * An item can be a string, an identifier or another macro
 */
class COutputItem {
  public:
    enum EItemType { ITEM_TYPE_STRING, ITEM_TYPE_IDENTIFIER };
  private:
    EItemType m_type;
    std::string m_value;
    unsigned int m_identifier;
  public:
    COutputItem( const std::string &value);
    COutputItem( unsigned int value);

    EItemType getType() const;
    unsigned int getIdentifier() const;
    const std::string getString() const;
};

}

#endif //_CSL_PREPROCESSOR
