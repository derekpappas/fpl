#include "csim.h"
#include <iostream>
#include <string>
#include "FlipFlopTypes.h"
#include <fstream>

using namespace std;
using namespace boost;

class Writer: public CSimVectorWriter{
  private:
    unsigned int a,b,c;
  public:
    Writer(string id, string version, string filename, unsigned int width)
      :CSimVectorWriter(id,version,filename,width){
    }
    
    void setAValue(unsigned int value){
      a = value;
    }

    void setBValue(unsigned int value){
      b = value;
    }

    void setCValue(unsigned int value){
      c = value;
    }

    void writeVector(){
      if(isTypeBinary()){
        binary(a,width,out);
        out<<"_";
        binary(b,width,out);
        out<<"_";
        binary(c,width,out);
      }else{
        out<<hex<<a<<"_"<<b<<"_"<<c<<dec;
      }
      out<<endl;
    }
};

class UnitChild: public CSimUnit{
  private:
    RefCFlipFlopUInt input_a;
    RefCFlipFlopUInt input_b;
    RefCFlipFlopUInt input_c;

    RefCFlipFlopUInt output_a;
    RefCFlipFlopUInt output_b;
    RefCFlipFlopUInt output_c;
    
    shared_ptr<FFUInt> d_inp_a;
    shared_ptr<FFUInt> d_inp_b;
    shared_ptr<FFUInt> d_inp_c;
    shared_ptr<FFUInt> d_out_a;
    shared_ptr<FFUInt> d_out_b;
    shared_ptr<FFUInt> d_out_c;

  public:
    UnitChild(string moduleName, string instanceName, RefCSimUnit parent)
      :CSimUnit(moduleName,instanceName,parent){
      
      RefCClock clk1 = CClock::build(5,"clk1");
      RefCClock clk2 = CClock::build(7,"clk2");

      d_inp_a = shared_ptr<FFUInt>(new FFUInt(1));
      d_inp_b = shared_ptr<FFUInt>(new FFUInt(2));
      d_inp_c = shared_ptr<FFUInt>(new FFUInt(3));
      d_out_a = shared_ptr<FFUInt>(new FFUInt(0));
      d_out_b = shared_ptr<FFUInt>(new FFUInt(0));
      d_out_c = shared_ptr<FFUInt>(new FFUInt(0));

      input_a  = CFlipFlop<FFUInt>::build(d_inp_a,clk1,"ff1");
      input_b  = CFlipFlop<FFUInt>::build(d_inp_b,clk1,"ff2");
      input_c  = CFlipFlop<FFUInt>::build(d_inp_c,clk1,"ff3");
      output_a = CFlipFlop<FFUInt>::build(d_out_a,clk2,"ff2");
      output_b = CFlipFlop<FFUInt>::build(d_out_b,clk2,"ff2");
      output_c = CFlipFlop<FFUInt>::build(d_out_c,clk2,"ff2");
    }


    void execute(){
      d_out_a->setValue(input_a->getQ().getValue());
      d_out_b->setValue(input_b->getQ().getValue());
      d_out_c->setValue(input_c->getQ().getValue());
    }

    void generate_vectors(){
    }

    void initialize(){
    }

    string getValue(string field){
      if(field == "d_inp_a"){
        return d_inp_a->toString();
      }else if(field == "d_inp_b"){
        return d_inp_b->toString();
      }else if(field == "d_inp_c"){
        return d_inp_c->toString();
      }else if(field == "d_out_a"){
        return d_out_a->toString();
      }else if(field == "d_out_b"){
        return d_out_b->toString();
      }else if(field == "d_out_c"){
        return d_out_c->toString();
      }else if(field == "input_a"){
        return input_a->getQ().toString();
      }else if(field == "input_b"){
        return input_b->getQ().toString();
      }else if(field == "input_c"){
        return input_c->getQ().toString();
      }else if(field == "output_a"){
        return output_a->getQ().toString();
      }else if(field == "output_b"){
        return output_b->getQ().toString();
      }else if(field == "output_c"){
        return output_c->getQ().toString();
      }else{
        return "";
      }
    }

