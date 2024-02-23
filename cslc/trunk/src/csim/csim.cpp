#include "csim.h"

using namespace std;
using namespace boost;

//---------------------------
//CClock class
//---------------------------
CClock::CClock(unsigned int period, string name){
  m_period          = period;
  m_cycles          = 0;
  m_peState         = 1;
  m_neState         = 0;
  m_currentCurrency = 0;
  m_name            = name;
}

void CClock::next(){
  if(++m_currentCurrency==m_period){
    m_peState=1;
    m_neState=0;
    m_currentCurrency=0;
    m_cycles++;//should have used ++var
  }else {
    m_peState=0;
    if(m_currentCurrency==m_period/2) m_neState=1;
    else m_neState=0;
  }
}

unsigned int CClock::getPeState(){
  return m_peState;
}

unsigned int CClock::getCycles(){
  return m_cycles;
}

unsigned int CClock::getNeState(){
  return m_neState;
}

unsigned int CClock::getPeriod(){
  return m_period;
}

string CClock::getName(){
  return m_name;
}

RefCClock CClock::build(unsigned int period, string name){
  CClock *object = new CClock(period, name);
  RefCClock ref = RefCClock(object);

  CSimulator::getInstance()->addClock(ref);

  return ref;
}

void CClock::addCFlipFlopBase(RefCFlipFlopBase flipFlopBase){
  m_flipFlops.push_back(flipFlopBase);
}

void CClock::addCSimVectorWriter(RefCSimVectorWriter simVectorWriter){
  m_vectorWriters.push_back(simVectorWriter);
}


//---------------------------
//CSimUnit class
//---------------------------
CSimUnit::CSimUnit(string moduleName, string instanceName, RefCSimUnit parent):
  m_moduleName(moduleName), m_instanceName(instanceName), m_parent(weak_ptr<CSimUnit>(parent)){
}


vector<RefCSimUnit >::iterator CSimUnit::begin(){
  return children.begin();
}

vector<RefCSimUnit >::iterator CSimUnit::end(){
  return children.end();
}

string CSimUnit::getModuleName(){
  return m_moduleName;
}

string CSimUnit::getInstanceName(){
  return m_instanceName;
}

vector<string> CSimUnit::getInputs(){
  return m_inputs;
}

vector<string> CSimUnit::getOutputs(){
  return m_outputs;
}

vector<string> CSimUnit::getSignals(){
  return m_signals;
}

vector<string> CSimUnit::getVectors(){
  return m_vectors;
}

RefCSimUnit CSimUnit::getParent(){
  return m_parent.lock();
}

void CSimUnit::addUnit(RefCSimUnit child){
  children.push_back(child);
}

RefCSimUnit CSimUnit::getChildByName(string childName){
  RefCSimUnit instance;
  
  for(vector<RefCSimUnit>::iterator it = children.begin(); it != children.end(); ++it){
    if((*it)->getInstanceName() == childName){
      instance = (*it);
      break;
    }
  }
  
  return instance;
}


string CSimUnit::getPath(){
  string path = m_instanceName;
  
  RefCSimUnit unit = m_parent.lock();
  while(unit.get()){
    path = unit->getInstanceName() + "/" + path;
    unit = unit->getParent();
  }

  return path;
}


string CSimUnit::getPathComplex(){
  string path = m_moduleName + "(" + m_instanceName + ")";
  
  RefCSimUnit unit = m_parent.lock();
  while(unit.get()){
    path = unit->getModuleName() + "(" + unit->getInstanceName() + ")" + "/" + path;
    unit = unit->getParent();
  }

  return path;
}


//-----------------------------------
//CMemoryBase class
//-----------------------------------
CMemoryBase::CMemoryBase(unsigned int width, RefCClock clk){
  this->width = width;
  this->clk   = clk;
}

bool CMemoryBase::write_enable(){
  return clk->getPeState();
}




//-----------------------------------
//CStateData class
//-----------------------------------

CStateData::CStateData(std::string filename, boost::shared_ptr<CMemoryBase> mem){
  out.open(filename.c_str());
  memory = mem;
  number = 0;
}

CStateData::~CStateData(){
  out.close();
}

boost::shared_ptr<CStateData> CStateData::build(std::string filename,boost::shared_ptr<CMemoryBase> memory){
  CStateData* object = new CStateData(filename,memory);
  boost::shared_ptr<CStateData> ref(object);
  
  CSimulator::getInstance()->addCStateData(ref);

  return ref;
}

void CStateData::setEnable_flag(bool flag){
  enable_flag = flag;
}

