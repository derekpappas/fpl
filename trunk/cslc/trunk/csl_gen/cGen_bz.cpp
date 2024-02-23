#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <cstdlib>
#include <sstream>
using namespace std;

const int UNIT_MAX_NO = 10;
const int PORT_MAX_NO = 10;
const int CONN_MAX_NO = 10;
const int INST_MAX_NO = 2;



struct unit {
    string name;
    vector <string> ports;
    map<string, unit*> insts;
};

string rDir() {
  int r = rand()%3;
  switch(r) {
    case 0: return string("input");
    case 1: return string("output");
    case 2: return string("inout");
  }
}

int main () {
  ofstream f("big.csl");
  int nop, noi, nou;
  bool genInst;
  vector <unit*> gen;
  nou = 30;
  for (int i =0 ; i < nou; i++) {
    gen.push_back( new unit );
    vector <unit*>::iterator it;
    f<<"csl_unit u"<<i<<" { \n  \n void initialize() { \n";
    unit *cu = gen.back();

    ostringstream s;
    s<<"u"<<i;
    gen.back()->name = s.str();
    int inst =0;
    for (it = gen.begin(); it < gen.end()-1; ++it) {
      noi = rand()%INST_MAX_NO;
      for (int k = 0 ; k < noi; k++) {
        inst++;
        f<< "  add_instance(" <<(*it)->name<<", i"<<inst<<");\n";
        ostringstream t;
        t<<"i"<<inst;
        gen.back()->insts[t.str()] = *it;
      }
    }
    inst = 0;
    nop = rand()%PORT_MAX_NO;
    for (int k = 0 ; k < nop; k++) {
      inst++;
      f<< "  add_port(" <<rDir()<<", p"<<inst<<");\n";
      ostringstream t;
      t<<"p"<<inst;
      gen.back()->ports.push_back(t.str());
    }
    int noCon = rand()%CONN_MAX_NO;
    for (int i=0; i<noCon; i++) {
      unit *temp = gen.back();
      string hid("");
      while(temp->insts.size() > 0) {
        if (rand()%5 == 0) {
          break;
        }
        else {
          map<string, unit*>::iterator it1 = temp->insts.begin();
          int m = rand()%(temp->insts.size());    
          while (m>0) {
            m--;
            it1++;
          }
          temp = it1->second;
          hid.append(it1->first);
          hid.append(".");
        }
      }
      if (temp->ports.size()>0) {
        vector <string>::iterator it2 = temp->ports.begin();
        int m = rand()%(temp->ports.size());    
        while (m>0) {
          m--;
          it2++;
        }
        hid.append(*it2);
      }

      temp = gen.back();
      string hid1("");
      while(temp->insts.size() > 0) {
        if (rand()%5 == 0) {
          break;
        }
        else {
          map<string, unit*>::iterator it1 = temp->insts.begin();
          int m = rand()%(temp->insts.size());    
          while (m>0) {
            m--;
            it1++;
          }
          temp = it1->second;
          hid1.append(it1->first);
          hid1.append(".");
        }
      }
      if (temp->ports.size()>0) {
        vector <string>::iterator it2 = temp->ports.begin();
        int m = rand()%(temp->ports.size());    
        while (m>0) {
          m--;
          it2++;
        }
        hid1.append(*it2);
      }
      if (!hid.empty() && !hid1.empty() && hid[hid.length()-1]!='.' && hid1[hid1.length()-1]!='.') {
        f<<"  "<<hid<<".connect("<<hid1<<");\n";
      }
    }
    f<<"} \n };\n\n";
  }
  f.close();
  return 0;
}
