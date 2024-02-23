//////////////////////////////////////////////////////////////////////////////
//  File name : s25fl004a.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2004-2005 Spansion, LLC.
//
//  MODIFICATION HISTORY :
//
//  version:   | author:     | mod date: | changes made:
//    V1.0      N.Makljenovic 04 Aug 25   Inital Release
//    V1.1      R. Munden     05 Mar 09   Changed nomenclature from s25fl004m
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        AMD
//  Technology:     Flash Memory
//  Part:           s25fl004a
//
//  Description: 4 Megabit Flash Memory with 50MHz SPI Bus Interface
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ns
module s25fl004a
(
    SCK      ,
    SI       ,
    CSNeg    ,
    HOLDNeg  ,
    WNeg     ,
    SO
);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
    input  SCK     ;
    input  SI      ;
    input  CSNeg   ;
    input  HOLDNeg ;
    input  WNeg    ;

    output SO      ;

// interconnect path delay signals
    wire  SCK_ipd      ;
    wire  SI_ipd       ;
    wire  CSNeg_ipd    ;
    wire  HOLDNeg_ipd  ;
    wire  WNeg_ipd     ;

//  internal delays
    reg PP_in       ;
    reg PP_out      ;
    reg BE_in       ;
    reg BE_out      ;
    reg SE_in       ;
    reg SE_out      ;
    reg WR_in       ;
    reg WR_out      ;
    reg SP_in       ;
    reg SP_out      ;
    reg RES_in      ;
    reg RES_out     ;

    reg SO_zd;
    reg SO_Pass;

    parameter UserPreload     = 1'b0;
    parameter mem_file_name   = "none";//"s25fl004a.mem";

    parameter TimingModel = "DefaultTimingModel";

    parameter PartID = "s25fl004a";
    parameter MaxData = 255;
    parameter SecSize = 65535;
    parameter SecNum = 7;
    parameter HiAddrBit = 18;
    parameter AddrRANGE = 24'h7FFFF;
    parameter BYTE = 8;
    parameter ID = 8'h12;
    parameter RD_ID1 = 8'h01;
    parameter RD_ID2 = 8'h02;
    parameter RD_ID3 = 8'h13;

    // powerup
    reg PoweredUp;

    reg PDONE    ; ////Prog. Done
    reg PSTART   ; ////Start Programming

    reg EDONE    ; ////Era. Done
    reg ESTART   ; ////Start Erasing

    reg WDONE    ; //// Writing Done
    reg WSTART   ; ////Start writing

    //Command Register
    reg write;
    reg read_out;

    //Status reg.
    reg[7:0] Status_reg = 8'b0;
    reg[7:0] Status_reg_in = 8'b0;

    integer SA      = 0;         // 0 TO SecNum+1
    integer Byte_number = 0;

    //Address
    integer Address = 0;         // 0 - AddrRANGE
    reg change_addr;

    //Sector Protection Status
    reg [SecNum:0] Sec_Prot; //= SecNum'b0;

    // timing check violation
    reg Viol = 1'b0;

    integer Mem[0:AddrRANGE];

    integer WByte[0:255];

    integer AddrLo;
    integer AddrHi;

    reg[7:0]  old_bit, new_bit;
    integer old_int, new_int;
    integer wr_cnt;

    integer read_cnt = 0;
    integer read_addr = 0;
    reg[7:0] data_out;

    reg oe = 1'b0;
    event oe_event;
    reg  FROMSCK, FROMCS;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////

 buf   (SCK_ipd, SCK);
 buf   (SI_ipd, SI);
 buf   (CSNeg_ipd, CSNeg);
 buf   (HOLDNeg_ipd, HOLDNeg);
 buf   (WNeg_ipd, WNeg);

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
    nmos   (SO, SO_Pass, 1);

 specify
        // tipd delays: interconnect path delays , mapped to input port delays.
        // In Verilog is not necessary to declare any tipd_ delay variables,
        // they can be taken from SDF file
        // With all the other delays real delays would be taken from SDF file

                        // tpd delays
     specparam           tpd_SCK_SO              =1;
     specparam           tpd_CSNeg_SO            =1;
     specparam           tpd_HOLDNeg_SO          =1;

     specparam           tsetup_SI_SCK           =1;   //tsuDAT /
     specparam           tsetup_CSNeg_SCK        =1;   // tCSS /
     specparam           tsetup_HOLDNeg_SCK      =1;   //tHD /
     specparam           tsetup_SCK_HOLDNeg      =1;   //tCH \
     specparam           tsetup_WNeg_CSNeg       =1;   //tWPS \

                          // thold values: hold times
     specparam           thold_SI_SCK            =1; //thdDAT /
     specparam           thold_CSNeg_SCK         =1; //tCSH /
     specparam           thold_HOLDNeg_SCK       =1; //tCD /
     specparam           thold_SCK_HOLDNeg       =1; //tHC \
     specparam           thold_WNeg_CSNeg        =1; //tWPH \

        // tpw values: pulse width
     specparam           tpw_SCK_posedge         =1; //tWH
     specparam           tpw_SCK_negedge         =1; //tWL
     specparam           tpw_CSNeg_posedge       =1; //tCS

        // tperiod min (calculated as 1/max freq)
     specparam           tperiod_SCK             =1; // fSCK

        // tdevice values: values for internal delays

            // Page Program Operation
     specparam   tdevice_PP                     = 3000000; //3 ms;

      //tdevice_SE_L is Sector Erase Operation time divided with t_div
      //Sector Erase Operation time(tdevice_SE) is t_div times larger.
     specparam   tdevice_SE_L                   = 300000000; //0.3 sec;

     specparam   t_div                  = 10;

            //Write Status Register Operation
     specparam   tdevice_WR                     = 65000000; //65 ms;;
            //Software Protect Mode
     specparam   tdevice_SP                     = 3000; // 3 us;
            //Release from Software Protect Mode
     specparam   tdevice_RES                    = 30000; // 30 us;
            //VCC (min) to CS# Low
     specparam   tdevice_PU                     = 4000000; //4 ms;

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
  (SCK => SO) = tpd_SCK_SO;
  (CSNeg => SO) = tpd_CSNeg_SO;
  (HOLDNeg => SO) = tpd_HOLDNeg_SO;

