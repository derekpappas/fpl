// This is the Expection header file
#ifndef TEST_EXCEPTIONS

#define TEST_EXCEPTIONS

#include <exception>
#include <iostream>

class CTestException : public std::exception {
private:
    std::string m_message;
    std::string m_place;
public:
    CTestException() throw(): m_message("xxxxx"), m_place("xxxxx") { }
    CTestException(std::string place) throw(): m_message("xxxxx"), m_place(place){ }
    CTestException(std::string place, std::string message) throw(): m_message(message), m_place(place){ }

    virtual ~CTestException() throw() { }

    const std::string getMessage() const throw() { return this->m_message; }
    const std::string getPlace() const throw() { return this->m_place; }
    const std::string toString() const throw() { return "Exception at " + m_place + " : " + m_message;}
    const char* what() const throw() { return this->toString().c_str(); }
};

class CTestExceptionInvalid : public CTestException {
public:
    CTestExceptionInvalid() throw(): CTestException(){}
    CTestExceptionInvalid(std::string place) throw(): CTestException(place){}
    CTestExceptionInvalid(std::string place, std::string message) throw(): CTestException(place,message){}

    virtual ~CTestExceptionInvalid() throw() { }
};

class CTestExceptionFailed : public CTestException {
public:
    CTestExceptionFailed() throw(): CTestException(){}
    CTestExceptionFailed(std::string place) throw(): CTestException(place){}
    CTestExceptionFailed(std::string place, std::string message) throw(): CTestException(place,message){}

    virtual ~CTestExceptionFailed() throw() { }
};
class CTestExceptionSyntaxErr : public CTestException {
public:
    CTestExceptionSyntaxErr() throw(): CTestException(){}
    CTestExceptionSyntaxErr(std::string place) throw(): CTestException(place){}
    CTestExceptionSyntaxErr(std::string place, std::string message) throw(): CTestException(place,message){}

    virtual ~CTestExceptionSyntaxErr() throw() { }
};

#endif
