//NIOS ring processor

`define DATA_WIDTH 32
`define ADDR_WIDTH 32
`define CMD_WIDTH 32
`define UNIT_ID_WIDTH 4
`define NODE_ID_WIDTH 32

module chip();
endmodule

module ring_node(node_ring_ifc_in_nrbus_data, 
                 node_ring_ifc_in_nrbus_addr,
                 node_ring_ifc_in_nrbus_cmd,
                 node_ring_ifc_in_nrbus_unit_id,
                 node_ring_ifc_in_nrbus_node_id,
                 node_ring_ifc_in_nrbus_burst,
                 node_ring_ifc_in_nrbus_valid,
                 node_ring_ifc_out_nrbus_data, 
                 node_ring_ifc_out_nrbus_addr,
                 node_ring_ifc_out_nrbus_cmd,
                 node_ring_ifc_out_nrbus_unit_id,
                 node_ring_ifc_out_nrbus_node_id,
                 node_ring_ifc_out_nrbus_burst,
                 node_ring_ifc_out_nrbus_valid,
                 clk,
                 rst_);
                 
    input [`DATA_WIDTH-1:0] node_ring_ifc_in_nrbus_data;
    input [`ADDR_WIDTH-1:0] node_ring_ifc_in_nrbus_addr;
    input [`CMD_WIDTH-1:0] node_ring_ifc_in_nrbus_cmd;
    input [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_unit_id;
    input [`NODE_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_node_id;
    input node_ring_ifc_in_nrbus_burst;
    output node_ring_ifc_in_nrbus_valid;
    output [`DATA_WIDTH-1:0] node_ring_ifc_out_nrbus_data;
    output [`ADDR_WIDTH-1:0] node_ring_ifc_out_nrbus_addr;
    output [`CMD_WIDTH-1:0] node_ring_ifc_out_nrbus_cmd;
    output [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_unit_id;
    output [`NODE_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_node_id;
    output node_ring_ifc_out_nrbus_burst;
    input node_ring_ifc_out_nrbus_valid;
    input clk;
    input rst_;
    
    in in_0();
    delay delay_1();
    out out_2();
    cmd_fifo cmd_fifo_0();
    ingress ingress_0();
    egress egress_0();
    ingress_fifo ingress_fifo_0();
    egress_fifo egress_fifo_0();
    inst_mem inst_mem_0();
    data_mem data_mem_0();
    nios2 nios2_0();
    custom_logic custom_logic_0();
    custom_logic_regs custom_logic_regs_0(); 
    out_mux out_mux_0();
    deframer deframer_0();
    framer framer_0();
endmodule

module in_0(node_ring_ifc_in_nrbus_data, 
            node_ring_ifc_in_nrbus_addr,
            node_ring_ifc_in_nrbus_cmd,
            node_ring_ifc_in_nrbus_unit_id,
            node_ring_ifc_in_nrbus_node_id,
            node_ring_ifc_in_nrbus_burst,
            node_ring_ifc_in_nrbus_valid,
            node_ring_ifc_out_nrbus_data, 
            node_ring_ifc_out_nrbus_addr,
            node_ring_ifc_out_nrbus_cmd,
            node_ring_ifc_out_nrbus_unit_id,
            node_ring_ifc_out_nrbus_node_id,
            node_ring_ifc_out_nrbus_burst,
            node_ring_ifc_out_nrbus_valid,
            clk,
            rst_);
            
    input [`DATA_WIDTH-1:0] node_ring_ifc_in_nrbus_data;
    input [`ADDR_WIDTH-1:0] node_ring_ifc_in_nrbus_addr;
    input [`CMD_WIDTH-1:0] node_ring_ifc_in_nrbus_cmd;
    input [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_unit_id;
    input [`NODE_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_node_id;
    input node_ring_ifc_in_nrbus_burst;
    output node_ring_ifc_in_nrbus_valid;
    output [`DATA_WIDTH-1:0] node_ring_ifc_out_nrbus_data;
    output [`ADDR_WIDTH-1:0] node_ring_ifc_out_nrbus_addr;
    output [`CMD_WIDTH-1:0] node_ring_ifc_out_nrbus_cmd;
    output [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_unit_id;
    output [`NODE_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_node_id;
    output node_ring_ifc_out_nrbus_burst;
    input node_ring_ifc_out_nrbus_valid;
    input clk;
    input rst_;
endmodule

module delay_1(node_ring_ifc_in_nrbus_data, 
               node_ring_ifc_in_nrbus_addr,
               node_ring_ifc_in_nrbus_cmd,
               node_ring_ifc_in_nrbus_unit_id,
               node_ring_ifc_in_nrbus_node_id,
               node_ring_ifc_in_nrbus_burst,
               node_ring_ifc_in_nrbus_valid,
               node_ring_ifc_out_nrbus_data, 
               node_ring_ifc_out_nrbus_addr,
               node_ring_ifc_out_nrbus_cmd,
               node_ring_ifc_out_nrbus_unit_id,
               node_ring_ifc_out_nrbus_node_id,
               node_ring_ifc_out_nrbus_burst,
               node_ring_ifc_out_nrbus_valid,
               clk,
               rst_);
               
       input [`DATA_WIDTH-1:0] node_ring_ifc_in_nrbus_data;
       input [`ADDR_WIDTH-1:0] node_ring_ifc_in_nrbus_addr;
       input [`CMD_WIDTH-1:0] node_ring_ifc_in_nrbus_cmd;
       input [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_unit_id;
       input [`NODE_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_node_id;
       input node_ring_ifc_in_nrbus_burst;
       output node_ring_ifc_in_nrbus_valid;
       output [`DATA_WIDTH-1:0] node_ring_ifc_out_nrbus_data;
       output [`ADDR_WIDTH-1:0] node_ring_ifc_out_nrbus_addr;
       output [`CMD_WIDTH-1:0] node_ring_ifc_out_nrbus_cmd;
       output [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_unit_id;
       output [`NODE_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_node_id;
       output node_ring_ifc_out_nrbus_burst;
       input node_ring_ifc_out_nrbus_valid;
       input clk;
       input rst_;
endmodule

module out_2(node_ring_ifc_in_nrbus_data, 
             node_ring_ifc_in_nrbus_addr,
             node_ring_ifc_in_nrbus_cmd,
             node_ring_ifc_in_nrbus_unit_id,
             node_ring_ifc_in_nrbus_node_id,
             node_ring_ifc_in_nrbus_burst,
             node_ring_ifc_in_nrbus_valid,
             node_ring_ifc_out_nrbus_data, 
             node_ring_ifc_out_nrbus_addr,
             node_ring_ifc_out_nrbus_cmd,
             node_ring_ifc_out_nrbus_unit_id,
             node_ring_ifc_out_nrbus_node_id,
             node_ring_ifc_out_nrbus_burst,
             node_ring_ifc_out_nrbus_valid,
             clk,
             rst_);
             
     input [`DATA_WIDTH-1:0] node_ring_ifc_in_nrbus_data;
     input [`ADDR_WIDTH-1:0] node_ring_ifc_in_nrbus_addr;
     input [`CMD_WIDTH-1:0] node_ring_ifc_in_nrbus_cmd;
     input [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_unit_id;
     input [`NODE_ID_WIDTH-1: 0] node_ring_ifc_in_nrbus_node_id;
     input node_ring_ifc_in_nrbus_burst;
     output node_ring_ifc_in_nrbus_valid;
     output [`DATA_WIDTH-1:0] node_ring_ifc_out_nrbus_data;
     output [`ADDR_WIDTH-1:0] node_ring_ifc_out_nrbus_addr;
     output [`CMD_WIDTH-1:0] node_ring_ifc_out_nrbus_cmd;
     output [`UNIT_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_unit_id;
     output [`NODE_ID_WIDTH-1: 0] node_ring_ifc_out_nrbus_node_id;
     output node_ring_ifc_out_nrbus_burst;
     input node_ring_ifc_out_nrbus_valid;
     input clk;
     input rst_;
endmodule

module cmd_fifo();
endmodule

module ingress();
endmodule

module egress();
endmodule

module ingress_fifo();
endmodule

module egress_fifo();
endmodule

module inst_mem();
endmodule

module data_mem();
endmodule

module nios2();
endmodule

module custom_logic();
endmodule

module custom_logic_regs();
endmodule

module out_mux();
endmodule

module deframer();
endmodule

module framer();
endmodule