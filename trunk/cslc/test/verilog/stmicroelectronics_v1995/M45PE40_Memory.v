/////////////////////////////////////////////////////////////////////////////////////////
//
// File:           - M45PE40_Memory.v
// Date:           - July 2004
// Author:         - Xue-feng Hu at MPG Memory Competence Center of China
// Description:    - M45PE40 SPI Bus Flash Memory Verilog Simulation Model
// Revision:       - Version 1.3
// Quotation:      - No bugs, all are features. 
//
/////////////////////////////////////////////////////////////////////////////////////////
// Revision History     Description
//             0.9:     2004/3/15 1st Release
//             1.0:     2004/3/26 build a new "Macro" file for M45PE40
//             1.1:     2004/4/30 modify the behavior of "PAGE_WRITE" and "PAGE_PROGRAM"
//             1.2:     2004/5/28 correct the behavior of "RESET"
//             1.3:     2004/7/28 update the "Sector Erase Cycle Time"
//
/////////////////////////////////////////////////////////////////////////////////////////
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
/////////////////////////////////////////////////////////////////////////////////////////

`include "M45PE40_Macro.v"
`timescale 1ns/1ns

//=====================================
// M45PE40 memory simulation model
//=====================================
module M45PE40  (
                    C,
                    D,
                    Q,
                    S,
                    W,
                    RESET,
                    VCC,
                    VSS
                );

//=====================================
// I/O signal definition
//=====================================
input   C;              //input serial clock
input   D;              //serial data input
input   S;              //Chip Select
input   W;              //write protect,active is low
input   RESET;
input   VCC;
input   VSS;
output  Q;              //serial data output

//===================================================================
//define "flag variable", reflecting the device operation status
//===================================================================
integer i,sr_bit;

reg bit_counter_en,bit_counter_ld;
reg dout,wr_protect,byte_ok,write_data_byte_ok;
reg ins_rej,hw_rst,power_on,power_off,power_on_rst;
reg write_en_id,write_dis_id,page_erase_id,sector_erase_id,deep_pd_id,release_pd_id;
reg instruction_byte,address_h_byte,address_m_byte,address_l_byte,dummy_byte,data_byte;
reg read_data_bytes,read_data_bytes_fast,page_write,page_program,page_erase,sector_erase;
reg deep_pd_delay,release_pd_delay,not_deep_pd,not_release_pd,device_power_down;

reg[1:0] mode;
reg[7:0] status_reg;
reg[7:0] shift_in_reg;
reg[7:0] data_out_buf;
reg[3:0] operation;
reg[3:0] instruction;
reg[7:0] instruction_code;
reg[7:0] bit_counter;
reg[7:0] address_h_code;
reg[7:0] address_m_code;
reg[7:0] address_l_code;
reg[23:0] device_id;
reg[23:0] memory_address;
reg[`PAGE_ADDR_BITS-1:0] page_address;
reg[`SECTOR_ADDR_BITS-1:0] sector_address;
reg[`DATA_BITS-1:0] memory[`MEM_SIZE-1:0];
reg[`DATA_BITS-1:0] data_latch[`PAGE_SIZE-1:0];

//===============================================
//define variable regarding timing check
//===============================================
reg  r_S,f_S,r_C,r_Cr,f_C,f_W,r_W,r_RESET,f_RESET,r_VCC,din_change;
time Tcr,t_rCr,t_rCr1,Tc,current_time;
time tVSL,tCH,tCL,tSLCH,tCHSL,tDVCH,tCHDX;
time tCHSH,tSHCH,tSHSL,tRHSL,tRLRH,tSHRH,tWHSL,tSHWL;
time t_rS,t_fS,t_rC,t_fC,t_d,t_rC1,t_fW,t_rW,t_rVCC,t_rRESET,t_fRESET;

//=========================================================
//define parameter regarding instruction
//=========================================================
parameter       WRITE_ENABLE            = 4'b0001;
parameter       WRITE_DISABLE           = 4'b0010;
parameter       READ_IDENTIFICATION     = 4'b0011;
parameter       READ_STATUS_REGISTER    = 4'b0100;
parameter       READ_DATA_BYTES         = 4'b0101;
parameter       READ_DATA_BYTES_FAST    = 4'b0110;
parameter       PAGE_WRITE              = 4'b0111;
parameter       PAGE_PROGRAM            = 4'b1000;
parameter       PAGE_ERASE              = 4'b1001;
parameter       SECTOR_ERASE            = 4'b1010;
parameter       DEEP_POWER_DOWN         = 4'b1011;
parameter       RELEASE_FROM_POWER_DOWN = 4'b1100;

//=========================================================
//define parameter regarding operation
//=========================================================
parameter       EN_WRITE                = 4'b0001;
parameter       DIS_WRITE               = 4'b0010;
parameter       READ_SR_OUT             = 4'b0011;
parameter       READ_ID                 = 4'b0100;
parameter       READ_DATA_OUT           = 4'b0101;
parameter       READ_DATA_OUT_FAST      = 4'b0110;
parameter       PAGE_WRITE_IN           = 4'b0111;
parameter       PAGE_PROGRAM_IN         = 4'b1000;
parameter       ERASE_PAGE              = 4'b1001;
parameter       ERASE_SECTOR            = 4'b1010;
parameter       ENTER_DEEP_POWER_DOWN   = 4'b1011;
parameter       RELEASE_DEEP_POWER_DOWN = 4'b1100;

//=========================================================
//define parameter regarding device mode
//=========================================================
parameter       device_no_power_mode    = 2'b00;
parameter       active_power_mode       = 2'b01;
parameter       device_standby_mode     = 2'b10;
parameter       deep_power_down_mode    = 2'b11;

//=========================================================
parameter       manufacturer_id         = 8'h20;
parameter       memory_type             = 8'h40;
parameter       memory_capacity         = 8'h13;

//===============================================
//"variable" initialization
//===============================================
initial
begin
    mode = device_no_power_mode;
    power_on        = 1'b0;
    power_off       = 1'b1;
    power_on_rst    = 1'b0;
    not_deep_pd     = 1'b0;
    not_release_pd  = 1'b0;
