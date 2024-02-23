#include "singleton.h"

class CMySingleton : public CSingleton<CMySingleton> {
  friend class CSingleton<CMySingleton>;   
 
private:      
  
  CMySingleton(){};
  ~CMySingleton(){};
 
};


int main(int argc, char** argv) {

  CMySingleton* mySingleton = CMySingleton::Instance();

  mySingleton->Instance();

  CMySingleton::DestroyInstance();

}
