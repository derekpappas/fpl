/***************************************************************************/
/* Cypress Semiconductor, Inc. Company Confidential                        */
/* Copyright 2002, Cypress Semiconductor Inc. All Rights reserved          */
/* Cypress Semiconductor proprietary source code                           */
/* Permission to use, modify or copy this code is prohibited               */
/* without the express written consent of Cypress Semiconductor Inc        */
/* 3901 North First Street,                                                */
/* San Jose, CA 95134                                                      */
/*                                                                         */
/* Description: CY7C4808V25-200                                            */
/* Filename: Fifo.taskfile_ez.v                                            */
/* Author: Johnie Au                                                       */
/* Release: 2002.03                                                        */
/* SCCS Path: /models/verilog/cy7c4808v25/                                 */
/* @(#)Fifo.taskfile_ez.v	1.2 03/21/02 */
/***************************************************************************/

  task reset;

   // reset( LittleEndian, STD, PRELOAD8, sizeA, sizeB );

   input   busMODE, tmgMODE, pgmMODE ;
   integer busMODE, tmgMODE, pgmMODE ;
   input   portsizA, portsizB;
   integer portsizA, portsizB;

   // MARK1, MARK2

  begin

   strobe_q_sw_cache = strobe_q_sw;
   strobe_q_sw = 0;
   ts = 1;
   MRSb = 1; 
   PRSb = 1;
   @ ( posedge sysclk1 ) 
   begin
    `ifdef lt1001
      cycleName = "ts1, cy1";
    `endif
    `ifdef hp83000j 
      cycleName = "reset ";
    `endif
    `ifdef versatest
      cycleName = "ts1, cy1";
    `endif
     MRSb = 0; 
   end

   PRSb = 1; 

   CSAb   = 1; CSBb    = 1;
   ENA    = 0; ENB     = 0;
   SIZE1A = 0; SIZE1B  = 0;
   SIZE2A = 0; SIZE2B  = 0;
   S_H    = 0;
   ZQ     = 0;
   Vref   = 1;
   TRST   = 0; TCK = 0; TM = 0; TDI = 0;

   RTbSPMb = 1;

   ///// XOR /////

    case ( busMODE )
      BigEndian:    
                 begin
                    BEFWFTb = 0; // xor
                    bmode = "Big";
                 end
      LittleEndian: 
                 begin
                    BEFWFTb = 1; // xor
                    bmode = "Little";
                 end
      default: BEFWFTb = 1; // Q&A
    endcase

   ///// XOR /////

   case ( pgmMODE )
     PRELOAD64: begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 0;
                      pmode = "preload 64";
                    end
     PRELOAD16: begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 1;
                      pmode = "preload 16";
                    end
     PRELOAD8 : begin
                      RTbSPMb = 1; FS1SENb = 1; FS0SD = 0;
                      pmode = "preload  8";
                    end
     PARALLEL  : begin
                      RTbSPMb = 1; FS1SENb = 1; FS0SD = 1;
                      pmode = "parallel";
                    end
     SERIAL    : begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 1;
                      pmode = "serial";
                    end
   endcase



    #trsts

    begin
     fork

        begin

          ENA = 0;
          #tsetup CLKA = 1; 
          #thold  ENA  = 0; 
          #(tch1-thold) CLKA = 0; 

         repeat (3)
         begin
         @ ( posedge sysclk1 )
           ENA = 0;
           #tsetup CLKA = 1; 
           #thold  ENA  = 0; 
           #(tch1-thold) CLKA = 0; 
         end

        end

        begin

          ENB = 0;
          #tsetup CLKB = 1; 
          #thold  ENB  = 0; 
          #(tch2-thold) CLKB = 0;
         repeat (3)
         begin
         @ ( posedge sysclk2 )
           ENB = 0;
           #tsetup CLKB = 1; 
           #thold  ENB  = 0; 
           #(tch2-thold) CLKB = 0;
         end

        end

     join
    end




    // SIZE1A, SIZE2A, SIZE1B, SIZE2B; 
  
    if ( portsizA == 80 ) begin 
      SIZE1A = 0; SIZE2A = 0;        // X 80  Byte Matching
      archA = 80;
    end
    if ( portsizA == 40 ) begin 
      SIZE1A = 0; SIZE2A = 1;        // X 40  Byte Matching
      archA = 40;
    end
    if ( portsizA == 20 ) begin 
      SIZE1A = 1; SIZE2A = 0;        // X 20  Byte Matching
      archA =  20;
    end
    if ( portsizA == 10 ) begin 
      SIZE1A = 1; SIZE2A = 1;        // X 10  Byte Matching
      archA =  10;
    end

    if ( portsizB == 80 ) begin 
      SIZE1B = 0; SIZE2B = 0;        // X 80  Byte Matching
      archB = 80;
    end
    if ( portsizB == 40 ) begin 
      SIZE1B = 0; SIZE2B = 1;        // X 40  Byte Matching
      archB = 40;
    end
    if ( portsizB == 20 ) begin 
      SIZE1B = 1; SIZE2B = 0;        // X 20  Byte Matching
      archB =  20;
    end
    if ( portsizB == 10 ) begin 
      SIZE1B = 1; SIZE2B = 1;        // X 10  Byte Matching
      archB =  10;
    end

   //$display("architecture A is ", archA );
   //$display("architecture B is ", archB );

   @ ( posedge sysclk1 ) // jcajca

   ////////// REAL SETTINGS ////////////////////////////////////

    case ( busMODE )
      BigEndian:    
                 begin
                    BEFWFTb = 1;
                    bmode = "Big";
                 end
      LittleEndian: 
                 begin
                    BEFWFTb = 0;
                    bmode = "Little";
                 end
      default: BEFWFTb = 1; // Q&A
    endcase


   case ( pgmMODE )

     PRELOAD64: begin
                      RTbSPMb = 1; FS1SENb = 1; FS0SD = 1;
                      pmode = "preload 64";
                    end
     PRELOAD16: begin
                      RTbSPMb = 1; FS1SENb = 1; FS0SD = 0;
                      pmode = "preload 16";
                    end
     PRELOAD8 : begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 1;
                      pmode = "preload  8";
                    end
     PARALLEL  : begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 0;
                      pmode = "parallel";
                    end
     SERIAL    : begin
                      RTbSPMb = 0; FS1SENb = 1; FS0SD = 0;
                      pmode = "serial";
                    end
   endcase

         
   #tfss

    MRSb = 1; 

   #tfsh

   case ( pgmMODE )
     PRELOAD64: begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 0;
                      pmode = "preload 64";
                    end
     PRELOAD16: begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 1;
                      pmode = "preload 16";
                    end
     PRELOAD8 : begin
                      RTbSPMb = 1; FS1SENb = 1; FS0SD = 0;
                      pmode = "preload  8";
                    end
     PARALLEL  : begin
                      RTbSPMb = 1; FS1SENb = 1; FS0SD = 1;
                      pmode = "parallel";
                    end
     SERIAL    : begin
                      RTbSPMb = 1; FS1SENb = 0; FS0SD = 1;
                      pmode = "serial";
                    end
   endcase

   #trsth 

    RTbSPMb = 1;

   case ( tmgMODE )
     STD:  
            begin
              BEFWFTb = 1; 
              tmode = "STD";
            end
     FWFT: 
            begin
              BEFWFTb = 0; 
              tmode = "FWFT";
            end
     default: 
            begin
             BEFWFTb = 1; 
            end
   endcase

   TRST   = 1; TCK = 0; TM = 0; TDI = 0;
   strobe_q_sw = strobe_q_sw_cache;

  end

  endtask // reset

  task marker;
  input [24*8-1:0] testlabel;
  integer i;
  begin

    $display("%s",testlabel);

  end
  endtask

  task done;
  input mode;
  reg [3:0] mode;
  begin

   $finish;

  end
  endtask

  task report_test;
  input mode;
  reg [3:0] mode;
  begin

  if ( STROBE_ON_OFF )
  begin
   $display(q1Error,efb1Error,aeb1Error,afb1Error,ffb1Error);
   Error = q1Error | efb1Error | aeb1Error | afb1Error | ffb1Error;
   Error_msg = ( Error ) ? "----------> failed" : "passed";

   q1Error = 0;
   efb1Error = 0;
   aeb1Error = 0;
   afb1Error = 0;
   ffb1Error = 0;
   Error = 0;
  end
   $display("%s depth: %d [%b%b] [%b%b] %d/%d %s",
             testname,
             depth,
             SIZE1A,SIZE1B,SIZE2A,SIZE2B, 
             CY7C480XV25.cyfifo.sizPortA,CY7C480XV25.cyfifo.sizPortB, 
             Error_msg);
   Error = 0;
   casex (mode)
    4'b0000: ;
    4'b0001: ;
    default: ;
   endcase
    -> tst_done;
  end
  endtask

  task w_cycle;
  input cyc;
  integer cyc;
  input enable;
  integer loop;
  input data;
  reg [83:0] data;
  begin

    MRSb = 1;
    CSBb = 0; // turn on port b
    ts = 2;
    wait ( MRSb == 1 );
    if ( enable ) begin
      portA.pattern = data;
      //$display("assigning portA.pattern(%b)<-data(%b)",portA.pattern,data);
    end

    loop = cyc;
    if ( enable ) loop = cyc * 80 / archA;
    

    repeat ( loop )
    begin
     //if ( beast.e_count % 500 == 0 ) $display("wrote .... ", beast.e_count );
     @ ( posedge sysclk1 )

        case ( {enable,pgm_cycle} )

        `ifdef sim
         2'b00: cycleName = "ts2, cy2";
         2'b10: cycleName = "ts2, cy2";
         2'b01: cycleName = "ts9, cy9";
         2'b11: cycleName = "ts9, cy9";
        `endif

       `ifdef lt1001
         2'b00: cycleName = "ts2, cy2";
         2'b10: cycleName = "ts2, cy2";
         2'b01: cycleName = "ts9, cy9";
         2'b11: cycleName = "ts9, cy9";
       `endif

       `ifdef hp83000j
         2'b00: cycleName = "wdis  ";
         2'b10: cycleName = "w     ";
         2'b01: cycleName = "wdis  ";
         2'b11: cycleName = "wpgm  ";
       `endif

       `ifdef versatest
         2'b00: cycleName = "cyc   ";
         2'b10: cycleName = "cyc   ";
         2'b01: cycleName = "cyc   ";
         2'b11: cycleName = "cyc   ";
       `endif

       `ifdef TM 
         2'b00: cycleName = "cyc   ";
         2'b10: cycleName = "cyc   ";
         2'b01: cycleName = "cyc   ";
         2'b11: cycleName = "cyc   ";
       `endif

        endcase

        ENA  =  enable;
        CSAb = ~enable; // chip select/de-select 
        CSAb = 0;
     #(tsetup) 
        CLKA = 1;
     #(thold)
        ENA  = 0;
        CSAb = 1;
     #(tcl1-thold)
        CLKA = 0;
    end



  end
  endtask

  
  task w;
  input cyc;
  integer cyc;
  input data;
  reg [83:0] data;
  begin

   if ( Free_Running_Clock )
    wbr_cycle( cyc, 1, 0, data);
   else
    w_cycle( cyc, 1, data);

  end
  endtask

  task wpgm;
  input cyc;
  integer numCycle;
  input [79:0] offset;
  begin
   pgm_cycle = 1;
   w_cycle( cyc, 1, offset );
   #0.001;
   pgm_cycle = 0;
  end
  endtask

  task wdis;
  input cyc;
  integer cyc;
  input pat;
  reg [83:0] pat;
  begin
   w_cycle( cyc, 0, pat );
  end
  endtask

  task r_cycle;
  input cyc;
  integer cyc;
  input enable;
  integer loop;
  begin

    ts = 3;
    //force CSBb = 0;

    wait ( MRSb == 1 );
    loop = cyc;
    if ( enable ) loop = cyc * 80 / archB;
    
    repeat ( loop )
    begin
     //if ( beast.e_count % 500 == 0 ) $display("read .... ", beast.e_count );
     @ ( posedge sysclk2 )
        case ( {enable} )

       `ifdef sim
         1'b0: cycleName = "ts3, cy3";
         1'b1: cycleName = "ts3, cy3";
       `endif

       `ifdef lt1001
         1'b0: cycleName = "ts3, cy3";
         1'b1: cycleName = "ts3, cy3";
       `endif

       `ifdef hp83000j
         1'b0: cycleName = "rdis  ";
         1'b1: cycleName = "r     ";
       `endif

       `ifdef versatest
         1'b0: cycleName = "cyc   ";
         1'b1: cycleName = "cyc   ";
       `endif

        endcase

        ENB  =  enable;
        //CSBb = ~enable; // chip select/de-select
        CSBb = 0;
     #(tsetup) 
        CLKB = 1;
     #(thold)
        ENB  = 0;
        //CSBb = 1; // RTO
     #(tcl2-thold)
        CLKB = 0;
    end
  end
  endtask

  task r;
  input cyc;
  integer cyc;
  begin

   if ( Free_Running_Clock )
    rbw_cycle( cyc, 0, 1, zero );
   else
    r_cycle( cyc, 1 );
  end
  endtask


  task rdis;
  input cyc;
  integer cyc;
  begin
   r_cycle( cyc, 0 );
  end
  endtask

  task noop;
  input cyc;
  integer cyc;
  begin
   r_cycle( cyc, 0 );
  end
  endtask


  task rt;
  begin

   //CSAb   = 0; CSBb    = 0;
   //ENA    = 0; ENB     = 0;

  `ifdef VPL
   @ ( posedge sysclk1 )
  `endif

  `ifdef sim
    cycleName = "ts8, cy8";
  `endif

  `ifdef lt1001
    cycleName = "ts8, cy8";
  `endif

  `ifdef hp83000j
    cycleName = "rt    ";
  `endif

  `ifdef versatest
    cycleName = "cyc   ";
  `endif

   //@ ( posedge sysclk1 ) 
   //#trsts RTbSPMb = 0;

    begin
     fork

        RTbSPMb = 0;

        begin
         repeat (8)
         begin
         @ ( posedge sysclk1 )

         `ifdef lt1001
           cycleName = "ts8, cy8";
         `endif

         `ifdef hp83000j 
           cycleName = "rt    ";
         `endif

         `ifdef versatest 
           cycleName = "cyc   ";
         `endif

           //ENA = 1;
           ENA = 0;
           #tsetup CLKA = 1;
           #thold  ENA  = 0; 
           #(tch1-thold) CLKA = 0; 
         end
        end

        begin
         repeat (8)
         begin
         @ ( posedge sysclk2 )
           //ENB = 1;
           ENB = 0;
           #tsetup CLKB = 1; 
           #thold  ENB  = 0; 
           #(tch1-thold) CLKB = 0; 
         end
        end

     join
    end

   #trsth RTbSPMb = 1;
  end
  endtask


  task prb;

  begin

   //CSAb   = 0; CSBb    = 0;
   //ENA    = 0; ENB     = 0;

  `ifdef lt1001
    cycleName = "ts1, cy1";
  `endif

  `ifdef hp83000j 
    cycleName = "prb   ";
  `endif

  `ifdef versatest 
    cycleName = "cyc   ";
  `endif

   @ ( posedge sysclk1 )
   #trsts PRSb = 0;

    begin
     fork

        begin
         repeat (4)
         begin
         @ ( posedge sysclk1 )
           ENA = 0;
           #tsetup CLKA = 1;
           #thold  ENA = 0; 
           #(tch1-thold) CLKA = 0; 
         end
        end

        begin
         repeat (4)
         begin
         @ ( posedge sysclk2 )
           ENB = 0;
           #tsetup CLKB = 1; 
           #thold  ENB = 0; 
           #(tch1-thold) CLKB = 0;
         end
        end

     join
    end
   #trsth PRSb = 1;

  end
  endtask

  task _wSpgm;
  input sbits;
  integer sbits;
  input [79:0] offset;
  reg [70:0] serial_bit;
   begin


     //offset = offset & 36'b000000_0000000000_0000001111_1111111111;

     FS1SENb = 0; // serial programming enable

     // Parallel-to-serial

     serial_bit = sbits-1;

	     repeat ( sbits ) begin
	       FS0SD = offset[serial_bit];
	       w_cycle( 1, 1, offset );
	       serial_bit = serial_bit - 1;
	       //$display( data, " ", FS0SD, " ", serial_bit );
	     end

	     FS1SENb = 1; // serial programming disable

	   #0.001;
	   end
	  endtask


 task wSpgm;
  input [79:0] offset;
  integer sbits;
  reg [70:0] serial_bit;
   begin

     pgm_cycle = 1;
     FS1SENb = 0; // serial programming enable

     // Parallel-to-serial

    case ( depth )

        64: sbits = 6;
      4096: sbits = 12;
     16384: sbits = 14;
     65536: sbits = 16;

    endcase

     serial_bit = sbits-1;

     repeat ( sbits ) begin
       FS0SD = offset[serial_bit];
       w_cycle( 1, 1, offset );
       serial_bit = serial_bit - 1;
       //$display( data, " ", FS0SD, " ", serial_bit );
     end

     FS1SENb = 1; // serial programming disable

   #0.001;
     pgm_cycle = 0;
   end
  endtask




  task next_size;
  begin

   begin
    next_ptr = (next_ptr +1 ) % 16;
    //$display("changing sizes -> %d", next_ptr);

    case (next_ptr)

      0: begin sizeA = 80; sizeB = 80; end
      1: begin sizeA = 80; sizeB = 40; end
      2: begin sizeA = 80; sizeB = 20; end
      3: begin sizeA = 80; sizeB = 10; end
      4: begin sizeA = 40; sizeB = 80; end
      5: begin sizeA = 40; sizeB = 40; end
      6: begin sizeA = 40; sizeB = 20; end
      7: begin sizeA = 40; sizeB = 10; end

      8: begin sizeA = 20; sizeB = 80; end
      9: begin sizeA = 20; sizeB = 40; end
     10: begin sizeA = 20; sizeB = 20; end
     11: begin sizeA = 20; sizeB = 10; end
     12: begin sizeA = 10; sizeB = 80; end
     13: begin sizeA = 10; sizeB = 40; end
     14: begin sizeA = 10; sizeB = 20; end
     15: begin sizeA = 10; sizeB = 10; end

    endcase
    

   end

  end

 endtask



  task rt_w2;
  begin

   //CSAb   = 0; CSBb    = 0;
   //ENA    = 0; ENB     = 0;
   CSAb = 0; CSBb = 0;

   @ ( posedge sysclk1 ) 
   #trsts RTbSPMb = 0;

    begin
     fork

        begin

         repeat (4)
         begin
         @ ( posedge sysclk1 )
           ENA = 1;
           #tsetup CLKA = 1;
           #thold  ENA  = 1; 
           #(tch1-thold) CLKA = 0; 
         end

         repeat (4)
         begin
         @ ( posedge sysclk1 )
           ENA = 0;
           #tsetup CLKA = 1;
           #thold  ENA  = 0; 
           #(tch1-thold) CLKA = 0; 
         end

        end

        begin
         repeat (8)
         begin
         @ ( posedge sysclk2 )
           ENB = 0;
           #tsetup CLKB = 1; 
           #thold  ENB  = 0; 
           #(tch1-thold) CLKB = 0; 
         end
        end

     join
    end

   CSAb = 0; CSBb = 0;
   #trsth RTbSPMb = 1;
  end
  endtask

  task wr_cycle;
  input cyc;
  integer cyc;
  input w_enable;
  input r_enable;

  input data;
  reg [83:0] data;

  integer w_loop;
  integer r_loop;

  begin
    wait ( MRSb == 1 );
    if ( w_enable ) portA.pattern = data;

    w_loop = cyc;
    r_loop = cyc;
    if ( w_enable | Free_Running_Clock ) w_loop = cyc * 80 / archA;
    if ( r_enable | Free_Running_Clock ) r_loop = cyc * 80 / archB;
    
   fork

    repeat ( w_loop )
    begin
     @ ( posedge sysclk1 )
        ENA  =  w_enable;
        CSAb = ~w_enable; // chip select/de-select 
        CSAb = 0;
     #(tsetup) 
        CLKA = 1;
     #(thold)
        ENA  = 0;
        CSAb = 1;
     #(tcl1-thold)
        CLKA = 0;
    end

    repeat ( r_loop )
    begin
     @ ( posedge sysclk2 )
        ENB  =  r_enable;
        //CSBb = ~r_enable; // chip select/de-select
        CSBb = 0;
     #(tsetup) 
        CLKB = 1;
     #(thold)
        ENB  = 0;
        //CSBb = 1;
     #(tcl2-thold)
        CLKB = 0;
    end

   join


  end
  endtask


  task wbr;
  input cyc;
  integer cyc;
  input data;
  reg [83:0] data;
  begin
    wbr_cycle( cyc, 1, 1, data);
  end
  endtask

  task wbr_cycle;
  input cyc;
  integer cyc;
  input w_enable;
  input r_enable;

  input data;
  reg [83:0] data;

  integer w_loop;
  integer r_loop;

  begin
    ts = 8;
    wait ( MRSb == 1 );
    if ( w_enable ) portA.pattern = data;

    w_loop = cyc;
    r_loop = cyc;
    if ( w_enable | Free_Running_Clock ) w_loop = cyc * 80 / archA;
    if ( r_enable | Free_Running_Clock ) r_loop = cyc * 80 / archB;
    
   fork

   begin
    repeat ( w_loop )
    begin
     @ ( posedge sysclk1 )

        case ( {w_enable} )

       `ifdef sim
         1'b0: cycleName = "ts4, cy4";
         1'b1: cycleName = "ts4, cy4";
       `endif

       `ifdef lt1001
         1'b0: cycleName = "ts4, cy4";
         1'b1: cycleName = "ts4, cy4";
       `endif

       `ifdef hp83000j
         1'b0: cycleName = "wbrdis";
         1'b1: cycleName = "wbr   ";
       `endif

       `ifdef versatest
         1'b0: cycleName = "cyc    ";
         1'b1: cycleName = "cyc   ";
       `endif

        endcase

        ENA  =  w_enable;
        CSAb = ~w_enable; // chip select/de-select 
        CSAb = 0;
     #(tsetup) 
        CLKA = 1;
     #(thold)
        ENA  = 0;
        CSAb = 1;
     #(tcl1-thold)
        CLKA = 0;
    end
   end

   begin
    repeat ( r_loop )
    begin
     @ ( posedge sysclk2 )
        ENB  =  r_enable;
        CSBb = ~r_enable; // chip select/de-select
        CSBb = 0;
     #(tsetup+tskew) 
        CLKB = 1;
     #(thold)
        ENB  = 0;
        //CSBb = 1;
     #(tcl2-thold)
        CLKB = 0;
    end
   end

   join


  end
  endtask


  task rbw;
  input cyc;
  integer cyc;
  input data;
  reg [83:0] data;
  begin
    rbw_cycle( cyc, 1, 1, data);
  end
  endtask

  task rbw_cycle;
  input cyc;
  integer cyc;
  input w_enable;
  input r_enable;

  input data;
  reg [83:0] data;

  integer w_loop;
  integer r_loop;

  begin
    ts = 9;
    wait ( MRSb == 1 );
    if ( w_enable ) portA.pattern = data;

    w_loop = cyc;
    r_loop = cyc;
    if ( w_enable | Free_Running_Clock ) w_loop = cyc * 80 / archA;
    if ( r_enable | Free_Running_Clock ) r_loop = cyc * 80 / archB;
    
   fork

   begin
    repeat ( w_loop )
    begin
     @ ( posedge sysclk1 )
        ENA  =  w_enable;
        CSAb = ~w_enable; // chip select/de-select 
        CSAb = 0;
     #(tsetup+tskew) 
        CLKA = 1;
     #(thold)
        ENA  = 0;
        CSAb = 1;
     #(tcl1-thold)
        CLKA = 0;
    end
   end

   begin
    repeat ( r_loop )
    begin
     @ ( posedge sysclk2 )

        case ( {r_enable} )

       `ifdef sim
         1'b0: cycleName = "ts6, cy6";
         1'b1: cycleName = "ts6, cy6";
       `endif

       `ifdef lt1001
         1'b0: cycleName = "ts6, cy6";
         1'b1: cycleName = "ts6, cy6";
       `endif

       `ifdef hp83000j
         1'b0: cycleName = "rbwdis";
         1'b1: cycleName = "rbw   ";
       `endif

       `ifdef versatest
         1'b0: cycleName = "cyc    ";
         1'b1: cycleName = "cyc   ";
       `endif

        endcase


        ENB  =  r_enable;
        CSBb = ~r_enable; // chip select/de-select
        CSBb = 0;
     #(tsetup) 
        CLKB = 1;
     #(thold)
        ENB  = 0;
        //CSBb = 1;
     #(tcl2-thold)
        CLKB = 0;
    end
   end

   join


  end
  endtask
