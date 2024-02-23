#include <iostream>
#include <fstream>
#include <vector>
#include <exception>

#include "header.h"
using namespace std;

istream& operator>>(istream& in, Tab1 &value) {
  string temp;
  in >> temp;
//values from 1st table
  if( temp == "dw" ) {
    value = VALUE_11;
  }
  else if(temp == "de" ) {
    value = VALUE_12;
  }
  else if(temp == "sm" ) {
    value = VALUE_13;
  }
  else if(temp == "cw" ) {
    value = VALUE_14;
  }
  else if(temp == "ce" ) {
    value = VALUE_15;
  }
  else if(temp == "cg" ) {
    value = VALUE_16;
  }
  else
    throw my_exception("[operator>>(istream& in, Evalue &value)] Error reading input value from stream");

  return in;
}
ostream& operator<<(ostream &out, const Tab1 &value) {
  switch(value) {
//values from 1st table
    case VALUE_11:
      out << "Design warnings";
      break;
    case VALUE_12:
      out << "Design errors";
      break;
    case VALUE_13:
      out << "Posible simulation and synthesis mismatch";
      break;
    case VALUE_14:
      out << "CSL warnings";
      break;
    case VALUE_15:
      out << "CSL errors";
      break;
    case VALUE_16:
      out << "Reserved";
      break;
  }
  return out;
}
istream& operator>>(istream& in, Tab2 &value){
  string temp;  
  in >> temp;
// values from 2nd table
  if(temp == "pp" ) {
    value = VALUE_21;
  }
  else if(temp == "pa" ) {
    value = VALUE_22;
  }
  else if(temp == "tw" ) {
    value = VALUE_23;
  }
  else if(temp == "cc" ) {
    value = VALUE_24;
  }
  else if(temp == "ce" ) {
    value = VALUE_25;
  }
  else if(temp == "ca" ) {
    value = VALUE_26;
  }
  else if(temp == "cg" ) {
    value = VALUE_27;
  }
  else
    throw my_exception("[operator>>(istream& in, Evalue &value)] Error reading input value from stream");

  return in;
}    
ostream& operator<<(ostream &out, const Tab2 &value) {
  switch(value) {
//values from 2nd table
    case VALUE_21:
      out << "Preprocessor";
      break;
    case VALUE_22:
      out << "CSL parser";
      break;
    case VALUE_23:
      out << "CSL tree walker";
      break;
    case VALUE_24:
      out << "CDOM creation";
      break;
    case VALUE_25:
      out << "CDOM elaboration";
      break;
    case VALUE_26:
      out << "CDOM analysis";
      break;
    case VALUE_27:
      out << "Code generation";
      break;
  }
    return out;
}
istream& operator>>(istream& in, Tab3 &value){
  string temp;
  in >> temp;
//values from 2nd table
  if(temp == "stmt" ) {
    value = VALUE_31;
  }
  else if(temp == "expr" ) {
    value = VALUE_32;
  }
  else if(temp == "num" ) {
    value = VALUE_33;
  }
  else if(temp == "cdir" ) {
    value = VALUE_34;
  }
  else if(temp == "udir" ) {
    value = VALUE_35;
  }
  else if(temp == "func" ) {
    value = VALUE_36;
  }
  else if(temp == "ase" ) {
    value = VALUE_37;
  }
  else if(temp == "ccs" ) {
    value = VALUE_38;
  }
  else if(temp == "dely" ) {
    value = VALUE_39;
  }
  else if(temp == "dely" ) {
    value = VALUE_310;
  }
  else if(temp == "drst" ) {
    value = VALUE_311;
  }
  else if(temp == "net" ) {
    value = VALUE_312;
  }
  else if(temp == "ec" ) {
    value = VALUE_313;
  }
  else if(temp == "blk" ) {
    value = VALUE_314;
  }
  else if(temp == "mod" ) {
    value = VALUE_315;
  }
  else if(temp == "file" ) {
    value = VALUE_316;
  }
  else if(temp == "mdb" ) {
    value = VALUE_317;
  }
  else if(temp == "sysc" ) {
    value = VALUE_318;
  }
  else if(temp == "cb" ) {
    value = VALUE_319;
  }
  else if(temp == "syst" ) {
    value = VALUE_320;
  }
  else if(temp == "simr" ) {
    value = VALUE_321;
  }
  else if(temp == "mins" ) {
    value = VALUE_322;
  }
  else if(temp == "mifc" ) {
    value = VALUE_323;
  }
  else if(temp == "snsl" ) {
    value = VALUE_324;
  }
  else if(temp == "loop" ) {
    value = VALUE_325;
  }
  else if(temp == "task" ) {
    value = VALUE_326;
  }
  else if(temp == "stsk" ) {
    value = VALUE_327;
  }
  else if(temp == "inst" ) {
    value = VALUE_328;
  }
  else if(temp == "prts" ) {
    value = VALUE_329;
  }
  else if(temp == "param" ) {
    value = VALUE_330;
  }
  else if(temp == "mem" ) {
    value = VALUE_331;
  }
  else if(temp == "file" ) {
    value = VALUE_332;
  }
  else if(temp == "chrs" ) {
    value = VALUE_333;
  }
  else if(temp == "unsy" ) {
    value = VALUE_334;
  }
  else if(temp == "dmsn" ) {
    value = VALUE_335;
  }
  else if(temp == "drvc" ) {
    value = VALUE_336;
  }
 else if(temp == "forc" ) {
    value = VALUE_337;
  }
  else if(temp == "clk" ) {
    value = VALUE_338;
  }
  else if(temp == "seq" ) {
    value = VALUE_339;
  }
  else if(temp == "spec" ) {
    value = VALUE_340;
  }
  else if(temp == "sply" ) {
    value = VALUE_341;
  }
  else if(temp == "ccd" ) {
    value = VALUE_342;
  }
  else if(temp == "prim" ) {
    value = VALUE_343;
  }
  else if(temp == "real" ) {
    value = VALUE_344;
  }
  else if(temp == "ectl" ) {
    value = VALUE_345;
  }
  else if(temp == "rst" ) {
    value = VALUE_346;
  }
  else if(temp == "tbcd" ) {
    value = VALUE_347;
  }
  else if(temp == "vec" ) {
    value = VALUE_348;
  }
  else if(temp == "datl" ) {
    value = VALUE_349;
  }
  else if(temp == "sdir" ) {
    value = VALUE_350;
  }
  else if(temp == "mem" ) {
    value = VALUE_351;
  }
  else if(temp == "cmnt" ) {
    value = VALUE_352;
  }
  else if(temp == "pp" ) {
    value = VALUE_353;
  }
  else if(temp == "sig" ) {
    value = VALUE_354;
  }
  else if(temp == "cmpl" ) {
    value = VALUE_355;
  }
  else if(temp == "case" ) {
    value = VALUE_356;
  }
  else if(temp == "pars" ) {
    value = VALUE_357;
  }
  else if(temp == "nett" ) {
    value = VALUE_358;
  }
  else if(temp == "cmdl" ) {
    value = VALUE_359;
  }
  else if(temp == "casn" ) {
    value = VALUE_360;
  }
  else if(temp == "trns" ) {
    value = VALUE_361;
  }
  else if(temp == "netd" ) {
    value = VALUE_362;
  }
  else if(temp == "str" ) {
    value = VALUE_363;
  }
  else if(temp == "proc" ) {
    value = VALUE_364;
  }
  else if(temp == "comp" ) {
    value = VALUE_365;
  }
  else if(temp == "decl" ) {
    value = VALUE_366;
  }
  else if(temp == "sens" ) {
    value = VALUE_367;
  }
  else if(temp == "dsgn" ) {
    value = VALUE_368;
  }
  else if(temp == "inhw" ) {
    value = VALUE_369;
  }
  else if(temp == "rel" ) {
    value = VALUE_370;
  }
  else if(temp == "mdn" ) {
    value = VALUE_371;
  }
  else if(temp == "tri" ) {
    value = VALUE_372;
  }
 else if(temp == "case" ) {
    value = VALUE_373;
  }
  else if(temp == "comb" ) {
    value = VALUE_374;
  }
  else if(temp == "init" ) {
    value = VALUE_375;
  }
  else if(temp == "mmod" ) {
    value = VALUE_376;
  }
  else if(temp == "cond" ) {
    value = VALUE_377;
  }
  else if(temp == "assn" ) {
    value = VALUE_378;
  }
  else if(temp == "defd" ) {
    value = VALUE_379;
  }
  else if(temp == "dsbl" ) {
    value = VALUE_380;
  }
  else if(temp == "drvs" ) {
    value = VALUE_381;
  }
  else
    throw my_exception("[operator>>(istream& in, Evalue &value)] Error reading input value from stream");

  return in;
}

