#include <cstdlib>
#include <iostream>
#include <conio.h>

using namespace std;

class Masina
{
    public:
        virtual void porneste()
        {
             cout<<"Porneste masina...\n";
        }
};

class Citroen : virtual public Masina
{
    public:
        void porneste()
        {
            cout<<"Porneste Citroen...\n";
        }
};

class Ford : virtual public Masina
{
    public:
        void porneste()
        {
            cout<<"Porneste Ford...\n";
        }
};

class RallyCar : public Citroen, public Ford
{
    public:
        void porneste()
        {
            cout<<"Porneste RallyCar\n";
        }
};
     
int main(int argc, char *argv[])
{
    Masina* citroen = new Citroen;
    Masina* ford = new Ford;
    Masina* rallycar = new RallyCar;
    citroen->porneste();
    ford->porneste();
    rallycar->porneste();
    cout<<"Press a key to exit...";getch();
    return EXIT_SUCCESS;
}
