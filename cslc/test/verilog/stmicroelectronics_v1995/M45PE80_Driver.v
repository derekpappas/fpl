//////////////////////////////////////////////////////////////////////////
//
// M45PE80 Access Driver for Verification
//
// File:           - M45PE80_Driver.v
// Author:         - Xue-feng Hu
// Date:           - July 2004
//
//////////////////////////////////////////////////////////////////////////
//
// LIMITATION OF LIABILITY: 
// NEITHER STMicroelectronics NOR ITS VENDORS OR AGENTS SHALL 
// BE LIABLE FOR ANY LOSS OF PROFITS, LOSS OF USE, LOSS OF
// DATA, INTERRUPTION OF BUSINESS, NOR FOR INDIRECT, SPECIAL, 
// INCIDENTAL OR CONSEQUENTIAL DAMAGES OF ANY KIND WHETHER 
// UNDER THIS AGREEMENT OR OTHERWISE, EVEN IF ADVISED OF THE 
// POSSIBILITY OF SUCH DAMAGES.
//
// Copyright 2003, STMicroelectrons Corporation, All Rights Reserved.
//
//////////////////////////////////////////////////////////////////////////

`include "M45PE80_Macro.v"

`define  PGBUF_MAX   256        //maximum number of bytes for PAGE WRITE and PAGE PROGRAM by different data

//===========================
module M45PE80_DRV(
                    C,
                    D,
                    Q,
                    S,
                    W,
                    RESET,
                    VCC,
                    VSS
                  );
//---------------------------
input Q;
output C,D,S,W,RESET,VCC,VSS;
//---------------------------
integer i,j;

reg C,D,S,W,RESET,VCC;

reg[7:0] sr;            //save the value of status register read by RDSR instruction
reg[7:0] read_dat;      //save the data value read by READ DATA and FAST READ DATA instruction
reg[7:0] id1,id2,id3;   //save identification read by RDID instruction
reg[7:0] page_wr_buf[`PGBUF_MAX-1:0];    //data buf for PAGE WRITE with different data
reg[7:0] page_pg_buf[`PGBUF_MAX-1:0];    //data buf for PAGE PROGRAM with different data

