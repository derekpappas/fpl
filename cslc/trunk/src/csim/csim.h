#ifndef CSIM_H
#define CSIM_H

#include <vector>
#include <iostream>
#include <string>
#include <map>
#include <fstream>
#include <iomanip>
#include <sstream>
#include <queue>

#include <boost/smart_ptr.hpp>
#include "csim_support.h"
#include "FlipFlopTypes.h"

#include <signal.h>

class CSimulator;
class CSimUnit;
class CClock;
class CFlipFlopBase;
class CSimVectorWriter;
class CSimulatorInterface;
template <class T> class CFlipFlop;
class CMemoryBase;
class CStateData;

typedef boost::shared_ptr<CSimUnit>                RefCSimUnit;
typedef boost::shared_ptr<CClock>                  RefCClock;
typedef boost::shared_ptr<CFlipFlopBase>           RefCFlipFlopBase;
typedef boost::shared_ptr<CSimVectorWriter>        RefCSimVectorWriter;
typedef boost::shared_ptr<CSimulatorInterface>     RefCSimulatorInterface;
typedef boost::shared_ptr<CFlipFlop<FFUInt> >      RefCFlipFlopUInt;
typedef boost::shared_ptr<CFlipFlop<FFUChar> >     RefCFlipFlopUChar;
typedef boost::shared_ptr<CFlipFlop<FFULongLong> > RefCFlipFlopULongLong;
typedef boost::shared_ptr<CMemoryBase>             RefCMemoryBase;
typedef boost::shared_ptr<CStateData>              RefCStateData;

//-----------------------------
//CClock class
//-----------------------------
/**
 * m_period determinates the posedge and negedge of the clock
 * example: if m_period is 5 then you will have
 *            posedge: 100001000010000....
 *            negedge: 001000010000100....
 *          m_peState is 1 if m_currentCurrency is 0,5,10.... and 0 in rest
 *          m_neState is 1 if m_currentCurrency is 2,7,12.... and 0 in rest (negedge-posedge = 2 = 5/2 <half of period>) 
*/
class CClock{
  private:
    unsigned int m_period;
    unsigned int m_peState;
    unsigned int m_neState;
    unsigned int m_currentCurrency;
    unsigned int m_cycles;
    std::string  m_name;

    CClock(unsigned int period, std::string name);

    /**
     * I put in CClock class vectors of types asociated with a CClock
     * By doing this i can find out easy wich objects are dependent on the clock - faster than wich clock is asociated with an object
    */
    std::vector<RefCFlipFlopBase>    m_flipFlops;
    std::vector<RefCSimVectorWriter> m_vectorWriters;

  public:    
    /**
     * Increments m_currentCurrency and sets the new values for m_peState and m_neState.
     * If m_currentCurrency becomes equal with m_period then m_currentCurrency is set to 0
     * so m_currentCurrency cicles between 0 and m_period-1.
    */
    void next();
    unsigned int getPeState();
    unsigned int getNeState();
    unsigned int getPeriod();
    unsigned int getCycles();

    std::string getName();

    void addCFlipFlopBase(RefCFlipFlopBase);
    void addCSimVectorWriter(RefCSimVectorWriter);

    static RefCClock build(unsigned int period, std::string name);
};


//----------------------------
//CSimUnit class
//----------------------------
/**
 * Class CSimUnit is a pure virtual class. It is used for simulating the exectution of a unit.
 * example:
 *              class UnitA: public CSimUnit{
 *                private:
 *                  int a,b,c;
 *                public:
 *                  void execute(){
 *                    a = b + c;
 *                  }
 *                  void initialize(){
 *                    b = 3;
 *                    c = 5;
 *                  }
 *                  void generate_std::vectors(){//what the ???
 *                  }
 *                  
 *                  UnitA(std::string moduleName,std::string instanceName):CSimUnit(moduleName,instanceName){
 *                  }
 *              };
*/
/**
 * build function for units.
 * Use :share_ptr<UnitA> x=build<UnitA>();
 * If you don't use it that way you will get memory leaks:D 
 * and other nasty errors:D.
*/
template <class T> boost::shared_ptr<T> buildUnit(std::string,std::string,RefCSimUnit);
class CSimUnit{
  private:
    std::string               m_moduleName;
    std::string               m_instanceName;
    boost::weak_ptr<CSimUnit> m_parent;

