#include "SystemCVectorFunc.h"


// map with all the existing instances for vector files
Ref_TMap_RefString_TBool unit_inst;
// map with all the existing instances for vcd files
Ref_TMap_RefString_TBool unit_inst_vcd;

namespace vec_func {

  //Ref_TVec_RefString parseValuesVec;
  //Ref_TVec_RefString parseValuesVcd;
  
    //adding unit instance to map and set to FALSE by default
  void registerUnit(RefString u) { 
    if(!unit_inst) {
      unit_inst = Ref_TMap_RefString_TBool(new TMap_RefString_TBool);
    }

    if(!unit_inst_vcd) {
      unit_inst_vcd = Ref_TMap_RefString_TBool(new TMap_RefString_TBool);
    }
    
  
    iter_TMap_RefString_TBool it;
    
    // insert instances for turning on vectors
    if(unit_inst) {
      if(unit_inst->insert(std::make_pair(*u,FALSE)).second) {
        //std::cout << "!!added unit instance:" << *u << std::endl;
      }
      else {
        std::cout<< "could not insert unit - already exists\n";
      }
    } 

    // insert instances for turning on vcd 
    if(unit_inst_vcd) {
      if(unit_inst_vcd->insert(std::make_pair(*u,FALSE)).second) {
        //std::cout << "!!added unit instance:" << *u << std::endl;
      }
      else {
        std::cout<< "could not insert unit - already exists\n";
      }
    }

  }
  
  // set unit instances to TRUE if they are turned on from the command line args  
  void turnOnVec(RefString u) { 

    iter_TMap_RefString_TBool it;
    
    if(unit_inst) {
      it = unit_inst->find(*u);
      it->second = TRUE;
      //std::cout << "--found instance:" << *u << "for iter:" << it->second << std::endl;
      if(it == unit_inst->end()) {
        std::cout << "Unit instance " << *u << " does not exist. Use -show_inst for existing instances\n";
      }
    }
    else {
      std::cout << "unit_inst is not allocated\n";
    }
    
  }

  // set unit instances to TRUE if they are turned on from the command line args  
  void turnOnVcd(RefString u) { 

    iter_TMap_RefString_TBool it;
    
    if(unit_inst_vcd) {
      it = unit_inst_vcd->find(*u);
      it->second = TRUE;
      //std::cout << "--found instance:" << *u << "for iter:" << it->second << std::endl;
      if(it == unit_inst_vcd->end()) {
        std::cout << "Unit instance " << *u << " does not exist. Use -show_inst for existing instances\n";
      }
    }
    else {
      std::cout << "unit_inst is not allocated\n";
    }
    
  }

// parsing the arguments passed to main
  void parseArgs(char* args[], int argc) {
    int i = 0;
    while(i < argc) {
      //std::cout << "arg is:" << args[i] << std::endl;
      if(strcmp(args[i],"main") == 0) {
        i++;
        continue;
      }
      else if(strcmp(args[i],"-vecon") == 0) {
        //std::cout << "vectors must be turned on for the next units\n";
        if(args[i+1]) {
          //std::cout << "unit:" << args[i+1] << std::endl;
          setVecArgs(args[i+1]);
        }
        i = i + 2;
        continue;
      } 
      else if(strcmp(args[i],"-vcdon") == 0) {
        //std::cout << "vcd traces must be turned on for the next units\n";
        if(args[i+1]) {	
          setVcdArgs(args[i+1]);
        }
        i = i + 2;
        continue;
      }
      else if(strcmp(args[i],"-gen_all_vectors") == 0) {
        turnOnVecAllUnits();
        i++;
        break;
      }
      else if(strcmp(args[i],"-gen_all_vcds") == 0) {
        turnOnVcdAllUnits();
        i++;
        break;
      }
      else if(strcmp(args[i],"-h") == 0 || strcmp(args[i],"--help") == 0) {
        std::cout << "    -vecon \"<unit instances>\"      turn on vectors for specified unit instances\n";
        std::cout << "    -vcdon \"<unit instances>\"      turn on vcds for specified units instances\n";
        std::cout << "    -show_inst                     lists existing unit instances\n";
        std::cout << "    -gen_all_vectors               generates vector files for all instances\n";
        std::cout << "    -gen_all_vcds                  generates vcd files for all instances\n";
        i++;
        exit(1);
      }
      else if(strcmp(args[i],"-show_inst") == 0) {
        printMap();
        i++;
        exit(1);
      }
      else {
        std::cout << "Unkown option. Use -h or --help for more details.\n";
        i++;
        exit(1);
      }
    }
  }
  
  // parsing the arguments for turning on the vector files
  void setVecArgs(char* args) {

    char *unit[10];
    unit[0] = std::strtok(args,",");
    if(unit[0] != NULL) {
      //printf ("first unit vec: %s\n",unit[0]);
      turnOnVec(RefString(new std::string(unit[0])));
    }
    for(int j = 1; j < sizeof(std::strtok(args, ",")); j++) {
      unit[j] = std::strtok(NULL, ",");
      if(unit[j] != NULL) {
        //printf ("next unit vec:%s\n",unit[j]);
        turnOnVec(RefString(new std::string(unit[j])));
      }
    }
  }
  
  // parsing the arguments for turning on the vcd files
  void setVcdArgs(char* args) {
    char *unit[30];
    unit[0] = std::strtok(args,",");
    if(unit[0] != NULL) {
      //printf ("first unit vcd: %s\n",unit[0]);
      turnOnVcd(RefString(new std::string(unit[0])));
    }
    for(int j = 1; j < sizeof(std::strtok(args, ",")); j++) {
      unit[j] = std::strtok(NULL, ",");
      if(unit[j] != NULL) {
        //printf ("next unit vcd:%s\n",unit[j]);
        turnOnVcd(RefString(new std::string(unit[j])));
      }
    }
  }
  
  //iterate through the units map and turn on all units
  void turnOnVecAllUnits() { 
    iter_TMap_RefString_TBool it;
    if(unit_inst) {
      for(it = unit_inst->begin(); it != unit_inst->end(); it++) {
        it->second = TRUE;
        //std::cout << "----turn on unit:" << it->first << "for iter:" << it->second << std::endl;
      }
    }
    
  }

  //iterate through the units map and turn on all units
  void turnOnVcdAllUnits() { 
    iter_TMap_RefString_TBool it;
    if(unit_inst_vcd) {
      for(it = unit_inst_vcd->begin(); it != unit_inst_vcd->end(); it++) {
        it->second = TRUE;
        //std::cout << "----turn on unit:" << it->first << "for iter:" << it->second << std::endl;
      }
    }
    
  }

  // prints all the existing unit instances
  void printMap() {

    iter_TMap_RefString_TBool itt;

    if(unit_inst) {
      std::cout << "instances are:";
      for(itt = unit_inst->begin(); itt != unit_inst->end(); itt++) {
        std::cout << itt->first << " ";
      }
      std::cout << std::endl;

      //unit_inst.reset();
    }
    else {
      std::cout << "map is not allocated\n";
    }
    
    
  }




}