//---------------------------
//test the M45PE80
//---------------------------
initial begin
        for(i=0;i<=`PGBUF_MAX-1;i=i+1)
        begin
            page_wr_buf[i] = 8'hff;
            page_pg_buf[i] = 8'hff;
        end

        VCC = 1'b1;     //Power up
        #(`tVSL);       //time delay for Vcc to /S low
        #(`tPUW_MAX);   //time delay before first write, program and erase instruction
        #10;
        W = 1'b1;
        #10;
        RESET = 1'b0;
        #10;
        S = 1'b1;
        #(`tSHSL);
        READ_IDENTIFICATION;

        //RESET = 1'b1;
        S = 1'b1;
        #(`tCHSL);              ///S not active hold time
        S = 1'b0;
        #(`tSLCH-`tDVCH);
        for(i=0;i<=7;i=i+1)
        begin
            if((i==5)||(i==6))  D = 1'b1;
            else D = 1'b0;      //WREN instruction
            #(`tDVCH);          //data setup time, and /S active setup time with #(`tSLCH-`tDVCH)
            C = 1'b1;
            RESET = 1'b0;       //RESET is driven low during instruction byte latched in
            #(`tCH+2);          //Clock High Time
            C = 1'b0;
            #(`tCL+2-`tDVCH);
        end
        #(`tDVCH);
        #(`tCHSH);              ///S active hold time
        S = 1'b1;
        #(`tSHSL);              ///S Deselect time

        #(`tRLRH);
        RESET = 1'b1;
        READ_IDENTIFICATION;
        
        WRITE_ENABLE;
        RESET = 1'b0;
        #(`tRLRH);
        RESET = 1'b1;

        WRITE_ENABLE;
        //page_pg_buf = {8'h55,8'haa,8'h00,8'hff,8'haa,8'h55,8'hff,8'h00,8'h12,8'h34,8'h56,8'h78};
        page_pg_buf[0] = 8'h55;  page_pg_buf[1] = 8'haa;   page_pg_buf[2] = 8'h00;
        page_pg_buf[3] = 8'hff;  page_pg_buf[4] = 8'haa;   page_pg_buf[5] = 8'h55;
        page_pg_buf[6] = 8'hff;  page_pg_buf[7] = 8'h00;   page_pg_buf[8] = 8'h12;
        page_pg_buf[9] = 8'h34;  page_pg_buf[10] = 8'h56;  page_pg_buf[11] = 8'h78;
        PAGE_PROGRAM_DIFF_DATA(12,24'h000000);
        //#(`tPW_MAX);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;
        READ_DATA_BYTES(4,24'h000000);
        READ_DATA_BYTES(4,24'h000004);
        READ_DATA_BYTES(4,24'h000008);
        READ_DATA_BYTES(4,24'h00000c);

        WRITE_ENABLE;
        //page_wr_buf = {8'haa,8'h55,8'hff,8'h00,8'h55,8'haa,8'h00,8'hff,8'hab,8'hcd,8'hef,8'h01};
        page_wr_buf[0] = 8'haa;  page_wr_buf[1] = 8'h55;   page_wr_buf[2] = 8'hff;
        page_wr_buf[3] = 8'h00;  page_wr_buf[4] = 8'h55;   page_wr_buf[5] = 8'haa;
        page_wr_buf[6] = 8'h00;  page_wr_buf[7] = 8'hff;   page_wr_buf[8] = 8'hab;
        page_wr_buf[9] = 8'hcd;  page_wr_buf[10] = 8'hef;  page_wr_buf[11] = 8'h01;
        PAGE_WRITE_DIFF_DATA(12,24'h000000);
        //#(`tPW_MAX);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;
        READ_DATA_BYTES(4,24'h000000);
        READ_DATA_BYTES(4,24'h000004);
        READ_DATA_BYTES(4,24'h000008);
        READ_DATA_BYTES(4,24'h00000c);

        WRITE_ENABLE;
        PAGE_ERASE(24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hff,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hfe,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hfd,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hfb,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hf7,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hef,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hdf,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'hbf,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(1,8'h7f,24'h000000);
        while(U_M45PE80.status_reg[0] == 1)   READ_STATUS_REGISTER;        
        READ_DATA_BYTES(1,24'h000000);
        WRITE_ENABLE;
        PAGE_ERASE(24'h000000);
        #(`tPE_MAX);

//================================================================================
//check all instructions druing an erase,write or program cycle is in progress.
//================================================================================
        $display("=================================================================================================");
        $display("%t: TESTING1: All instructions are executed while an erase,program,write cycle is in progress.",$realtime);
        $display("=================================================================================================");
        WRITE_ENABLE;
        SECTOR_ERASE(24'h000000);       //Sector Erase begin, WIP = 1
        //PAGE_ERASE(24'h010000);
        //PAGE_WRITE_SAME_DATA(2,8'h68,24'h000000);
        WRITE_ENABLE;
        WRITE_DISABLE;
        READ_IDENTIFICATION;
        READ_STATUS_REGISTER;
        READ_DATA_BYTES(2,24'h000100);
        READ_DATA_BYTES_FAST(2,24'h000100);
        PAGE_PROGRAM_SAME_DATA(2,8'haa,24'h000000);
        //#(`tPP_MAX+100);
        PAGE_WRITE_SAME_DATA(2,8'h00,24'h01ff00);
        //#(`tPW_MAX+100);
        PAGE_ERASE(24'h010000);
        //#(`tPE_MAX);
        SECTOR_ERASE(24'h000000);
        //#(`tSE_MAX);
         DEEP_POWER_DOWN;
        //#(`tDP);
        RELEASE_FROM_DEEP_POWER_DOWN;
        //#(`tRDP);
        #(`tSE_MAX);       //Sector Erase Cycle finish

//=======================================
//check hardware write protect
//=======================================
        $display("=================================================================");
        $display("%t: TESTING2: Memory hardware write protect by W input.",$realtime);
        $display("=================================================================");
        W = 1'b0;                       //wr_protect,first 256 pages become read only
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(2,8'haa,24'h000000); //program "aa" to page0
        #(`tPP_MAX+100);
        READ_DATA_BYTES(2,24'h000000);

        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(2,8'haa,24'h010000); //program "aa" to page256
        #(`tPP_MAX+100);
        RESET = 1'b0;
        #(`tRLRH);
        RESET = 1'b1;
        READ_DATA_BYTES_FAST(2,24'h010000);
        W = 1'b1;
        //-------------------
        W = 1'b0;                       //wr_protect
        WRITE_ENABLE;
        PAGE_WRITE_SAME_DATA(2,8'haa,24'h00ff00);   //write "aa" to page255 
        #(`tPW_MAX+100);
        READ_DATA_BYTES(2,24'h00ff00);

        WRITE_ENABLE;
        PAGE_WRITE_SAME_DATA(2,8'haa,24'h0fff00);   //write "aa" to page4095
        #(`tPW_MAX+100);
        READ_DATA_BYTES_FAST(2,24'h0fff00);
        W = 1'b1;
        //-------------------
        W = 1'b1;                       //not wr_protect
        #(`tWHSL);
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(2,8'h55,24'h000000); //program "55" to page0
        #(`tPP_MAX+100);
        READ_DATA_BYTES(2,24'h000000);

        WRITE_ENABLE;
        PAGE_WRITE_SAME_DATA(2,8'h55,24'h010000);   //write "55" to page256
        #(`tPW_MAX+100);
        READ_DATA_BYTES_FAST(2,24'h010000);
        //--------------------
        W = 1'b0;                       //wr protect
        WRITE_ENABLE;
        PAGE_ERASE(24'h000000);                     //erase page 0
        #(`tPE_MAX);
        READ_DATA_BYTES(2,24'h000000);

        WRITE_ENABLE;
        PAGE_ERASE(24'h010000);                     //erase page 256
        #(`tPE_MAX);
        READ_DATA_BYTES(2,24'h010000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h000000);                   //erase sector 0
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h000000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h010000);                   //erase sector 1
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h010000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h020000);                   //erase sector 2
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h020000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h030000);                   //erase sector 3
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h030000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h040000);                   //erase sector 4
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h040000);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h050000);                   //erase sector 5
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h050000);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h060000);                   //erase sector 6
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h060000);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h070000);                   //erase sector 7
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h070000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h080000);                   //erase sector 8
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h080000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h090000);                   //erase sector 9
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h090000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h0a0000);                   //erase sector a
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h0a0000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h0b0000);                   //erase sector b
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h0b0000);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h0c0000);                   //erase sector c
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h0c0000);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h0d0000);                   //erase sector d
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h0d0000);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h0e0000);                   //erase sector e
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h0e0000);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h0f0000);                   //erase sector f
        #(`tSE_MAX);
        READ_DATA_BYTES(2,24'h0f0000);

        W = 1'b1;

//=============================================================================
//check the address increases or rolls over during read and write operation
//=============================================================================
        $display("==========================================================================================");
        $display("%t: TESTING3: Memory Write,Program,Erase,Read operation and address roll over.",$realtime);
        $display("==========================================================================================");
        W = 1'b1;
        #(`tWHSL);
        WRITE_ENABLE;
        PAGE_ERASE(24'h000000);         //erase page 0
        #(`tPE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h000000);       //erase sector 0
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h010000);       //erase sector 1
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h020000);       //erase sector 2
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h030000);       //erase sector 3
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h040000);       //erase sector 4
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h050000);       //erase sector 5
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h060000);       //erase sector 6
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h070000);       //erase sector 7
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h080000);       //erase sector 8
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h090000);       //erase sector 9
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h0a0000);       //erase sector a
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h0b0000);       //erase sector b
        #(`tSE_MAX);

        WRITE_ENABLE;
        SECTOR_ERASE(24'h0c0000);       //erase sector c
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h0d0000);       //erase sector d
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h0e0000);       //erase sector e
        #(`tSE_MAX);
        
        WRITE_ENABLE;
        SECTOR_ERASE(24'h0f0000);       //erase sector f
        #(`tSE_MAX);

        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(2,8'h66,24'h0000ff);
        #(`tPP_MAX+100);                //page program from byte 255 in page 0, address roll over in write operation.

        READ_DATA_BYTES(2,24'h000000);  //read data addressed "00h" and "01h"
        READ_DATA_BYTES(2,24'h0000ff);  //read data addressed "ffh" and "100h"

        WRITE_ENABLE;
        PAGE_WRITE_SAME_DATA(2,8'h88,24'h0fffff);
        #(`tPW_MAX+100);                //page write from byte 255 in page 4095(last page), address roll over in write operation.

        READ_DATA_BYTES(2,24'h0fff00);  //read data addressed "fff00h" and "fff01h"
        READ_DATA_BYTES(2,24'h0fffff);  //read data addressed "fffffh" and "00000h", address roll over in read

//=================================================================
//check the behavior of memory regarding deep power down mode
//=================================================================
        $display("===============================================================================");
        $display("%t: TESTING4: Memory Deep Power Down and Release Deep Power Down instruction.",$realtime);
        $display("===============================================================================");
        DEEP_POWER_DOWN;
        #(`tDP);
        RELEASE_FROM_DEEP_POWER_DOWN;
        //#100;
        //S = 1'b0;
        //#(`tRDP-100);
        //RELEASE_FROM_DEEP_POWER_DOWN;
        #(`tRDP);
        //--------------------
        DEEP_POWER_DOWN;
        //#100;
        //S = 1'b0;
        //#(`tDP-100);
        //DEEP_POWER_DOWN;    // all instructions are execute during Deep Power Down mode
        #(`tDP);
        WRITE_ENABLE;
        WRITE_DISABLE;
        READ_IDENTIFICATION;
        READ_STATUS_REGISTER;
        READ_DATA_BYTES(2,24'h000000);
        READ_DATA_BYTES_FAST(2,24'h000000);
        PAGE_PROGRAM_SAME_DATA(2,8'haa,24'h000000);
        #(`tPP_MAX+100);
        PAGE_WRITE_SAME_DATA(2,8'h00,24'h01ff00);
        #(`tPW_MAX+100);
        PAGE_ERASE(24'h010000);
        #(`tPE_MAX);
        SECTOR_ERASE(24'h000000);
        #(`tSE_MAX);
         DEEP_POWER_DOWN;
        #(`tDP);
        RELEASE_FROM_DEEP_POWER_DOWN;
        #(`tRDP);
        DEEP_POWER_DOWN;
        #(`tDP);
        VCC = 1'b0;         //Deep Power Down is stoped by Power off
        #100;
/////////////////////////////////////////////////////////////////////        
        VCC = 1'b1;         //power on
        #1;
        #(`tVSL);
        #(`tPUW_MAX);
        S = 1'b0;
        //#10;
        //S = 1'b1;
        //RESET = 1'b1;
        //#10;
        //RESET = 1'b0;       //hardware reset
        //#(`tRLRH);
        //RESET = 1'b1;
        //-----------------------------
        READ_STATUS_REGISTER;
        
        WRITE_ENABLE;
        PAGE_PROGRAM_SAME_DATA(2,8'h68,24'hffff00);
        #(`tPP_MAX+100);
        READ_DATA_BYTES(2,24'hffff00);

        $finish;       
end
//===============================================
//Stimuli task definition
//===============================================
/////////////////////////////////////////////////
task WRITE_ENABLE;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);
    for(i=0;i<=7;i=i+1)
    begin
        if((i==5)||(i==6))  D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time, and /S active setup time with #(`tSLCH-`tDVCH)
        C = 1'b1;
        #(`tCH+2);          //Clock High Time
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task WRITE_DISABLE;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if(i==5) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task READ_IDENTIFICATION;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==1)||(i==2)) D = 1'b0;
        else D = 1'b1;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    //------------------read 24bit id
    for(i=0;i<=7;i=i+1)
    begin
        C = 1'b1;
        id1 = {id1[7:0],Q};
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2);
    end
    for(i=0;i<=7;i=i+1)
    begin
        C = 1'b1;
        id2 = {id2[7:0],Q};
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2);
    end
    for(i=0;i<=7;i=i+1)
    begin
        C = 1'b1;
        id3 = {id3[7:0],Q};
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2);
    end
    $display("%t: Manufacturer    = [%h]",$realtime,id1);
    $display("%t: Memory_type     = [%h]",$realtime,id2);
    $display("%t: Memory_capacity = [%h]",$realtime,id3);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task READ_STATUS_REGISTER;
begin
    //------------------instruction
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==5)||(i==7)) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    //------------------read status register
    for(i=0;i<=7;i=i+1)
    begin
        C = 1'b1;
        sr = {sr[6:0],Q};
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2);
    end
    //if((sr[0] == 1'b0)) $display("%t: STATUS_REGISTER = [%b]",$realtime,sr);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task READ_DATA_BYTES;
input n;
input[23:0] address;
integer n;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==6)||(i==7)) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------address
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    //------------------read data bytes
    for(i=1;i<=n;i=i+1)
    begin
        address = U_M45PE80.memory_address[`MEM_ADDR_BITS-1:0];
        for(j=0;j<=7;j=j+1)
        begin
            C = 1'b1;
            read_dat = {read_dat[6:0],Q};
            #(`tRH);
            C = 1'b0;
            #(`tRL);
        end
        $display("%t: READ RESULT: ADDRESS = [%h], DATA = [%h]",$realtime,address,read_dat);
    end
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task READ_DATA_BYTES_FAST;
input n;
input[23:0] address;
integer n;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==4)||(i==6)||(i==7)) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------address
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------dummy
    for(i=0;i<=7;i=i+1)
    begin
        D = address[7-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    //------------------read data bytes
    for(i=1;i<=n;i=i+1)
    begin
        address = U_M45PE80.memory_address[`MEM_ADDR_BITS-1:0];
        for(j=0;j<=7;j=j+1)
        begin
            C = 1'b1;
            read_dat = {read_dat[6:0],Q};
            #(`tCH+2);
            C = 1'b0;
            #(`tCL+2);
        end
        $display("%t: FAST READ RESULT: ADDRESS = [%h], DATA = [%h]",$realtime,address,read_dat);
    end
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task PAGE_WRITE_DIFF_DATA;
input n;
input[23:0] address;        //the accessed location's address
reg[7:0] data;
integer n;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==4)||(i==6)) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        //RESET = 1'b0;       //hu
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------address
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        //RESET = 1'b0;       //hu
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------write data
    for(i=0;i<=n-1;i=i+1)
    begin
        //data = page_wr_buf[`PGBUF_MAX-1-i];
        data = page_wr_buf[i];
        for(j=0;j<=7;j=j+1)
        begin
            D = data[7-j];
            #(`tDVCH);      //data setup time
            C = 1'b1;
            //RESET = 1'b0;   //hu
            #(`tCH+2);
            C = 1'b0;
            #(`tCL+2-`tDVCH);
        end
    end
    //------------------
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
    //#(`tRLRH);              //hu
    //RESET = 1'b1;           //hu
