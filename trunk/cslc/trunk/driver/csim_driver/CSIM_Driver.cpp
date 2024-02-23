#include "csim.h"
#include "FlipFlop.h"

using namespace std;
using namespace boost;


class UnitDumy: public CSimUnit{
  public:
    UnitDumy(string moduleName, string instanceName, RefCSimUnit parent):CSimUnit(moduleName, instanceName, parent){
      initialize();
      x = shared_ptr<FFUInt>(new FFUInt(10));
      y = shared_ptr<FFUInt>(new FFUInt(10));
    }

    void execute(){
      x->setValue(x->getValue()*2 % 100);
      y->setValue(y->getValue()*3 % 100);
    }

    void generate_vectors(){
    }

    void initialize(){
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

    string getValue(string field){
      string value = "";
      
      if(field == "x"){
        value = x->toString();
      }else if(field == "y"){
        value = y->toString();
      }

      return value;
    }

  private:
    shared_ptr<FFUInt> x;
    shared_ptr<FFUInt> y;
};

class UnitAdd: public CSimUnit{
  public:
    UnitAdd(string moduleName, string instanceName, RefCSimUnit parent):CSimUnit(moduleName,instanceName,parent){
      initialize();
      RefCClock clk1 = CClock::build(6,"clk1");
      RefCClock clk2 = CClock::build(9,"clk2");

      in1_d = shared_ptr<FFUInt>(new FFUInt(2));
      in2_d = shared_ptr<FFUInt>(new FFUInt(3));
      out_d = shared_ptr<FFUInt>(new FFUInt(0));

      input1 = CFlipFlop<FFUInt>::build(in1_d,clk1,"input1");
      input2 = CFlipFlop<FFUInt>::build(in2_d,clk1,"input1");
      output = CFlipFlop<FFUInt>::build(out_d,clk2,"output");
    }
    
    void execute(){
      unsigned int in1 = input1->getQ().getValue();
      unsigned int in2 = input2->getQ().getValue();
      unsigned int sum = in1 + in2;
      out_d->setValue(sum);
    }

    void generate_vectors(){
    }

    void initialize(){
      
    }

    void instantiateUnits(RefCSimUnit parent){
      a = buildUnit<UnitDumy>("UnitDummy","a",parent);
      b = buildUnit<UnitDumy>("UnitDummy","b",parent);
      c = buildUnit<UnitDumy>("UnitDummy","c",parent);
      d = buildUnit<UnitDumy>("UnitDummy","d",parent);
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

    string getValue(string field){
      string value = "";
      
      if(field == "in1_d"){
        value = in1_d->toString();
      }else if(field == "in2_d"){
        value = in2_d->toString();
      }else if(field == "out_d"){
        value = out_d->toString();
      }else if(field == "input1"){
        value = input1->get();
      }else if(field == "input2"){
        value = input2->get();
      }else if(field == "output"){
        value = output->get();
      };

      return value;
    }

  private:
    shared_ptr<FFUInt> in1_d;
    shared_ptr<FFUInt> in2_d;
    shared_ptr<FFUInt> out_d;

    RefCFlipFlopUInt input1;
    RefCFlipFlopUInt input2;
    RefCFlipFlopUInt output;

    shared_ptr<UnitDumy> a;
    shared_ptr<UnitDumy> b;
    shared_ptr<UnitDumy> c;
    shared_ptr<UnitDumy> d;
    
};




class MyInterface:public CSimulatorInterface{
  private:

    shared_ptr<UnitAdd> add;
  public:
    MyInterface(){
      add = buildUnit<UnitAdd>("UnitAdd","add",RefCSimUnit());

      CSimulator::getInstance()->setTopUnit(add);
    }
    void beforeSimulation(){
    }
    void afterSimulation(){
    }
    void cycleStart(int cycle_count){
    }
    void cycleEnd  (int cycle_count){
    }
};



//----------------------------
//main
//----------------------------
int main(){
  CSimulator::getInstance()->setSimulatorInterface(shared_ptr<CSimulatorInterface>(new MyInterface()));
  CSimulator::getInstance()->start_simulation();

  return 0;
}
