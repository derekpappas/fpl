#include <iostream>
using namespace std;

class gen_protocol                          
{
 public:
   virtual void data_transfer()
   {
     cout<<"Transferring data using GENERAL protocol instructions\n";
   }
};

class http_protocol:public gen_protocol                       
{
 public:
   void data_transfer()
   {
    cout<<"Transferring data using HTTP protocol instructions\n";
   }
};

class ftp_protocol:public gen_protocol    
{
 public:
   void data_transfer()
   {
    cout<<"Transferring data using FTP protocol instructions\n";
   }
};

void main()
{
  http_protocol ht;
  gen_protocol *point=&ht;
  point->data_transfer();
  ftp_protocol ft;
  point=&ft;
  point->data_transfer();
}