end
endtask

/////////////////////////////////////////////////
task PAGE_WRITE_SAME_DATA;
input n;                    //the number of data byte that be written in
input[7:0] data;            //the data written in memory
input[23:0] address;        //the accessed location's address
integer n;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==4)||(i==6)) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        //RESET = 1'b0;     //hu
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------address
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        //RESET = 1'b0;       //hu
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------write data
    for(i=0;i<=n-1;i=i+1)
    begin
        for(j=0;j<=7;j=j+1)
        begin
            D = data[7-j];
            #(`tDVCH);      //data setup time
            C = 1'b1;
            //RESET = 1'b0;   //hu
            #(`tCH+2);
            C = 1'b0;
            #(`tCL+2-`tDVCH);
        end
    end
    //------------------
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
    #(`tRLRH);          //hu
    RESET = 1'b1;       //hu
end
endtask
/////////////////////////////////////////////////
task PAGE_PROGRAM_DIFF_DATA;
input n;
input[23:0] address;        //the accessed location's address
reg[7:0] data;
integer n;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if(i==6) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------address
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------write data
    for(i=0;i<=n-1;i=i+1)
    begin
        //data = page_pg_buf[`PGBUF_MAX-1-i];
        data = page_pg_buf[i];
        for(j=0;j<=7;j=j+1)
        begin
            D = data[7-j];
            #(`tDVCH);      //data setup time
            C = 1'b1;
            #(`tCH+2);
            C = 1'b0;
            #(`tCL+2-`tDVCH);
        end
    end
    //------------------
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task PAGE_PROGRAM_SAME_DATA;
input n;                    //the number of data byte that be written in
input[7:0] data;            //the data written in memory
input[23:0] address;        //the accessed location's address
integer n;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if(i==6) D = 1'b1;
        else D = 1'b0;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------address
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    //------------------write data
    for(i=0;i<=n-1;i=i+1)
    begin
        for(j=0;j<=7;j=j+1)
        begin
            D = data[7-j];
            #(`tDVCH);      //data setup time
            C = 1'b1;
            #(`tCH+2);
            C = 1'b0;
            #(`tCL+2-`tDVCH);
        end
    end
    //------------------
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task PAGE_ERASE;
input[23:0] address;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==2)||(i==5)) D = 1'b0;
        else D = 1'b1;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task SECTOR_ERASE;
input[23:0] address;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==2)||(i==5)||(i==6)||(i==7)) D = 1'b0;
        else D = 1'b1;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    for(i=0;i<=23;i=i+1)
    begin
        D = address[23-i];
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task DEEP_POWER_DOWN;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==1)||(i==5)||(i==6)) D = 1'b0;
        else D = 1'b1;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
task RELEASE_FROM_DEEP_POWER_DOWN;
begin
    S = 1'b1;
    #(`tCHSL);              ///S not active hold time
    S = 1'b0;
    #(`tSLCH-`tDVCH);       ///S active setup time
    for(i=0;i<=7;i=i+1)
    begin
        if((i==1)||(i==3)||(i==5)) D = 1'b0;
        else D = 1'b1;
        #(`tDVCH);          //data setup time
        C = 1'b1;
        #(`tCH+2);
        C = 1'b0;
        #(`tCL+2-`tDVCH);
    end
    #(`tDVCH);
    #(`tCHSH);              ///S active hold time
    S = 1'b1;
    #(`tSHSL);              ///S Deselect time
end
endtask
/////////////////////////////////////////////////
endmodule