////////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                           //
////////////////////////////////////////////////////////////////////////////////
        $setup ( WNeg , negedge CSNeg, tsetup_WNeg_CSNeg, Viol);
        $setup ( negedge HOLDNeg, posedge SCK, tsetup_HOLDNeg_SCK, Viol);
        $setup ( posedge SCK, posedge HOLDNeg, tsetup_SCK_HOLDNeg, Viol);

        $hold ( posedge CSNeg, WNeg,  thold_WNeg_CSNeg, Viol);
        $hold ( posedge SCK, negedge HOLDNeg, thold_HOLDNeg_SCK, Viol);
        $hold ( posedge HOLDNeg, posedge SCK, thold_SCK_HOLDNeg, Viol);

        $setuphold ( posedge SCK, SI, tsetup_SI_SCK, thold_SI_SCK, Viol);
        $setuphold ( posedge SCK, CSNeg, tsetup_CSNeg_SCK,
                                                  thold_CSNeg_SCK, Viol);

        $width (posedge SCK, tpw_SCK_posedge);
        $width (negedge SCK, tpw_SCK_negedge);

        $width (posedge CSNeg, tpw_CSNeg_posedge);

        $period (posedge SCK, tperiod_SCK);

    endspecify

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////
// FSM states
 parameter IDLE            =4'd0;
 parameter S_PROTECT       =4'd1;
 parameter WRITE_SR        =4'd2;
 parameter SECTOR_ER       =4'd4;
 parameter BULK_ER         =4'd5;
 parameter PAGE_PG         =4'd6;

 reg [3:0] current_state;
 reg [3:0] next_state;

// Instructions
 parameter NONE            =5'd0;
 parameter WREN            =5'd1;
 parameter WRDI            =5'd2;
 parameter WRSR            =5'd3;
 parameter RDSR            =5'd4;
 parameter RDID            =5'd5;
 parameter READ            =5'd6;
 parameter FAST_READ       =5'd7;
 parameter SE              =5'd9;
 parameter BE              =5'd10;
 parameter PP              =5'd11;
 parameter SP              =5'd12;
 parameter RES             =5'd13;
 parameter RES_READ_ID     =5'd14;

 reg [4:0] Instruct;

