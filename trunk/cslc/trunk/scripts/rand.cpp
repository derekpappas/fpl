#include <assert.h>
#include <map>
#include <stack>
#include <vector>
#include <fstream>
#include <iostream>
#include <algorithm>
using namespace std;

string randString(string name) {
  string randStr = name;

  randStr += rand() % ('9' - '0') + '0';
  randStr += rand() % ('9' - '0') + '0';
  //  cout << "randString = " << randStr << endl;

  return randStr;
}

int main() {

  string s = "unitx";;
    s += "_inst_";
    string instanceName = randString(s);
}
