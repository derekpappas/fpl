#include "CSLOM_CslTmplDriver.h"
#include <stdlib.h>
#include <fstream>
#include <iostream>
#include <string>

using namespace std;
using namespace tmpl;
using namespace NSCSLOm;
using namespace NSCSLOmCslCodeGenerator;

//----------------------------------------------------------------------------
void run_csl_generator(RefCSLOmCslCodeGenerator& cslCodeInfo)
{
#ifdef _DEBUG_CSLOM_CSL_CODE_GENERATOR
        cout << "CSLOM_CslTmplDriver.cpp :: run_csl_generator" << endl;
#endif

    // create a template object
    string path = getenv("WORK");
    html_template templ(path + "/trunk/templates/csl_templates/cslCodeTemplate.tmpl");

   
    //---------------create the csl file------------------

    string csl_name;
    string m_outputPath = cslCodeInfo->m_cslPath;
    vector<RefString>::const_iterator unitIter;
    bool has_unit, ifc_has_ports, unit_has_ports, has_ifc;

    vector<string> in_port_name_vec;
    vector<string> in_port_type_vec;
    vector<string> out_port_name_vec;
    vector<string> out_port_type_vec;
    
    string port_name;
    string port_type;
    if(!(cslCodeInfo->m_cslName).empty()){
      csl_name = cslCodeInfo->m_cslName;
    }
  
    string csl_file_name;
    const char* file_name;
    ofstream cslCode;
    row_t row;
    
    //generated csl file_name
    if(!csl_name.empty() && !m_outputPath.empty()){
     csl_file_name = m_outputPath + csl_name;
     file_name= csl_file_name.c_str();
     
     
      cslCode.open(file_name, ios::trunc);
      cslCode.open(file_name, ios::in);
      
      cout << ".........The csl file is created: " << file_name << "\n";
    }
    else {
      cout << "NO csl file is generated!!!" << endl;
    }

    

  //--------------Unit predeclarations---------------------------------
    loop_t unit_predecl_loop;
   
        
    if(!(cslCodeInfo->unitVec).empty()){
      has_unit = true;
      for(unitIter = (cslCodeInfo->unitVec).begin(); unitIter != (cslCodeInfo->unitVec).end(); unitIter++){
	
	row("unit_name") = *(*unitIter);
	unit_predecl_loop +=row;
      }
    }
    else{
      has_unit = false;
      }

    //------------------------bitrange declarations-----------------------//
    loop_t br_loop;
    bool has_br = false;
    string br_param="";
    RefString_TInt_Map::const_iterator brIt1;
    vector<TInt>::const_iterator brIt2;
    if(!(cslCodeInfo->bitrangeMap)->empty()){
      has_br = true;
      for(brIt1 = (cslCodeInfo->bitrangeMap)->begin();brIt1 != (cslCodeInfo->bitrangeMap)->end(); brIt1++){
	row("br_name")= *(brIt1->first);
	br_param="";
	for(brIt2 = (brIt1->second)->begin();brIt2 != (brIt1->second)->end(); brIt2++){
	  int range = *brIt2;
	  stringstream oss;
	  oss << range;
	  string srange= oss.str();
	  br_param = br_param + srange;
	  if(brIt2 < (brIt1->second)->end()-1){
	    br_param = br_param + ",";
	  }
	  // row("num_expr")= br_param;
	  // br_loop +=row;
	}
	row("num_expr")= br_param;
	br_loop +=row;
      }
    }
    else { has_br = false; }
    //----------------------signal group declaration------------------------//
    loop_t sg_loop;
    bool has_sg;
    vector<RefString>::const_iterator sgIter;
    int sg_size;

    if(!(cslCodeInfo->sgVec).empty()){
       sg_size=0;
       has_sg = true;
       //cout << "size=" << (cslCodeInfo->sgVec).size() <<endl;
       for(sgIter = (cslCodeInfo->sgVec).begin(); sgIter != (cslCodeInfo->sgVec).end(); sgIter++){
	 sg_size++;
	 //if((cslCodeInfo->sgVec).size() == 1 || size <= (cslCodeInfo->sgVec).size()/2){
	   RefString sg_name = (*sgIter);
	   row("sg_name")= **sgIter;

	 //-----------------sg signal list----------------------//
	 loop_t sg_sig_loop;
	 bool sg_has_stype, sg_has_swidth, sg_has_signals;
	 TMap_RefString_RefTMap::const_iterator iterS1;
	 TMap_RefString_RefTVec::const_iterator iterS2;
	 //TVec_RefString::const_iterator iter3;
	 if( (cslCodeInfo->sgSigDeclMap).get()){
	   
	   if(!(cslCodeInfo->sgSigDeclMap)->empty()){
	     sg_has_signals = true;
	    
	     for(iterS1 = (cslCodeInfo->sgSigDeclMap)->begin(); iterS1 != (cslCodeInfo->sgSigDeclMap)->end(); iterS1++){
	      
	     if(*(iterS1->first) == *sg_name){
	       //cout <<" sg name=" << *sg_name << endl;
	     RefTMap_RefString_RefTVec  sgSigData = iterS1->second;
	    
	     for(iterS2 = sgSigData->begin(); iterS2 != sgSigData->end(); iterS2++){
	       RefString sgSigName = (iterS2->first);
	      
	       row("sg_sig_name")= *sgSigName;
	       vector<RefString>  sData = *iterS2->second;
	     
		 if(sData[0].get()){
		   
		   sg_has_stype =true;
		   row("sg_sig_type") = *sData[0];
		 }
		 else{ sg_has_stype = false; }
		
		 if(sData[1].get() /*&& *pData[1]!=""*/){
		   
		   sg_has_swidth = true;
		   row("sg_sig_width") = *sData[1];
		   
		 }
		 else{ sg_has_swidth = false; }
		
		 row("sg_has_type")= sg_has_stype;
		 row("sg_has_width") = sg_has_swidth;
		 sg_sig_loop += row;
	       
	       }
	    
	     row("sg_sig_loop")= sg_sig_loop;
	     }
	    }
 
	   }
	   else { sg_has_signals = false; }
	 }
	 row("sg_has_signals") = sg_has_signals;
	 sg_loop +=row;
	 // }
       }
     }
     
     else {
       has_sg=false;
     }
    //----------------------interface declaration--------------------------//
   
    loop_t ifc_loop;
    vector<RefString>::const_iterator ifcIter;
    int size;
     if(!(cslCodeInfo->ifcVec).empty()){
       size=0;
       has_ifc = true;
       //cout << "size=" << (cslCodeInfo->ifcVec).size() <<endl;
       for(ifcIter = (cslCodeInfo->ifcVec).begin(); ifcIter != (cslCodeInfo->ifcVec).end(); ifcIter++){
	 size++;
	 //if((cslCodeInfo->ifcVec).size() == 1 || size <= (cslCodeInfo->ifcVec).size()/2){
	   RefString ifc_name = (*ifcIter);
	   row("ifc_name")= **ifcIter;
	 //-----------------ifc ports list----------------------//
	 //loop_t ifc_port_list;
	 bool ifc_has_type, ifc_has_width, ifc_has_ports;
	 TMap_RefString_RefTMap::const_iterator iterP1;
	 TMap_RefString_RefTVec::const_iterator iterP2;
	 //TVec_RefString::const_iterator iter3;
	 if( (cslCodeInfo->ifcPortDeclMap).get()){
	  
	   if(!(cslCodeInfo->ifcPortDeclMap)->empty()){
	     ifc_has_ports = true;
	     
	     for(iterP1 = (cslCodeInfo->ifcPortDeclMap)->begin(); iterP1 != (cslCodeInfo->ifcPortDeclMap)->end(); iterP1++){
	      
	     if(*(iterP1->first) == *ifc_name){
	      
	       loop_t ifc_port_list;
	       RefTMap_RefString_RefTVec  ifcPortData = iterP1->second;
	      
	     for(iterP2 = ifcPortData->begin(); iterP2 != ifcPortData->end(); iterP2++){
	       RefString ifcPortName = (iterP2->first);
	      
	       row("ifc_port_name")= *ifcPortName;
	       vector<RefString>  pData = *iterP2->second;
	     
	      
		 if(pData[0].get()){
		   
		   ifc_has_type =true;
		   row("ifc_port_type") = *pData[0];
		   // cout << "type " << *pData[0];
		 }
		 else{ ifc_has_type = false; }
		row("ifc_has_type")= ifc_has_type;

		 if(pData[1].get()){
		  
		   row("ifc_port_dir") = *pData[1];
		   // cout <<" dir=" << *pData[1];
		 }
		 if(pData[2].get() /*&& *pData[2]!=""*/){
		   
		   ifc_has_width = true;
		   row("ifc_port_width") = *pData[2];
		   //cout<< " width=" << *pData[2] << endl;
		 }
		 else{ ifc_has_width = false; }
		 row("ifc_has_width") = ifc_has_width;
		 ifc_port_list += row;
	       
	       }
	     // ifc_port_list += row;
	     row("ifc_port_loop")= ifc_port_list;
	     }
	     // row("ifc_port_loop")= ifc_port_list;
	    }
 //

	   }
	   else { ifc_has_ports = false; }
	 }
	 row("ifc_has_ports") = ifc_has_ports;
	 ifc_loop +=row;
	 // }
       }
     }
     
     else {
       has_ifc=false;
     }
     
    //--------------Unit list----------------------------------------------//
    
    loop_t unit_list;
    TMap_RefString_RefTVec::const_iterator  uIter;
    bool has_ptype, has_pwidth;  
    bool has_no_methods = false;
    int op_cnt=0;
    int repl_cnt=0;
    int ass_cnt=0;
    if(!(cslCodeInfo->unitVec).empty()){
     
      for(unitIter = (cslCodeInfo->unitVec).begin(); unitIter != (cslCodeInfo->unitVec).end(); unitIter++){
	//int op_cnt=0;
	//int repl_cnt=0;
	//int ass_cnt=0;
	
	has_unit = true;
	RefString uName = (*unitIter);
	row("unit_name") = *(*unitIter);

	//--------------Unit Port list---------------------------//

	loop_t port_list;

	
	TMap_RefString_RefTMap::const_iterator iter1;
	TMap_RefString_RefTVec::const_iterator iter2;
	//TVec_RefString::const_iterator iter3;
	if( (cslCodeInfo->unitPortDeclMap).get()){
	if(!(cslCodeInfo->unitPortDeclMap)->empty()){
       
	  unit_has_ports = true;
	 
	  for(iter1 = (cslCodeInfo->unitPortDeclMap)->begin(); iter1 != (cslCodeInfo->unitPortDeclMap)->end(); iter1++){
	  
	     if(*(iter1->first) == *uName){
	      
	     RefTMap_RefString_RefTVec  portData = iter1->second;
	    
	     for(iter2 = portData->begin(); iter2 != portData->end(); iter2++){
	       RefString portName = (iter2->first);
	      
	       row("port_name")= *portName;
	       vector<RefString>  pData = *iter2->second;
	      
		 if(pData[0].get()){
		   
		   has_ptype =true;
		   row("port_type") = *pData[0];
		 }
		 else{ has_ptype = false; }
		
		 if(pData[1].get()){
		  
		   row("port_dir") = *pData[1];
		 }
		 if(pData[2].get()&& *pData[2]!=""){
		   
		   has_pwidth = true;
		   row("port_width") = *pData[2];
		   
		 }
		 else{ has_pwidth = false; }
		
		 row("has_ptype")= has_ptype;
		 row("has_pwidth") = has_pwidth;
		 port_list += row;
	       }
	     
	     }
	     row("unit_port_loop")= port_list;
	    }
	 
	  }

	else{
	  unit_has_ports = false;
	}
	}
	row("unit_has_ports") = unit_has_ports;

	//-----------------------------------------------------//
	//------------Unit signal list-------------------------//
	loop_t sig_list;
	bool unit_has_signals,has_stype,has_swidth;
	
	TMap_RefString_RefTMap::const_iterator iter11;
	TMap_RefString_RefTVec::const_iterator iter12;
       
	if( (cslCodeInfo->unitSigDeclMap).get()){
	  if(!(cslCodeInfo->unitSigDeclMap)->empty()){
	    
	    unit_has_signals = true;
	   
	    for(iter11 = (cslCodeInfo->unitSigDeclMap)->begin(); iter11 != (cslCodeInfo->unitSigDeclMap)->end(); iter11++){
	      
	      if(*(iter11->first) == *uName){
	       
		RefTMap_RefString_RefTVec  sigData = iter11->second;
	    
		for(iter12 = sigData->begin(); iter12 != sigData->end(); iter12++){
		  RefString sigName = (iter12->first);
		  
		  row("sig_name")= *sigName;
		  vector<RefString>  sData = *iter12->second;
		  
		  
		  if(sData[1].get()){
		   
		    has_swidth = true;
		    row("sig_type") = *sData[1];
		    
		  }
		  else{ has_swidth = false; }
		  
		  if(sData[0].get()){
		    
		    has_stype =true;
		    row("sig_width") = *sData[0];
		  }
		  else{ has_stype = false; }
		  
		  
		  row("has_stype")= has_stype;
		  row("has_swidth") = has_swidth;
		  sig_list += row;
		}
		
	      }
	      row("unit_signal_loop")= sig_list;
	    }
	    
	  }
	  
	  else{
	    unit_has_signals = false;
	  }
	}
	row("unit_has_signals") = unit_has_signals;
	//------------------SG instances list-----------------//
	loop_t sg_inst_loop;
	bool has_sg_inst = false;
	TMap_RefString_RefTMap_RefString::const_iterator sgIt1;
	TMap_RefString::const_iterator sgIt2;
	
	if(!(cslCodeInfo->unitSgInstMap)->empty() /*&& !(cslCodeInfo->sgInstMap)->empty()*/){
	  has_sg_inst = true;
	    for(sgIt1 = (cslCodeInfo->unitSgInstMap)->begin(); sgIt1 != (cslCodeInfo->unitSgInstMap)->end(); sgIt1++){
	      if( *(sgIt1->first) == *uName){
		for(sgIt2 = (sgIt1->second)->begin(); sgIt2 != (sgIt1->second)->end(); sgIt2++){
		  row("sg_orig_name")= *sgIt2->second;
		  row("sg_inst")= *sgIt2->first;
		  sg_inst_loop +=row;
		 
		  }
		
		row("sg_inst_loop")= sg_inst_loop;	  
		}
	
	      }
	      row("has_sg_inst")= has_sg_inst;
	    }
      
	else {
	  has_sg_inst = false;
	  row("has_sg_inst")= has_sg_inst;
	}

	//-----------------IFC instances list ----------------//
       	loop_t ifc_inst_loop;
	TMap_RefString_RefTMap_RefString::const_iterator uIt1;
	TMap_RefString::const_iterator uIt2;
	bool has_ifc_inst= false;

	if(!(cslCodeInfo->unitIfcInstMap)->empty()){
	  has_ifc_inst = true;
	 
	    for(uIt1 = (cslCodeInfo->unitIfcInstMap)->begin(); uIt1 != (cslCodeInfo->unitIfcInstMap)->end(); uIt1++){
	      if( *(uIt1->first) == *uName){
		for(uIt2 = (uIt1->second)->begin(); uIt2 != (uIt1->second)->end(); uIt2++){
		  row("ifc_orig_name")= *uIt2->second;
		  row("ifc_inst")= *uIt2->first;
		  ifc_inst_loop +=row;
		 
		  }
		
		row("ifc_inst_loop")= ifc_inst_loop;	  
		}
	
	      }
	      row("has_ifc_inst")= has_ifc_inst;
	    }
      
	else {
	  has_ifc_inst = false;
	  row("has_ifc_inst")= has_ifc_inst;
	}
	//row("has_ifc_inst")= has_ifc_inst;
      
      //-------------Unit instances list--------------------//
	
    bool has_f2a;
    TMap_RefString_RefTMap_RefString::const_iterator iter4;    //unitDeclInstNameMap
    TMap_RefString::const_iterator iter5;
   
    TMap_RefString::const_iterator iter7;                      //instF2aVec
    TMap_RefString_RefTMap_RefString::const_iterator iter8;    //unitInstMap
    TMap_RefString::const_iterator iter9;                        //unitInstF2aMap
    TMap_RefString_RefTMap_RefString::const_iterator iter10;     //unitDeclInstF2aMap
    int size;
    loop_t unit_f2a_inst_loop;
    //loop_t f2a_loop;
    //-------------------------------------------------------------------------------//
    //---------------------------instance with f2a connections-----------------------//
        
    if(!(cslCodeInfo->unitDeclInstF2aMap)->empty()){
      has_f2a = true;
      // loop_t unit_f2a_inst_loop;
      for (iter10 =(cslCodeInfo->unitDeclInstF2aMap)->begin(); iter10 != (cslCodeInfo->unitDeclInstF2aMap)->end(); iter10++){
	
	if(*(iter10->first)==*uName){
	  has_f2a = true;
	  
	  for(iter9 = (iter10->second)->begin();iter9 != (iter10->second)->end(); iter9++){
	    
	    row("unit_inst_name") = *(iter9->second);
	    row("unit_inst")= *(iter9->first);
	    
	    for(iter8 = (cslCodeInfo->unitInstMap)->begin(); iter8 != (cslCodeInfo->unitInstMap)->end(); iter8++){
	      
	      if(*(iter8->first) == *(iter9->first)){
		// has_f2a = true;
		loop_t f2a_loop;
		
		for(iter7 = (iter8->second)->begin(); iter7 != (iter8->second)->end(); iter7++){
		  
		  row("formal")= *(iter7->first);
		  row("actual")= *(iter7->second);
		  f2a_loop +=row; 
		  
		}
		
		row("f2a_loop")= f2a_loop; 
	      }
	      
	    }
	    unit_f2a_inst_loop += row;
	  }
	  
	  
	}

      }
	 row("unit_f2a_inst_loop")= unit_f2a_inst_loop;
      }
      else { has_f2a = false; }
      row("has_f2a")= has_f2a;
    //-------------------------------------------------------------//
    //-----------------------assign statement----------------------//
      bool has_assignStmt= false;
      bool  has_opExpr= false;
      bool  has_no_assn =true;
      bool has_concatRhs = false;
      bool  has_replicRhs = false;
        
    TMap_RefString_RefTMap_RefString::const_iterator iter13;
    TMap_RefString::const_iterator iter14;
    TMap_RefString_RefTMap::const_iterator iter15;
    TMap_RefString_RefTVec::const_iterator iter16;
    vector<RefString>::const_iterator iter17;
    string rhs="";
    string rhs_concat="{";
    string rhs_replic="{";
   
    if(!(cslCodeInfo->unitDeclAssignStmt)->empty()){
      has_assignStmt = false;
      has_no_assn = false;
      has_no_methods = false;
      ass_cnt++;
      loop_t assign_loop;
     
      for( iter13 = (cslCodeInfo->unitDeclAssignStmt)->begin(); iter13 != (cslCodeInfo->unitDeclAssignStmt)->end(); iter13++){
	if(*(iter13->first) == *uName){
	  //has_assignStmt = true;
	  //loop_t assign_loop;
	
	  for(iter14 = (iter13->second)->begin(); iter14 != (iter13->second)->end(); iter14++){
	    if(!(iter14->second)->empty()){
	      has_assignStmt = true;
	      row("lhs") = *(iter14->first);
	      row("rhs") = *(iter14->second);

	      // cout << "lhs=" << *(iter14->first)<< " rhs=" << *(iter14->second) << endl;
	      assign_loop +=row;
	    }
	   
	  }
	   row("assign_loop") = assign_loop;

	}
      }
      
    }
    else {
      has_assignStmt = false;
    }
    row("has_assignStmt") =  has_assignStmt;
    //------------------------------------------------------------//
    //-----------------assign with op expr in RHS-----------------//
  
    if(!(cslCodeInfo->unitDeclOpExpr)->empty()){
      // has_opExpr = true;
      has_no_assn = false;
      has_no_methods = false;
      has_assignStmt = false;
      string op, op1,op2;
      loop_t  ass_opExpr_loop;
     
      for(iter15 = (cslCodeInfo->unitDeclOpExpr)->begin(); iter15 != (cslCodeInfo->unitDeclOpExpr)->end(); iter15++){
	if(*(iter15->first) == *uName){
	  
	  //if(op_cnt ==1){
	  for(iter16 = (iter15->second)->begin(); iter16 !=(iter15->second)->end(); iter16++){
	    if(  (iter16->second)->size() >3){
	      has_opExpr = true;
	      row("lhs_op")= *(iter16->first);
	      cout << "lhs=" << *(iter16->first) << endl;
	    }
	    else {  has_opExpr = false; }
	    ///////////////////////
	    // cout << "size=" << (iter16->second)->size() << endl;
	    for(iter17 = (iter16->second)->begin(); iter17 !=(iter16->second)->end(); iter17++){
	      //has_opExpr = true;
		//row("lhs_op")= *(iter16->first);
	    
	      if(cslCodeInfo->m_isNum){
		  
		rhs = rhs + **iter17;
		if(iter17 == (iter16->second)->end()-1){
		  row("rhs_op")= rhs;
		  ass_opExpr_loop += row;
		}
	      }
	      else{
		  
		  if( iter17 == (iter16->second)->begin()+1){
		    op1 = **iter17;
		    
		  }
		  else {
		    if(iter17 == (iter16->second)->begin()+2){
		      op2 = **iter17;
		      
		    }
		    else { 
		      
		      if(iter17 == (iter16->second)->begin()+3){
			op = **iter17;
			rhs = op1 + op + op2;
			//cout << "rhs=" << rhs << endl;
		      }
		    }
		  }
		}
		
	      }
	      if(!cslCodeInfo->m_isNum){
		// rhs = op1 + op + op2;
	      
		row("rhs_op")= rhs;
		ass_opExpr_loop += row;
	      }
	      // }
	    ////////////////////////
	    //rhs = "";
	  }
	}
	  // }
	// else {  has_opExpr = false; }
	//	row ("has_opExpr")= has_opExpr;

	}
      row("ass_opExpr_loop")=  ass_opExpr_loop;
      row ("has_opExpr")= has_opExpr;
      has_opExpr = false;
    }
    //else { has_opExpr = false; }
   
  
    //---------------------------------------------------------//
    //----------------assign with concat on RHS----------------//
   TMap_RefString_RefTMap::const_iterator iter18;
   TMap_RefString_RefTVec::const_iterator iter19;
   vector<RefString>::const_iterator iter20;
 
   if((cslCodeInfo->unitDeclConcat).get() && (cslCodeInfo->concatVec).get()){
   if(!(cslCodeInfo->unitDeclConcat)->empty() && !(cslCodeInfo->concatVec)->empty()){
      loop_t ass_concat_loop;
      for(iter18 = (cslCodeInfo->unitDeclConcat)->begin(); iter18 != (cslCodeInfo->unitDeclConcat)->end(); iter18++){
	if(*(iter18->first) == *uName){
	 
	  //loop_t ass_concat_loop;
	  for(iter19 = (iter18->second)->begin(); iter19 !=(iter18->second)->end(); iter19++){
	    has_concatRhs = true;
	    has_no_assn = false;
	    has_no_methods = false;
	    has_assignStmt = false;
	    row("lhs_concat")= *(iter19->first);
	    if((iter19->second).get()){
	      for(iter20 = (iter19->second)->begin(); iter20 !=(iter19->second)->end(); iter20++){
		rhs_concat = rhs_concat +  **iter20;
		if(iter20 != (iter19->second)->end()-1){
		  rhs_concat = rhs_concat + ",";
		}
		if(iter20 == (iter19->second)->end()-1){
		  rhs_concat = rhs_concat + "}";
		  row("rhs_concat")= rhs_concat;
		  ass_concat_loop += row;
		}
		
	      }
	    }
	    //cout << rhs_concat << endl;
	   rhs_concat = "{";
	    
	   
	  }
	  //row("ass_concat_loop")=  ass_concat_loop;
	}
	row("ass_concat_loop")=  ass_concat_loop;
      }
    }
    else { has_concatRhs = false; }
    row ("has_concatRhs")= has_concatRhs;
   }
    //--------------------------------------------------------//
    //----------------asign with replication in RHS----------//
    TMap_RefString_RefTMap::const_iterator iter21;
   TMap_RefString_RefTVec::const_iterator iter22;
   vector<RefString>::const_iterator iter23;
  
   if(!(cslCodeInfo->unitDeclReplic)->empty() && !(cslCodeInfo->replicVec)->empty()){
     has_no_assn = false;
     // has_replicRhs = true;
     has_no_methods = false;
     has_assignStmt = false;
     repl_cnt++;

     loop_t ass_replic_loop;
     if(repl_cnt==1){
      for(iter21 = (cslCodeInfo->unitDeclReplic)->begin(); iter21 != (cslCodeInfo->unitDeclReplic)->end(); iter21++){

	if(*(iter21->first) == *uName){
	
	 //loop_t ass_replic_loop;
	  if((iter21->second)->size()!=0){
	    has_replicRhs = true;
	  }
	  else {  has_replicRhs = false;}
	  for(iter22 = (iter21->second)->begin(); iter22 !=(iter21->second)->end(); iter22++){
	     
	      row("lhs_replic")= *(iter22->first);
	    
	    for(iter23 = (iter22->second)->begin(); iter23 !=(iter22->second)->end(); iter23++){
	      rhs_replic = rhs_replic +  **iter23;
	      if(iter23 == (iter22->second)->begin()){
		rhs_replic = rhs_replic + "{";
	      }
	      if(iter23 != (iter22->second)->end()-1 && iter23 != (iter22->second)->begin() ){
		rhs_replic = rhs_replic + ",";
	      }
	      if(iter23 == (iter22->second)->end()-1){
		rhs_replic = rhs_replic + "}}";
		//cout << "rhs=" << rhs_replic << endl;
		row("rhs_replic")= rhs_replic;
		ass_replic_loop += row;
	      }
	      
	    }
	    //cout << rhs_concat << endl;
	   rhs_replic = "{";
	    
	   
	  }
	  // row("ass_replic_loop")=  ass_replic_loop;
	
	}
	row("ass_replic_loop")=  ass_replic_loop;
      }
     }
     // else { has_replicRhs = false;}
    }
   //else { has_replicRhs = false; }
    row ("has_replicRhs")= has_replicRhs;
    has_replicRhs = false;	 
    //------------------------set attribute ------------------//
    TMap_RefString::const_iterator iter24;
    TMap_RefString_RefTMap_RefString::const_iterator iter25;
    bool has_set_attr= false;
    loop_t clk_loop;
   

    if(!(cslCodeInfo->unitDeclAttrMap)->empty() && !(cslCodeInfo->attributeMap)->empty()){
      has_set_attr = true;
      for(iter25 = (cslCodeInfo->unitDeclAttrMap)->begin(); iter25 != (cslCodeInfo->unitDeclAttrMap)->end(); iter25++){
	if( *(iter25->first)== *uName){
	  for(iter24 = (iter25->second)->begin(); iter24 != (iter25->second)->end(); iter24++){
	    row("clk_name")= *(iter24->first);
            row("clock")= *(iter24->second);
	    clk_loop +=row;
	  }
	  row("clk_loop")=clk_loop;
	}
      }
    }
    else {  has_set_attr = false; }
    row("has_set_attr")= has_set_attr;
    
    if(has_set_attr == false && has_no_assn == true){
      has_no_methods = true;
    }
    else {  has_no_methods = false; }
    row("has_no_methods")= has_no_methods;
   
 //---------------------------------------------------------//
	unit_list +=row;
      }
    }
    else{
      has_unit = false;
    }

 
    //--------------------vector list--------------------------------------------//
    loop_t vector_loop;
    bool has_vectors;
    // TMap_RefString_RefTVec::const_iterator iterVec1;
    vector<RefString>::const_iterator iterVec2;
    // TVec_RefMap::const_iterator iterVec3;

    if(!(cslCodeInfo->vecData)->empty()){
      has_vectors = true;
    for(int i =0; i< (cslCodeInfo->vecData)->size(); i++){
      if( i==0 || i==3){
	row("dut_name") = *(cslCodeInfo->vecData)->at(i);
      }
      else {
	if(i==1 || i==4){
	  row("vec_dir") = *(cslCodeInfo->vecData)->at(i);
	}
	else {
	  if(i==2 || i==5){
	    row("vec_name")= *(cslCodeInfo->vecData)->at(i);
	    vector_loop +=row; 
	  }
	}
      }
    }
      
}
    else { has_vectors = false;}
    row("has_vectors")= has_vectors;

    //-----------------------TB code-------------------------------//     
    loop_t dut_list;
    loop_t tb_sig_loop;
    bool tb_has_stype,tb_has_swidth;
    bool has_tb;
    string tb_name, tb_clk, timescale;
    int period;
    TMap_RefString::const_iterator iterDut1, iterDut2;
    TMap_RefString_RefTVec::const_iterator sigIter1;
    vector<RefString>::const_iterator sigIter2;

    if((cslCodeInfo->tbName).get()){
      has_tb = true;
     
      tb_name = *(cslCodeInfo->tbName);
      for(iterDut1 = (cslCodeInfo->dutName_dutInst)->begin(); iterDut1 != (cslCodeInfo->dutName_dutInst)->end(); iterDut1++){
	row("dut_name")= *(iterDut1->first);
	row("dut_inst")= *(iterDut1->second);
	for(iterDut2 = (cslCodeInfo->dutName_dutClk)->begin(); iterDut2 != (cslCodeInfo->dutName_dutClk)->end(); iterDut2++){
	  if( *(iterDut2->first) == *(iterDut1->first)){
	    row("dut_clk")= *(iterDut2)->second;
	    
	  }
	  
	}
	tb_clk = *(cslCodeInfo->m_tbClockName);
	row("tb_clk")= *(cslCodeInfo->m_tbClockName);
	dut_list += row;
      }
      row("dut_inst_loop") = dut_list;

      if(!(cslCodeInfo->tbSigDataMap)->empty()){

	for(sigIter1 = (cslCodeInfo->tbSigDataMap)->begin(); sigIter1 != (cslCodeInfo->tbSigDataMap)->end(); sigIter1++){
	  row("tb_sName")= *(sigIter1->first);
	  vector<RefString> sData = *sigIter1->second;
	    if(sData[0].get()){
		   
		    tb_has_swidth = true;
		    row("tb_sig_width") = *sData[0];
		    
		  }
		  else{ tb_has_swidth = false; }
		  
		  if(sData[1].get()){
		    
		    tb_has_stype =true;
		    row("tb_sig_type") = *sData[1];
		  }
		  else{ tb_has_stype = false; }
		  
		  
		  row("tb_has_stype")= tb_has_stype;
		  row("tb_has_swidth") = tb_has_swidth;
		  tb_sig_loop += row;
	  }
	}
     
      period = (cslCodeInfo->per);
      timescale = *(cslCodeInfo->timeBase);
  
    }
    else { has_tb = false; }
  

//---------------------------------------------------------------------//
    templ("has_unit")= has_unit;
    templ("has_ifc")= has_ifc;
    templ("has_sg")= has_sg;
    templ("unit_predecl_loop")= unit_predecl_loop;
    templ("ifc_loop")= ifc_loop;
    templ("sg_loop")= sg_loop;
    templ("unit_loop")= unit_list;
    templ("vec_loop")= vector_loop;
    templ("has_vectors")= has_vectors;
    templ("has_tb")= has_tb;
    templ("dut_inst_loop") = dut_list;
    templ("tb_name") = tb_name;
    templ("tb_clk") = tb_clk;
    templ("period") = period;
    templ("timescale") = timescale;
    templ("tb_sig_loop") = tb_sig_loop;
    templ("br_loop")= br_loop;
    templ("has_br")= has_br;

    if(file_name){ 
      ofstream cslCode(file_name, ios::app);
      cslCode << templ;
    }   
    cslCode.close();    
}