void CStateData::writeMemory(unsigned int index){
  if(!enable_flag) return;
  if(!memory->write_enable()) return;

  time_t rawtime;
  time ( &rawtime );

  out<<"//-----------------------------------------------------"<<std::endl;
  out<<"//simulation cycle count "<<index<<endl;
  out<<"//state data  nr. "<<number<<std::endl;
  out<<"//generated on "<<ctime (&rawtime);
  out<<"//-----------------------------------------------------"<<std::endl;

  memory->dumpMemory(out);
  out<<std::endl<<std::endl;
  number++;
}





//-----------------------------------
//CSimVectorWriter class
//-----------------------------------
CSimVectorWriter::CSimVectorWriter(int id, int version, string filename,
                                   string vectorName,string vectorInstanceName, 
                                   string moduleName,string moduleInstanceName,
                                   unsigned int width): 
  m_id(id), 
  m_version(version), 
  m_filename(filename), 
  m_vectorName(vectorName),
  m_vectorInstanceName(vectorInstanceName),
  m_moduleName(moduleName),
  m_moduleInstanceName(moduleInstanceName),
  m_width(width), 
  m_type(1), 
  m_start_gen(false),
  m_counts(0)
{
  m_out.open(filename.c_str());
  writeComments(m_out);
}

void CSimVectorWriter::setMaxEvents(unsigned int maxEvents){
  m_maxEvents = maxEvents;
}

bool CSimVectorWriter::isTypeBinary(){
  return m_type == 0;
}

bool CSimVectorWriter::isTypeHex(){
  return m_type == 1;
}

void CSimVectorWriter::setTypeBinary(){
  m_type = 0;
}

void CSimVectorWriter::setTypeHex(){
  m_type = 1;
}

bool CSimVectorWriter::canWrite(){
  return m_counts < m_maxEvents;
}

void CSimVectorWriter::writeComments(std::ostream &os){
  time_t rawtime;
  time ( &rawtime );

  os<<"/**"<<endl;
  os<<" * generated on         : "<<ctime (&rawtime);
  os<<" * vector name          : "<<m_vectorName<<endl;
  os<<" * vector instance name : "<<m_vectorInstanceName<<endl;
  os<<" * module name          : "<<m_moduleName<<endl;
  os<<" * module instance name : "<<m_moduleInstanceName<<endl;
  os<<"*/"<<endl<<endl;

  if(m_type){
    os << hex;
    os << m_id << endl;
    os << m_version;
    os << dec << endl;
    m_pos=os.tellp();
    os << "                                                                     " << endl; //space for m_count
  }else{
    binary(m_id,32,os); os << endl;
    binary(m_version,32,os); os << endl;
    m_pos=os.tellp();
    unsigned int temp = 0;
    binary(temp,32,os); os << endl;    //space for m_count
  }
  
  os<<endl;
}

bool CSimVectorWriter::getStartGen(){
  return m_start_gen;
}

CSimVectorWriter::~CSimVectorWriter(){
  m_out.seekp(m_pos);
  if(m_type){
    m_out << hex << m_counts;
    m_out << dec;
  }else{
    binary(m_counts,32,m_out);
  }
  m_out.close();
}

//----------------------------
//FlipFlopBase class
//----------------------------
CFlipFlopBase::CFlipFlopBase(RefCClock clock,string name):
  m_clock(clock), m_name(name){
}

string CFlipFlopBase::getName(){
  return m_name;
}

RefCClock CFlipFlopBase::getClock(){
  return m_clock;
}






//---------------------------------
//DefaultSimulatorInterface class
//---------------------------------
void DefaultSimulatorInterface::beforeSimulation(){}
void DefaultSimulatorInterface::afterSimulation() {}
void DefaultSimulatorInterface::cycleStart(int cycle_count){}
void DefaultSimulatorInterface::cycleEnd  (int cycle_count){}




//---------------------------------
//CBreakPoint class
//---------------------------------
CBreakPoint::CBreakPoint(RefCSimUnit unit, string field, string oper, string value){
  this->unit  = unit;
  this->field = field;
  this->oper  = oper;
  this->value = value;
  
  isOn = true;
}

CBreakPoint::CBreakPoint(){
  isOn = true;
}

bool CBreakPoint::isTrue(){
  string current_value = unit->getValue(field);
  
  if(oper=="=="){
    return (value == current_value);
  }else if(oper=="<="){
    return (value <= current_value);
  }else if(oper==">="){
    return (value >= current_value);
  }else if(oper=="!="){
    return (value != current_value);
  }else if(oper==">"){
    return (value > current_value);
  }else if(oper=="<"){
    return (value < current_value);
  }

}



