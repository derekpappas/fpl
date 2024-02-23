/* Frame Grabber Module © 2005**************************/
/* Made By Azhar Hussain**************************/
/* 2k2 Electrical  UET Taxila ,Pakistan.********/	 

module Azhar_fg(vidin_clk,vidin_idq,vidin_ipd,vidin_igph,vidin_igpv,vidin_itri,vidin_itrdy,vidout_clk,vidout_hsync_n,vidout_vsync_n,vidout_blank_n,vidout_g,vidout_b,vidout_r,ram_ce_n,pb_oe_n,pb_we_n,pb_ub_n,pb_lb_n,pb_a,pb_d);
input    vidin_clk;
input    vidin_idq;
input    vidin_igph;
input    vidin_igpv;
input    [7:0] vidin_ipd;
output   vidin_itri, vidin_itrdy;
wire     vidin_itri, vidin_itrdy;
output   vidout_clk;
wire     vidout_clk;
output   vidout_hsync_n;
output   vidout_vsync_n;
output   vidout_blank_n;
output   [9:0] vidout_g;
output   [9:0] vidout_b;
output   [9:0] vidout_r;
output   ram_ce_n;
wire     ram_ce_n;
output   pb_oe_n;
output   pb_we_n;
output   pb_ub_n;
output   pb_lb_n;
output [17:0]pb_a;
inout  [7:0]pb_d;

reg vidout_hsync_n, vidout_vsync_n,vidout_blank_n;
wire[9:0] vidout_g;
wire   [9:0] vidout_b;
wire [9:0] vidout_r;
wire  pb_oe_n;
wire   pb_we_n;
wire  pb_ub_n;
wire  pb_lb_n;
wire   [17:0]pb_a;
parameter [3:0] wfvs=0;	 /*Wait for  Vertical SYNC*/ 
parameter [3:0] wfvse=1;	 /*Wait for  Vertical SYNC end*/ 
parameter [3:0] wfhs=2;	 /*Wait for Horizontal SYNC*/ 
parameter [3:0] wfhse=3;	 /*Wait for Horizontal SYNC end*/ 
parameter [3:0] avcb=4;	 /*Active Video chrominance for blue comp.*/ 
parameter [3:0] avlb=5;	 /*Active Video luminance for bluce comp.*/ 
parameter [3:0] avcr=6;	 /*Active Video chrominance for red comp.*/  
parameter [3:0] avlr=7;	 /*Active Video luminance for red comp.*/ 
parameter [3:0] display=8; /*Display the Stored Frame */ 
reg [3:0] vid_next;
wire clk;
reg reset;
reg  reset_cnt;
reg [9:0] grab_cntrlo;
reg [17:10] grab_cntrhi;
reg [17:0]  grab_addr;
reg grab;
reg display_frame;
reg [7:0] luminance;
reg refresh;
reg [7:0] grabhi;
reg [9:0]  grablo;
reg [23:0] refresh_cnt;
reg [9:0] cntx;
reg [9:0] cnty;
reg ResetCntX, EnableCntY, ResetCntY;
reg valid ;
assign clk=vidin_clk;
assign vidin_itri=1'b1;
assign vidin_itrdy=1'b1;

 /**************************GENERATE A RESET*************************************************/
always@(posedge clk)
begin
if(reset_cnt==0)
reset<=1'b0;
else
begin
reset<=1'b1;
reset_cnt<=reset_cnt+1'b1;
end
end

/**************************GENERATE A DISPLAY REFRESH **********************************************/
always@(posedge clk)
begin

refresh_cnt<=refresh_cnt+1;
if(refresh_cnt==0)
refresh<=1'b1;
else
refresh<=1'b0;

end

/**************************SIMPLE STATE M/C THAT INTERPRETS DATA STREAM FROM SAA7114 ****************************/
/*************************LUMINANCE DATA IS ON LOWER 8 BITS OF RAM DATA BUS********************************/
always @(posedge clk)
begin