end
//--------------------------------
assign Q = dout;
//--------------------------------
always@(power_on_rst)
begin
    if(power_on_rst == 1'b1)
    begin
        mode                 = device_standby_mode;
        power_on_rst         = 1'b0;
        status_reg           = 8'b00;
        operation            = 4'b0000;
        instruction          = 4'b0000;
        hw_rst               = 1'b0;
        ins_rej              = 1'b0;
        byte_ok              = 1'b0;
        write_data_byte_ok   = 1'b0;
        bit_counter_en       = 1'b0;
        deep_pd_id           = 1'b0;
        release_pd_id        = 1'b0;
        write_en_id          = 1'b0;
        write_dis_id         = 1'b0; 
        page_erase_id        = 1'b0;
        sector_erase_id      = 1'b0;
        instruction_byte     = 1'b0;
        address_h_byte       = 1'b0;
        address_m_byte       = 1'b0;
        address_l_byte       = 1'b0;
        dummy_byte           = 1'b0;
        data_byte            = 1'b0;
        read_data_bytes      = 1'b0;
        read_data_bytes_fast = 1'b0;
        page_write           = 1'b0;
        page_program         = 1'b0;
        page_erase           = 1'b0;
        sector_erase         = 1'b0;
        deep_pd_delay        = 1'b0;
        release_pd_delay     = 1'b0;
        wr_protect           = 1'b0;
        $display("%t, Notes: DEVICE POWER ON RESET OK!\n",$realtime);
    end
end

//==========================================
//Write Protect
//==========================================
always@(W)
begin
    if((W == 1'b0)&&(S == 1'b0))   wr_protect = 1'b1;
end

//==========================================
//Device Power On/Off
//==========================================
always@(VCC)
begin
    if(VCC == 1'b1)
    begin
        mode = device_standby_mode;
        r_VCC = 1'b1; t_rVCC = $time;        
        power_on = 1'b1; power_off = 1'b0; power_on_rst = 1'b1;
        $display("%t, Notes: DEVICE IS POWER-ON!\n",$realtime);
    end
//-----------------------------------------------
    else begin
        if(power_on == 1'b1)
            $display("%t, Notes: DEVICE IS POWER-OFF!\n",$realtime);
        if(mode == deep_power_down_mode)
            $display("%t, Notes: The Deep Power Down mode automatically stops at Power Off.\n",$realtime);
        power_on = 1'b0;
        power_off = 1'b1;
        device_power_down = 1'b0;
        mode = device_no_power_mode;
    end
end

//==========================================
//Device Hardware Reset
//==========================================
always@(RESET)
begin
    if(power_on == 1'b1)        //Power_on
    begin
        if(RESET == 1'b0)
        begin
            f_RESET  = 1'b1;
            t_fRESET = $time;
            if(S == 1'b1)
            begin
                if(status_reg[0] == 1'b1) $display("%t, Notes: Driving Reset Low while an internal operation is in process has no effect.\n",$realtime);
            end
            else begin
                hw_rst = 1'b1; //reset driven low before cs driven high (or sametime)
                if(operation == READ_ID)
                begin
                    dout = 1'bx;
                    #(`tSHQZ);                      //output disable time
                    dout = 1'bz;                    //data output(Q) is HiZ
                    operation = 4'b0000;
                    instruction = 4'b0000;
                    $display("%t, Warning: This READ IDENTIFICATION instruction is terminated because RESET pin is driven low.",$realtime);
                end
                if(operation == READ_SR_OUT)
                begin
                    dout = 1'bx;
                    #(`tSHQZ);
                    dout = 1'bz;                    //data output(Q) is HiZ
                    operation = 4'b0000;
                    instruction = 4'b0000;
                    $display("%t, Warning: This READ STATUS REGISTER instruction is terminated because RESET pin is driven low.",$realtime);
                end
                if(operation == READ_DATA_OUT)
                begin
                    dout = 1'bx;
                    #(`tSHQZ);
                    dout = 1'bz;                    //data output(Q) is HiZ
                    operation = 4'b0000;
                    $display("%t, Warning: This READ DATA BYTES instruction is terminated because RESET pin is driven low.",$realtime);
                end
                if(operation == READ_DATA_OUT_FAST)
                begin
                    dout = 1'bx;
                    #(`tSHQZ);
                    dout = 1'bz;                    //data output(Q) is HiZ
                    operation = 4'b0000;
                    $display("%t, Warning: This FAST READ DATA BYTES instruction is terminated because RESET pin is driven low.",$realtime);
                end
            end
        end
        //-----------------------------
        if(RESET == 1'b1)
        begin
            r_RESET  = 1'b1;
            t_rRESET = $time;
            if((S == 1'b0)&&(f_RESET == 1'b1))
            begin
                $display("%t, Error: RESET is driven high during chip select enable(memory is selected)!\n",$realtime); 
                $finish;
            end
            if(f_RESET == 1'b1)
            begin
                tRLRH = t_rRESET - t_fRESET;
                if(tRLRH < `tRLRH) 
                begin
                    $display("%t, Error: Reset Pluse Width(tRLRH) violated.\n",$realtime); 
                    $finish;
                end
            end
            if(r_S == 1'b1)
            begin
                tSHRH = t_rRESET - t_rS;
                if(tSHRH < `tSHRH)
                begin
                    $display("%t, Error: Chip deselect before RESET is de-asserted(tSHRH) conditon violated.\n",$realtime); 
                    $finish;
                end
            end
        end
    end
    else $display("%t, Warning: Device has not been Power-on before level change on RESET pin.\n",$realtime);
end

//=========================================================
//chip select driven low, device active.
//=========================================================
always@(negedge S)                          //Chip Select Enable.
begin
    if(power_on == 1'b1)
    begin
        f_S  = 1'b1;
        t_fS = $time;
        if(W == 1'b0) wr_protect = 1'b1;    //W=0 when chip slect, device in hardware protect mode
        if(r_VCC == 1'b1)
        begin
            r_VCC = 1'b0;
            tVSL = t_fS - t_rVCC;
            if(tVSL < `tVSL)
            begin
                $display("%t, Error: The time of VCC to /S low(tVSL) violated.\n",$realtime);
                $finish;
            end
        end
        if(r_RESET == 1'b1)
        begin
            r_RESET = 1'b0;
            tRHSL = t_fS - t_rRESET;
            if(tRHSL > `tRHSL)
            begin
                $display("%t, Error: Reset Recovery Time(tRHSL) violated.\n",$realtime); 
                $finish;
            end
        end
        if(RESET == 1'b1)
        begin
            if(deep_pd_delay == 1'b1)    not_deep_pd = 1'b1;
            if(release_pd_delay == 1'b1) not_release_pd = 1'b1;
            if(tVSL >= `tVSL)
            begin
                bit_counter_en = 1'b1;
                bit_counter_ld = 1'b1;      //enable the bit-counter
                instruction_byte = 1'b1;    //ready to get instruction code.
                mode = active_power_mode;
            end
        end
        else if(RESET == 1'b0)              //2004.5.24
        begin
            if(deep_pd_delay == 1'b1)    not_deep_pd = 1'b1;
            if(release_pd_delay == 1'b1) not_release_pd = 1'b1;
            if(tVSL >= `tVSL)
            begin
                bit_counter_en = 1'b1;
                bit_counter_ld = 1'b1;      //enable the bit-counter
                instruction_byte = 1'b1;    //ready to get instruction code.
                mode = active_power_mode;
                ins_rej = 1'b1;
            end
        end
    end
    else $display("%t, Warning: Device has not been Power-on before chip select enable!.\n",$realtime);
end

//=========================================================
//Serial data bit(on the "D" line) input
//=========================================================
always@(posedge C)
begin
    if(power_on == 1'b1)
    begin
         if(S == 1'b0)
         begin
             if((bit_counter_en == 1'b1)&&(bit_counter_ld == 1'b1))
             begin
                 bit_counter = 3'b111;
                 shift_in_reg = {shift_in_reg[6:0],D};    //data bit shift in
                 if(operation == PAGE_WRITE_IN)           write_data_byte_ok = 1'b0;
                 if(operation == PAGE_PROGRAM_IN)         write_data_byte_ok = 1'b0;
                 if(operation == ENTER_DEEP_POWER_DOWN)   deep_pd_id         = 1'b0;
                 if(operation == RELEASE_DEEP_POWER_DOWN) release_pd_id      = 1'b0;
                 if(operation == EN_WRITE)                write_en_id        = 1'b0;
                 if(operation == DIS_WRITE)               write_dis_id       = 1'b0;
                 if(operation == ERASE_PAGE)              page_erase_id      = 1'b0;
                 if(operation == ERASE_SECTOR)            sector_erase_id    = 1'b0;
             end
             else if((bit_counter_en == 1'b1)&&(bit_counter_ld == 1'b0))
             begin
                 bit_counter = bit_counter - 3'b001;
                 shift_in_reg = {shift_in_reg[6:0],D};   //data bit shift in
             end
             if((bit_counter_en == 1'b1)&&(bit_counter == 3'b000))
             begin                                       //8 bit serial data input ok
                 byte_ok = 1'b1;
                 bit_counter_en = 1'b0;                  //disable the bit-counter
             end
             else if(bit_counter_en == 1'b1) bit_counter_ld = 1'b0;
         end
         else $display("%t, Warning: Device is in standby mode! Falling edge on /S is required!\n",$realtime);
    end
    else $display("%t, Warning: Device has not been Power-on before clock starts!\n",$realtime);
end

//=========================================================
//input instruction decode, address latch, data latch
//=========================================================
always@(negedge C)
begin
    //-------------------------------------------instruction byte input and decode
    if((mode == active_power_mode)&&(instruction_byte == 1'b1)&&(byte_ok == 1'b1))
    begin
        byte_ok = 1'b0;
        instruction_byte = 1'b0;
        instruction_code = shift_in_reg;
        case(instruction_code)
            8'b0000_0110:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This WRITE ENABLE instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = WRITE_ENABLE;
                end
            8'b0000_0100:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This WRITE DISABLE instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = WRITE_DISABLE;
                end
            8'b1001_1111:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This READ IDENTIFICATION instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else begin instruction = READ_IDENTIFICATION; i = 24; end
                end
            8'b0000_0101:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This READ STATUS REGISTER instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else begin instruction = READ_STATUS_REGISTER; sr_bit = 8; end
                end
            8'b0000_0011:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This READ DATA BYTES instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = READ_DATA_BYTES;
                end
            8'b0000_1011:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This FAST READ DATA BYTES instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = READ_DATA_BYTES_FAST;
                end
            8'b0000_1010:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This PAGE WRITE instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = PAGE_WRITE;
                end
            8'b0000_0010:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This PAGE PROGRAM instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = PAGE_PROGRAM;
                end
            8'b1101_1011:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This PAGE ERASE instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = PAGE_ERASE;
                end
            8'b1101_1000:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This SECTOR ERASE instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = SECTOR_ERASE;
                end
            8'b1011_1001:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This DEEP POWER DOWN instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = DEEP_POWER_DOWN;
                end
            8'b1010_1011:
                begin
                    if(ins_rej == 1'b1)
                    begin
                        ins_rej = 1'b0;
                        $display("%t, Warning: This WRITE ENABLE instruction is rejected because RESET pin is low when chip select enable.",$realtime);
                    end
                    else instruction = RELEASE_FROM_POWER_DOWN;
                end
            default:
                begin $display("%t, Warning: This instruction code[%b] is undefined!\n",$realtime,instruction_code); end
        endcase
    end
    //-----------------------address high byte input
    if((mode == active_power_mode)&&(address_h_byte == 1'b1)&&(byte_ok == 1'b1))
    begin
        byte_ok = 1'b0;
        address_h_byte = 1'b0;
        address_h_code = shift_in_reg;  //saves address high byte
        address_m_byte = 1'b1;          //receives address middle byte
        bit_counter_en = 1'b1;
        bit_counter_ld = 1'b1;
    end
    //-----------------------address middle byte input
    if((mode == active_power_mode)&&(address_m_byte == 1'b1)&&(byte_ok == 1'b1))
    begin
        byte_ok = 1'b0;
        address_m_byte = 1'b0;
        address_m_code = shift_in_reg;  //saves address middle byte
        address_l_byte = 1'b1;          //receives address low byte
        bit_counter_en = 1'b1;
        bit_counter_ld = 1'b1;
    end
    //-----------------------address low byte input
    if((mode == active_power_mode)&&(address_l_byte == 1'b1)&&(byte_ok == 1'b1))
    begin
        byte_ok = 1'b0;
        address_l_byte = 1'b0;
        address_l_code = shift_in_reg;  //save address low byte, memory address received
        memory_address = {address_h_code,address_m_code,address_l_code};
        if(page_erase == 1'b1)          //receives address in Page Erase Instruction
        begin
            page_erase = 1'b0;
            page_erase_id = 1'b1;
            operation = ERASE_PAGE;
        end
        if(sector_erase == 1'b1)        //receives address in Sector Erase Instruction
        begin
            sector_erase = 1'b0;
            sector_erase_id = 1'b1;
            operation = ERASE_SECTOR;
        end
        if(read_data_bytes == 1'b1)     //receives address in Read Data Bytes Instruction
        begin
            read_data_bytes = 1'b0;
            operation = READ_DATA_OUT;
            i = 8;
        end        
        if(read_data_bytes_fast == 1'b1)//receives address in Fast Read Data Bytes Instruction
        begin
            read_data_bytes_fast = 1'b0;
            dummy_byte = 1'b1;          //receives dummy byte if "READ DATA BYTES AT HIGHER SPEED" instruction
            bit_counter_en = 1'b1;
            bit_counter_ld = 1'b1;
        end
        if(page_write == 1'b1)
        begin
            page_write = 1'b0; data_byte = 1'b1;    //receives data byte if "PAGE WRITE" instruction
            bit_counter_en = 1'b1; bit_counter_ld = 1'b1;
            operation = PAGE_WRITE_IN;
            page_address = memory_address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-`PAGE_ADDR_BITS];
            for(i=1;i<=`PAGE_SIZE;i=i+1)            //load the data value of bytes of addressed page
            begin
                data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]] = memory[memory_address[`MEM_ADDR_BITS-1:0]];
                if(memory_address[`PAGE_OFFSET_BITS-1:0] == `PAGE_OFFSET_BITS'hff)
                    memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
                else
                    memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
            end
        end
        if(page_program == 1'b1)
        begin
            page_program = 1'b0; data_byte = 1'b1;  //receives data byte if "PAGE WRITE" instruction
            bit_counter_en = 1'b1; bit_counter_ld = 1'b1;
            operation = PAGE_PROGRAM_IN;
            page_address = memory_address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-`PAGE_ADDR_BITS];
            for(i=1;i<=`PAGE_SIZE;i=i+1)            //load the data value of bytes of addressed page
            begin
                data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]] = memory[memory_address[`MEM_ADDR_BITS-1:0]];
                if(memory_address[`PAGE_OFFSET_BITS-1:0] == `PAGE_OFFSET_BITS'hff)
                    memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
                else
                    memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
            end
        end
    end
    //-----------------------dummy byte input
    if((mode == active_power_mode)&&(dummy_byte == 1'b1)&&(byte_ok == 1'b1))
    begin
        byte_ok = 1'b0;
        dummy_byte = 1'b0;
        operation = READ_DATA_OUT_FAST;
        i = 8;
    end
    //-----------------------data bytes input
    if((mode == active_power_mode)&&(data_byte == 1'b1)&&(byte_ok == 1'b1))
    begin
        byte_ok = 1'b0;
        if(operation == PAGE_WRITE_IN)
        begin                                       //change the value of address bytes
            data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]] = shift_in_reg;
            if(memory_address[`PAGE_OFFSET_BITS-1:0] == `PAGE_OFFSET_BITS'hff)
                memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
            else
                memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
        end
        if(operation == PAGE_PROGRAM_IN)
        begin                                       //only change bit from 1 to 0
            data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]] = data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]] & shift_in_reg;
            if(memory_address[`PAGE_OFFSET_BITS-1:0] == `PAGE_OFFSET_BITS'hff)
                memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
            else
                memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
        end
        bit_counter_en = 1'b1;
        bit_counter_ld = 1'b1;
        write_data_byte_ok = 1'b1;                  //set flag which indicates one byte data latch in
    end
    //-----------------------------------------------------
    if(operation == READ_DATA_OUT)
    begin
        if(i==0)
        begin
            if(memory_address[`MEM_ADDR_BITS-1:0] == `MEM_ADDR_BITS'h7ffff)
                memory_address[`MEM_ADDR_BITS-1:0] = `MEM_ADDR_BITS'h00000;
            else memory_address[`MEM_ADDR_BITS-1:0] = memory_address[`MEM_ADDR_BITS-1:0] + `MEM_ADDR_BITS'h00001;
            i = 8;
        end
        dout = 1'bx;                //output "x" between last data and next data
        #(`tCLQV);                  //Clock low to Output Valid
        data_out_buf = memory[memory_address[`MEM_ADDR_BITS-1:0]];
        dout = data_out_buf[i-1];
        i = i-1;
    end
    //-----------------------------------------------------
    if(operation == READ_DATA_OUT_FAST)
    begin
        if(i==0)
        begin
            if(memory_address[`MEM_ADDR_BITS-1:0] == `MEM_ADDR_BITS'h7ffff)
                memory_address[`MEM_ADDR_BITS-1:0] = `MEM_ADDR_BITS'h00000;
            else memory_address[`MEM_ADDR_BITS-1:0] = memory_address[`MEM_ADDR_BITS-1:0] + `MEM_ADDR_BITS'h00001;
            i = 8;
        end
        dout = 1'bx;                //output "x" between last data and next data
        #(`tCLQV);                  //Clock low to Output Valid
        data_out_buf = memory[memory_address[`MEM_ADDR_BITS-1:0]];
        dout = data_out_buf[i-1];
        i = i-1;
    end
//---------------------------
    case(instruction)
//---------------------------
    WRITE_ENABLE:
    begin
        current_time = $time;
        instruction = 4'b0000;
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1)||(current_time - t_rVCC < `tPUW_MAX))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this WRITE ENABLE INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this WRITE_ENABLE INSTRUCTION is rejected!",$realtime);
            if(current_time - t_rVCC < `tPUW_MAX)
                $display("%t, Warning: Device ignores Write Enable(WREN) instruction during a time delay of tPUW!",$realtime);
        end
        else begin
            write_en_id = 1'b1;
            operation = EN_WRITE;
        end
    end
//---------------------------
    WRITE_DISABLE:
    begin
        instruction = 4'b0000;
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this WRITE DISABLE INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this WRITE_DISABLE INSTRUCTION is rejected!",$realtime);
        end
        else begin
            write_dis_id = 1'b1;
            operation = DIS_WRITE;
        end
    end
//---------------------------
    READ_IDENTIFICATION:
    begin
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1))
        begin
            instruction = 4'b0000;
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this READ_IDENTIFICATION INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this READ_IDENTIFICATION INSTRUCTION is rejected!",$realtime);
        end
        else begin
            device_id = {manufacturer_id,memory_type,memory_capacity};
            operation = READ_ID;
            if(i==0)
            begin
                i = 24;
            end
            dout = 1'bx;                //output "x" between last data and next data
            #(`tCLQV);                  //during the period of clock low to output valid, output "x" on Q line.
            dout = device_id[i-1];
            i = i-1;
        end
   end
//---------------------------
    READ_STATUS_REGISTER:
    begin
        if(device_power_down == 1'b1)
        begin
            instruction = 4'b0000;
            $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this READ_STATUS_REGISTER INSTRUCTION is rejected!",$realtime);
        end
        else begin
            operation = READ_SR_OUT;
            if(sr_bit==0)
            begin
                sr_bit = 8;
            end
            dout = 1'bx;                //output "x" between last data and next data
            #(`tCLQV);                  //Clock low to Output Valid
            dout = status_reg[sr_bit-1];
            sr_bit = sr_bit-1;
        end
    end
//---------------------------
    READ_DATA_BYTES:
    begin
        instruction = 4'b0000;          //clear "READ_DATA_BYTES" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this READ DATA BYTES INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this READ_DATA_BYTES INSTRUCTION is rejected!",$realtime);
        end
        else begin
            address_h_byte = 1'b1;      //receives address high byte
            bit_counter_en = 1'b1;
            bit_counter_ld = 1'b1;
            read_data_bytes = 1'b1;
        end
    end
//---------------------------
    READ_DATA_BYTES_FAST:
    begin
        instruction = 4'b0000;          //clear "READ_DATA_BYTES_FAST" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this FAST READ DATA BYTES INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this FAST_READ_DATA_BYTES INSTRUCTION is rejected!",$realtime);
        end
        else begin
            address_h_byte = 1'b1;      //receives address high byte
            bit_counter_en = 1'b1;
            bit_counter_ld = 1'b1;
            read_data_bytes_fast = 1'b1;
        end
    end
//---------------------------
    PAGE_WRITE:
    begin
        current_time = $time;
        instruction = 4'b0000;          //clear "PAGE WRITE" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1)||(current_time - t_rVCC < `tPUW_MAX))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this PAGE WRITE INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this PAGE_WRITE INSTRUCTION is rejected!",$realtime);
            if(current_time - t_rVCC < `tPUW_MAX)
                $display("%t, Warning: Device ignores Page Write(PW) instruction during a time delay of tPUW!",$realtime);
        end
        else begin
            if(status_reg[1] == 1'b1)   //before "PAGE_WRITE",WEL must be set
            begin
                page_write = 1'b1;
                address_h_byte = 1'b1;  //receives address high byte
                bit_counter_en = 1'b1;
                bit_counter_ld = 1'b1;
            end
            else $display("%t, Warning: Write Disable! Page Write instruction can not be accepted!",$realtime);
        end
    end
//---------------------------
    PAGE_PROGRAM:
    begin
        current_time = $time;
        instruction = 4'b0000;          //clear "PAGE PROGRAM" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1)||(current_time - t_rVCC < `tPUW_MAX))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this PAGE PROGRAM INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this PAGE_PROGRAM INSTRUCTION is rejected!",$realtime);
            if(current_time - t_rVCC < `tPUW_MAX)
                $display("%t, Warning: Device ignores Page Program(PP) instruction during a time delay of tPUW!",$realtime);
        end
        else begin
            if(status_reg[1] == 1'b1)   //before "PAGE_PROGRAM",WEL must be set
            begin
                page_program = 1'b1;
                address_h_byte = 1'b1;  //receives ddress high byte
                bit_counter_en = 1'b1;
                bit_counter_ld = 1'b1;
            end
            else $display("%t, Warning: Write Disable! Page Program instruction can not be accepted!",$realtime);
        end
    end
//---------------------------
    PAGE_ERASE:
    begin
        current_time = $time;
        instruction = 4'b0000;          //clear "PAGE ERASE" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1)||(current_time - t_rVCC < `tPUW_MAX))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this PAGE ERASE INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this PAGE_ERASE INSTRUCTION is rejected!",$realtime);
            if(current_time - t_rVCC < `tPUW_MAX)
                $display("%t, Warning: Device ignores Page Erase(PE) instruction during a time delay of tPUW!",$realtime);
        end
        else begin
            if(status_reg[1] == 1'b1)   //before "PAGE_WRITE",WEL must be set
            begin
                page_erase = 1'b1;
                address_h_byte = 1'b1;  //receives address high byte
                bit_counter_en = 1'b1;
                bit_counter_ld = 1'b1;
            end
            else $display("%t, Warning: Write Disable! Page Erase instruction can not be accepted!",$realtime);
        end
    end
//---------------------------
    SECTOR_ERASE:
    begin
        current_time = $time;
        instruction = 4'b0000;          //clear "SECTOR ERASE" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1)||(current_time - t_rVCC < `tPUW_MAX))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this SECTOR ERASE INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this SECTOR_ERASE INSTRUCTION is rejected!",$realtime);
            if(current_time - t_rVCC < `tPUW_MAX)
                $display("%t, Warning: Device ignores Sector Erase(SE) instruction during a time delay of tPUW!",$realtime);
        end
        else begin
            if(status_reg[1] == 1'b1)   //before "PAGE_WRITE",WEL must be set
            begin
                sector_erase = 1'b1;
                address_h_byte = 1'b1;  //receives address high byte
                bit_counter_en = 1'b1;
                bit_counter_ld = 1'b1;
            end
            else $display("%t, Warning: Write Disable! Sector Erase instruction can not be accepted!",$realtime);
        end
    end
//---------------------------
    DEEP_POWER_DOWN:
    begin
        instruction = 4'b0000;          //clear "DEEP POWER DOWN" instruction
        if((status_reg[0] == 1'b1)||(device_power_down == 1'b1))
        begin
            if(status_reg[0] == 1'b1)   //WIP is set, an erase,program,write cycle is in progress
                $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this DEEP POWER DOWN INSTRUCTION is rejected!",$realtime);
            if(device_power_down == 1'b1)
                $display("%t, Warning: Device is in DEEP POWER DOWN MODE, this DEEP_POWER_DOWN INSTRUCTION is rejected!",$realtime);
        end
        else begin
            deep_pd_id = 1'b1;
            operation = ENTER_DEEP_POWER_DOWN;
        end
    end
//---------------------------
    RELEASE_FROM_POWER_DOWN:
    begin
        instruction = 4'b0000;
        if(status_reg[0] == 1'b1)       //WIP is set, an erase,program,write cycle is in progress
            $display("%t, Warning: An Erase,Program or Write Cycle is in progress, this RELEASE FROM DEEP POWER DOWN INSTRUCTION is rejected!",$realtime);
        else begin
            release_pd_id = 1'b1;
            operation = RELEASE_DEEP_POWER_DOWN;
        end
    end
//---------------------------
    endcase
end

//===================================================================
//chip select driven high, trigger internal cycle and standby
//===================================================================
always@(posedge S)
begin                                   //finish read_sr while internal write cycle is in progress.
    if((status_reg[0] == 1'b1)&&(operation == READ_SR_OUT))
    begin
        dout = 1'bz;
        operation = 4'b0000;
        instruction = 4'b0000;
        //$display("%t, Notes: Read status register operation is finished.\n",$realtime);
    end
end
//-------------------------------------------------------------------
always@(posedge S)                      //chip select driven high,device disable.
begin
    mode = device_standby_mode;
    //----------------------------------//incorrect /S input checking
    if(instruction_byte == 1'b1)
    begin
        $display("%t, Error: /S is driven high during the instruction byte latched in.\n",$realtime);
        $finish;
    end
    if(address_h_byte == 1'b1)
    begin
        $display("%t, Error: /S is driven high during the high address byte latched in.\n",$realtime);
        $finish;
    end
    if(address_m_byte == 1'b1)
    begin
        $display("%t, Error: /S is driven high during the middle address byte latched in.\n",$realtime);
        $finish;
    end
    if(address_l_byte == 1'b1)
    begin
        $display("%t, Error: /S is driven high during the low address byte latched in.\n",$realtime);
        $finish;
    end
    if(dummy_byte == 1'b1)
    begin
        $display("%t, Error: /S is driven high during the dummy byte latched in.\n",$realtime);
        $finish;
    end
    //----------------------------------//Write Enable Instruction Execute
    if(operation == EN_WRITE)
    begin
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        if((write_en_id == 1'b1)&&(hw_rst == 1'b0))
        begin
            write_en_id = 1'b0;
            status_reg[1] = 1'b1;       //WEL is set
            $display("%t, Notes: WRITE ENABLE.\n",$realtime);
        end
        else begin
            if(write_en_id == 1'b0)
                $display("%t, Warning: This WRITE ENABLE instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This WRITE ENABLE instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //----------------------------------//Write Disable Instruction Execute
    if(operation == DIS_WRITE)
    begin
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        if((write_dis_id == 1'b1)&&(hw_rst == 1'b0))
        begin
            write_dis_id = 1'b0;
            status_reg[1] = 1'b0;       //WEL is reset
            $display("%t, Notes: WRITE DISABLE.\n",$realtime);
        end
        else begin 
            if(write_dis_id == 1'b0)
                $display("%t, Warning: This WRITE DISABLE instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This WRITE DISABLE instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //----------------------------------
    if(operation == READ_ID)
    begin
        dout = 1'bx;
        #(`tSHQZ);                      //output disable time 
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        instruction = 4'b0000;
        //$display("%t, Notes: Read identification operation is finished.\n",$realtime);
    end
    //----------------------------------
    if(operation == READ_SR_OUT)
    begin
        dout = 1'bx;
        #(`tSHQZ);
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        instruction = 4'b0000;
        //$display("%t, Notes: Read status register operation is finished.\n",$realtime);
    end
    //----------------------------------
    if(operation == READ_DATA_OUT)
    begin
        dout = 1'bx;
        #(`tSHQZ);
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        $display("%t, Notes: Read data bytes operation is finished.\n",$realtime);
    end
    //----------------------------------
    if(operation == READ_DATA_OUT_FAST)
    begin
        dout = 1'bx;
        #(`tSHQZ);
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        $display("%t, Notes: Fast Read data bytes operation is finished.\n",$realtime);
    end
    //----------------------------------/S is driven high after address in, the self-timed Page Write cycle is triggered
    if(operation == PAGE_WRITE_IN)
    begin
        dout = 1'bz;                                        //data output(Q) is HiZ
        data_byte = 1'b0;
        operation = 4'b0000;
        if((write_data_byte_ok == 1'b1)&&(hw_rst == 1'b0))  //trigger the self-timed Page Write cycle
        begin
            write_data_byte_ok = 1'b0;
            if((wr_protect == 1'b1)&&(page_address <= `PAGE_ADDR_BITS'h0ff))
                $display("%t, Warning: Device in the Hardware Protected mode, the first 256 pages can't be written in!\n",$realtime);
            else begin
                $display("%t, Notes: Page[%d] Write Cycle is started!",$realtime,page_address);
                status_reg[1] = 1'bx;
                //In order to avoid mistake caused by checking internal cycle by WEL, WEL is X during this cycle. 
                //because WEL bit will be reset at some unspecified time before the cycle is complete.
                status_reg[0] = 1'b1;                       //WIP is 1 during this cycle
                #(`tPW_MAX);   
                //Step one
                memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
                for(i=1;i<=`PAGE_SIZE;i=i+1)
                begin
                    memory[memory_address[`MEM_ADDR_BITS-1:0]] = `DATA_BITS'hff;
                    memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
                end
                //Step two
                memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
                for(i=1;i<=`PAGE_SIZE;i=i+1)
                begin
                    memory[memory_address[`MEM_ADDR_BITS-1:0]] = data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]];
                    memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
                end
                status_reg[1] = 1'b0;                       //WEL is reset
                status_reg[0] = 1'b0;                       //WIP is 0 when this cycle completed
                $display("%t, Notes: Page[%d] Write Cycle is completed!\n",$realtime,page_address);
            end
        end
        else begin
            if(write_data_byte_ok == 1'b0)
                $display("%t, Warning: This PAGE WRITE IN instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This PAGE WRITE IN instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //----------------------------------/S is driven high after address in, the self-timed Page Program cycle is triggered
    if(operation == PAGE_PROGRAM_IN)
    begin
        dout = 1'bz;                            //data output(Q) is HiZ
        data_byte = 1'b0;
        operation = 4'b0000;
        if((write_data_byte_ok == 1'b1)&&(hw_rst == 1'b0))
        begin                                   //Page Program
            write_data_byte_ok = 1'b0;
            if((wr_protect == 1'b1)&&(page_address <= `PAGE_ADDR_BITS'h0ff))
                $display("%t, Warning: Device in the Hardware Protected mode, the first 256 pages can't be Programmed!\n",$realtime);
            else begin
                $display("%t, Notes: Page[%d] Program Cycle is started!",$realtime,page_address);
                status_reg[1] = 1'bx;           //WEL is X during this cycle
                status_reg[0] = 1'b1;           //WIP is 1 during this cycle
                #(`tPP_MAX);
                memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
                 for(i=1;i<=`PAGE_SIZE;i=i+1)
                begin
                    memory[memory_address[`MEM_ADDR_BITS-1:0]] = data_latch[memory_address[`PAGE_OFFSET_BITS-1:0]];
                    memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
                end
                status_reg[1] = 1'b0;           //WEL is reset
                status_reg[0] = 1'b0;           //WIP is 0 when this cycle completed
                $display("%t, Notes: Page[%d] Program Cycle is completed!\n",$realtime,page_address);
            end
        end
        else begin
            if(write_data_byte_ok == 1'b0)
                $display("%t, Warning: This PAGE PROGRAM IN instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This PAGE PROGRAM IN instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //----------------------------------/S is driven high after address in, the self-timed Page Erase cycle is triggered
    if(operation == ERASE_PAGE)
    begin
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        page_address = memory_address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-`PAGE_ADDR_BITS];
        if((page_erase_id == 1'b1)&&(hw_rst == 1'b0))
        begin
            page_erase_id = 1'b0;
            if((wr_protect == 1'b1)&&(page_address <= `PAGE_ADDR_BITS'h0ff))
                $display("%t, Warning: Device in the Hardware Protected mode, the first 256 pages can't be erased!\n",$realtime);
            else begin
                $display("%t, Notes: Page[%d] Erase Cycle is started!",$realtime,page_address);
                status_reg[1] = 1'bx;   //WEL is X during this cycle 
                status_reg[0] = 1'b1;   //WIP is 1 during this cycle
                #(`tPE_MAX);
                memory_address[`PAGE_OFFSET_BITS-1:0] = `PAGE_OFFSET_BITS'h00;
                for(i=1;i<=`PAGE_SIZE;i=i+1)
                begin
                    memory[memory_address[`MEM_ADDR_BITS-1:0]] = `DATA_BITS'hff;
                    memory_address[`PAGE_OFFSET_BITS-1:0] = memory_address[`PAGE_OFFSET_BITS-1:0] + `PAGE_OFFSET_BITS'h01;
                end               
                status_reg[1] = 1'b0;   //WEL is reset
                status_reg[0] = 1'b0;   //WIP is 0 when this cycle completed
                $display("%t, Notes: Page[%d] Erase Cycle is completed!\n",$realtime,page_address);
            end
        end
        else begin
            if(page_erase_id == 1'b0)
                $display("%t, Warning: This ERASE PAGE instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This ERASE PAGE instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //----------------------------------/S is driven high after address in, the self-timed Sector Erase cycle is triggered
    if(operation == ERASE_SECTOR)
    begin
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        if(`SECTOR_ADDR_BITS == 1)
            sector_address = memory_address[`MEM_ADDR_BITS-1];
        else sector_address = memory_address[`MEM_ADDR_BITS-1:`MEM_ADDR_BITS-`SECTOR_ADDR_BITS];
        if((sector_erase_id == 1'b1)&&(hw_rst == 1'b0))
        begin
            sector_erase_id = 1'b0;
            if((wr_protect == 1'b1)&&(sector_address <= `SECTOR_ADDR_BITS'h0))
                $display("%t, Warning: Device in the Hardware Protected mode, the first 256 pages can't be erased!\n",$realtime);
            else begin
                $display("%t, Notes: Sector[%d] Erase Cycle is started!",$realtime,sector_address);
                status_reg[1] = 1'bx;   //WEL is X during this cycle
                status_reg[0] = 1'b1;   //WIP is 1 during this cycle
                //#(`SECTOR_SIZE*`tPE_MAX);
                #(`tSE_MAX);
                memory_address[`SECTOR_OFFSET_BITS-1:0] = `SECTOR_OFFSET_BITS'h0000;
                for(i=1;i<=`SECTOR_SIZE;i=i+1)
                begin
                    memory[memory_address[`MEM_ADDR_BITS-1:0]] = `DATA_BITS'hff;
                    memory_address[`SECTOR_OFFSET_BITS-1:0] = memory_address[`SECTOR_OFFSET_BITS-1:0] + `SECTOR_OFFSET_BITS'h0001;
                end
                status_reg[1] = 1'b0;   //WEL is reset
                status_reg[0] = 1'b0;   //WIP is 0 when this cycle completed
                $display("%t, Notes: Sector[%d] Erase Cycle is completed!\n",$realtime,sector_address);
            end
        end
        else begin
            if(sector_erase_id == 1'b0)
                $display("%t, Warning: This ERASE SECTOR instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This ERASE SECTOR instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //---------------------------------
    wr_protect = 1'b0;
    //===============================================================
    if(operation == ENTER_DEEP_POWER_DOWN)
    begin
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        if((deep_pd_id == 1'b1)&&(hw_rst == 1'b0))
        begin
            deep_pd_id = 1'b0;
            mode = device_standby_mode;
            deep_pd_delay = 1'b1;
            #(`tDP);                    ///S driven high to deep power down
            deep_pd_delay = 1'b0;
            if(not_deep_pd == 1'b0)
            begin
                device_power_down = 1'b1;
                mode = deep_power_down_mode;
                $display("%t, Notes: Device enter the DEEP POWER DOWN MODE,the supply current is reduced!\n",$realtime);
            end
            else begin
                not_deep_pd = 1'b0;
                $display("%t, Error: /S falling edge happens during a delay of tDP before the DEEP POWER DOWN MODE is entered.",$realtime);
                $finish;
            end
        end
        else begin
            if(deep_pd_id == 1'b0)
                $display("%t, Warning: This ENTER DEEP POWER DOWN instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This ENTER DEEP POWER DOWN instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    //---------------------------------
    if(operation == RELEASE_DEEP_POWER_DOWN)
    begin
        dout = 1'bz;                    //data output(Q) is HiZ
        operation = 4'b0000;
        if((release_pd_id == 1'b1)&&(hw_rst == 1'b0))
        begin
            release_pd_id = 1'b0;
            release_pd_delay = 1'b1;
            #(`tRDP);
            release_pd_delay = 1'b0;
            if(not_release_pd == 1'b0)
            begin
                device_power_down = 1'b0;
                mode = device_standby_mode;
                $display("%t, Notes: Device release from the DEEP POWER DOWN MODE!\n",$realtime);
            end
            else begin
                not_release_pd = 1'b0;
                $display("%t, Error: /S falling edge happens during a delay of tRDP before the DEEP POWER DOWN MODE is released.",$realtime);
                $finish;
            end
        end
        else begin
            if(release_pd_id == 1'b0)
                $display("%t, Warning: This RELEASE FROM DEEP POWER DOWN instruction is rejected because chip select is not driven high after the eighth bit of instruction code has been latched in.\n",$realtime);
            if(hw_rst == 1'b1)
            begin
                hw_rst = 1'b0;
                $display("%t, Warning: This RELEASE FROM DEEP POWER DOWN instruction is rejected because RESET pin is driven low.",$realtime);
            end
        end
    end
    dout = 1'bz;
    hw_rst = 1'b0;
end

//=========================================================
//AC timing Characteristics Check
//=========================================================
always@(posedge S)          //rising edge of /S
begin
    r_S = 1'b1;
    t_rS = $time;
    if(r_C == 1'b1)
    begin                   //check /S active hold time (relative to C)
        tCHSH = t_rS - t_rC;
        if(tCHSH < `tCHSH)
        begin
            $display("%t, Error: /S active hold time(tCHSH) violated.\n",$realtime); 
            $finish; 
        end
    end
end
//--------------------------------
always@(negedge S)          //falling edge of /S
begin
    f_S = 1'b1;
    t_fS = $time;
    if(r_S == 1'b1)
    begin                   //check /S deselect time
        tSHSL = t_fS - t_rS;
        if(tSHSL < `tSHSL)
        begin
            $display("%t, Error: /S Deselect time(tSHSL) violated.\n",$realtime);
            $finish;
        end
    end
    if(r_C == 1'b1)
    begin                   //check /S not active hold time (relative to C)
        tCHSL = t_fS - t_rC;
        if(tCHSL < `tCHSL)
        begin
            $display("%t, Error: /S not active hold time(tCHSL) violated.\n",$realtime);
            $finish;
        end
    end
    if(r_W == 1'b1)
    begin                   //check Write Protect Setup Time
        tWHSL = t_fS - t_rW;
        if(tWHSL < `tWHSL)
        begin
            $display("%t, Error: Write Protect Setup Time(tWHSL) violated.\n",$realtime); 
            $finish;
        end
    end
end
//--------------------------------
always@(negedge W)
begin
    f_W = 1'b1;
    t_fW = $time;
    if(r_S == 1'b1)
    begin                   //check Write Protect Hold Time
        tSHWL = t_fW - t_rS;
        if(tSHWL < `tSHWL)
        begin
            $display("%t, Error: Write Protect Hold Time(tSHWL) violated.\n",$realtime); 
            $finish;
        end
    end
end
//--------------------------------
always@(posedge W)
begin
    r_W = 1'b1;
    t_rW = $time;
end
//--------------------------------
always@(C)
begin
    if(C == 1'b1)           //rising edge of clock
    begin
        if(operation == READ_DATA_OUT)
        begin
            t_rCr = $time;
            if(r_Cr == 1'b1)
            begin           //check clock freq. for READ instruction
                Tcr = t_rCr - t_rCr1;
                if(Tcr < `tR)
                begin
                    $display("%t, Error: Clock for read instruction frequency(fR) violated, fC>20MHz.\n",$realtime); 
                    $finish;
                end
            end
            r_Cr = 1'b1;
            t_rCr1 = t_rCr;
        end
        else begin
            t_rC = $time;
            if(r_C == 1'b1)
            begin           //check clock freq. for all except READ instruction
                Tc = t_rC - t_rC1;
                if(Tc < `tC)
                begin
                    $display("%t, Error: Clock frequency(fC) violated, fC>25MHz.\n",$realtime); 
                    $finish;
                end
            end
            r_C = 1'b1;
            if(f_S == 1'b1)
            begin           //check /S active setup time (relative to C)
                tSLCH = t_rC - t_fS;
                if(tSLCH < `tSLCH)
                begin
                    $display("%t, Error: /S active setup time(tSLCH) violated.\n",$realtime);
                    $finish;
                end
            end
            if(r_S == 1'b1)
            begin           //check /S not active setup time (relative to C)
                tSHCH = t_rC - t_rS;
                if(tSHCH < `tSHCH)
                begin
                    $display("%t, Error: /S not active setup time(tSHCH) violated.\n",$realtime);
                    $finish;
                end
            end
            if(f_C == 1'b1)
            begin           //check clock low time
                tCL = t_rC - t_fC;
                if(tCL < `tCL)
                begin
                    $display("%t, Error: Clock low time(tCL) violated.\n",$realtime);
                    $finish;
                end
            end
            if(din_change == 1'b1)
            begin           //check data in setup time
                tDVCH = t_rC - t_d;
                if(tDVCH < `tDVCH)
                begin
                    $display("%t, Error: Data in setup time(tDVCH) violated.\n",$realtime);
                    $finish;
                end
            end
            t_rC1 = t_rC;
        end
    end
//--------------------------------
    if(C == 1'b0)           //falling edge of clock
    begin
        f_C = 1'b1;
        t_fC = $time;
        if(r_C == 1'b1)
        begin               //check data high time
            tCH = t_fC - t_rC;
            if(tCH < `tCH)
            begin
                $display("%t, Error: Clock high time(tCH) violated.\n",$realtime);
                $finish;
            end
        end
    end
end
//--------------------------------
always@(D)                  //Input data change on "D" line
begin
    din_change = 1'b1;
    t_d = $time;
    if(r_C == 1'b1)
    begin                   //check data in hold time
        tCHDX = t_d - t_rC;
        if(tCHDX < `tCHDX)
        begin
            $display("%t,Error: Data in hold time(tCHDX) violated.\n",$realtime);
            $finish;
        end
    end
end
//--------------------------------

endmodule 