//---------------------------------
//CSimulator class - singleton
//---------------------------------
shared_ptr<CSimulator> CSimulator::m_instance = shared_ptr<CSimulator>(new CSimulator());


unsigned int CSimulator::gdb(unsigned int a, unsigned int b){
  if(b == 0){
    return a;
  }else{
    return gdb(b, a % b);
  }
}

CSimulator::CSimulator():
  m_wavesEnabled(false), max_cycle(0x7fffffff), m_interface(new DefaultSimulatorInterface()), m_maxLength(0), end_simulation(false), is_continue(true),m_clock_gdb(1){

  //signals
  signal(SIGHUP , shell_exit_signal);
  signal(SIGINT , shell_exit_signal);
  signal(SIGQUIT, shell_exit_signal);
  signal(SIGILL , shell_exit_signal);
}

void shell_exit_signal(int code){
  if(CSimulator::getInstance()->loops && CSimulator::getInstance()->is_continue){
    CSimulator::getInstance()->loops = 1;
    
    cout<<"Simulation aborded!"<<endl;
  }else{
    CSimulator::getInstance()->end_simulation = true;
    CSimulator::getInstance()->loops          = 1;
    CSimulator::getInstance()->is_continue    = true;
    cout<<endl<<"CSLC Simulator aborded"<<endl;
    cout<<"press Enter to continue..."<<endl;
  }
}

void CSimulator::addUnit(RefCSimUnit unit){
  m_units.push_back(unit);
}

void CSimulator::addFlipFlopBase(RefCFlipFlopBase flipFlopBase){
  RefCClock clock = flipFlopBase->getClock();
  m_flipFlops[clock].push_back(flipFlopBase);

  //add to waves
  m_ffWaves[flipFlopBase]=vector<string>();
  if(flipFlopBase->getName().length()>m_maxLength){
    m_maxLength=flipFlopBase->getName().length();
  }
}

shared_ptr<CSimulator>  CSimulator::getInstance(){
  return m_instance;
}

void CSimulator::setSimulatorInterface(RefCSimulatorInterface interface){
  m_interface=interface;
}

void CSimulator::addClock(RefCClock clock){
  m_flipFlops[clock]=vector<RefCFlipFlopBase >();

  //add to waves
  m_clkWaves[clock]=vector<int>();
  if(clock->getName().length()>m_maxLength){
    m_maxLength=clock->getName().length();
  }

  m_clock_gdb = gdb(m_clock_gdb, clock->getPeriod());
}


void CSimulator::addCSimVectorWriter(RefCSimVectorWriter vectorWriter, RefCClock clk){
  m_vectorWriters[clk].push_back(vectorWriter);
}

void CSimulator::addCStateData(RefCStateData stateData){
  m_stateData.push_back(stateData);
}

void CSimulator::print(){
  map<RefCClock,vector<RefCFlipFlopBase > >::iterator it;
  for(it=m_flipFlops.begin();it!=m_flipFlops.end();++it){
    cout<<it->first->getName()<<" :";
    for(vector<RefCFlipFlopBase >::iterator its=it->second.begin();its!=it->second.end();++its){
      cout<<" "<<(*its)->getName();
    }
    cout<<endl;
  }
}

void CSimulator::enableWaves(){
  m_wavesEnabled = true;

  //remove all current waves
  for(map<RefCClock,vector<int> >::iterator it = m_clkWaves.begin();it!=m_clkWaves.end();++it){
    it->second.clear();
  }

  for(map<RefCFlipFlopBase,vector<string> >::iterator it = m_ffWaves.begin();it!=m_ffWaves.end();++it){
    it->second.clear();
  }
}

void CSimulator::disableWaves(){
  m_wavesEnabled = false;
}

void CSimulator::writeWaves(string file_name){
  ofstream out(file_name.c_str());
  if(!out){
    cerr<<"file \""<<file_name<<"\" can not be open for write"<<endl;
    return;
  }
  
  //clocks first
  for(map<RefCClock,vector<int> >::iterator it = m_clkWaves.begin(); it!=m_clkWaves.end();++it){
    out<<setw(m_maxLength)<<it->first->getName()<<": ";
    for(vector<int>::iterator its = it->second.begin();its!=it->second.end();++its){
      out<<(*its)<<" ";
    }
    out<<endl;
  }

  out<<"-------------------"<<endl;

  //now the flip flops
  for(map<RefCFlipFlopBase,vector<string> >::iterator it = m_ffWaves.begin(); it!=m_ffWaves.end(); ++it){
    out<<setw(m_maxLength)<<it->first->getName()<<": ";
    for(vector<string>::iterator its = it->second.begin(); its!=it->second.end(); ++its){
      out<<(*its)<<" ";
    }
    out<<endl;
  }

  out.close();
}