    void instantiateUnits(RefCSimUnit parent){
    }

    vector<string> getInputs(){
      vector<string> result;
      result.push_back("input_a");
      result.push_back("input_b");
      result.push_back("input_c");
      return result;
    }

    vector<string> getOutputs(){
      vector<string> result;
      result.push_back("output_a");
      result.push_back("output_b");
      result.push_back("output_c");
      return result;
    }

    vector<string> getSignals(){
      return vector<string>();
    }

    vector<string> getVectors(){
      return vector<string>();
    }

    unsigned int getOutput_a(){
      return output_a->getQ().getValue();
    }

    unsigned int getOutput_b(){
      return output_b->getQ().getValue();
    }

    unsigned int getOutput_c(){
      return output_c->getQ().getValue();
    }

    unsigned int getInput_a(){
      return input_a->getQ().getValue();
    }

    unsigned int getInput_b(){
      return input_b->getQ().getValue();
    }

    unsigned int getInput_c(){
      return input_c->getQ().getValue();
    }

    void setOutput_a(unsigned int value){
      d_out_a->setValue(value);
    }
    
    void setOutput_b(unsigned int value){
      d_out_b->setValue(value);
    }

    void setOutput_c(unsigned int value){
      d_out_c->setValue(value);
    }

    void setInput_a(unsigned int value){
      d_inp_a->setValue(value);
    }

    void setInput_b(unsigned int value){
      d_inp_b->setValue(value);
    }

    void setInput_c(unsigned int value){
      d_inp_c->setValue(value);
    }
};


class UnitTop: public CSimUnit{
  private:
    RefCSimUnit x;
    RefCSimUnit y;

    bool valid;

    shared_ptr<CSimVectorWriter> vw1;
    shared_ptr<CSimVectorWriter> vw2;

  public:
    UnitTop(string moduleName, string instanceName, RefCSimUnit parent)
      :CSimUnit(moduleName,instanceName,parent){
      vw1 = buildVectorWriter<Writer>("1","1.0","vw1.txt",5);
      vw2 = buildVectorWriter<Writer>("2","1.1","vw2.txt",5);

      vw1->setTypeBinary();
      vw2->setTypeBinary();
    }

    void execute(){
      valid = !valid;
      int value_a;
      int value_b;
      int value_c;

      value_a =((UnitChild*)x.get())->getOutput_a();
      value_b =((UnitChild*)x.get())->getOutput_b();
      value_c =((UnitChild*)x.get())->getOutput_c();

      ((Writer*)vw1.get())->setAValue(value_a);
      ((Writer*)vw1.get())->setBValue(value_b);
      ((Writer*)vw1.get())->setCValue(value_c);

      if(valid){
        vw1->writeVector();
      }

      ((UnitChild*)y.get())->setInput_a(value_a);
      ((UnitChild*)y.get())->setInput_b(value_b);
      ((UnitChild*)y.get())->setInput_c(value_c);

      value_a =((UnitChild*)y.get())->getOutput_a();
      value_b =((UnitChild*)y.get())->getOutput_b();
      value_c =((UnitChild*)y.get())->getOutput_c();

      ((Writer*)vw2.get())->setAValue(value_a);
      ((Writer*)vw2.get())->setBValue(value_b);
      ((Writer*)vw2.get())->setCValue(value_c);
    
      vw2->writeVector();
     

    }

    void generate_vectors(){
    }

    void initialize(){
    }

    string getValue(string field){
      return "";
    }

    void instantiateUnits(RefCSimUnit parent){
      x = buildUnit<UnitChild>("UnitChild","x",parent);
      y = buildUnit<UnitChild>("UnitChild","y",parent);

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
  CSimulator::getInstance()->setTopUnit(buildUnit<UnitTop>("UnitTop","top",RefCSimUnit()));
  CSimulator::getInstance()->start_simulation();

  return 0;
}
