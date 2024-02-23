enum e_units{
   EUNIT_DSP,
   EUNIT_H264,
   EUNIT_ARM,
   EUNIT_CMPR,
   ...
}

enum e_status{
   EHWSTATUS_TIMEOUT,
   EHWSTATUS_ERROR,
   EHWSTATUS_WARNING,
   EHWSTATUS_BLOCKED,
   EHWSTATUS_WAITING,
   ...
}

enum e_operation{
   EHWOPERATION_SETBIT ,
   EHWOPERATION_RUN ,
   EHWOPERATION_STOP ,
   EHWOPERATION_STALL ,
   EHWOPERATION_KILL ,
   EHWOPERATION_DISABLE ,
   ...
}

// get status from unit n
e_status getStatus(e_units u) {

} 

// 
e_status sendOperation(e_operation op, e_units u) {
    
} 

void writeWordToSsmClient(e_unit u, TUInt address) {

}

TUInt readWordFromSsmClient(e_unit u, TUInt address) {

}
 
void writeWordToSsmController(e_unit u, TUInt address) {

}

TUInt readWordFromSsmController(e_unit u, TUInt address) {

}
 
e_status pollUnit() {

}

How do you stop a virus from shutting down the HW?




