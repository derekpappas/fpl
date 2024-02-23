module m_map;
    parameter M_MAP_LOWER_BOUND = 0;
    parameter M_MAP_UPPER_BOUND = 31;
    parameter M_MAP_INCR_AMOUNT = 8;
    reg m_map [M_MAP_LOWER_BOUND:M_MAP_UPPER_BOUND];
    integer i;
//    for (i = M_MAP_LOWER_BOUND; i <= M_MAP_UPPER_BOUND; i = i + M_MAP_INCR_AMOUNT) begin
//      m_map [i] = 0;
//    end
endmodule
`define RESERVED_MMAP_RESERVED_ADDR_LOW 16'h3FFF
`define RESERVED_MMAP_RESERVED_ADDR_HIGH 16'h7FFF
module reserved_mmap;
reg reserved_mmap [16'h0000:16'hFFFF];
endmodule