ostream& operator<<(ostream &out, const Tab3 &value) {
  switch(value) {
//values from 3rd table
    case VALUE_31:
      out << "Statement";
      break;
    case VALUE_32:
      out << "Expression";
      break;
    case VALUE_33:
      out << "Numeric";
      break;
    case VALUE_34:
      out << "CSL directive";
      break;
    case VALUE_35:
      out << "Unknown compiler directive";
      break;
    case VALUE_36:
      out << "Function";
      break;
    case VALUE_37:
      out << "Architectural state element";
      break;
    case VALUE_38:
      out << "CSL clock specification";
      break;
    case VALUE_39:
      out << "Delay statement";
      break;
    case VALUE_310:
      out << "Disable statement";
      break;
    case VALUE_311:
      out << "Drive strength";
      break;
    case VALUE_312:
      out << "Net";
      break;
    case VALUE_313:
      out << "Event control";
      break;
    case VALUE_314:
      out << "Block";
      break;
    case VALUE_315:
      out << "Module";
      break;
    case VALUE_316:
      out << "File";
      break;
    case VALUE_317:
      out << "Multi driven bus";
      break;
    case VALUE_318:
      out << "System call";
      break;
    case VALUE_319:
      out << "Cycle based";
      break;
    case VALUE_320:
      out << "System task";
      break;
    case VALUE_321:
      out << "Simulation result";
      break;
    case VALUE_322:
      out << "Module instantiation";
      break;
    case VALUE_323:
      out << "Module instance";
      break;
    case VALUE_324:
      out << "Sensitivity list";
      break;
    case VALUE_325:
      out << "Loop";
      break;
    case VALUE_326:
      out << "Task";
      break;
    case VALUE_327:
      out << "System task";
      break;
    case VALUE_328:
      out << "Instantiation";
      break;
    case VALUE_329:
      out << "Part select";
      break;
    case VALUE_330:
      out << "Parameter";
      break;
    case VALUE_331:
      out << "Memory";
      break;
    case VALUE_332:
      out << "File";
      break;
    case VALUE_333:
      out << "Charge strength";
      break;
    case VALUE_334:
      out << "Unsynthesizable";
      break;
    case VALUE_335:
      out << "Dimension";
      break;
    case VALUE_336:
      out << "Driver contention";
      break;
    case VALUE_337:
      out << "Force";
      break;
    case VALUE_338:
      out << "Clock";
      break;
    case VALUE_339:
      out << "Sequential";
      break;
    case VALUE_340:
      out << "Specify";
      break;
    case VALUE_341:
      out << "Supply";
      break;
    case VALUE_342:
      out << "CSL compiler directive";
      break;
    case VALUE_343:
      out << "Primitive";
      break;
    case VALUE_344:
      out << "Real";
      break;
    case VALUE_345:
      out << "Event control";
      break;
    case VALUE_346:
      out << "Reset";
      break;
    case VALUE_347:
      out << "Testbench code";
      break;
    case VALUE_348:
      out << "Vec";
      break;
    case VALUE_349:
      out << "Data loop";
      break;
    case VALUE_350:
      out << "Synopsys compile directive";
      break;
    case VALUE_351:
      out << "Memory";
      break;
    case VALUE_352:
      out << "Comment";
      break;
    case VALUE_353:
      out << "Preprocessor";
      break;
    case VALUE_354:
      out << "Signal";
      break;
    case VALUE_355:
      out << "Component loop";
      break;
    case VALUE_356:
      out << "Case item";
      break;
    case VALUE_357:
      out << "Parser";
      break;
    case VALUE_358:
      out << "Net type";
      break;
    case VALUE_359:
      out << "Comand line";
      break;
    case VALUE_360:
      out << "Continuous assgin";
      break;
    case VALUE_361:
      out << "Transistor";
      break;
    case VALUE_362:
      out << "Net declaration";
      break;
    case VALUE_363:
      out << "String";
      break;
    case VALUE_364:
      out << "Process";
      break;
    case VALUE_365:
      out << "Component";
      break;
    case VALUE_366:
      out << "Declaration";
      break;
    case VALUE_367:
      out << "Sensitivity list";
      break;
    case VALUE_368:
      out << "Design";
      break;
    case VALUE_369:
      out << "Inference hardware";
      break;
    case VALUE_370:
      out << "Release";
      break;
    case VALUE_371:
      out << "Multi driven net";
      break;
    case VALUE_372:
      out << "Tristate";
      break;
    case VALUE_373:
      out << "Case statement";
      break;
    case VALUE_374:
      out << "Combinational logic";
      break;
    case VALUE_375:
      out << "Initialization";
      break;
    case VALUE_376:
      out << "Macro module";
      break;
    case VALUE_377:
      out << "Conditional";
      break;
    case VALUE_378:
      out << "Assignment";
      break;
    case VALUE_379:
      out << "Define declaration";
      break;
    case VALUE_380:
      out << "Disable";
      break;
    case VALUE_381:
      out << "Drive strength";
      break;
  }
  return out;
}
vector<string> readEnumStrings(const char *fileName) {
  ifstream fin(fileName);
  if(!fin) {
    cerr << "can't read imput file:" << fileName << endl;
    exit(1);
  }
  vector<string> values;
  string temp;
  while(!fin.eof()) {
    temp.clear();
    getline(fin, temp);
    if(fin.eof())
      break;
    values.push_back(temp);
  }
  fin.close();
  return values;
}

int main (int argc, char **argv) {
  // !!! Verify that the vector you read from the file has a size that agrees with the size of the enum
  try {
    if(argc != 2) {
      cerr << "Invalid number og arguments" << endl;
      return 1;
    }
    vector<string> values = readEnumStrings(argv[1]);
    cout << values.size() << endl;;
    for( vector<string>::iterator it = values.begin(); it != values.end(); ++it)
      cout << *it << endl;

    Evalue val;
    cout << "Enter the value:";
    cin >> val;
    cout << "Your value is: " << val << endl;

    cout << values[val] << endl;

  } 
  catch( exception &ex) {
    cerr << "An exception occured: " << ex.what() << endl;
    return 1;
  }
  catch( ... ) {
    cerr << "An unknown exception occured" << endl;
    return 1;
  }
  
  return 0;
}
