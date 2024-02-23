//#include "cslInterconnectGen_TB.h"
#include "cslIsa.h"
#include "cGenFifo_ao.h"
#include "cslMemoryMap.h"
#include "cslRegister.h"
#include "cslGenEnum.h"
#include "cslField.h"
#include "cslMemory.h"

using namespace NSCSLinterconnect;
string illegalPath;
string legalPath;
string legalTestFileName = "legal_test_";
string illegalTestFileName = "illegal_test_";
string extension = ".csl";



void makeDir(const char* path, const char* dirName, string& storeTo) {
  storeTo = string(path).append(dirName);
  const char* mkDir = string("cd ").append(path).append("; mkdir ").append(dirName).c_str();
  if (system(mkDir)) {
    exit(1);
  }
}

int main (int argc, char** argv) {
  srand(time(0));

 if (argc != 2) {
   cerr << argv[0] << " received invalid number of params: got " << argc - 1 << " needed 1\n";
   return 1;
 }
 else if (argv[1][string(argv[1]).size() - 1] != '/') {
   cerr << argv[1] << " is not a valid directory name\n";
   return 1;
 }

 string testPath;
 makeDir(argv[1], "gen_tests/", testPath);
 //    makeDir(testPath.c_str(), "gen_tests/", legalPath);
 //   makeDir(testPath.c_str(), "illegal/", illegalPath);

 for (int i=0;i<50;i++) {

   ostringstream s;
   s<<"out"<<i<<".csl";
   testPath.append("");
   string out = testPath;
   ofstream fout (out.append(s.str()).c_str());
   //     ofstream fout (s.str().c_str());

    CSLdesign *d = new CSLdesign(fout);
    d->buildDecl();
    d->print();
   
    fout.close();

    delete d;
 }
  return 0;
}