void CSimulator::writeWaves(){
  //clocks first
  for(map<RefCClock,vector<int> >::iterator it = m_clkWaves.begin(); it!=m_clkWaves.end();++it){
    cout<<setw(m_maxLength)<<it->first->getName()<<": ";
    for(vector<int>::iterator its = it->second.begin();its!=it->second.end();++its){
      cout<<(*its)<<" ";
    }
    cout<<endl;
  }

  cout<<"-------------------"<<endl;

  //now the flip flops
  for(map<RefCFlipFlopBase,vector<string> >::iterator it = m_ffWaves.begin(); it!=m_ffWaves.end(); ++it){
    cout<<setw(m_maxLength)<<it->first->getName()<<": ";
    for(vector<string>::iterator its = it->second.begin(); its!=it->second.end(); ++its){
      cout<<(*its)<<" ";
    }
    cout<<endl;
  }
}

void CSimulator::setTopUnit(RefCSimUnit top){
  m_top=top;
  current_unit=top;
}


RefCSimUnit CSimulator::getUnitByPath(string path){
  if(path[path.size()-1]!='/'){
    path = path + "/";
  }
    
  RefCSimUnit unit,next_unit;
  int find = path.find("/");
  string unit_name = path.substr(0,find);
  path.erase(0,find + 1);


  /**find the start unit from the path*/
  if(unit_name == ".."){
    unit = current_unit->getParent();
    if(!unit.get()){//no parent
      unit = m_top;
    }
  }else{
    if(m_top->getInstanceName() == unit_name){
      unit = m_top;
    }else{
      unit = current_unit->getChildByName(unit_name);
      if(!unit.get()){//no child with name from the path
        cerr<<"Error: unit \""<<current_unit->getInstanceName()<<"\" has no child named \""<<unit_name<<"\""<<endl;
        return unit;
      }
    }
  }

  /**parse the path*/
  while(path.size()){
    find      = path.find("/");
    unit_name = path.substr(0,find);
    path.erase(0,find + 1);
    
    if(unit_name == ".."){
      next_unit = unit->getParent();
      if(next_unit.get()){
        unit = next_unit;
      }
    }else{
      next_unit = unit->getChildByName(unit_name);
    
      if(!next_unit.get()){
        cerr<<"Error: unit \""<<unit->getInstanceName()<<"\" has no child named \""<<unit_name<<"\""<<endl;
        return next_unit;
      }

      unit = next_unit;
    }
  }

  return unit;
}

string CSimulator::getFieldValue(string path_value){
  string path;
  string name;
  string value;

  RefCSimUnit unit = current_unit;

  int start = path_value.rfind("/",path_value.size());
  if(start == string::npos){
    start = 0;
  }

  int path_end = path_value.find(".",start);

  if(path_end == string::npos && start == 0){
  
    value = current_unit->getValue(path_value);

  }else if(path_end == string::npos && start ){
  
    cerr<<"sintax error: <path>.<name>"<<endl;
    return "";
  
  }else{
    
    path  = path_value.substr(0,path_end);
    name  = path_value.substr(path_end + 1, path_value.size() );
  
    unit  = getUnitByPath(path);
    if(!unit.get()){
      return "";
    }
    value = unit->getValue(name);
  }

  if(!value.size()){
    cerr<<"Error: unit \""<<unit->getInstanceName()<<"\" has no field named \""<<name<<"\""<<endl;
  }

  return value;

}

void CSimulator::cmd_exit(queue<string> params){
  if(params.size()){
    cerr<<"sintax error: exit"<<endl;
    return;
  }

  is_continue    = true;
  loops          = 1;
  end_simulation = true;
}
  
void CSimulator::cmd_run(queue<string> params){
  if(params.size()!=1){
    cerr<<"sintax error: run <no_loops>"<<endl;
    return;
  }

  unsigned int no_loops;
  string param = params.front();
  params.pop();

  if(stringToUInt(param,no_loops)){
    loops=no_loops;
  }
}