if(reset==1'b1)
  begin
vid_next<=wfvs;

  end
    else
        begin

            if(vidin_idq==1'b1)

               begin
                       grab<=1'b0;
                       display_frame<=1'b0;

                           case   (vid_next)

                            wfvs:        begin

                                                if(vidin_igpv==1'b0)
                                                   vid_next<=wfvse;
                                         end

                            wfvse:       begin

                                                 grab_cntrlo<={10{1'b0}};
                                                 grab_cntrhi<={8{1'b0}};
                                                 if(vidin_igpv==1'b1)
                                                   vid_next<=wfhs;
                                        end

                            wfhs:        begin

                                                  if(vidin_igph==1'b0)
                                                    vid_next<=wfhse;
                                         end

                            wfhse:       begin

                                                   grab_addr<={grab_cntrhi,grab_cntrlo};
                                                   if(vidin_igph==1'b1)
									        begin
                                                          grab_cntrlo<={10{1'b0}};
		                                              grab_cntrhi<=grab_cntrhi+1;
                                                        vid_next<=avlb;
                                                     end
                                         end

                            avcb:        begin

                                                       if(vidin_igpv==1'b0)
                                                          vid_next<=display;
                                                       else   if(vidin_igph==1'b0)
                                                               vid_next<=wfhse;
                                                       else
                                                               vid_next<=avlb;

                                           end

                            avlb:         begin

                                                       if(vidin_igpv==1'b0)
                                                          vid_next<=display;
                                                       else   if(vidin_igph==1'b0)
                                                           vid_next<=wfhse;
                                                        else
                                                           begin
                                                      vid_next<=avcr;
	                                                 luminance<=vidin_ipd;
                                                      grab<=1'b1;
			                                       grab_cntrlo<=grab_cntrlo+1;
	                                                   grab_addr<={grab_cntrhi,grab_cntrlo};
	   					
                                                           end

                                          end

                           avcr:          begin

                                                       if(vidin_igpv==1'b0)
                                                          vid_next<=display;
                                                      else   if(vidin_igph==1'b0)
                                                               vid_next<=wfhse;
                                                      else
                                                               vid_next<=avlr;

                                           end

                         avlr:            begin

                                                              if(vidin_igpv==1'b0)
                                                                    vid_next<=display;
                                                              else   if(vidin_igph==1'b0)
                                                                    vid_next<=wfhse;
                                                              else
                                                                  begin
                                                                   vid_next<=avcb;
                                                                   luminance<=vidin_ipd;
										   grab<=1'b1;
		                                                       grab_cntrlo<=grab_cntrlo;				
 	                                                             grab_addr<={grab_cntrhi,grab_cntrlo};
                                                                   end

                                           end

/**********************************DISPLAY STORED FRAME DATA********************************************/

                        display:          begin

                                                        if(refresh==1'b1)
                                                         begin
                                                                vid_next<=wfvs;
                                                                display_frame<=1'b0;
                                                         end
                                                           else
                                                               display_frame<=1'b1;

                                           end

                        default:         begin
											 vid_next<=wfvs;
                                          end

                    endcase

                end
       end
end

/*****************************************ASSIGNMENTS***********************************************************/

assign ram_ce_n=1'b0;
assign pb_oe_n=(display_frame==1'b0)  ?   1'b1  :   1'b0;
assign pb_we_n=(grab==1'b1 & clk==1'b1)   ?  1'b0  :  1'b1;
assign pb_ub_n=1'b1;
assign pb_lb_n=1'b0;
assign pb_d[7:0]=(display_frame==1'b0)  ? luminance :{8{1'bz}}  ;
assign pb_a[17:0]=(grab==1'b1)? grab_addr :{grabhi[7:0],grablo[9:0]}  ;
assign vidout_clk = clk;
assign vidout_r=( display_frame==1'b0)?10'bzzzzzzzzzz:{(pb_d[7:0]),2'b00};
assign vidout_b=( display_frame==1'b0)?10'bzzzzzzzzzz:{(pb_d[7:0]),2'b00};
assign vidout_g=( display_frame==1'b0)?10'bzzzzzzzzzz:{(pb_d[7:0]),2'b00};

always@(posedge clk)

begin
 if(display_frame==1)
   begin
    if(valid == 1'b1)
     begin
      if(cntx==159 && cnty==119)
         begin
                grablo<={10{1'b0}};
                grabhi<= 1;
         end

      if( (cntx >= 160) && (cntx<=480)  &&  (cnty >= 120) && (cnty <= 350))

         begin
           grablo<=grablo+1;
            if(cntx==480)
              begin
                grabhi<=grabhi+1;
                 if(cnty==350)
                   grabhi<=1;
              end

         end

     else
        begin
         grablo<={10{1'b0}};
         grabhi<= grabhi;

        end

     end

  end

end

//Counters
always @ (posedge clk)

begin
        if (ResetCntX)
           cntx[9:0] <= {10{1'b0}};
        else
           cntx[9:0] <= cntx[9:0] + 1;
	   if (ResetCntY)
           cnty[9:0] <= {{1'b0}};
        else 
	   if (EnableCntY) cnty[9:0] <= cnty[9:0] + 1;
        else  
	      cnty[9:0]<=cnty[9:0];

end

//Sync controller
always @(posedge clk )
begin

ResetCntX 	<= (cntx[9:0] == 799);
EnableCntY 	<= (cntx[9:0] == 650 );
ResetCntY 	<= (cnty[9:0] ==527);

end
// Generating horizontal and vertical Syncs for VGA Monitor 
always @(posedge clk)

begin

vidout_hsync_n <= ~((cntx[9:0] >= 656) && (cntx[9:0] <= 752));
vidout_vsync_n	<= ~((cnty[9:0] == 493)  	|| (cnty[9:0]  == 494 ));	
valid 	<=  (((cntx[9:0] == 800) || (cntx[9:0] < 640)) &&	 ((cnty[9:0] ==  527) 	|| (cnty[9:0] < 480 )) );
vidout_blank_n     <=  ~((cntx>=640)&&(cntx < 800)) ;

end

endmodule









