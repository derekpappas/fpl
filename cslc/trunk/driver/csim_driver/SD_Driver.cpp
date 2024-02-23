#include "csim.h"
#include <iostream>

using namespace std;
using namespace boost;


class TopUnit: public CSimUnit{
  private:
    RefCClock                    clk;
    shared_ptr<CMemory<int> >    memory;
    shared_ptr<CStateData<int> > sd;

    bool flag;

    int a;
    int b;
    int c;

  public:
    TopUnit(string moduleName,string instanceName,RefCSimUnit parent)
      :CSimUnit(moduleName,instanceName,parent){
      clk    = CClock         ::build(5,"clk");         
      memory = CMemory<int>   ::build(6,clk);          
      sd     = CStateData<int>::build("sd.txt",memory);
      flag   = false;

      memory->add(1); a = 1;
      memory->add(2); b = 2;
      memory->add(3); c = 3;
    }

    void execute(){
      flag = !flag;
      a++;b++;c++;
      memory->setAt(0,a);
      memory->setAt(1,b);
      memory->setAt(2,c);

      sd->setEnable_flag(flag);
      sd->writeMemory();
    }

    void generate_vectors(){
    }

    void initialize(){
    }

    string getValue(string field){
      return "";
    }

    void instantiateUnits(RefCSimUnit parent){
    }

    vector<string> getInputs(){
      return vector<string>();
    }

    vector<string> getOutputs(){
      return vector<string>();
    }

    vector<string> getSignals(){
      return vector<string>();
    }

    vector<string> getVectors(){
      return vector<string>();    
    }
};

int main(){
  CSimulator::getInstance()->setTopUnit(buildUnit<TopUnit>("TopUnit","/",RefCSimUnit()));
  CSimulator::getInstance()->start_simulation();

  return 0;
}