void CSimulator::cmd_ls(queue<string> params){
  string path = "";
  bool   i    = false;
  bool   o    = false;
  bool   s    = false;
  bool   v    = false;

  while(params.size()){
    string param = params.front(); params.pop();
    if(param == "-i"){     
      if(i){
        cerr<<"sintax error: -i"<<endl;
        return;
      }      
      i = true;
    }else if(param == "-o"){
      if(o){
        cerr<<"sintax error: -o"<<endl;
        return;
      }  
      o = true;
    }else if(param == "-s"){
      if(s){
        cerr<<"sintax error: -s"<<endl;
        return;
      }      
      s = true;
    }else if(param == "-v"){
      if(v){
        cerr<<"sintax error: -v"<<endl;
        return;
      }     
      v = true;
    }else{      
      if(path.size()){
        cerr<<"sintax error: path"<<endl;
        return;
      }
      path = param;
    }
  }

  /**
   * if no params then list everything
  */
  if(!i && !o && !s && !v){ 
    i = true;
    o = true;
    s = true;
    v = true;
  }

  RefCSimUnit unit = current_unit;
  if(path.size()){
    unit = getUnitByPath(path);
    if(!unit.get()){
      return;
    }
  }


  //inputs
  if(i){
    vector<string> inputs = unit->getInputs();
    cout<<"->inputs:"<<endl;
    for(vector<string>::iterator it = inputs.begin(); it != inputs.end(); ++it){
      cout<<"\t"<<*(it)<<endl;
    }
  }

  //outputs
  if(o){
    vector<string> outputs = unit->getOutputs();
    cout<<"->outputs:"<<endl;
    for(vector<string>::iterator it = outputs.begin(); it != outputs.end(); ++it){
      cout<<"\t"<<*(it)<<endl;
    }
  }

  //signals
  if(s){
    vector<string> signals = unit->getSignals();
    cout<<"->signals:"<<endl;
    for(vector<string>::iterator it = signals.begin(); it != signals.end(); ++it){
      cout<<"\t"<<*(it)<<endl;
    }
  }

  //vectors
  if(v){
    vector<string> vectors = unit->getVectors();
    cout<<"->vectors:"<<endl;
    for(vector<string>::iterator it = vectors.begin(); it != vectors.end(); ++it){
      cout<<"\t"<<*(it)<<endl;
    }
  }

  //units
  cout<<"->units"<<endl;
  for(vector<RefCSimUnit >::iterator it = unit->begin(); it!= unit->end(); ++it){
    cout<<"\t"<<(*it)->getModuleName()<<" "<<(*it)->getInstanceName()<<endl;
  }
}

void CSimulator::cmd_root(queue<string> params){
  if(params.size()){
    cerr<<"sintax error: root"<<endl;
    return;
  }

  cout<<m_top->getModuleName()<<" "<<m_top->getInstanceName()<<endl;
}

void CSimulator::cmd_cd(queue<string> params){
  if(params.size()!=1){
    cerr<<"sintax error: cd <unit path>"<<endl;
    return;
  }

  string path = params.front();
  params.pop();

  RefCSimUnit m_unit = getUnitByPath(path);
  if(!m_unit.get()){
    return;
  }

  current_unit = m_unit;

}

void CSimulator::cmd_waves(queue<string> params){
  if(params.size()!=1){
    cerr<<"sintax error: waves enable|disable"<<endl;
    return;
  }

  string state = params.front();
  
  if(state == "enable"){
    enableWaves();
  }else if(state == "disable"){
    disableWaves();
  }else{
    cerr<<"sintax error: waves enable|disable"<<endl;
    return;
  }

}

void CSimulator::cmd_dump_waves(queue<string> params){
  if(params.size()!=2 && params.size()!=0){
    cerr<<"sintax error: dump_waves [-f <file_name>]"<<endl;
    return;
  }
  
  if(!params.size()){
    writeWaves();
    return;
  }

  string argument  = params.front(); params.pop();
  string file_name = params.front(); params.pop();

  if(argument != "-f"){
    cerr<<"sintax error: dump_waves [-f <file_name>]"<<endl;
    return;
  }

  writeWaves(file_name);
}

void CSimulator::cmd_finish(queue<string> params){
  if(params.size() != 1){
    cerr<<"sintax error: finish <no_cycles>"<<endl;
    return;
  }

  string param = params.front(); params.pop();
  unsigned int m_finish;
  if(stringToUInt(param,m_finish)){
    max_cycle = m_finish;
  }
  
}

