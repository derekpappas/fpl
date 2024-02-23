`timescale 1 ps / 1 ps

module id_vers_checker(rd_1st_3,
                       ra,
                       vector);
                       
parameter VECTOR_ID_VERS_ADDR = 0;
parameter VECTOR_ID_VERS = 0;
parameter VECTOR_WIDTH = 0;
parameter VECTOR_RA_W = 0;
parameter VECTOR_NAME = 0;
parameter ID_VERS_NAME = 0;

input                        rd_1st_3;
input [VECTOR_RA_W  - 1 : 0] ra;
input [VECTOR_WIDTH - 1 : 0] vector;

wire addr_eq_id_version_addr   = ra == VECTOR_ID_VERS_ADDR;
wire addr_eq_id_version        = addr_eq_id_version_addr & rd_1st_3;
wire vector_id_version_correct = (vector == VECTOR_ID_VERS);
reg  vector_id_version_match;

always@(posedge addr_eq_id_version) begin
      vector_id_version_match = 1'b0;
      if (vector_id_version_correct ) begin 
         vector_id_version_match = 1'b1;
         $display("%s MATCHED   for %s vector ! tb ra = %d Defined %s VECTOR %s = %d File  %s = %d Continuing simulation!",
                   ID_VERS_NAME, VECTOR_NAME, ra, VECTOR_NAME, ID_VERS_NAME, VECTOR_ID_VERS, ID_VERS_NAME, vector);
      end else begin 
         vector_id_version_match = 1'b0;
         $display("%s MISMATCH   for %s vector ! tb ra = %d Defined %s VECTOR %s != %d File  %s = %d Exiting simulation!",
                   ID_VERS_NAME, VECTOR_NAME, ra, VECTOR_NAME, ID_VERS_NAME, VECTOR_ID_VERS, ID_VERS_NAME, vector);
         //stop_vec_mtc = 1'b1;
         //$finish;
      end
end

endmodule