  protected:
    CSimUnit(std::string,std::string,RefCSimUnit);
    template<class T> friend boost::shared_ptr<T> buildUnit(std::string,std::string,RefCSimUnit);

    std::vector<std::string> m_inputs;
    std::vector<std::string> m_outputs;
    std::vector<std::string> m_signals;
    std::vector<std::string> m_vectors;

    std::vector<RefCSimUnit > children;

  public:
    virtual void connect()                            = 0;
    virtual void execute()                            = 0;
    virtual void generate_vectors()                   = 0;
    virtual void initialize()                         = 0;
    virtual void instantiateUnits(RefCSimUnit)        = 0;

    virtual std::string getValue(std::string)         = 0;

    std::vector<std::string> getInputs() ;
    std::vector<std::string> getOutputs();
    std::vector<std::string> getSignals();
    std::vector<std::string> getVectors();

    std::string getModuleName();
    std::string getInstanceName();

    RefCSimUnit getParent();
    RefCSimUnit getChildByName(std::string childName);
    std::string getPath();                 
    std::string getPathComplex();

    void addUnit(RefCSimUnit);
    /**
     * iteration in children
     * usage:
     *   for(std::vector<CSimUnit>::iterator it= unit_inst.begin(); it!=unit_inst.end(); ++it){
     *     //stuff here
     *   }
    */
    std::vector<RefCSimUnit>::iterator begin();
    std::vector<RefCSimUnit>::iterator end();

};

//-----------------------------------
//CSimVectorWriter class
//-----------------------------------
//id, version, filename, vectorName, vectorInstanceName, moduleName, moduleInstanceName, width
template <class T> boost::shared_ptr<T> buildVectorWriter(int,int,std::string,std::string,std::string,std::string,std::string,unsigned int);
class CSimVectorWriter{
  protected:
    int           m_id;
    int           m_version;
    std::string   m_filename;
    std::string   m_vectorName;
    std::string   m_vectorInstanceName;
    std::string   m_moduleName;
    std::string   m_moduleInstanceName;
                  
    int           m_type; //0 = binary 1 = hex //numbers in code?
    unsigned int  m_width;

    bool          m_start_gen;

    std::ofstream::pos_type m_pos; //pos to number of vectors written
    unsigned int            m_counts;

    unsigned int  m_maxEvents;

    std::ofstream m_out;
    void writeComments(std::ostream &os);


    CSimVectorWriter(int,int,std::string,std::string,std::string,std::string,std::string,unsigned int);
    template <class T> friend boost::shared_ptr<T> buildVectorWriter(int,int,std::string, std::string, std::string, std::string, std::string, unsigned int, RefCClock);

  public:
    ~CSimVectorWriter();

    bool isTypeBinary();
    bool isTypeHex();

    bool canWrite();

    void setTypeBinary();
    void setTypeHex();
    void setMaxEvents(unsigned int maxEvents);

    virtual void writeVector() = 0;
    virtual void setStartGen() = 0;

    bool getStartGen();
};





//-----------------------------------
//CMemoryBase class
//-----------------------------------
/**
 * Base class, not template for CMemory class
 * This is used for declaring a vector of 
 * CMemory objects
 */

class CMemoryBase{
  protected:
    CMemoryBase(unsigned int, RefCClock);
    
    unsigned int width;
    RefCClock    clk;

  public:
    ~CMemoryBase();

    virtual void dumpMemory(std::ofstream &out) = 0;

    bool write_enable();
};


//-----------------------------------
//CMemorySimple class
//-----------------------------------
/**
 * Class enherited from CMemoryBase.
 * The memory is a single dimension vector of data
 */
template <class T> class CMemorySimple:public CMemoryBase{
  private:
    std::vector<T> memory;

    CMemorySimple(unsigned int, RefCClock);

  public:
    ~CMemorySimple();

    static boost::shared_ptr<CMemorySimple<T> > build(unsigned int,RefCClock);
    
    void setSize(unsigned int size);
    T    getAt(unsigned int index);//setAt????
    void setAt(unsigned int index, T value);//getAt???? cool

    void dumpMemory(std::ofstream &out);

};


