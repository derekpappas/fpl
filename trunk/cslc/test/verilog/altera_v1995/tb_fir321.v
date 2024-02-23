`timescale 1 ns / 1 ps

module tb_mcv_fir;

parameter data_file_name = "data_in.txt" ;
parameter coef_file_name = "fir321_coef_reload0.txt" ;
parameter DATA_WIDTH = 16;	//input data bit width
parameter MSB_RM = 0;
parameter LSB_RM = 0;
parameter ACCUM_WIDTH = 35;	//used to calculate output bit width
parameter COEF_NUM = 18;	//coefficient bit width
parameter NUM_COEF_IN = 64;	//# of reloadable coefficients in fir321_coef_reload0.txt
parameter ENDDAT = 120 ;	//# of input data in data_in.txt
parameter NUM_OUT = 481 ;

wire [ACCUM_WIDTH - MSB_RM - LSB_RM -1:0] fir_res;
integer data_addr_cnt;
initial data_addr_cnt = 0;

wire done;
wire rdy_to_ld;
integer data[0:ENDDAT];
integer data_file;
integer coef_file;
integer coef[0:NUM_COEF_IN];
integer i,j;
//Generate control circuit
reg clk;
reg clk_en;
initial clk = 1;
always
  #5 clk <= ~clk;

reg clk2;
initial clk2 = 0;
always
  #4 clk2 <= ~clk2;

integer cnt_clks;

// keep track of clocks
initial cnt_clks = 0;
always @(posedge clk)
  cnt_clks <= cnt_clks + 1'b1;

initial clk_en = 1;
always @(posedge clk)
clk_en = 1'b1;
// rest Unit under test
reg rst_uut;
initial rst_uut = 0;
always @(negedge clk)
begin
  if (cnt_clks <= 3) rst_uut <= 1'b1;
  else               rst_uut <= 1'b0;
end                 
                 

// generate input data stream
reg reg_rdy;
always @(posedge clk)
  reg_rdy <= rdy_to_ld;
always @(posedge clk)
begin
  if (rdy_to_ld == 1'b1 && clk_en == 1'b1 && rst_uut == 1'b0)
  begin
    if (data_addr_cnt != ENDDAT) data_addr_cnt <= data_addr_cnt + 1'b1;
    else                         data_addr_cnt <= ENDDAT;
  end
end

initial
    begin
    data_file = $fopen(data_file_name,"r");
	 for(j = 0; j <= ENDDAT; j = j + 1)
		i = $fscanf(data_file, "%d", data[j]);
end

reg [DATA_WIDTH-1:0] data_value;
always @(posedge clk) begin
   if (clk_en == 1'b1) begin
      if (rdy_to_ld == 1'b1)
         data_value <= data[data_addr_cnt];
      else
         data_value <= 0;
   end
end

// generate coefficient data stream
reg [6:0] coef_addr_cnt;
// set coef_write enable
reg coef_we;
reg do_load;
reg we_flag;
reg ld_reg1;
reg ld_reg2;
reg ld_reg3;
initial we_flag <= 0;
always @(posedge clk2)
begin
	if(coef_we == 1 && do_load == 0)  we_flag <= 1;
end

initial do_load <= 0;
always @(posedge clk2)
begin
  if (rst_uut == 1'b0 && ld_reg2 == 0 &&  data_addr_cnt >2 && we_flag == 0) do_load <= 1;
  if (coef_addr_cnt == NUM_COEF_IN) do_load <= 0;
end

initial coef_we <= 0;
always @(posedge clk2)
begin
  if (do_load == 1) coef_we <= 1;
  else  coef_we <= 0;
end


initial 
begin
	ld_reg1 <= 0;
	ld_reg2 <= 0;
	ld_reg3 <= 0;
end

always@(posedge clk2)
begin
	ld_reg1 <= do_load;
	ld_reg2 <= ld_reg1;
	ld_reg3 <= ld_reg2;
end

initial coef_addr_cnt <= 0;
always@(posedge clk2)
begin
  if (ld_reg3== 0) coef_addr_cnt <=0;
  else              coef_addr_cnt <= coef_addr_cnt + 1'b1;
end

initial
    begin
    coef_file = $fopen(coef_file_name,"r");
	 for(j = 0; j < NUM_COEF_IN; j = j + 1)
		i = $fscanf(coef_file, "%d", coef[j]);
//    i = $fcloser(coef_file);
    end
wire [17:0] coef_in;
assign coef_in = coef[coef_addr_cnt];

fir321  UUT (.clk(clk),
          .rst(rst_uut),
          .data_in(data_value), 
          .coef_we(coef_we),
          .coef_in(coef_in),
          .coef_in_clk(clk2),
          .done(done),
          .rdy_to_ld(rdy_to_ld),
          .fir_result(fir_res) );


// write the output to a file
integer fid;
integer samp_cnt;

initial
begin
  fid = $fopen("fir_results.txt");
  samp_cnt = 0;
end
  
real fir_conv;
real conv;
reg [ACCUM_WIDTH - MSB_RM - LSB_RM : 0] conv_vec;
always @(posedge clk)
begin
conv_vec <= 1<<(ACCUM_WIDTH - MSB_RM - LSB_RM);
conv <= conv_vec;
end
  
always @(fir_res)
begin
  if (fir_res[ACCUM_WIDTH - MSB_RM - LSB_RM-1] == 1 ) 
      fir_conv <= fir_res - conv;
  else
     fir_conv <= fir_res;
end 


always @(posedge clk)
begin
	if(done == 1 && clk_en == 1)
	begin
		samp_cnt <= samp_cnt + 1;
		$fwrite (fid, "%17.0f\n",fir_conv);
	end
end 

// end simulation
always @(data_addr_cnt)
begin
  if (data_addr_cnt == ENDDAT - 10)
  begin
     $fclose(fid);
//     $finish;
  end
end
endmodule
