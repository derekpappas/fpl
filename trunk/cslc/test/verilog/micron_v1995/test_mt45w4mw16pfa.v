// Testbench for CellularRAM

// DO NOT CHANGE THE TIMESCALE
// MAKE SURE YOUR SIMULATOR USE "PS" RESOLUTION
`timescale 1ns / 100ps

module test;

    // Constant parameters
    parameter addr_bits =      22;
    parameter data_bits =      16;

    // Timing parameters for -70
    parameter tAW       =      70;
    parameter tBW       =      70;
    parameter tCW       =      70;
    parameter tDW       =      23;
    parameter tPC       =      20;
    parameter tRC       =      70;
    parameter tWC       =      70;
    parameter tWP       =      46;
    parameter tZZWE_min =      10;

    reg  [data_bits - 1 : 0] dq;
    reg  [addr_bits - 1 : 0] addr;
    reg                      ce_n;
    reg                      we_n;
    reg                      oe_n;
    reg                      lb_n;
    reg                      ub_n;
    reg                      zz_n;

    wire [data_bits - 1 : 0] DQ = dq;

    mt45w4mw16pfa uut (.Dq(DQ), .Addr(addr), .Ce_n(ce_n), .We_n(we_n), .Oe_n(oe_n), .Lb_n(lb_n), .Ub_n(ub_n), .Zz_n(zz_n));

    initial begin
        dq   = 16'bz;
        addr = 22'b0;
        ce_n =  1'b1;
        we_n =  1'b1;
        oe_n =  1'b1;
        lb_n =  1'b1;
        ub_n =  1'b1;
        zz_n =  1'b1;
    end

    /**************************************************************************
    *
    *  This task does the WRITE Cycle (CE# Control).
    *
    **************************************************************************/

    task write_cycle;
        input [addr_bits - 1 : 0] wr_addr;
        input [data_bits - 1 : 0] wr_data;
        begin
            dq = {data_bits{1'bz}};
            fork
                begin : addr_blk 
                    addr <= #(tWC / 2) wr_addr; 
                end
                begin : ce_blk 
                    ce_n <= #(tWC / 2) 1'b0; 
                    ce_n <= #(tWC / 2 + tAW) 1'b1;
                end
                begin : lb_blk 
                    lb_n <= #(tWC / 2) 1'b0; 
                    lb_n <= #(tWC / 2 + tBW + 5) 1'b1;
                end
                begin : ub_blk 
                    ub_n <= #(tWC / 2) 1'b0; 
                    ub_n <= #(tWC / 2 + tBW + 5) 1'b1;
                end
                begin : we_blk 
                    we_n <= #(tWC / 2) 1'b0; 
                    we_n <= #(tWC / 2 + tAW + 5) 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(tWC / 2) 1'b0; 
                    oe_n <= #(tWC / 2 + tBW + 5) 1'b1;
                end
                begin : dq_blk 
                    dq   <= #(tWC / 2 + tAW - tDW) wr_data; 
                    dq   <= #(tWC / 2 + tAW) {data_bits{1'bz}};
                end
                #(tWC + tWC);
            join
        end
    endtask

    /**************************************************************************
    *
    *  This task does the Single READ Operation (WE# = VIH)
    *
    **************************************************************************/

    task read_cycle;
        input [addr_bits - 1 : 0] rd_addr;
        begin
            dq = {data_bits{1'bz}};
            fork
                begin : addr_blk 
                    addr <= #(tWC / 2) rd_addr; 
                end
                begin : ce_blk 
                    ce_n <= #(tWC / 2) 1'b0; 
                    ce_n <= #(tWC / 2 + tCW) 1'b1;
                end
                begin : lb_blk 
                    lb_n <= #(tWC / 2) 1'b0; 
                    lb_n <= #(tWC / 2 + tBW) 1'b1;
                end
                begin : ub_blk 
                    ub_n <= #(tWC / 2) 1'b0; 
                    ub_n <= #(tWC / 2 + tBW) 1'b1;
                end
                begin : we_blk 
                    we_n <= 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(tWC / 2) 1'b0; 
                    oe_n <= #(tWC / 2 + tBW) 1'b1;
                end
                #(tWC + tWC);
            join
        end
    endtask

    /**************************************************************************
    *
    *  This task does the Page Mode READ Operation (WE# = VIH)
    *
    **************************************************************************/

    task page_cycle;
        input [addr_bits - 1 : 0] rd_addr0;
        input [addr_bits - 1 : 0] rd_addr1;
        input [addr_bits - 1 : 0] rd_addr2;
        input [addr_bits - 1 : 0] rd_addr3;
        begin
            dq = {data_bits{1'bz}};
            fork
                begin : addr_blk 
                    addr <= #(tWC / 2) rd_addr0; 
                    addr <= #(tWC / 2 + tRC + 1 * tPC) rd_addr1; 
                    addr <= #(tWC / 2 + tRC + 2 * tPC) rd_addr2; 
                    addr <= #(tWC / 2 + tRC + 3 * tPC) rd_addr3; 
                end
                begin : ce_blk 
                    ce_n <= #(tWC / 2) 1'b0; 
                    ce_n <= #(tWC / 2 + tRC + 4 * tPC) 1'b1;
                end
                begin : lb_blk 
                    lb_n <= #(tWC / 2) 1'b0; 
                    lb_n <= #(tWC / 2 + tRC + 4 * tPC) 1'b1;
                end
                begin : ub_blk 
                    ub_n <= #(tWC / 2) 1'b0; 
                    ub_n <= #(tWC / 2 + tRC + 4 * tPC) 1'b1;
                end
                begin : we_blk 
                    we_n <= 1'b1;
                end
                begin : oe_blk 
                    oe_n <= #(tWC / 2) 1'b0; 
                    oe_n <= #(tWC / 2 + tRC + 4 * tPC) 1'b1;
                end
                #(tWC/2 + tRC + 5 * tPC);
            join
        end
    endtask

    /**************************************************************************
    *
    *  This task does the Load Configuration Register
    *
    **************************************************************************/
    
    task lcr_cycle;
        input [addr_bits - 1 : 0] lcr_addr;
        begin
            dq = {data_bits{1'bz}};
            fork
                begin : addr_blk 
                    addr <= #(tWC / 2) lcr_addr; 
                end
                begin : ce_blk 
                    ce_n <= #(tWC / 2) 1'b0; 
                    ce_n <= #(tWC / 2 + tCW) 1'b1;
                end
                //begin : lb_blk 
                //    lb_n <= #(tWC / 2) 1'b0; 
                //    lb_n <= #(tWC / 2 + tBW) 1'b1;
                //end
                //begin : ub_blk 
                //    ub_n <= #(tWC / 2) 1'b0; 
                //    ub_n <= #(tWC / 2 + tBW) 1'b1;
                //end
                begin : we_blk 
                    we_n <= #(tWC / 2) 1'b0; 
                    we_n <= #(tWC / 2 + tWP) 1'b1;
                end
                //begin : oe_blk 
                //    oe_n <= #(tWC / 2) 1'b0; 
                //    oe_n <= #(tWC / 2 + tBW) 1'b1;
                //end
                begin : zz_blk
                    zz_n <= #(tWC / 2 - tZZWE_min) 1'b0; 
                    zz_n <= #(tWC / 2 + tZZWE_min + tWC) 1'b1;
                end
                #(tWC + tWC);
            join
        end
    endtask


    // Test vectors
    initial begin
        lcr_cycle (22'b00000000000000_1_11_1_0_000);
        write_cycle(10, 100);
        write_cycle(11, 101);
        write_cycle(12, 102);
        write_cycle(13, 103);
        write_cycle(14, 104);
        read_cycle(10);
        page_cycle(11, 12, 13, 14);
        $stop;
        $finish;
    end

endmodule