template <class T>
void CMemorySimple<T>::setSize(unsigned int size){
  memory.resize(size);
}

template <class T>
T CMemorySimple<T>::getAt(unsigned int index){
  return memory.at(index);
}

template <class T>
  void CMemorySimple<T>::setAt(unsigned int index, T value){
  memory[index] = value;
}

template <class T> 
CMemorySimple<T>::CMemorySimple(unsigned int width, RefCClock clk)
  :CMemoryBase(width,clk){}


template <class T> 
boost::shared_ptr<CMemorySimple<T> > CMemorySimple<T>::build(unsigned int width, RefCClock clk){
  CMemorySimple<T> *object = new CMemorySimple<T>(width,clk);

  boost::shared_ptr<CMemorySimple<T> > ref = boost::shared_ptr<CMemorySimple<T> >(object);

  return ref;
}


template <class T> 
  void CMemorySimple<T>::dumpMemory(std::ofstream &out){
  if(!clk->getPeState()){
    return;
  }

  for(int i = 0; i < memory.size(); ++i){
    binary(memory.at(i),width,out);
    out<<std::endl;
  }
}





//-----------------------------------
//CMemoryComplex class
//-----------------------------------
/**
 * Class enherited from CMemoryBase.
 * The memory is a 2 dimension vector of data
 */
template <class T> class CMemoryComplex:public CMemoryBase{
  private:
    std::vector<std::vector<T> > memory;

    CMemoryComplex(unsigned int, RefCClock);

  public:
    virtual ~CMemoryComplex();

    static boost::shared_ptr<CMemoryComplex<T> > build(unsigned int,RefCClock);
    
    void setSize(unsigned int size_lines, unsigned int size_columns);
    T    getAt(unsigned int index_line, unsigned int index_column);
    void setAt(unsigned int index_line, unsigned int index_column, T value);

    void dumpMemory(std::ofstream &out);

};



template <class T> 
CMemoryComplex<T>::CMemoryComplex(unsigned int width, RefCClock clk)
  :CMemoryBase(width,clk){
}

template<class T>
void CMemoryComplex<T>::setSize(unsigned int size_lines, unsigned int size_columns){
  memory.resize(size_lines);
  for(int i=0; i< size_lines; ++i){
    memory[i].resize(size_columns);
  }
}

template <class T>
T CMemoryComplex<T>::getAt(unsigned int index_line, unsigned int index_column){
  return memory[index_line][index_column];
}

template <class T>
void CMemoryComplex<T>::setAt(unsigned int index_line, unsigned int index_column, T value){
  memory[index_line][index_column] = value;
}

template <class T> 
boost::shared_ptr<CMemoryComplex<T> > CMemoryComplex<T>::build(unsigned int width, RefCClock clk){
  CMemoryComplex<T> *object = new CMemoryComplex<T>(width,clk);

  boost::shared_ptr<CMemoryComplex<T> > ref = boost::shared_ptr<CMemoryComplex<T> >(object);

  return ref;
}


template <class T> 
  void CMemoryComplex<T>::dumpMemory(std::ofstream &out){
  if(!clk->getPeState()){
    return;
  }

  for(int i = 0; i < memory.size(); ++i){
    binary(memory.at(i),width,out);
    out<<std::endl;
  }
}






//---------------------------------
//CStateData class
//---------------------------------
class CStateData{
  private:
    boost::shared_ptr<CMemoryBase> memory;
    bool enable_flag;
    std::ofstream out;
    
    int number;

    CStateData(std::string,boost::shared_ptr<CMemoryBase>);  
  public:
    virtual ~CStateData();
    static boost::shared_ptr<CStateData> build(std::string, boost::shared_ptr<CMemoryBase>);
    
    void setEnable_flag(bool);
    void writeMemory(unsigned int index);
};





//----------------------------
//FlipFlopBase class
//----------------------------
/**
 * FlipFlop class is template.
 * Use this class for a not template class
*/
class CFlipFlopBase{
  private:
    RefCClock m_clock;
    std::string m_name;
  protected:
     CFlipFlopBase(RefCClock clock,std::string name);   
  public:
    virtual void        prop()  = 0;
    virtual std::string get()   = 0;
    virtual void        init()  = 0;