void CSimulator::cmd_help(queue<string> params){
  if(params.size()){
    cerr<<"sintax error: exit"<<endl;
  }

  cout<<"help"<<endl;
  cout<<"\tdisplay the help"<<endl<<endl;

  cout<<"exit, quit"<<endl;
  cout<<"\texit the simulator console"<<endl<<endl;

  cout<<"run <no_loops>"<<endl;
  cout<<"\tsimulate \'no_loops\' clock cycles"<<endl<<endl;

  cout<<"ls [<unit_path>] [-i] [-o] [-s] [-v]"<<endl;
  cout<<"\tdisplay units from the \'unit_path\'; if path is missing than display units from the current unit"<<endl<<endl;
  cout<<"\toptions:"<<endl;
  cout<<"\t\t-i : inputs"<<endl;
  cout<<"\t\t-o : outputs"<<endl;
  cout<<"\t\t-s : signals"<<endl;
  cout<<"\t\t-v : vectos"<<endl;

  cout<<"cd <unit_path>"<<endl;
  cout<<"\tdisplay units from the \'unit_path\'"<<endl<<endl;

  cout<<"root"<<endl;
  cout<<"\tdisplay the root (top) of the tree"<<endl<<endl;

  cout<<"pwd"<<endl;
  cout<<"\tfull explained path to the current_unit"<<endl<<endl;

  cout<<"waves <enable>|<disable>"<<endl;
  cout<<"\tenable and disable waves"<<endl<<endl;

  cout<<"dump_waves [-f <file_name>]"<<endl;
  cout<<"\twrite waves to the \'file_name\' or to the screen if no file_name is given"<<endl<<endl;

  cout<<"finish <no_cycles>"<<endl;
  cout<<"\tset the MAX_CYCLE to \'no_cycles\'"<<endl<<endl;

  cout<<"print <name> [-p <path>]"<<endl;
  cout<<"\tprint the value of field \'name\' in the unit from the \'path\'"<<endl<<endl;

  cout<<"break <field> <operator> <value> [-p <path>]"<<endl;
  cout<<"\tset a break"<<endl;
  cout<<"\texample: break x == 45 -p top/child1/child2/<..>/childn"<<endl;
  cout<<"\tpossible values for <operator>: \"==\" \"<=\" \">=\" \"!=\" \">\" \"<\""<<endl;
  cout<<"\t\tWarning: please use spaces beetween <field>, <operator> and <value>"<<endl<<endl;

  cout<<"show_bp"<<endl;
  cout<<"\tdisplay the break points"<<endl<<endl;

  cout<<"delete_bp <id>"<<endl;
  cout<<"\tdelete the break point corespounding to \"id\""<<endl<<endl;

  cout<<"set_bp <id> <state>"<<endl;
  cout<<"\tpossible values for <state>: on , off"<<endl;

  cout<<"continue"<<endl;
  cout<<"\tcontinue to simulate until loops = 0 or other condition to stop"<<endl<<endl;
}

void CSimulator::cmd_print(queue<string> params){
  if(params.size()!=1 &&  params.size()!=3){
    cerr<<"sintax error: print <name> [-p <path>]"<<endl;
    return;
  }
  
  string field = params.front(); params.pop();
  RefCSimUnit unit = current_unit;
  
  if(params.size()){
    string arg = params.front(); params.pop();
    if(arg!="-p"){
      cerr<<"sintax error: print <name> [-p <path>]"<<endl;
      return;
    }

    string path = params.front();
    unit = getUnitByPath(path);
    
    if(!unit.get()){
      return;
    }
  }


  string value = unit->getValue(field);

  if(!value.size()){
    cerr<<"Error: unit \""<<unit->getInstanceName()<<"\" has no field named \""<<field<<"\""<<endl;
    return;
  }else{
    cout<<value<<endl;
  }
}

void CSimulator::cmd_add_watch(queue<string> params){
}

void CSimulator::cmd_del_watch(queue<string> params){
}

void CSimulator::cmd_break(queue<string> params){
  if(params.size()!=3 && params.size() != 5){
    cerr<<"break <field> <operator> <value> [-p <path>]"<<endl;
    return;
  }
  
  string      field = params.front(); params.pop();
  string      oper  = params.front(); params.pop();
  string      value = params.front(); params.pop();
  RefCSimUnit unit  = current_unit;

  if(oper!="==" && oper!="<=" && oper!=">=" && oper!="!=" && oper!=">" && oper!="<"){     
    cerr<<"sintax error: possible values for <operator> are \"==\" \"<=\" \">=\" \"!=\" \">\" \"<\""<<endl;
    return;
  }
  
  if(params.size()){
    string option = params.front(); params.pop();
    string path   = params.front(); params.pop();
    
    if(option != "-p"){
      cerr<<"break <field> <operator> <value> [-p <path>]"<<endl;
      return;
    }

    unit = getUnitByPath(path);
    if(!unit.get()){
      return;
    }
  }

  if(!unit->getValue(field).size()){
    cerr<<"Error: unit \""<<unit->getInstanceName()<<"\" has no field named \""<<field<<"\""<<endl;
    return;
  }

  m_breakPoints.push_back(CBreakPoint(unit,field,oper,value));
}


