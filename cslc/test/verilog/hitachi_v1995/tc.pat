//        Test Case ID: tc_pat_pwr_auto_read_x8.pat 
//
//        Note        : DEV_TYPE = 00    =>  [00 - HN29V128A1A (3.3v, x8)]        
//                      MEMORY_TYPE = FULL
//                      PWRUP_EN    = ENABLE                                           
//                      BUSY_MAX_EN = ENABLE
//                      INIT_MEM_EN = DISABLE
//
//
//        Test Flow   :    Power on sequence(Pre = Low)
//                      -> ID read -> Rewrite -> Status read -> program
//                      -> Status read x2 -> Rewrite -> Sequential read -> Read stop
//                      -> Read -> Read stop -> Deep standbye -> Erase -> Status read
//                      -> read -> read stop
//******************************************************************************
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//       INIT
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              // DRIV(ce_n,we_n,re_n,wp_n,dse_n,pre,cle,ale,dump,io)
#(0);            DRIV('b1,'b1, 'b1, 'b1, 'b0,  'b0,'b0,'b0,'b0,16'hZZZZ);
#(10);           DRIV('b1,'b1, 'b1, 'b1, 'b1,  'b0,'b0,'b0,'b0,16'hZZZZ);

#(Tdb + Tbsy + Trmres + 1000);  CMND(8'h90);                              //ID read
#(Twhc + 50);                   IDRD(8'h00);

#(Twhc + 50);                   CMND(8'h80);                               //Rewrite
#(Twhc + 50);                   CADD(11'h000);
#(Twhc + 50);                   SADD(13'h0000);
#(Twhc + 50);                   DATA(16'h0000, 'd15);
#(Twhc + 50);                   CMND(8'h1F);

#(Twb + Trewrite + 500);        CMND(8'h70);                               //Status read
#(Twhc + 50);                   READ('d1);
#(Twhc + 50);                   CMND(8'h80);                               //Program
#(Twhc + 50);                   CADD(11'h400);
#(Twhc + 50);                   SADD(13'h1FFD);
#(Twhc + 50);                   DATA(16'h0010, 'd512);
#(Twhc + 50);                   DATA(16'h0020, 'd512);
#(Twhc + 50);                   CMND(8'h10);
#(Twb + Tprog - 200);           CMND(8'h70);                               //Status read
#(Twhc + 50);                   READ('d1);
#(700);                         CMND(8'h70);                               //Status read
#(Twhc + 50);                   READ('d1);

#(Twhc + 50);                   CMND(8'h80);                               //Rewrite
#(Twhc + 50);                   CADD(11'h000);
#(Twhc + 50);                   SADD(13'h1FFF);
#(Twhc + 50);                   DATA(16'h0050, 'd512);
#(Twhc + 50);                   DATA(16'h0060, 'd512);
#(Twhc + 50);                   DATA(16'h0070, 'd512);
#(Twhc + 50);                   DATA(16'h0080, 'd512);
#(Twhc + 50);                   CMND(8'h1F);

#(Twb + Trewrite + 500);        CMND(8'h0F);                               //Sequential read
#(Tcls + 50);                   CADD(11'h400);
#(Twhc + 50);                   SADD(13'h1FFD);
#(Trhz + Twb + Tr + Trr);       READ('d1024);
#(Trhz + Tsrb + Tr + Trr);      READ('d2048);
#(Trhz + Tsrb + Tr + Trr);      READ('d2047);
#(Trhws);                       CMND(8'hF0);                               //Read stop  
                   // DRIV(ce_n,we_n,re_n,wp_n,dse_n,pre,cle,ale,dump,io)
#(Twb + Trstp +200);  DRIV('b1,'b1, 'b1, 'b1, 'b1,  'b0,'b0,'b0,'b0,16'hZZZZ);  // ce_n = High
#(Tcehs);             DRIV('b0,'b1, 'b1, 'b1, 'b1,  'b0,'b0,'b0,'b0,16'hZZZZ);  // ce_n = Low

#(Trhw + 50);                   CMND(8'h00);                               //Read
#(Twhc + 50);                   CADD(11'h000);
#(Twhc + 50);                   SADD(13'h0000);
#(Twb + Tr + Trr +200);         READ('d30);
#(Trhw);                        CMND(8'hF0);                               //Read stop
#(Twb + Trstp + 200);  DRIV('b1,'b1, 'b1, 'b1, 'b1,  'b0,'b0,'b0,'b0,16'hZZZZ);  // ce_n = High
#(100);                DRIV('b1,'b1, 'b1, 'b1, 'b0,  'b0,'b0,'b0,'b0,16'hZZZZ);  // dse_n = Low 
#(10000);              DRIV('b1,'b1, 'b1, 'b1, 'b1,  'b0,'b0,'b0,'b0,16'hZZZZ);  // dse_n = High

#(Twb + Tdbsy + 200);           CMND(8'h60);                               //Erase
#(Twhc + 50);                   SADD(13'h0000);
#(Twhc + 50);                   CMND(8'hD0); 
#(Twb + Ters + 200);            CMND(8'h70);                               //Status read
#(Twhc + 50);                   READ('d1);

#(Trhw + 50);                   CMND(8'h00);                               //Read
#(Twhc + 50);                   CADD(11'h000);
#(Twhc + 50);                   SADD(13'h0000);
#(Twb + Tr + Trr +200);         READ('d30);
#(Trhw);                        CMND(8'hF0);                               //Read stop
#(Twb + Trstp + 200);           DUMP;                                      //Dump 
#(1000);                        STOP;  


