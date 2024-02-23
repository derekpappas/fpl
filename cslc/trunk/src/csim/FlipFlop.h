#ifndef FLIPFLOP_H
#define FLIPFLOP_H

#include "csim.h"

using std::string;

//-------------------------------------------
//CFlipFlopR class
//-------------------------------------------
template <class T> class CFlipFlopR:public CFlipFlopBase{
  private:
    bool reset;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopR(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopR<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopR<T>::prop(){
  if(reset){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopR<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopR<T>::init(){
}

template <class T>
CFlipFlopR<T>::CFlipFlopR(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopR<T> > CFlipFlopR<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopR<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopR<T> > ref = boost::shared_ptr<CFlipFlopR<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopRE class
//-------------------------------------------
template <class T> class CFlipFlopRE:public CFlipFlopBase{
  private:
    bool reset;
    bool enable;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopRE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopRE<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopRE<T>::prop(){
  if(reset && enable){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopRE<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopRE<T>::init(){
}

template <class T>
CFlipFlopRE<T>::CFlipFlopRE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopRE<T> > CFlipFlopRE<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopRE<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopRE<T> > ref = boost::shared_ptr<CFlipFlopRE<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopRSE class
//-------------------------------------------
template <class T> class CFlipFlopRSE:public CFlipFlopBase{
  private:
    bool reset;
    bool set;
    bool enable;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopRSE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopRSE<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopRSE<T>::prop(){
  if(reset && set && enable){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopRSE<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopRSE<T>::init(){
}

template <class T>
CFlipFlopRSE<T>::CFlipFlopRSE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopRSE<T> > CFlipFlopRSE<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopRSE<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopRSE<T> > ref = boost::shared_ptr<CFlipFlopRSE<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopE class
//-------------------------------------------
template <class T> class CFlipFlopE:public CFlipFlopBase{
  private:
    bool enable;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopE<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopE<T>::prop(){
  if(enable){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopE<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopE<T>::init(){
}

template <class T>
CFlipFlopE<T>::CFlipFlopE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopE<T> > CFlipFlopE<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopE<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopE<T> > ref = boost::shared_ptr<CFlipFlopE<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopSE class
//-------------------------------------------
template <class T> class CFlipFlopSE:public CFlipFlopBase{
  private:
    bool set;
    bool enable;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopSE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopSE<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopSE<T>::prop(){
  if(set && enable){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopSE<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopSE<T>::init(){
}

template <class T>
CFlipFlopSE<T>::CFlipFlopSE(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopSE<T> > CFlipFlopSE<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopSE<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopSE<T> > ref = boost::shared_ptr<CFlipFlopSE<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopSECu class
//-------------------------------------------
template <class T> class CFlipFlopSECu:public CFlipFlopBase{
  private:
    bool set;
    bool enable;
    bool count_up;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopSECu(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopSECu<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopSECu<T>::prop(){
  if(set && enable && count_up){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopSECu<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopSECu<T>::init(){
}

template <class T>
CFlipFlopSECu<T>::CFlipFlopSECu(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopSECu<T> > CFlipFlopSECu<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopSECu<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopSECu<T> > ref = boost::shared_ptr<CFlipFlopSECu<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopSECd class
//-------------------------------------------
template <class T> class CFlipFlopSECd:public CFlipFlopBase{
  private:
    bool set;
    bool enable;
    bool count_down;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopSECd(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopSECd<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopSECd<T>::prop(){
  if(set && enable && count_down){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopSECd<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopSECd<T>::init(){
}

template <class T>
CFlipFlopSECd<T>::CFlipFlopSECd(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopSECd<T> > CFlipFlopSECd<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopSECd<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopSECd<T> > ref = boost::shared_ptr<CFlipFlopSECd<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopSECud class
//-------------------------------------------
template <class T> class CFlipFlopSECud:public CFlipFlopBase{
  private:
    bool set;
    bool enable;
    bool count_up_down;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopSECud(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopSECud<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopSECud<T>::prop(){
  if(set && enable){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopSECud<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopSECud<T>::init(){
}

template <class T>
CFlipFlopSECud<T>::CFlipFlopSECud(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopSECud<T> > CFlipFlopSECud<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopSECud<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopSECud<T> > ref = boost::shared_ptr<CFlipFlopSECud<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopRSECu class
//-------------------------------------------
template <class T> class CFlipFlopRSECu:public CFlipFlopBase{
  private:
    bool reset;
    bool set;
    bool enable;
    bool count_up;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopRSECu(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopRSECu<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopRSECu<T>::prop(){
  if(reset && set && enable && count_up){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopRSECu<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopRSECu<T>::init(){
}

template <class T>
CFlipFlopRSECu<T>::CFlipFlopRSECu(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopRSECu<T> > CFlipFlopRSECu<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopRSECu<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopRSECu<T> > ref = boost::shared_ptr<CFlipFlopRSECu<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopRSECd class
//-------------------------------------------
template <class T> class CFlipFlopRSECd:public CFlipFlopBase{
  private:
    bool reset;
    bool set;
    bool enable;
    bool count_down;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopRSECd(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopRSECd<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopRSECd<T>::prop(){
  if(reset && set && enable && count_down){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopRSECd<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopRSECd<T>::init(){
}

template <class T>
CFlipFlopRSECd<T>::CFlipFlopRSECd(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopRSECd<T> > CFlipFlopRSECd<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopRSECd<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopRSECd<T> > ref = boost::shared_ptr<CFlipFlopRSECd<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



//-------------------------------------------
//CFlipFlopRSECud class
//-------------------------------------------
template <class T> class CFlipFlopRSECud:public CFlipFlopBase{
  private:
    bool reset;
    bool set;
    bool enable;
    bool count_up_down;

    boost::shared_ptr<T> m_d;
    T                    m_q;

    CFlipFlopRSECud(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name);
  public:
    void prop();
    string get();
    void init();

    static boost::shared_ptr<CFlipFlopRSECud<T> > build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name);
};

/*implementing templates*/

template <class T>
void CFlipFlopRSECud<T>::prop(){
  if(reset && set && enable){
      m_q=*m_d.get();
  }
}

template <class T>
std::string CFlipFlopRSECud<T>::get(){
  return m_q.toString();
}

template <class T>
void CFlipFlopRSECud<T>::init(){
}

template <class T>
CFlipFlopRSECud<T>::CFlipFlopRSECud(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock, std::string name)
  :CFlipFlopBase(clock,name){
  m_d=d;
}

template <class T>
boost::shared_ptr<CFlipFlopRSECud<T> > CFlipFlopRSECud<T>::build(boost::shared_ptr<T> d, boost::shared_ptr<CClock> clock,std::string name){
  CFlipFlopRSECud<T> *object = new CFlipFlop<T>(d,clock, name);
  boost::shared_ptr<CFlipFlopRSECud<T> > ref = boost::shared_ptr<CFlipFlopRSECud<T> >(object);

  CSimulator::getInstance()->addFlipFlopBase(ref);

  return ref;
}



#endif