    std::string getName();
    RefCClock getClock();
};

//-----------------------------
//CFlipFlop class
//-----------------------------
/**
 *           ---------
 *           |   |   |
 *           |   |   |
 *       --->| D | Q |--->
 *           |   |   |          
 *           |   |   |
 *           ------^--
 *           clk___|
 *                 
 * Because D is a pointer user cand change its value in a very simple way.
 * D is a pointer to a combinational signal.
 * A clock is attached to every FlipFlops.
 * If Clock is true then the prop() function propagates the D value to Q.
 * 
*/
template <class T>
class CFlipFlop:public CFlipFlopBase{
  private:
    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlop(boost::shared_ptr<T> d, RefCClock clock,std::string name);   //Constructor: takes D, the clock and the name;
  public:
    void prop();                                                           //D=Q
    std::string get();                                                     //return Q
    void init();
    
    T getQ();
    static boost::shared_ptr<CFlipFlop<T> > build(boost::shared_ptr<T> d, RefCClock clock,std::string name);
};

template <class T>
CFlipFlop<T>::CFlipFlop(boost::shared_ptr<T> d, RefCClock clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
void CFlipFlop<T>::prop(){
    m_q=*m_d.get();
}


template <class T>
T CFlipFlop<T>::getQ(){
  return m_q;
}

template <class T>
std::string CFlipFlop<T>::get(){
  return m_q.toString();
}


template <class T>
void CFlipFlop<T>::init(){
}
  
    
//------------------------------
//CSimulatorInterface interface
//------------------------------
/**
 * Abstract interface for CSimulator.
 * Extend this interface and use it with the CSimulator.
*/
class CSimulatorInterface{
  public:
    virtual void beforeSimulation()          = 0;
    virtual void afterSimulation()           = 0;
    virtual void cycleStart(int cycle_count) = 0;
    virtual void cycleEnd  (int cycle_count) = 0;
};


//---------------------------------
//DefaultSimulatorInterface class
//---------------------------------
/**
 * Emty implementation of the CSimulatorInterface
*/
class DefaultSimulatorInterface:public CSimulatorInterface{
  public:
    void beforeSimulation()         ;
    void afterSimulation()          ;
    void cycleStart(int cycle_count);
    void cycleEnd  (int cycle_count);
};


//---------------------------------
//CBreakPoint class
//---------------------------------
/**
 * if user input "break f == 45 -p top/child1/child2/< .. >/childn"
 * then:
 *      field = "f"
 *      unit  = childn
 *      oper  = "=="
 * possible values for oper: "==" "<=" ">=" "!=" "<" ">"
*/
class CBreakPoint{
  public:
    RefCSimUnit  unit;
    std::string  field;
    std::string  oper;
    std::string  value;

    bool isOn;

    bool isTrue();

    CBreakPoint(RefCSimUnit,std::string,std::string,std::string);
    CBreakPoint();
};

//---------------------------------
//CSimulator class - singleton
//---------------------------------
/**
 * function for signals
*/
void shell_exit_signal(int code);

/**
 * Singleton class. This is the class that does the simulation. 
 * Extend an interface from CSimulatorInterface, put you stuff in it
 * and add it to this class. Then use start_simulation() method.
 * Each time an unit is instanciated is added to m_unitStd::Vector. 
 * Each time a flipFlop is instanciated is added to m_flipFlopStd::Vector. 
*/
class CSimulator{
  private:
    CSimulator(); //private constructor

    std::map<RefCClock,std::vector<RefCFlipFlopBase> >    m_flipFlops;
    std::map<RefCClock,std::vector<RefCSimVectorWriter> > m_vectorWriters;
    std::vector<RefCStateData>                            m_stateData;
    std::vector<RefCSimUnit>                              m_units;

    RefCSimulatorInterface                                m_interface;
    RefCSimUnit                                           m_top;//top unit;

    static boost::shared_ptr<CSimulator>                  m_instance;

    //simulation
    int         loops;
    int         max_cycle;
    int         is_continue;
    RefCSimUnit current_unit; 
    bool        end_simulation;

    //break points
    std::vector<CBreakPoint> m_breakPoints; 

    //signals
    /**
     * It seems like the function that is used when a signal occurs
     * can't be member of a class. So i make it outside of the class
     * and declare it friend
    */
    friend void shell_exit_signal(int code);

    //waves
    bool                                                 m_wavesEnabled;
    std::map<RefCClock,std::vector<int> >                m_clkWaves;
    std::map<RefCFlipFlopBase,std::vector<std::string> > m_ffWaves;
    int                                                  m_maxLength;

    void enableWaves();
    void disableWaves();
    void writeWaves(std::string);
    void writeWaves();

    //clock simplification
    unsigned int gdb(unsigned int a, unsigned int b);
    unsigned int m_clock_gdb;

    //shell
    void outputShell(unsigned int);
    /** 
     * starts from top unit if fisrt name in the path equals with top unit name;
     * else starts from current_unit
    */       
    RefCSimUnit getUnitByPath(std::string path);
    std::string getFieldValue(std::string path);

    void cmd_help      (std::queue<std::string>);
    void cmd_exit      (std::queue<std::string>); 
    void cmd_run       (std::queue<std::string>); 
    void cmd_ls        (std::queue<std::string>); 
    void cmd_root      (std::queue<std::string>); 
    void cmd_cd        (std::queue<std::string>);
    void cmd_waves     (std::queue<std::string>);
    void cmd_dump_waves(std::queue<std::string>);
    void cmd_finish    (std::queue<std::string>);
    void cmd_print     (std::queue<std::string>);
    void cmd_add_watch (std::queue<std::string>);
    void cmd_del_watch (std::queue<std::string>);
    void cmd_break     (std::queue<std::string>);
    void cmd_show_bp   (std::queue<std::string>);
    void cmd_delete_bp (std::queue<std::string>);
    void cmd_continue  (std::queue<std::string>);
    void cmd_set_bp    (std::queue<std::string>);
    void cmd_pwd       (std::queue<std::string>);

  public:
    void addClock             (RefCClock               clock);
    void addFlipFlopBase      (RefCFlipFlopBase        flipFlopBase);
    void addCSimVectorWriter  (RefCSimVectorWriter     vectorWriter, RefCClock clk);
    void addCStateData        (RefCStateData           stateData);
    void addUnit              (RefCSimUnit             unit);
    void setSimulatorInterface(RefCSimulatorInterface  interface);
    void setTopUnit           (RefCSimUnit             top);

    static boost::shared_ptr<CSimulator> getInstance();

    void print();

    /**
     * Everything is done here.
     * Read the coments from csim.cpp for more details
    */ 
    void start_simulation();
};





//--------------------------------------
//templates implementation
//--------------------------------------
template <class T> boost::shared_ptr<T> buildUnit(std::string moduleName,std::string instanceName, RefCSimUnit parent){
  if(false){
    CSimUnit *unit = new T(moduleName,instanceName,parent);
  }
  
  T* object = new T(moduleName,instanceName,parent);
  boost::shared_ptr<T> ref = boost::shared_ptr<T>(object);

  ref->instantiateUnits(ref);

  if(parent.get()){
    parent->addUnit(ref);
  }else{
    ref->connect();
  }
  
  ref->generate_vectors();
  CSimulator::getInstance()->addUnit(ref);

  return ref;
}

template <class T>
boost::shared_ptr<CFlipFlop<T> > CFlipFlop<T>::build(boost::shared_ptr<T> d, RefCClock clock,std::string name){
  CFlipFlop<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlop<T> > ref = boost::shared_ptr<CFlipFlop<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}

template <class T> boost::shared_ptr<T> buildVectorWriter(int id,int version,std::string filename,std::string vectorName,std::string vectorInstanceName, std::string moduleName,std::string moduleInstanceName,  unsigned int width, RefCClock clk){
  if(false){
    CSimVectorWriter *vector = new T(id,version,filename,vectorName,vectorInstanceName,moduleName,moduleInstanceName,width);
  }
  
  T* object = new T(id,version,filename,vectorName,vectorInstanceName,moduleName,moduleInstanceName,width);
  boost::shared_ptr<T> ref = boost::shared_ptr<T>(object);
  
  CSimulator::getInstance()->addCSimVectorWriter(ref,clk);

  return ref;
}

#endif
