task INI;
input [4:0]		wmt_exsigin;
begin: INI_blk
	realtime 	tmp_time;

	wm_com = 4'b1XXX;
	wm_exsigin = wmt_exsigin;
	tmp_time = wm_cycle * 8;
	#(tmp_time) wm_com = 4'b1111;
	wm_exsigin = 5'b10000;
end
endtask

task MRS;
input [0:0]		wmt_DRS;
input [2:0]		wmt_CL;
input [0:0]		wmt_BT;
input [2:0]		wmt_BL;
begin: MRS_blk
	realtime 	tmp_time;

	reg [0:0] wmt_TM;
	reg [3:0] wmt_RFU;
	wmt_TM = 1'b0;
	wmt_RFU = 4'b0000;
	{ wm_addr[12:11], wm_addr[10:9]} = wmt_RFU;
	{ wm_addr[8:8]} = wmt_DRS;
	{ wm_addr[7:7]} = wmt_TM;
	{ wm_addr[6:4]} = wmt_CL;
	wm_clatency = wm_addr[6:4];
	{ wm_addr[3:3]} = wmt_BT;
	{ wm_addr[2:0]} = wmt_BL;
	wm_com = 4'b0000;
	#2.40 wm_com = 4'b1XXX;
	tmp_time = wm_cycle-2.40;
	#(tmp_time);
	tmp_time = 1*wm_cycle;
	#(tmp_time);
end
endtask

task EMRS;
input [2:0]		wmt_DLL;
begin: EMRS_blk
	realtime 	tmp_time;

	reg [9:0] wmt_RFU;
	wmt_RFU = 10'b0100000000;
	{ wm_addr[12:11], wm_addr[10:7], wm_addr[5:2]} = wmt_RFU;
	{ wm_addr[6:6], wm_addr[1:0]} = wmt_DLL;
	wm_com = 4'b0000;
	#2.40 wm_com = 4'b1XXX;
	tmp_time = wm_cycle-2.40;
	#(tmp_time);
	tmp_time = 1*wm_cycle;
	#(tmp_time);
end
endtask

task AREF;
input 		NULL_arg;
begin: AREF_blk
	realtime 	tmp_time;

	wm_com = 4'b0001;
	#2.40 wm_com = 4'b1XXX;
	tmp_time  = $realtime + (72 - 1.20);
	while($realtime < tmp_time) begin
	    if(($realtime + wm_cycle) < tmp_time) begin
		@(posedge CLK);
	    end
	    else begin
		#(wm_cycle - 1.20);
		tmp_time = 0;
	    end
	end
end
endtask

task ACTIVE;
input [1:0]		wmt_BANK;
input [10:0]		wmt_ROW_AD;
begin: ACTIVE_blk
	realtime 	tmp_time;

	{ wm_addr[12:11]} = wmt_BANK;
	{ wm_addr[10:0]} = wmt_ROW_AD;
	wm_com = 4'b0011;
	#2.40 wm_com = 4'b1XXX;
	tmp_time = wm_cycle-2.40;
	#(tmp_time);
end
endtask

task READ;
input [1:0]		wmt_BANK;
input [0:0]		wmt_APRE_AD;
input [7:0]		wmt_COL_AD;
input [31:0] 		wmt_cycle;
begin: READ_blk
	integer 	i;
	realtime 	tmp_time;

	reg [1:0] wmt_DONTCARE;
	i = wmt_cycle;
	wmt_DONTCARE = 2'b00;
	{ wm_addr[12:11]} = wmt_BANK;
	{ wm_addr[8:8]} = wmt_APRE_AD;
	{ wm_addr[7:0]} = wmt_COL_AD;
	{ wm_addr[10:9]} = wmt_DONTCARE;
	wm_com = 4'b0101;
	#2.40 wm_com = 4'b1XXX;
	tmp_time = wm_cycle-2.40;
	#(tmp_time);
	if(wmt_cycle == 1)
		tmp_time = (i-1) * wm_cycle;
	else
		tmp_time = ((i/2)-1) * wm_cycle;
	#(tmp_time);
end
endtask

task WRITE;
input [1:0]		wmt_BANK;
input [0:0]		wmt_APRE_AD;
input [7:0]		wmt_COL_AD;
input [31:0]		wmt_datain;
input [31:0] 		wmt_cycle;
input		start_ds;
begin: WRITE_blk
	integer 	i,j;
	realtime 	tmp_time;

	reg [1:0] wmt_DONTCARE;
	wmt_DONTCARE = 2'b00;
	{ wm_addr[12:11]} = wmt_BANK;
	{ wm_addr[8:8]} = wmt_APRE_AD;
	{ wm_addr[7:0]} = wmt_COL_AD;
	{ wm_addr[10:9]} = wmt_DONTCARE;
	wm_com = 4'b0100;
	if(wmt_cycle == 1) begin
		wm_datain = wmt_datain;
		#2.40 wm_com = 4'b1XXX;
		tmp_time = wm_cycle-2.40;
		#(tmp_time);
		wm_datain = 32'bz;
	end
	else begin
		tmp_time = wm_cycle;
		fork
			if(start_ds == 1'b0) begin
				#1.20;
				wm_dqs[0] <= 1'b0;
			end
		#2.40 wm_com = 4'b1XXX;
		join

		j = 0;
		i = wmt_cycle;
		@(CLK);
		wm_dqs <= 1'b0;
		wm_datain <= #(tmp_time/4) wmt_datain;
		j = j + 1;
		for (i = 0; i < wmt_cycle; i = i + 1) begin
			@(CLK);
			wm_dqs[0] <= ~wm_dqs[0];
			#(tmp_time/4);
			wm_datain = wm_datain + 1;
			if( i != wmt_cycle-1) begin
				wm_dqs[0] <= @(CLK) ~wm_dqs[0];
			end
		end
		if(j == 1) begin
			wm_datain = 32'bz;
			#(tmp_time/4 - 1.20);
			wm_dqs <= @(negedge CLK) 1'bz;
		end
	end
end
endtask

task PRECHARGE;
input [2:0]		wmt_BANK;
begin: PRECHARGE_blk
	realtime 	tmp_time;

	reg [9:0] wmt_DONTCARE;
	wmt_DONTCARE = 10'bXXXXXXXXXX;
	{ wm_addr[12:11], wm_addr[8:8]} = wmt_BANK;
	{ wm_addr[10:9], wm_addr[7:0]} = wmt_DONTCARE;
	wm_com = 4'b0010;
	#2.40 wm_com = 4'b1xxx;
	tmp_time = wm_cycle-2.40;
	#(tmp_time);
end
endtask