//Bus cycle states
 parameter STAND_BY        =3'd0;
 parameter CODE_BYTE       =3'd1;
 parameter ADDRESS_BYTES   =3'd2;
 parameter DUMMY_BYTES     =3'd3;
 parameter DATA_BYTES      =3'd4;

 reg [2:0] bus_cycle_state;

    initial
    begin : Init

        write    = 1'b0;
        read_out  = 1'b0;
        Address   = 0;
        change_addr = 1'b0;

        PDONE    = 1'b1;
        PSTART   = 1'b0;

        EDONE    = 1'b1;
        ESTART   = 1'b0;

        WDONE    = 1'b1;
        WSTART   = 1'b0;

        SP_in = 1'b0;
        SP_out = 1'b0;
        RES_in = 1'b0;
        RES_out = 1'b0;
        Instruct = NONE;
        bus_cycle_state = STAND_BY;
        current_state = IDLE;
        next_state = IDLE;
    end

    // initialize memory
    initial
    begin: InitMemory
    integer i;

        for (i=0;i<=AddrRANGE;i=i+1)
        begin
            Mem[i] = MaxData;
        end

        if ((UserPreload) && !(mem_file_name == "none"))
        begin
           // Memory Preload
           //s25fl004a.mem, memory preload file
           //  @aaaaa   - <aaaaa> stands for address
           //  dd      - <dd> is byte to be written at Mem(aaaaa++)
           // (aaaaa is incremented at every load)
           $readmemh(mem_file_name,Mem);
        end
    end

    //Power Up time;
    initial
    begin
        PoweredUp = 1'b0;
        #tdevice_PU PoweredUp = 1'b1;
    end

   always @(posedge SP_in)
   begin:TSPr
     #tdevice_SP SP_out = SP_in;
   end
   always @(negedge SP_in)
   begin:TSPf
     #1 SP_out = SP_in;
   end

   always @(posedge RES_in)
   begin:TRESr
     #tdevice_RES RES_out = RES_in;
   end
   always @(negedge RES_in)
   begin:TRESf
     #1 RES_out = RES_in;
   end

always @(next_state or PoweredUp)
begin: StateTransition

        if (PoweredUp)
        begin
                current_state = next_state;
        end
