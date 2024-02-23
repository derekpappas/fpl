// Testbench for CellularRAM

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 100ps

module test;

    // Constant parameters
    parameter addr_bits =      22;
    parameter data_bits =      16;
// Timing parameters for -70
    parameter tAVH      =      5.00;
    parameter tAVS      =     10.00;
    parameter tAW       =     70.00;
    parameter tBW       =     70.00;
    parameter tCBPH     =      5.00;
    parameter tCKA      =     70.00;
    parameter tCLK      =      9.26;
    parameter tCW       =     70.00;
    parameter tDW       =     20.00;
    parameter tDH       =      0.00;
    parameter tPC       =     20.00;
    parameter tPU       = 150000.00;
    parameter tRC       =     70.00;
    parameter tVP       =     10.00;
    parameter tVPH      =     10.00;
    parameter tWC       =     70.00;
    parameter tWP       =     40.00;
    parameter tWPH      =     10.00;

    // Ports register
    reg  [data_bits - 1 : 0] dq;
    wire                     owait;
    reg                      clk;
    reg  [addr_bits - 1 : 0] addr;
    reg                      ce_n;
    reg                      we_n;
    reg                      adv_n;
    reg                      oe_n;
    reg                      cre;
    reg                      lb_n;
    reg                      ub_n;

    reg              [2 : 0] latency_counter;

    wire [data_bits - 1 : 0] DQ = dq;

    mt45w4mw16bfb uut (.Dq(DQ), .oWait(owait), .Clk(clk), .Addr(addr), .Ce_n(ce_n), .We_n(we_n), .Adv_n(adv_n), .Oe_n(oe_n), .Cre(cre), .Lb_n(lb_n), .Ub_n(ub_n));

    initial begin
        dq   = 16'bz;
        addr = 22'b0;
        clk  =  1'b0;
        ce_n =  1'b1;
        we_n =  1'b1;
        oe_n =  1'b1;
        lb_n =  1'b1;
        ub_n =  1'b1;
        cre = 1'b0;
        adv_n = 1'b1;
        latency_counter = 3'b011;
    end

    /**************************************************************************
    *
    *  Figure 20: Initialization Period
    *
    **************************************************************************/
    
    task initialization_period;
        begin
            addr  = 'bx;
            dq    = 'bz;
            clk   = 1'b0;
            ce_n  = 1'b1;
            adv_n = 1'b1;
            we_n  = 1'b1;
            lb_n  = 1'b1;
            ub_n  = 1'b1;
            cre   = 1'b0;
            oe_n  = 1'b1;
            #tPU;
        end
    endtask

    /**************************************************************************
    *
    *  Figure 11: Asynchronous Configuration Register WRITE
    *
    **************************************************************************/
    
    task asynchronous_configuration_register;
        input [addr_bits - 1 : 0] opcode;
    begin
        fork
            begin : clk_blk 
                clk <= 1'b0; 
            end
            begin : cre_blk 
                cre <= 1'b1; 
            end
            begin : addr_blk 
                addr <= 'bx;
                addr <= #(tVPH + tVP - tAVS) opcode;
                addr <= #(tVPH + tVP + tAVH) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1; 
                adv_n <= #(tVPH) 1'b0;
                adv_n <= #(tVPH + tVP) 1'b1;
            end
            begin : ce_blk
                ce_n <= 1'b1;
                ce_n <= #(tVPH) 1'b0; 
                ce_n <= #(tVPH + tCW) 1'b1;
            end
            begin : lb_blk
                lb_n <= 1'b1;
                lb_n <= #(tVPH) 1'b0; 
                lb_n <= #(tVPH + tBW + tWPH) 1'b1;
            end
            begin : ub_blk
                ub_n <= 1'b1;
                ub_n <= #(tVPH) 1'b0; 
                ub_n <= #(tVPH + tBW + tWPH) 1'b1;
            end
            begin : oe_blk
                oe_n <= 1'b1; 
            end
            begin : we_blk 
                we_n <= 1'b1;
                we_n <= #(tVPH) 1'b0;
                we_n <= #(tVPH + tBW) 1'b1;
            end
            begin : dq_blk 
                dq <= {data_bits{1'bz}}; 
            end
            #(tVPH + tCW + tWC);
        join
    end
    endtask

    /**************************************************************************
    *
    *  Figure 21: Asynchronous READ
    *
    **************************************************************************/

    task asynchronous_read_cycle;
        input [addr_bits - 1 : 0] rd_addr;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk 
                addr <= 'bx;
                addr <= #(tCBPH) rd_addr; 
                addr <= #(tCBPH + tRC) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                adv_n <= #(tCBPH) 1'b0;
                adv_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tCBPH) 1'b0;
                ce_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tCBPH) 1'b0;
                lb_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tCBPH) 1'b0;
                ub_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b0; 
            end
            begin : we_blk 
                we_n <= 1'b1;
            end
            begin : dq_blk
                dq <= 'bz;
            end
            #(tCBPH + tRC + tCBPH);
        join
    end
    endtask

    /**************************************************************************
    *
    *             Asynchronous READ ADV tied HIGH
    *
    **************************************************************************/

    task asynchronous_read_cycle_adv_high;
        input [addr_bits - 1 : 0] rd_addr;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk 
                addr <= 'bx;
                addr <= #(tCBPH) rd_addr; 
                addr <= #(tCBPH + tRC) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                //adv_n <= #(tCBPH) 1'b0;
                //adv_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tCBPH) 1'b0;
                ce_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tCBPH) 1'b0;
                lb_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tCBPH) 1'b0;
                ub_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b0; 
            end
            begin : we_blk 
                we_n <= 1'b1;
            end
            begin : dq_blk
                dq <= 'bz;
            end
            #(tCBPH + tRC + tCBPH);
        join
    end
    endtask


    /**************************************************************************
    *
    *  Figure 22: Asynchronous READ Using ADV#
    *
    **************************************************************************/

    task asynchronous_read_using_adv_n;
        input [addr_bits - 1 : 0] rd_addr;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk 
                addr <= 'bx;
                addr <= #(tCBPH + tVP - tAVS) rd_addr;
                addr <= #(tCBPH + tVP + tAVH) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                adv_n <= #(tCBPH) 1'b0;
                adv_n <= #(tCBPH + tVP) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tCBPH) 1'b0;
                ce_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tCBPH) 1'b0;
                lb_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tCBPH) 1'b0;
                ub_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b0; 
            end
            begin : we_blk 
                we_n <= 1'b1;
            end
            begin : dq_blk
                dq <= 'bz;
            end
            #(tCBPH + tRC + tCBPH);
        join
    end
    endtask

    task asynchronous_read_using_adv_n_oen;
        input [addr_bits - 1 : 0] rd_addr;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk 
                addr <= 'bx;
                addr <= #(tCBPH + tVP - tAVS) rd_addr;
                addr <= #(tCBPH + tVP + tAVH) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                adv_n <= #(tCBPH) 1'b0;
                adv_n <= #(tCBPH + tVP) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tCBPH) 1'b0;
                ce_n <= #(tCBPH + tRC+20) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tCBPH) 1'b0;
                lb_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tCBPH) 1'b0;
                ub_n <= #(tCBPH + tRC) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b1; 
                oe_n <= #(50) 1'b0;
                oe_n <= #(70) 1'b1;
                oe_n <= #(100) 1'b0;
            end
            begin : we_blk 
                we_n <= 1'b1;
            end
            begin : dq_blk
                dq <= 'bz;
            end
            #(tCBPH + tRC + tCBPH);
        join
    end
    endtask


    /**************************************************************************
    *
    *  Figure 23: Page Mode READ
    *
    **************************************************************************/

    task page_mode_read;
        input [addr_bits - 1 : 0] rd_addr0;
        input [addr_bits - 1 : 0] rd_addr1;
        input [addr_bits - 1 : 0] rd_addr2;
        input [addr_bits - 1 : 0] rd_addr3;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk 
                addr <= 'bx;
                addr <= #(tCBPH) rd_addr0; 
                addr <= #(tCBPH + tRC) rd_addr1;
                addr <= #(tCBPH + tRC + 1 * tPC) rd_addr2;
                addr <= #(tCBPH + tRC + 2 * tPC) rd_addr3;
                addr <= #(tCBPH + tRC + 3 * tPC) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                adv_n <= #(tCBPH) 1'b0;
                adv_n <= #(tCBPH + tRC + 3 * tPC) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tCBPH) 1'b0;
                ce_n <= #(tCBPH + tRC + 3 * tPC) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tCBPH) 1'b0;
                lb_n <= #(tCBPH + tRC + 3 * tPC) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tCBPH) 1'b0;
                ub_n <= #(tCBPH + tRC + 3 * tPC) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b0; 
            end
            begin : we_blk 
                we_n <= 1'b1;
            end
            begin : dq_blk
                dq <= 'bz;
            end
            #(tCBPH + tRC + 3 * tPC + tCBPH);
        join
    end
    endtask

    /**************************************************************************
    *
    *  Figure 29-31: Asynchronous WRITE cycle
    *
    **************************************************************************/

    task asynchronous_write_cycle;
        input [addr_bits - 1 : 0] wr_addr;
        input [data_bits - 1 : 0] wr_data;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk
                addr <= 'bx;
                addr <= #(tWPH) wr_addr;
                addr <= #(tWPH + tWC) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                adv_n <= #(tWPH) 1'b0;
                adv_n <= #(tWPH + tAW) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tWPH) 1'b0; 
                ce_n <= #(tWPH + tCW) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tWPH) 1'b0; 
                lb_n <= #(tWPH + tBW + tWPH) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tWPH) 1'b0; 
                ub_n <= #(tWPH + tBW + tWPH) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b0; 
            end
            begin : we_blk 
                we_n <= 1'b1;
                we_n <= #(tWPH) 1'b0;
                we_n <= #(tWPH + tBW) 1'b1;
            end
            begin : dq_blk
                dq   <= 'bz;
                dq   <= #(tWPH + tBW - tDW) wr_data; 
                dq   <= #(tWPH + tBW + tDH) 'bz;
            end
            #(tWPH + tBW + tWPH);
        join
    end
    endtask

    /**************************************************************************
    *
    *  Figure 32: Asynchronous WRITE Using ADV#
    *
    **************************************************************************/

    task asynchronous_write_using_adv_n;
        input [addr_bits - 1 : 0] wr_addr;
        input [data_bits - 1 : 0] wr_data;
    begin
        fork
            begin : clk_blk
                clk <= 1'b0;
            end
            begin : cre_blk
                cre <= 1'b0;
            end
            begin : addr_blk
                addr <= 'bx;
                addr <= #(tVPH + tVP - tAVS) wr_addr;
                addr <= #(tVPH + tVP + tAVH) 'bx;
            end
            begin : adv_blk
                adv_n <= 1'b1;
                adv_n <= #(tVPH) 1'b0;
                adv_n <= #(tVPH + tVP) 1'b1;
            end
            begin : ce_blk 
                ce_n <= 1'b1;
                ce_n <= #(tVPH) 1'b0; 
                ce_n <= #(tVPH + tCW) 1'b1;
            end
            begin : lb_blk 
                lb_n <= 1'b1;
                lb_n <= #(tVPH) 1'b0; 
                lb_n <= #(tVPH + tBW + tWPH) 1'b1;
            end
            begin : ub_blk 
                ub_n <= 1'b1;
                ub_n <= #(tVPH) 1'b0; 
                ub_n <= #(tVPH + tBW + tWPH) 1'b1;
            end
            begin : oe_blk 
                oe_n <= 1'b0; 
            end
            begin : we_blk 
                we_n <= 1'b1;
                we_n <= #(tVPH) 1'b0;
                we_n <= #(tVPH + tBW) 1'b1;
                //we_n <= #(tVPH + tBW - tWP) 1'b0;
                //we_n <= #(tVPH + tBW) 1'b1;
            end
            begin : dq_blk
                dq   <= 'bz;
                dq   <= #(tVPH + tBW - tDW) wr_data; 
                dq   <= #(tVPH + tBW + tDH) 'bz;
            end
            #(tVPH + tBW + tWPH);
        join
    end
    endtask

    /**************************************************************************
    *
    *  This task does the Synchronous Configuration Register
    *
    **************************************************************************/
    
    task synchronous_configuration_register;
        input [addr_bits - 1 : 0] opcode;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #(0.5 * tCLK) 1'b0; 
                    clk <= #(1.0 * tCLK) 1'b1; 
                    clk <= #(1.5 * tCLK) 1'b0; 
                    clk <= #(2.0 * tCLK) 1'b1; 
                    clk <= #(2.5 * tCLK) 1'b0; 
                    clk <= #(3.0 * tCLK) 1'b1; 
                    clk <= #(3.5 * tCLK) 1'b0; 
                    clk <= #(4.0 * tCLK) 1'b1; 
                    clk <= #(4.5 * tCLK) 1'b0; 
                    clk <= #(5.0 * tCLK) 1'b1; 
                    clk <= #(5.5 * tCLK) 1'b0; 
                    clk <= #(6.0 * tCLK) 1'b1; 
                    clk <= #(6.5 * tCLK) 1'b0; 
                    clk <= #(7.0 * tCLK) 1'b1; 
                    clk <= #(7.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= opcode; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b1; 
                    cre <= #(1.5 * tCLK) 1'b0;
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #(0.5 * tCLK) 1'b0; 
                    ce_n <= #(6.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= 1'b1; 
                end
                begin : we_blk 
                    we_n <= #(0.5 * tCLK) 1'b0; 
                    we_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk 
                    lb_n <= 1'b1; 
                    ub_n <= 1'b1; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}}; 
                end
                #(8.0 * tCLK);

                // Record latency counter for future use
                if (opcode[19] === 1) begin
                    latency_counter = opcode [13 : 11];
                end
            join
        end
    endtask

    task synchronous_write_operation_oe;
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;
        input [data_bits - 1 : 0] data2;
        input [data_bits - 1 : 0] data3;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    //clk <= 1'b1; 
                    //clk <= #( 0.5 * tCLK) 1'b0; 
                    //clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                    clk <= #(14.0 * tCLK) 1'b1; 
                    clk <= #(14.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(1.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(1.5 * tCLK) 1'b0;
                    adv_n <= #(2.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= 1'b0;
                    //ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(1.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 1.5 * tCLK) 1'b0; 
                    we_n <= #(14.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk
                    lb_n <= #(1.5 * tCLK) 1'b0; 
                    ub_n <= #(1.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= data0;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (owait === 1'b1) begin
                            @ (negedge clk) begin
                                case (count)
                                    1 : dq <= data1;
                                    2 : dq <= data2;
                                    3 : dq <= data3;
                                    4 : begin
                                            dq <= 16'bz;
                                            ce_n <= 1'b1;
                                            //lb_n <= 1'b1; 
                                            //ub_n <= 1'b1;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(15.0 * tCLK);
            join
        end
    endtask

    task synchronous_read_operation_oe;
        input [addr_bits - 1 : 0] addr_in;
        begin
            fork
                begin : clk_blk 
                    //clk <= 1'b1; 
                    //clk <= #( 0.5 * tCLK) 1'b0; 
                    //clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                    clk <= #(14.0 * tCLK) 1'b1; 
                    clk <= #(14.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(1.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(1.5 * tCLK) 1'b0;
                    adv_n <= #(2.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= 1'b0;
                    ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #( 1.5 * tCLK) 1'b0; 
                end
                begin : we_blk 
                    we_n <= #(1.5 * tCLK) 1'b1; 
                end
                begin : lb_ub_blk
                    lb_n <= #(1.5 * tCLK) 1'b0; 
                    ub_n <= #(1.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(15.0 * tCLK);
            join
        end
    endtask


    task synchronous_write_operation_ce_first;
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;
        input [data_bits - 1 : 0] data2;
        input [data_bits - 1 : 0] data3;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    //clk <= 1'b1; 
                    //clk <= #( 0.5 * tCLK) 1'b0; 
                    //clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                    clk <= #(14.0 * tCLK) 1'b1; 
                    clk <= #(14.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(1.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(1.5 * tCLK) 1'b0;
                    adv_n <= #(2.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= 1'b0;
                    //ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(1.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 1.5 * tCLK) 1'b0; 
                    we_n <= #(14.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk
                    lb_n <= #(1.5 * tCLK) 1'b0; 
                    ub_n <= #(1.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= data0;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (owait === 1'b1) begin
                            @ (negedge clk) begin
                                case (count)
                                    1 : dq <= data1;
                                    2 : dq <= data2;
                                    3 : dq <= data3;
                                    4 : begin
                                            dq <= 16'bz;
                                            ce_n <= 1'b1;
                                            //lb_n <= 1'b1; 
                                            //ub_n <= 1'b1;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(15.0 * tCLK);
            join
        end
    endtask

    task synchronous_read_operation_ce_first;
        input [addr_bits - 1 : 0] addr_in;
        begin
            fork
                begin : clk_blk 
                    //clk <= 1'b1; 
                    //clk <= #( 0.5 * tCLK) 1'b0; 
                    //clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                    clk <= #(14.0 * tCLK) 1'b1; 
                    clk <= #(14.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(1.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(1.5 * tCLK) 1'b0;
                    adv_n <= #(2.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= 1'b0;
                    ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #( 1.5 * tCLK) 1'b0; 
                end
                begin : we_blk 
                    we_n <= #(1.5 * tCLK) 1'b1; 
                end
                begin : lb_ub_blk
                    lb_n <= #(1.5 * tCLK) 1'b0; 
                    ub_n <= #(1.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(15.0 * tCLK);
            join
        end
    endtask



    task synchronous_write_operation_ce_co;
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;
        input [data_bits - 1 : 0] data2;
        input [data_bits - 1 : 0] data3;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= 1'b0;
                    //ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                    we_n <= #(13.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= data0;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (owait === 1'b1) begin
                            @ (negedge clk) begin
                                case (count)
                                    1 : dq <= data1;
                                    2 : dq <= data2;
                                    3 : dq <= data3;
                                    4 : begin
                                            dq <= 16'bz;
                                            ce_n <= 1'b1;
                                            //lb_n <= 1'b1; 
                                            //ub_n <= 1'b1;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(14.0 * tCLK);
            join
        end
    endtask

    task synchronous_read_operation_ce_co;
        input [addr_bits - 1 : 0] addr_in;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= 1'b0;
                    ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #( 0.5 * tCLK) 1'b0; 
                end
                begin : we_blk 
                    we_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(14.0 * tCLK);
            join
        end
    endtask


    /**************************************************************************
    *
    *  Figure 33: Synchronous Write Operation
    *
    **************************************************************************/
     
    task synchronous_write_operation;
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] data0;
        input [data_bits - 1 : 0] data1;
        input [data_bits - 1 : 0] data2;
        input [data_bits - 1 : 0] data3;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                    //ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                    we_n <= #(13.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= data0;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (owait === 1'b1) begin
                            @ (negedge clk) begin
                                case (count)
                                    1 : dq <= data1;
                                    2 : dq <= data2;
                                    3 : dq <= data3;
                                    4 : begin
                                            dq <= 16'bz;
                                            ce_n <= 1'b1;
                                            //lb_n <= 1'b1; 
                                            //ub_n <= 1'b1;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(14.0 * tCLK);
            join
        end
    endtask
 

    //  ARB = Across Row Boundary Starts at Addr 126
    task synchronous_write_operation_B4RB;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= 126; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                    we_n <= #(13.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= 'bz;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (1) begin
                            @ (negedge clk) begin
                                case (count)
                                    1 : dq <= 126;
                                    2 : dq <= 127;
                                    3 : dq <= 128;
                                    4 : begin
                                            dq <= 16'bz;
                                            //ce_n <= 1'b1;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(14.0 * tCLK);
            join
        end
    endtask
 

    //  ARB = Across Row Boundary Starts at Addr 127
    task synchronous_write_operation_ARB;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    clk <= #(13.0 * tCLK) 1'b1; 
                    clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= 127; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                    we_n <= #(13.5 * tCLK) 1'b1;
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= 'bz;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (1) begin
                            @ (negedge clk) begin
                                case (count)
                                    1 : dq <= 127;
                                    2 : dq <= 128;
                                    3 : dq <= 129;
                                    4 : begin
                                            dq <= 16'bz;
                                            //ce_n <= 1'b1;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(14.0 * tCLK);
            join
        end
    endtask
  
    task synchronous_write_operation_owb; //  One word burst
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] data0;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    //clk <= #( 8.5 * tCLK) 1'b0; 
                    //clk <= #( 9.0 * tCLK) 1'b1; 
                    //clk <= #( 9.5 * tCLK) 1'b0; 
                    //clk <= #(10.0 * tCLK) 1'b1; 
                    //clk <= #(10.5 * tCLK) 1'b0; 
                    //clk <= #(11.0 * tCLK) 1'b1; 
                    //clk <= #(11.5 * tCLK) 1'b0; 
                    //clk <= #(12.0 * tCLK) 1'b1; 
                    //clk <= #(12.5 * tCLK) 1'b0; 
                    //clk <= #(13.0 * tCLK) 1'b1; 
                    //clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk);
                    @ (posedge clk);
                    @ (negedge clk) dq <= data0;
                    count = 1;
                    while (count < 5) begin
                        @ (posedge clk);
                        if (owait === 1'b1) begin
                            @ (negedge clk) begin
                                case (count)
                                    2 : dq <= 16'bz;
                                    3 : dq <= 16'bz;
                                    4 : dq <= 16'bz;
                                    5 : begin
                                            dq <= 16'bz;
                                        end
                                endcase
                                count = count + 1;
                            end
                        end
                    end
                end
                #(8.0 * tCLK);
            join
        end
    endtask

    task synchronous_write_operation_cust2; // writes 80 data
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] count;
        integer                   mycount;
        integer                   myclkcount;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    myclkcount = 0;
                    while (myclkcount < (count+8)) begin
                        clk <= #( (myclkcount+0.5) * tCLK) 1'b0; 
                        clk <= #( (myclkcount+1.0) * tCLK) 1'b1; 
                        myclkcount = (myclkcount + 1);
                    end
                    clk <= #( (myclkcount+0.5) * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk)
                    @ (negedge clk)
                    @ (negedge clk)
                    @ (negedge clk)
                    mycount = 0;
                    while (mycount < (count+5)) begin
                        @ (negedge clk) begin
                            dq <= (addr_in + mycount);
                            mycount = mycount + 1;
                        end
                    end
                    dq <= {data_bits{1'bz}};
                end
                #((count+10) * tCLK);
            join
        end
    endtask



    task synchronous_write_operation_cust;
        input [addr_bits - 1 : 0] addr_in;
        input [data_bits - 1 : 0] count;
        integer                   mycount;
        integer                   myclkcount;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    myclkcount = 0;
                    while (myclkcount < (count+7)) begin
                        clk <= #( (myclkcount+0.5) * tCLK) 1'b0; 
                        clk <= #( (myclkcount+1.0) * tCLK) 1'b1; 
                        myclkcount = (myclkcount + 1);
                    end
                    clk <= #( (myclkcount+0.5) * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : we_blk 
                    we_n <= #( 0.5 * tCLK) 1'b0; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                    @ (negedge clk)
                    @ (negedge clk)
                    @ (negedge clk)
                    @ (negedge clk)
                    mycount = 0;
                    while (mycount < (count+4)) begin
                        @ (negedge clk) begin
                            dq <= (addr_in + mycount);
                            mycount = mycount + 1;
                        end
                    end
                    dq <= {data_bits{1'bz}};
                end
                #((count+10) * tCLK);
            join
        end
    endtask

    task synchronous_write_operation_cont;
        input [data_bits - 1 : 0] data0;
        integer                   count;
        begin
            fork
                begin : clk_blk 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                end
                begin : dq_blk 
                    dq <= #(3) data0;
                end
                #tCLK;
            join
        end
    endtask



    /**************************************************************************
    *
    *  Figure 26: Synchronous Read Operation
    *
    **************************************************************************/
    
    task synchronous_read_operation;
        input [addr_bits - 1 : 0] addr_in;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                    clk <= #( 5.5 * tCLK) 1'b0; 
                    clk <= #( 6.0 * tCLK) 1'b1; 
                    clk <= #( 6.5 * tCLK) 1'b0; 
                    clk <= #( 7.0 * tCLK) 1'b1; 
                    clk <= #( 7.5 * tCLK) 1'b0; 
                    clk <= #( 8.0 * tCLK) 1'b1; 
                    clk <= #( 8.5 * tCLK) 1'b0; 
                    clk <= #( 9.0 * tCLK) 1'b1; 
                    clk <= #( 9.5 * tCLK) 1'b0; 
                    clk <= #(10.0 * tCLK) 1'b1; 
                    clk <= #(10.5 * tCLK) 1'b0; 
                    clk <= #(11.0 * tCLK) 1'b1; 
                    clk <= #(11.5 * tCLK) 1'b0; 
                    clk <= #(12.0 * tCLK) 1'b1; 
                    clk <= #(12.5 * tCLK) 1'b0; 
                    //clk <= #(13.0 * tCLK) 1'b1; 
                    //clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                    ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #( 0.5 * tCLK) 1'b0; 
                end
                begin : we_blk 
                    we_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(14.0 * tCLK);
            join
        end
    endtask
 
    task synchronous_read_operation_start;
        input [addr_bits - 1 : 0] addr_in;
        begin
            fork
                begin : clk_blk 
                    clk <= 1'b1; 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                    clk <= #( 1.5 * tCLK) 1'b0; 
                    clk <= #( 2.0 * tCLK) 1'b1; 
                    clk <= #( 2.5 * tCLK) 1'b0; 
                    clk <= #( 3.0 * tCLK) 1'b1; 
                    clk <= #( 3.5 * tCLK) 1'b0; 
                    clk <= #( 4.0 * tCLK) 1'b1; 
                    clk <= #( 4.5 * tCLK) 1'b0; 
                    clk <= #( 5.0 * tCLK) 1'b1; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #(0.5 * tCLK) 1'b0;
                end
                begin : oe_blk 
                    oe_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : we_blk 
                    we_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(5.0 * tCLK);
            join
        end
    endtask
 
    task synchronous_read_operation_cont;
        begin
            fork
                begin : clk_blk 
                    clk <= #( 0.5 * tCLK) 1'b0; 
                    clk <= #( 1.0 * tCLK) 1'b1; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(tCLK);
            join
        end
    endtask



    /**************************************************************************
    *
    *  Synchronous Read Operation at row boundary
    *
    **************************************************************************/
    
    task synchronous_read_over_row_boundary;
        input [addr_bits - 1 : 0] addr_in;
        input [addr_bits - 1 : 0] size;
        integer i;

        begin
            fork
                begin : clk_blk 
                   clk <= 1'b1; 
                   clk <= #( 0.5 * tCLK) 1'b0; 
                   clk <= #( 1.0 * tCLK) 1'b1; 
                   clk <= #( 1.5 * tCLK) 1'b0; 
                   clk <= #( 2.0 * tCLK) 1'b1; 
                   clk <= #( 2.5 * tCLK) 1'b0; 
                   clk <= #( 3.0 * tCLK) 1'b1; 
                   clk <= #( 3.5 * tCLK) 1'b0; 
                   clk <= #( 4.0 * tCLK) 1'b1; 
                   clk <= #( 4.5 * tCLK) 1'b0; 
                   clk <= #( 5.0 * tCLK) 1'b1; 
                   clk <= #( 5.5 * tCLK) 1'b0; 
                   clk <= #( 6.0 * tCLK) 1'b1; 
                   clk <= #( 6.5 * tCLK) 1'b0; 
                   clk <= #( 7.0 * tCLK) 1'b1; 
                   clk <= #( 7.5 * tCLK) 1'b0; 
                   clk <= #( 8.0 * tCLK) 1'b1; 
                   clk <= #( 8.5 * tCLK) 1'b0; 
                   clk <= #( 9.0 * tCLK) 1'b1; 
                   clk <= #( 9.5 * tCLK) 1'b0; 
                   clk <= #(10.0 * tCLK) 1'b1; 
                   clk <= #(10.5 * tCLK) 1'b0; 
                   clk <= #(11.0 * tCLK) 1'b1; 
                   clk <= #(11.5 * tCLK) 1'b0; 
                   clk <= #(12.0 * tCLK) 1'b1; 
                   clk <= #(12.5 * tCLK) 1'b0; 
                   clk <= #(13.0 * tCLK) 1'b1; 
                   clk <= #(13.5 * tCLK) 1'b0; 
                end
                begin : addr_blk 
                    addr <= addr_in; 
                end
                begin : cre_blk 
                    cre <= #(0.5 * tCLK) 1'b0; 
                end
                begin : adv_blk 
                    adv_n <= #(0.5 * tCLK) 1'b0;
                    adv_n <= #(1.5 * tCLK) 1'b1;
                end
                begin : ce_blk 
                    ce_n <= #( 0.5 * tCLK) 1'b0;
                    ce_n <= #(12.5 * tCLK) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #( 0.5 * tCLK) 1'b0; 
                end
                begin : we_blk 
                    we_n <= #(0.5 * tCLK) 1'b1; 
                end
                begin : lb_ub_blk
                    lb_n <= #(0.5 * tCLK) 1'b0; 
                    ub_n <= #(0.5 * tCLK) 1'b0; 
                end
                begin : dq_blk 
                    dq <= {data_bits{1'bz}};
                end
                #(14.0 * tCLK);
            join
 
        end
    endtask

    /*
      Similar to figure 36: Asynchonous WRITE Followed by Burst READ
    */
    task asynchronous_write_followed_by_burst_read;
        input [addr_bits - 1 : 0] wr_addr0;
        input [data_bits - 1 : 0] wr_data0;
        input [addr_bits - 1 : 0] wr_addr1;
        input [data_bits - 1 : 0] wr_data1;
        input [addr_bits - 1 : 0] rd_addr2;
    begin
        asynchronous_write_using_adv_n (wr_addr0, wr_data0);
        asynchronous_write_using_adv_n (wr_addr1, wr_data1);
        #tCKA;
        synchronous_read_operation (rd_addr2);
    end
    endtask

    integer i;

    // Test vectors
    initial begin
        initialization_period;
        //page_mode_read (12, 13, 14, 15);
        asynchronous_configuration_register(22'h08194F);  //BCR - Sync mode - EMP config
        //asynchronous_configuration_register(22'b00_1_000_0_0_011_0_0_0_0_1_0_0_1_001);  //BCR - Sync mode - 
        //asynchronous_write_followed_by_burst_read(16, {$random} % 65536, 17, {$random} % 65536, 14);

        synchronous_write_operation_cust(0, 8);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(0); #500;

        synchronous_write_operation_cust(117, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(117); #500;

        synchronous_write_operation_cust(117, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(117); #500;

        synchronous_write_operation_cust(118, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(118); #500;

        synchronous_write_operation_cust(119, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(119); #500;

        synchronous_write_operation_cust(120, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(120); #500;

        synchronous_write_operation_cust2(120, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(120); #500;

        synchronous_write_operation_cust(121, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(121); #500;

        synchronous_write_operation_cust2(121, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(121); #500;

        synchronous_write_operation_cust(122, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(122); #500;

        synchronous_write_operation_cust2(122, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(122); #500;

        synchronous_write_operation_cust(123, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(123); #500;

        synchronous_write_operation_cust(124, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(124); #500;

        synchronous_write_operation_cust(125, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(125); #500;

        synchronous_write_operation_cust(126, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(126); #500;

        synchronous_write_operation_cust(127, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(127); #500;


////////////////////////////////////////////

        synchronous_write_operation_cust(0, 320);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation_start(0); 
        for (i = 1; i < 280 ; i = i + 1) begin
            synchronous_read_operation_cont;
        end 
        #500;

////////////////////////////////////////////

        #2000;
        synchronous_configuration_register(22'h08184F);  //BCR - Sync mode - EMP config

        synchronous_write_operation_cust(0, 8);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(0); #500;

        synchronous_write_operation_cust(117, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(117); #500;

        synchronous_write_operation_cust(117, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(117); #500;

        synchronous_write_operation_cust(118, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(118); #500;

        synchronous_write_operation_cust(119, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(119); #500;

        synchronous_write_operation_cust(120, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(120); #500;

        synchronous_write_operation_cust2(120, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(120); #500;

        synchronous_write_operation_cust(121, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(121); #500;

        synchronous_write_operation_cust2(121, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(121); #500;

        synchronous_write_operation_cust(122, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(122); #500;

        synchronous_write_operation_cust2(122, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(122); #500;

        synchronous_write_operation_cust(123, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(123); #500;

        synchronous_write_operation_cust(124, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(124); #500;

        synchronous_write_operation_cust(125, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(125); #500;

        synchronous_write_operation_cust(126, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(126); #500;

        synchronous_write_operation_cust(127, 6);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation(127); #500;


////////////////////////////////////////////

        synchronous_write_operation_cust(0, 320);  //Start Addr, Cycles
        ce_n <= #( 0.5 * tCLK) 1'b1; we_n <= #( 0.5 * tCLK) 1'b1; #200;
        synchronous_read_operation_start(0); 
        for (i = 1; i < 280 ; i = i + 1) begin
            synchronous_read_operation_cont;
        end 
        #500;

////////////////////////////////////////////



        //synchronous_configuration_register(22'b00_1_000_1_0_011_0_0_0_0_1_0_0_1_001);  //BCR - Async mode
        //asynchronous_write_cycle (10, {$random} % 65536);
        //asynchronous_write_cycle (11, {$random} % 65536);
        //asynchronous_write_cycle (12, {$random} % 65536);
        //asynchronous_write_using_adv_n (15, {$random} % 65536);
        //asynchronous_read_cycle (10);
        //asynchronous_read_using_adv_n (11);
        //asynchronous_read_using_adv_n_oen (12);

        #20;
        $stop;
        //$finish;
    end

endmodule
