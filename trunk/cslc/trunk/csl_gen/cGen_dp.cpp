#include <fstream>
#include <vector>
#include <map>
#include <string>
#include <cstdlib>
#include <sstream>
using namespace std;

const int UNIT_MAX_NO = 10;
const int PORT_MAX_NO = 50;
const int CONN_MAX_NO = 50;
const int INST_MAX_NO = 2;
const int LEVL_MAX_NO = 5;
const int UONL_MAX_NO = 5;



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
  int nop, noi, nou, nol;
  int noUperL;
  bool genInst;

  vector <unit*> gen;
  vector <unit*> children;


  nol = rand()%LEVL_MAX_NO;
  noUperL = rand()%UONL_MAX_NO;
  
  nol = 4;
  noUperL = 36;
  int l ;
  for  (l = nol ; l >= 1; l--) {
    if (l == 1) {
      noUperL = 1;
    }
    //    nou = rand()%UNIT_MAX_NO;
    for (int j =0 ; j < noUperL; j++) { // unit level 
      //****** gen unit header*********
      f<<"csl_unit u"<<l<<j<<" { \n  \n void initialize() { \n";
      gen.push_back( new unit );
      ostringstream s;
      s<<"u"<<l<<j;
      gen.back()->name = s.str();

      //****** end gen unit header*********
      //--------------------------------------------------------------------------------------------------
      //****** gen unit PORTS*********
      
      int inst = 0;
      nop = rand()%PORT_MAX_NO;
      for (int k = 0 ; k < nop; k++) {
        inst++;
        f<< "  add_port(" <<rDir()<<", p"<<inst<<");\n";
        ostringstream t;
        t<<"p"<<inst;
        gen.back()->ports.push_back(t.str());
      }
      
      //****** end gen ports ***********
      //--------------------------------------------------------------------------------------------------
      //****** gen insts ***********

      if (l != nol ) {
        vector <unit*>::iterator it;
        inst =0;
        if (l == 1) {
          for (int m = 0; m < children.size(); ++m) {
            inst++;
            f<< "  add_instance(" <<children[m]->name<<", i"<<inst<<");\n";
            ostringstream t;
            t<<"i"<<inst;
            gen.back()->insts[t.str()] = children[m];
          }
        }
        else {
          for (int m = j * children.size()/(l+1); m < (j+1) * children.size()/(l+1); ++m) {
            inst++;
            f<< "  add_instance(" <<children[m]->name<<", i"<<inst<<");\n";
            ostringstream t;
            t<<"i"<<inst;
            gen.back()->insts[t.str()] = children[m];
          }
        }
        //        children.push_back(gen.back());
      }
      
      //****** end gen insts ***********
      //--------------------------------------------------------------------------------------------------
      //****** start connects *********
      if (l != nol) {
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
      }      
      //****** end gen connects ***********
      //--------------------------------------------------------------------------------------------------
      //****** end unit *********
      f<<"} \n };\n\n";
      //****** end end unit*********      

    }
    children.clear();
    for (int j = 0 ; j < gen.size(); j++) {
      children.push_back(gen[j]);
    }
    gen.clear();
    noUperL = noUperL/(noUperL/l);
    

  }


  f.close();
  return 0;
}