void CSimulator::cmd_show_bp(queue<string> params){
  if(params.size()){
    cerr<<"sintax error: show_bp"<<endl;
    return;
  }
  
  int id_width = 3;  //more than 999 breaks???
  int st_width = 6;  //size of "status"
  int fd_width = 5;  //size of "field"
  int cm_width = 11; //size of "comparations"
  int ev_width = 14; //size of "expected_value"
  int cv_width = 13; //size of "current_value"
 
  //calculating width
  for(vector<CBreakPoint>::iterator it = m_breakPoints.begin(); it!=m_breakPoints.end();++it){
    //fd_width
    string temp = it->field;       
    if(temp.size()>fd_width){
      fd_width = temp.size();
    }
    
    //cm_width
    temp = it->oper;       
    if(temp.size()>cm_width){
      cm_width = temp.size();
    }

    //ev_width
    temp = it->value;       
    if(temp.size()>ev_width){
      ev_width = temp.size();
    }

    //cv_width
    temp = it->unit->getValue(it->field);
    if(temp.size()>cv_width){
      cv_width = temp.size();
    }
  }

  
  //printing
  cout<<endl<<"BreakPoints:"<<endl<<endl;
  cout <<setiosflags(ios::left);
  cout<<" "<<setw(id_width)<<"id"<<" | "<<setw(st_width)<<"status"<<" | "<<setw(fd_width)<<"field"<<" | "<<setw(cm_width)<<"comparation"<<" | ";
  cout<<setw(ev_width)<<"expected_value"<<" | "<<setw(cv_width)<<"current_value"<<" | "<<"path"<<endl;
  cout<<"---------------------------------------------------------------------------------------------"<<endl;
  for(int i = 0; i < m_breakPoints.size(); ++i){
    CBreakPoint bp = m_breakPoints.at(i);
    string status = "on";
    if(!bp.isOn){
      status = "off";
    }
    cout<<" "<<setw(id_width)<<i<<" | "<<setw(st_width)<<status<<" | "<<setw(fd_width)<<bp.field<<" | "<<setw(cm_width)<<bp.oper<<" | ";
    cout<<setw(ev_width)<<bp.value<<" | "<<setw(cv_width)<<bp.unit->getValue(bp.field)<<" | "<<bp.unit->getPath()<<endl;  
  }
  cout<<endl;
  //cout << setiosflags(ios::right);
}


void CSimulator::cmd_delete_bp(queue<string> params){
  if(params.size() != 1){
    cerr<<"sintax error: delete_bp <id>"<<endl;
    return;
  }

  string str = params.front();
  unsigned int value;
  if(!stringToUInt(str,value)){
    return;
  }
  
  if(value<0 || value >m_breakPoints.size()){
    cerr<<"Error: no break point with id = "<<value<<endl;
    return;
  }
  m_breakPoints.erase(m_breakPoints.begin()+value);
}

void CSimulator::cmd_continue(std::queue<std::string> params){
  if(params.size()){
    cerr<<"sintax error: continue"<<endl;
    return;
  }

  is_continue = true;
}

void CSimulator::cmd_set_bp(queue<string> params){
  if(params.size()!=2){
    cerr<<"sintax error: set_bp <id> <state>"<<endl;
    return;
  }

  string temp = params.front();params.pop();
  unsigned int id;
  if(!stringToUInt(temp,id)){
    return;
  }

  if(id>= m_breakPoints.size() || !m_breakPoints.size()){
    cerr<<"error: no break point with id "<<id<<endl;
    return;
  }

  temp = params.front(); params.pop();
  if(temp == "on"){
    m_breakPoints[id].isOn = true;
  }else if(temp == "off"){
    m_breakPoints[id].isOn = false;
  }else{
    cerr<<"possible values for <state> are : on , off"<<endl;
    return;
  }
  
}

void CSimulator::cmd_pwd(queue<string> params){
  if(params.size()){
    cerr<<"sintax error: pwd"<<endl;
    return;
  }
  
  cout<<current_unit->getPathComplex()<<endl;
}

