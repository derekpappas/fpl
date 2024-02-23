// #include "csl_gen_base.h"
// #include "csl_gen_design.h"
//#include "csl_enum_field.h"
//#include "cGenIsa_ao.h"
#include "csl_gen_design.h"
using namespace std;

using namespace NSCSLinterconnect;

int main(){
  srand(time(0));
  CSLdesign p("design");
  p.buildDecl();

//   for (int i=0;i<100;i++) {
//     CSLdesign p;
//     ostringstream s;
//     s<<"out"<<i<<".csl";
//     ofstream fout (s.str().c_str());
//     p.buildDecl();
//     p.print();
//     fout.close();
//   }
  return 0;
}
