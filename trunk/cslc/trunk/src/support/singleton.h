/*!
    \file       singleton.h
    \brief      Implementation of the CSingleton template class.
    \author     Brian van der Beek

Introduction
There are times, when you need to have a class which can be instantiated once only. The Singleton 
Design Pattern provides a solution for such a situation.

There are several possible ways to implement a singleton pattern, but it all pretty much comes down 
to a class that has a private constructor and a static member function to create and retrieve an 
instance of the class. My implementation does not differ much from this scenario, with the exception 
that I created a singleton template class.

So, why a template class?
Well I have searched the Internet for an elegant implementation of a singleton class but I did not 
really find a solution to my satisfaction. Most classes I found consist of a Singleton base class that 
you can use to derive your own singleton class from. The problem with most of these classes is the fact 
that you still have to override the GetInstance function to return a pointer to your derived class. 
A template base class does not have this limitation as I can return any type of pointer.

How it works
To prevent outside source from creating (or copying) an instance of our singleton class, we need to 
shield the constructor and copy constructor of the singleton class. Further we need to provide a 
method to create and retrieve a reference to the singleton object:

static T* Instance() {
  if (m_instance == NULL) { 
    m_instance = new T; 
  }
            
  ASSERT(m_instance != NULL);

  return m_instance;
};

When this method is called for the first time, it creates an instance of the singleton class, 
any sequential calls will return a reference to the created class instance. To get a reference 
to the singleton object, all we have to do is call this method as following:

CMySingleton* mySingleton = CMySingleton::Instance();

That is almost all that there is to it. Next to shielding the constructors, I also shielded 
the destructor, so the singleton class cannot be deleted by accident. Just call the DestroyInstance() 
method to destroy the singleton object. However, be careful when to call this method, because after 
you have called this method, all your class data will be destroyed and a sequential to the Instance() 
method will create a new instance. 

So how do you create a class derived from the singleton template class? Again there is nothing to it. 
Just include the attached header file and create your object as following:

class CMySingleton : public CSingleton<CMySingleton> {
    friend CSingleton<CMySingleton>;   
 
       private:      

           CMySingleton();
           ~CMySingleton();
 
    ...
}

Conclusion
This implementation of the Singleton Pattern makes creating your own singleton class incredibly easy. 
But you do have to be careful when to destroy the singleton class instance. If you find this to be a 
problem you could consider adding (automatic) reference counting.

This article has no explicit license attached to it but may contain usage terms in the article text 
or the download files themselves. If in doubt please contact the author via the discussion board below.
A list of licenses authors might use can be found here

*/

#ifndef __SINGLETON_H__
#define __SINGLETON_H__

#include <cstdlib>

//! The CSingleton class is a template class for creating singleton objects.
/*!
  When the static Instance() method is called for the first time, the singleton 
  object is created. Every sequential call returns a reference to this instance.
  The class instance can be destroyed by calling the DestroyInstance() method.
*/
template <typename T> 
class CSingleton {
public:
    
  //! Gets a reference to the instance of the singleton class.
  /*!
    \return A reference to the instance of the singleton class.
    If there is no instance of the class yet, one will be created.
  */
  static T* Instance() {
    if (m_instance == NULL) {
      m_instance = new T;
    }
        
    //    ASSERT(m_instance != NULL);

    return m_instance;
  };

  //! Destroys the singleton class instance.
  /*!
    Be aware that all references to the single class instance will be
    invalid after this method has been executed!
  */
  static void DestroyInstance() {
    delete m_instance;
    m_instance = NULL;
  };

protected:

  // shield the constructor and destructor to prevent outside sources
  // from creating or destroying a CSingleton instance.

  //! Default constructor.
  CSingleton(){};


  //! Destructor.
  virtual ~CSingleton(){};

private:

  //! Copy constructor.
  CSingleton(const CSingleton& source){};

  static T* m_instance; //!< singleton class instance
};

//! static class member initialisation.
template <typename T> T* CSingleton<T>::m_instance = NULL;


#endif // ! defined __SINGLETON_H__