void CSimulator::outputShell(unsigned int index){
  cout<<"[fpl_simulator:"<<index<<" "<<current_unit->getInstanceName()<<"]$ ";
  string line;
  getline(cin,line);
  std::istringstream ssinp(line);

  string command;
  queue<string> params;
  ssinp>>command;

  string param;
  while(ssinp>>param){
    params.push(param);
  }

  
  if(command == "exit" || command == "quit"){
    cmd_exit(params);
  }else if(command == "help"){
    cmd_help(params);
  }else if(command == "run"){
    cmd_run(params);
  }else if(command == "ls"){
    cmd_ls(params);
  }else if(command == "root"){
    cmd_root(params);
  }else if(command == "cd"){
    cmd_cd(params);
  }else if(command == "waves"){
    cmd_waves(params);
  }else if(command == "dump_waves"){
    cmd_dump_waves(params);
  }else if(command == "finish"){
    cmd_finish(params);
  }else if(command == "print"){
    cmd_print(params);
  }else if(command == "break"){
    cmd_break(params);
  }else if(command == "show_bp"){
    cmd_show_bp(params);
  }else if(command == "delete_bp"){
    cmd_delete_bp(params);
  }else if(command == "continue"){
    cmd_continue(params);
  }else if(command == "set_bp"){
    cmd_set_bp(params);
  }else if(command == "pwd"){
    cmd_pwd(params);
  }else{
    if(command != ""){
      cout<<command<<": command not found"<<endl;
    }
  }
}

void CSimulator::start_simulation(){
  cout<<"CSLC Simulator"<<endl;
  cout<<"type \"help\" if you need it"<<endl<<endl;


  loops = 1;
  m_interface->beforeSimulation();

  /**
   * main for:
   * for(....){
   *   foreach(unit) unit.execute();
   *   foreach(clock) clock.next(); 
   *   foreach(flip_flop) flip_flop.prop();
   *
   *   break
   *
   *   max_cicle_check
   *
   *   shell
   * }
  */
  for(int i = 0/*i is just a counter*/;!end_simulation;++i){
    m_interface->cycleStart(i);

    /**
     * foreach(unit) unit.execute();
    */
//    for(vector<RefCSimUnit >::iterator it = m_units.begin();it!=m_units.end();++it){
//      (*it)->execute();
//    }
    for(int unit_index = m_units.size() - 1; unit_index >= 0; --unit_index){
      m_units.at(unit_index)->execute();
    }
    
    /**
     * foreach(clock) clock.next(); 
     * increment current time for each clock and resolve peStatus/neStatus
    */
    map<RefCClock,vector<RefCFlipFlopBase > >::iterator it;
    for(it=m_flipFlops.begin();it!=m_flipFlops.end();++it){
      it->first->next();
      //add to waves
      if(m_wavesEnabled){
        m_clkWaves[it->first].push_back(it->first->getPeState());
      }

      /**
       * foreach(flip_flop) flip_flop.prop();
      */
      if(it->first->getPeState()){
        for(vector<RefCFlipFlopBase >::iterator its = it->second.begin();its!=it->second.end();++its){
          (*its)->prop();
        }

        /**
         * vectorwriter
        */
        for(vector<RefCSimVectorWriter>::iterator its = m_vectorWriters[it->first].begin();its!= m_vectorWriters[it->first].end();++its){
          (*its)->writeVector();
        }
      }
      //add to waves
      if(m_wavesEnabled){
        for(vector<RefCFlipFlopBase >::iterator its = it->second.begin();its!=it->second.end();++its){
          m_ffWaves[*its].push_back((*its)->get());
        }
      }

    }

    /**
     * stateData
    */
    for(vector<RefCStateData>::iterator it = m_stateData.begin(); it != m_stateData.end(); ++it){
      (*it)->writeMemory(i);
    }

    
    m_interface->cycleEnd(i);

    /**
     * break
    */
    for(vector<CBreakPoint>::iterator it = m_breakPoints.begin(); it!=m_breakPoints.end(); ++it){
      if(it->isOn && it->isTrue()){
        cout<<"breakpoint: "<<it->field<<" "<<it->oper<<" "<<it->value<<endl;
        is_continue = false;
        it->isOn    = false;
      }
    }

    /**
     * max_cicle_check
     * Counter i must be smaller than MAX_CICLE.
     * default is 0x7fffffff(max int)
    */
    if(i>=max_cycle) break;

    /**
     * shell
     * If you have no loops in <main for> to do (loops==0) than u enter the shell.
     * Each time u reach this loops gets decremented. Say u write in shell "run 9":
     * this will set loops to 9 (loops=9) so after 9 loops you have acces again 
     * to shell.
    */
    --loops;
    while(!loops || !is_continue){
      outputShell(i);
    }
  }

  m_interface->afterSimulation();
}
