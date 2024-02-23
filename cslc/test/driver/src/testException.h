// This is the Expection header file
namespace NSTestExceptions{
class CTestException {
private:
	string m_message;
	string m_place;
public:
	CTestException(){
		this->m_message = "xxxxx";
		this->m_place = "xxxxx";
	}

	CTestException(string place){
		this->m_message = "xxxxx";
		this->m_place = place;
	}
		
	CTestException(string place, string message){
		this->m_message = message;
		this->m_place = place;
	}

	string getMessage(){ return this->m_message; }
	string getPlace(){ return this->m_place; }
	string toString(){ return "Exception at " + m_place + " : " + m_message;}
};

class CTestExceptionInvalid : public CTestException {
public:
	CTestExceptionInvalid():CTestException(){}
	CTestExceptionInvalid(string place):CTestException(place){}
	CTestExceptionInvalid(string place, string message):CTestException(place,message){}
};
class CTestExceptionFailed : public CTestException {
public:
	CTestExceptionFailed():CTestException(){}
	CTestExceptionFailed(string place):CTestException(place){}
	CTestExceptionFailed(string place, string message):CTestException(place,message){}
};
}