end

   initial
   begin:CheckCEOnPowerUP
       if (CSNeg!==1'b1)
           $display ("Device is selected during Power Up");
   end

//    //////////////////////////////////////////////////////////////////////////
//    // Instruction cycle decode
//    //////////////////////////////////////////////////////////////////////////
 integer data_cnt = 0;
 integer addr_cnt = 0;
 integer code_cnt = 0;
 integer dummy_cnt = 0;
 integer bit_cnt = 0;
 reg[2047:0] Data_in = 2048'b0;
 reg[7:0] code = 8'b0;
 reg[7:0] code_in = 8'b0;
 reg[7:0] Byte_slv = 8'b0;
 reg[HiAddrBit:0] addr_bytes;
 reg[23:0] Address_in = 8'b0;

    always @(negedge CSNeg_ipd)
    begin: Buscycle1
        if (bus_cycle_state==STAND_BY)
        begin
            bus_cycle_state = CODE_BYTE;
            Instruct = NONE;
            write = 1'b1;
            code_cnt = 0;
            addr_cnt = 0;
            data_cnt = 0;
            dummy_cnt = 0;
        end
    end

    always @(posedge SCK_ipd)
    begin: Buscycle2
    integer i;
        if ( HOLDNeg_ipd)
        begin
            case (bus_cycle_state)
                CODE_BYTE :
                begin
                    code_in[code_cnt] = SI_ipd;
                    code_cnt = code_cnt + 1;
                    if (code_cnt == BYTE)
                    begin
                        for (i=0;i<=7;i=i+1)
                        begin
                            code[i] = code_in[7-i];
                        end
                        case(code)
                            8'b00000110 :
                            begin
                                Instruct = WREN;
                                bus_cycle_state = DATA_BYTES;
                            end
                            8'b00000100 :
                            begin
                                Instruct = WRDI;
                                bus_cycle_state = DATA_BYTES;
                            end
                            8'b00000001 :
                            begin
                                Instruct = WRSR;
                                bus_cycle_state = DATA_BYTES;
                            end
                            8'b00000101 :
                            begin
                                Instruct = RDSR;
                                bus_cycle_state = DATA_BYTES;
                            end
                            8'b10011111 :
                            begin
                                Instruct = RDID;
                                bus_cycle_state = DATA_BYTES;
                            end
                            8'b00000011 :
                            begin
                                Instruct = READ;
                                bus_cycle_state = ADDRESS_BYTES;
                            end
                            8'b00001011 :
                            begin
                                Instruct = FAST_READ;
                                bus_cycle_state = ADDRESS_BYTES;
                            end
                            8'b10101011 :
                            begin
                                Instruct = RES_READ_ID;
                                bus_cycle_state = DUMMY_BYTES;
                            end
                            8'b11011000 :
                            begin
                                Instruct = SE;
                                bus_cycle_state = ADDRESS_BYTES;
                            end
                            8'b11000111 :
                            begin
                                Instruct = BE;
                                bus_cycle_state = DATA_BYTES;
                            end
                            8'b00000010 :
                            begin
                                Instruct = PP;
                                bus_cycle_state = ADDRESS_BYTES;
                            end
                            8'b10111001 :
                            begin
                                Instruct = SP;
                                bus_cycle_state = DATA_BYTES;
                            end
                        endcase
                    end
                end

                ADDRESS_BYTES :
                begin
                    Address_in[addr_cnt] = SI_ipd;
                    addr_cnt = addr_cnt + 1;
                    if (addr_cnt == 3*BYTE)
                    begin
                        for (i=23;i>=23-HiAddrBit;i=i-1)
                        begin
                            addr_bytes[23-i] = Address_in[i];
                        end
                        Address = addr_bytes;
                        change_addr = 1'b1;
                        #1 change_addr = 1'b0;
                        if (Instruct == FAST_READ)
                            bus_cycle_state = DUMMY_BYTES;
                        else
                            bus_cycle_state = DATA_BYTES;
                    end
                end

                DUMMY_BYTES :
                begin
                    dummy_cnt = dummy_cnt + 1;
                    if ((dummy_cnt == BYTE && Instruct == FAST_READ) ||
                        (dummy_cnt == 3*BYTE && Instruct == RES_READ_ID))
                        bus_cycle_state = DATA_BYTES;
                end

                DATA_BYTES :
                begin
                    if (data_cnt > 2047)
                    //In case of PP, if more than 256 bytes are
                    //sent to the device
                    begin
                        if (bit_cnt == 0)
                        begin
                            for (i=0;i<=(255*BYTE-1);i=i+1)
                            begin
                                Data_in[i] = Data_in[i+8];
                            end
                        end
                        Data_in[2040 + bit_cnt] = SI_ipd;
                        bit_cnt = bit_cnt + 1;
                        if (bit_cnt == 8)
                        begin
                            bit_cnt = 0;
                        end
                        data_cnt = data_cnt + 1;
                    end
                    else
                    begin
                        Data_in[data_cnt] = SI_ipd;
                        data_cnt = data_cnt + 1;
                        bit_cnt = 0;
                    end
                end
            endcase
        end
    end

    always @(negedge SCK_ipd)
    begin: Buscycle3
        if (bus_cycle_state==DATA_BYTES && (~CSNeg_ipd))
            if (Instruct == READ || Instruct == RES_READ_ID ||
                Instruct == FAST_READ || Instruct == RDSR || Instruct == RDID)
                read_out = 1'b1;
                #1 read_out = 1'b0;
    end

    always @(posedge CSNeg_ipd)
    begin: Buscycle4
    integer i;
    integer j;
        if (bus_cycle_state == DATA_BYTES)
        begin
            bus_cycle_state = STAND_BY;
            if (HOLDNeg_ipd)
            begin
                case (Instruct)
                    WREN,
                    WRDI,
                    SP,
                    BE,
                    SE :
                    begin
                        if (data_cnt == 0)
                            write = 1'b0;
                    end

                    RES_READ_ID :
                    begin
                        write = 1'b0;
                    end

                    WRSR :
                    begin
                        if (data_cnt == BYTE)
                            write = 1'b0;
                            Status_reg_in = Data_in[7:0];
                    end

                    PP :
                    begin
                        if ((data_cnt > BYTE) && ((data_cnt % 8) == 0))
                        begin
                            write = 1'b0;
                            for (i=0;i<=255;i=i+1)
                            begin
                                for (j=7;j>=0;j=j-1)
                                begin
                                    Byte_slv[j] = Data_in[(i*8) + (7-j)];
                                end
                                WByte[i] = Byte_slv;
                            end
                            if (data_cnt > 256*BYTE)
                                Byte_number = 255;
                            else
                                Byte_number = ((data_cnt/8) - 1);
                        end
                    end
                endcase
            end
        end
        else
        begin
        if ((bus_cycle_state==DUMMY_BYTES)&&
                 (Instruct == RES_READ_ID  && HOLDNeg_ipd && dummy_cnt==0))
            begin
                write = 1'b0;
            end

        if (bus_cycle_state==DUMMY_BYTES)
        begin
            bus_cycle_state = STAND_BY;
        end
        else
        begin
            bus_cycle_state = STAND_BY;
        end
        end

    end

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Program Operations
//    // start
//    //////////////////////////////////////////////////////////////////////////

 event pdone_event;

    always @(PSTART)
    begin
        if ((PSTART && PDONE)&& (~(Sec_Prot[SA])))
        begin
            PDONE = 1'b0;
           ->pdone_event;
        end
    end

    always @(pdone_event)
    begin:pdone_process
        PDONE = 1'b0;
        #tdevice_PP PDONE = 1'b1;
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Write Status Register Operation
//    // start
//    //////////////////////////////////////////////////////////////////////////

 event wdone_event;

    always @(WSTART)
    begin
        if (WSTART && WDONE)
        begin
                WDONE = 1'b0;
                ->wdone_event;
        end
    end

    always @(wdone_event)
    begin:wdone_process
        WDONE = 1'b0;
        #tdevice_WR WDONE = 1'b1;
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Timing control for the Erase Operations
//    //////////////////////////////////////////////////////////////////////////
 integer cnt_erase = 0;
 time duration_erase;
 integer  i = 0;
    event edone_event;

    always @(ESTART)
    begin: erase
        if (ESTART && EDONE)
        begin
            cnt_erase = 1;

            if (Instruct == BE)
            begin
                cnt_erase = 8;
                duration_erase = cnt_erase * tdevice_SE_L;
            end
            if (Instruct == SE)
            begin
                duration_erase = tdevice_SE_L;
            end

            EDONE = 1'b0;
            ->edone_event;

        end
    end

    always @(edone_event)
    begin : edone_process
        EDONE = 1'b0;
        while (i <t_div)
        begin
        # duration_erase
        EDONE = 1'b0;
        i = i+1;
        end
        i = 0;
        EDONE = 1'b1;
    end

//    //////////////////////////////////////////////////////////////////////////
//    // Main Behavior Process
//    // combinational process for next state generation
//    //////////////////////////////////////////////////////////////////////////

    integer sect;

    always @( write)
    begin: StateGen1

        case (current_state)
            IDLE :
            begin
                if (~write)
                begin
                    if (Instruct == WRSR && Status_reg[1])
                    begin
                        if (~(Status_reg[7] && (~WNeg_ipd)))
                            next_state = WRITE_SR;
                    end

                    else if (Instruct == PP && Status_reg[1])
                    begin
                        sect = Address / 24'h10000;
                        if (Sec_Prot[sect] == 1'b0)
                            next_state = PAGE_PG;
                    end
                    else if (Instruct == SE && Status_reg[1])
                    begin
                        sect = Address / 24'h10000;
                        if (Sec_Prot[sect] == 1'b0)
                            next_state = SECTOR_ER;
                    end
                    else if (Instruct == BE && Status_reg[1])
                    begin
                        if (Status_reg[2] == 1'b0 && Status_reg[3] == 1'b0)
                            next_state = BULK_ER;
                    end
                    else if (Instruct == SP)
                        next_state = S_PROTECT;
                    else
                        next_state = IDLE;
                end
            end

            S_PROTECT:
            begin
                if ((~write)&&(Instruct == RES_READ_ID))
                        next_state = IDLE;
            end

        endcase
    end

    always @(posedge PDONE)
    begin: StateGen2
        if (current_state==PAGE_PG)
        begin
            next_state = IDLE;
        end
    end

    always @(posedge WDONE)
    begin: StateGen3
        if (current_state==WRITE_SR)
        begin
            next_state = IDLE;
        end
    end

    always @(posedge EDONE)
    begin: StateGen4
        if ( current_state==SECTOR_ER || current_state==BULK_ER)
        begin
            next_state = IDLE;
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    //FSM Output generation and general funcionality
    ///////////////////////////////////////////////////////////////////////////

    always @(posedge read_out)
    begin
        if (HOLDNeg_ipd == 1'b1 && PoweredUp == 1'b1)
            ->oe_event;
    end

    always @(oe_event)
    begin
        oe = 1'b1;
        #1 oe = 1'b0;
    end

    always @(Instruct)
    begin
        read_cnt = 0;
    end

    always @(change_addr)
    begin
        if (change_addr)
            read_addr = Address;
    end

    always @(oe or current_state)
    begin

        case (current_state)
            IDLE :
            begin
                    if ((oe && RES_in == 1'b0)&& (Instruct == RDSR))
                    begin
                    //Read Status Register
                        SO_zd = Status_reg[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                            read_cnt = 0;
                    end
                    else if ((oe && RES_in == 1'b0)
                             && (Instruct == READ || Instruct == FAST_READ))
                    begin
                    //Read Memory array
                        data_out[7:0] = Mem[read_addr];
                        SO_zd = data_out[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                        begin
                            read_cnt = 0;
                            if (read_addr == AddrRANGE)
                                read_addr = 0;
                            else
                                read_addr = read_addr + 1;
                        end
                    end
                    else if ((oe && RES_in == 1'b0)&&(Instruct == RES_READ_ID))
                    begin
                    // Read ID
                        data_out[7:0] = ID;
                        SO_zd = data_out[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        if (read_cnt == 8)
                            read_cnt = 0;
                    end

                    else if ((oe && RES_in == 1'b0)&&  (Instruct == RDID))
                    begin
                    // Read ID
                    if (read_cnt <= 7)
                        begin
                        data_out[7:0] = RD_ID1;
                        SO_zd = data_out[7-read_cnt];
                        read_cnt = read_cnt + 1;
                        end
                    else if (read_cnt <= 15)
                        begin
                        data_out[7:0] = RD_ID2;
                        SO_zd = data_out[15-read_cnt];
                        read_cnt = read_cnt + 1;
                        end
                    else
                        begin
                        data_out[7:0] = RD_ID3;
                        SO_zd = data_out[23-read_cnt];
                        read_cnt = read_cnt + 1;
                        end
                        if (read_cnt == 24)
                            read_cnt = 0;
                    end
                else if (oe && RES_in == 1'b1)
                begin
                    $display ("Command results can be corrupted");
                    SO_zd = 1'bX;
                    read_cnt = read_cnt + 1;
                    if (read_cnt == 8)
                        read_cnt = 0;
                end
            end

            WRITE_SR,
            SECTOR_ER,
            BULK_ER,
            PAGE_PG :
            begin
                if (oe && Instruct == RDSR)
                begin
                //Read Status Register
                    SO_zd = Status_reg[7-read_cnt];
                    read_cnt = read_cnt + 1;
                    if (read_cnt == 8)
                        read_cnt = 0;
                end
            end

            S_PROTECT :
            begin
                if (oe && Instruct == RES_READ_ID)
                begin
                // Read ID
                    data_out[7:0] = ID;
                    SO_zd = data_out[7-read_cnt];
                    read_cnt = read_cnt + 1;
                    if (read_cnt == 8)
                        read_cnt = 0;
                end
            end

        endcase
    end

    integer sector;
    integer WData [0:255];
    integer Addr;

    always @( write)
    begin : Output_generation
    integer i;

        case (current_state)
            IDLE :
            begin
                if (~write)
                begin
                        if (RES_in == 1'b1)
                        begin
                            $display ("Command results can be corrupted");
                        end
                        if (Instruct == WREN)
                            Status_reg[1] = 1'b1;
                        else if (Instruct == WRDI)
                            Status_reg[1] = 1'b0;
                        else if (Instruct == WRSR && Status_reg[1] &&
                                (~(Status_reg[7] == 1'b1 && WNeg_ipd == 1'b0)))
                        begin
                            WSTART = 1'b1;
                            WSTART <= #1 1'b0;
                            Status_reg[0] = 1'b1;
                        end
                        else if (Instruct == PP && Status_reg[1] == 1'b1)
                        begin
                            sector = Address / 20'h10000;
                            if (Sec_Prot[sector] == 1'b0)
                            begin
                                PSTART = 1'b1;
                                PSTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                                Addr = Address;
                                SA = sector;
                                wr_cnt = Byte_number;
                                for (i=0;i<=wr_cnt;i=i+1)
                                begin
                                    if (Viol!=1'b0)
                                        WData[i] = -1;
                                    else
                                        WData[i] = WByte[i];
                                end
                            end
                        end
                        else if (Instruct == SE && Status_reg[1] == 1'b1)
                        begin
                            sector = Address / 20'h10000;
                            if (Sec_Prot[sector] == 1'b0)
                            begin
                                ESTART = 1'b1;
                                ESTART <= #1 1'b0;
                                Status_reg[0] = 1'b1;
                                Addr = Address;
                            end
                        end
                        else if (Instruct == BE && Status_reg[1] == 1'b1 &&
                                Status_reg[2] == 1'b0 && Status_reg[3] == 1'b0)
                        begin
                            ESTART = 1'b1;
                            ESTART <= #1 1'b0;
                            Status_reg[0] = 1'b1;
                        end
                        else if (Instruct == SP )
                        begin
                        SP_in = 1'b1;
                        end
                    end
            end

            S_PROTECT :
            begin
                if ((~write)&& (Instruct == RES_READ_ID))
                        RES_in = 1'b1;
            end

        endcase
    end

    always @(SP_out)
    begin : SPROTECT_IN
        if (SP_out)
        begin
            SP_in = 1'b0;
        end
    end

    always @(RES_out)
    begin : SPROTECT1
        if (RES_out)
        begin
            RES_in = 1'b0;
        end
    end

    always @(current_state or EDONE)
    begin: ERASE1
    integer i;
        case (current_state)

            SECTOR_ER :
            begin
                ADDRHILO_SEC(AddrLo, AddrHi, Addr);
                for (i=AddrLo;i<=AddrHi;i=i+1)
                begin
                    Mem[i] = -1;
                end

                if (EDONE)
                begin
                    Status_reg[0] = 1'b0;
                    Status_reg[1] = 1'b0;
                    for (i=AddrLo;i<=AddrHi;i=i+1)
                    begin
                        Mem[i] = MaxData;
                    end
                end
            end

            BULK_ER :
            begin
                for (i=0;i<=AddrRANGE;i=i+1)
                begin
                    Mem[i] = -1;
                end

                if (EDONE)
                begin
                    Status_reg[0] = 1'b0;
                    Status_reg[1] = 1'b0;
                    for (i=0;i<=AddrRANGE;i=i+1)
                    begin
                        Mem[i] = MaxData;
                    end
                end
            end
        endcase
    end

    always @(current_state or WDONE)
    begin: WRSR1
        if (current_state == WRITE_SR)
        begin
            if (WDONE)
            begin
                Status_reg[0] = 1'b0;//WIP
                Status_reg[1] = 1'b0;//WEL
                Status_reg[7] = Status_reg_in[0];//MSB first, SRWD
                Status_reg[4] = Status_reg_in[3];//MSB first, BP2
                Status_reg[3] = Status_reg_in[4];//MSB first,BP1
                Status_reg[2] = Status_reg_in[5];//MSB first, BP0
                case (Status_reg[4:2])

                    3'b000 :
                    begin
                        Sec_Prot = 8'b00000000;
                    end

                    3'b001 :
                    begin
                        Sec_Prot = 8'b10000000;
                    end

                    3'b010 :
                    begin
                        Sec_Prot = 8'b11000000;
                    end

                    3'b011 :
                    begin
                        Sec_Prot = 8'b11110000;
                    end

                    3'b100, 3'b101, 3'b110, 3'b111  :
                    begin
                        Sec_Prot = 8'b11111111;
                    end
                endcase
            end
        end
    end

    always @(current_state or PDONE)
    begin: PPPG1
    integer i, j;
        if (current_state == PAGE_PG)
        begin
            ADDRHILO_PG(AddrLo, AddrHi, Addr);
            if ((Addr + wr_cnt) > AddrHi)
                wr_cnt = AddrHi - Addr;
            for (i=Addr;i<=Addr+wr_cnt;i=i+1)
            begin
                new_int = WData[i-Addr];
                old_int = Mem[i];
                if (new_int > -1)
                begin
                    new_bit = new_int;
                    if (old_int > -1)
                    begin
                        old_bit = old_int;
                        for(j=0;j<=7;j=j+1)
                            if (~old_bit[j])
                                new_bit[j]=1'b0;
                        new_int=new_bit;
                    end

                    WData[i-Addr]= new_int;
                end
                else
                begin
                    WData[i-Addr] = -1;
                end
            end

            for (i=Addr;i<=Addr+wr_cnt;i=i+1)
            begin
                Mem[i] = -1;
            end

            if (PDONE)
            begin
                Status_reg[0] = 1'b0;//wip
                Status_reg[1] = 1'b0;// wel
                for (i=Addr;i<=Addr+wr_cnt;i=i+1)
                begin
                    Mem[i] = WData[i-Addr];
                end
            end
        end
    end

// Output Control
    always @(CSNeg_ipd or HOLDNeg_ipd)
    begin
        //Output Disable Control
        if (CSNeg_ipd || (~HOLDNeg_ipd))
            SO_zd = 1'bZ;
     end

// Procedure ADDRHILO_SEC
 task ADDRHILO_SEC;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   Addr;
 integer AddrLOW;
 integer AddrHIGH;
 integer Addr;
 integer sector;
 begin

    sector = Addr / 20'h10000;
    AddrLOW = sector * 20'h10000;
    AddrHIGH = sector * 20'h10000 + 16'hFFFF;

 end
 endtask

// Procedure ADDRHILO_PG
 task ADDRHILO_PG;
 inout  AddrLOW;
 inout  AddrHIGH;
 input   Addr;
 integer AddrLOW;
 integer AddrHIGH;
 integer Addr;
 integer page;
 begin

    page = Addr / 16'h100;
    AddrLOW = page * 16'h100;
    AddrHIGH = page * 16'h100 + 8'hFF;

 end
 endtask

 reg  BuffInCS,  BuffInSCK;
 wire BuffOutCS, BuffOutSCK;

   VitalBuf    BUFCSNeg   (BuffOutCS, BuffInCS);
   VitalBuf    BUFSCK     (BuffOutSCK, BuffInSCK);

   initial
    begin
        BuffInCS   = 1'b1;
        BuffInSCK  = 1'b1;
    end

  time SCKSO_t, CSSO_t;
  time SCKSO_01, CSSO_01;
  time SCK_event, CSNeg_event;

  always @(posedge BuffOutCS)
    begin
        CSSO_01 = $time;
    end

  always @(posedge BuffOutSCK)
    begin
        SCKSO_01 = $time;
    end

  always @(negedge SCK_ipd)
    begin
        FROMSCK = 1;
        SCK_event = $time;
        # SCKSO_01;
        FROMSCK = 0;
    end

  always @(posedge CSNeg_ipd)
    begin
        CSNeg_event = $time;
    end

 always @(SO_zd)
   begin
       if ((SO_zd === 1'bz)&& (FROMSCK == 1'b1))
               SO_Pass <=#(CSSO_01-($time-CSNeg_event)) SO_zd;
       else
           SO_Pass <= SO_zd;
   end

endmodule

module VitalBuf ( OUT,IN);
   input IN;
   output OUT;
   buf   ( OUT, IN);
 endmodule
