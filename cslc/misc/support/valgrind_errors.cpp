#include <iostream>

using namespace std;

int main() {
  int *i = new int;
  int *x = new int[2];
  delete x;

  int *z = new int;
  z++;
  cout << *z;
  *z = 1;

  int t;
  if (t) {
    cout<<"conditional jump";
  }

  delete &cout;
  return 0;
}
