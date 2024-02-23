//Copyright 2005, Cypress Semiconductor Corporation
/*****************************************************************************/
//This software is owned by Cypress Semiconductor Corporation (Cypress) and is
//protected by United States copyright laws and international treaty provisions.
//Cypress hereby grants to Licensee a personal, non-exclusive, non-transferable
//license to copy, use, modify, create derivative works of, and compile the
//Cypress Source Code and derivative works for the sole purpose of creating
//custom software in support of Licensee product ("Licensee Product") to be
//used only in conjunction with a Cypress integrated circuit. Any reproduction,
//modification, translation, compilation, or representation of this software
//except as specified above is prohibited without the express written permission
//of Cypress.


//Disclaimer: Cypress makes no warranty of any kind, express or implied, with
//regard to this material, including, but not limited to, the implied warranties
//of merchantability and fitness for a particular purpose. Cypress reserves the
//right to make changes without further notice to the materials described
//herein. Cypress does not assume any liability arising out of the application
//or use of any product or circuit described herein. Cypress products described
// herein are not authorized for use as components in life-support devices.
//This software is protected by and subject to worldwide patent coverage,
//including U.S. and foreign patents. Use may be limited by and subject to
//the Cypress Software License Agreement.
/*****************************************************************************/

//Source File Information Header Template
// *******************************************************************
// File           : fullflex72s18_mbox.v
// Author         :
// Author's Email :
// Date           : 23 MAR 2005
// Revision       : 1.0
// *******************************************************************
// Description :
//      This is the mailbox logic . 
//      When the left port writes into the LAST ADDR
//      location, this unit will generate the interrupt 
//      for right port.
//      Similarly when right port writes into the LAST ADDR -1 
//      location , it generates the interrupt for left port 
//
// *******************************************************************


 module fullflex72s18_mbox(ileft_clk       ,
                       iright_clk      ,
                       inreset         ,
                       ileft_addr      ,
                       ileft_read_en   ,
                       ileft_write_en  ,
                       inleft_busy     ,
                       iright_addr     ,
                       iright_read_en  ,
                       iright_write_en ,
                       inright_busy    ,
                       onleftintr      ,
                       onrightintr
	              );

   // Selectable parameters
   parameter              CYP_ADDRWIDTH = 18;
   parameter              CYP_LASTADDR  = 262143;


   input                     ileft_clk;       // Left port clock
   input                     iright_clk;      // Right port clock
   input                     inreset;         // Master reset
   input [CYP_ADDRWIDTH-1:0] ileft_addr;      // Left port address
   input [CYP_ADDRWIDTH-1:0] iright_addr;     // Right port address
   input                     ileft_read_en;   // Left port read  enable active low
   input                     ileft_write_en;  // Left port write enable
   input                     inleft_busy;     // Left port busy indication
   input                     iright_read_en;  // Right port read  enable
   input                     iright_write_en; // Right port write enable
   input                     inright_busy;    // Right port busy indication
   output                    onleftintr;      // Left interrupt output
   output                    onrightintr;     // Right interrupt output

   wire                      intr_left_wr;
   reg                       intr_left_wr_delayed;
   wire                      intr_left_wr_filtered;
   reg                       intr_right_rd_delayed;
   wire                      intr_right_rd_filtered;
   wire                      intr_right_rd;
   reg                       onrightintr;
   wire                      intr_right_wr;
   wire                      intr_left_rd;
   reg                       intr_right_wr_delayed;
   reg                       intr_left_rd_delayed;
   wire                      intr_right_wr_filtered;
   wire                      intr_left_rd_filtered;
   reg                       onleftintr;
   reg                       left_write_en;
   reg                       left_read_en;
   reg                       nleft_busy;
   reg                       right_write_en;
   reg                       right_read_en;
   reg                       nright_busy;

   // Synchronize the left interrupt control signals
   // with respect to left clock
   always @ (posedge ileft_clk)
   begin
     #0.001;
     left_write_en = ileft_write_en;
     left_read_en  = ileft_read_en;
     nleft_busy    = inleft_busy;
   end

   // Synchronize the right interrupt control signals
   // with respect to right clock
   always @ (posedge iright_clk)
   begin
     #0.001;
     right_write_en = iright_write_en;
     right_read_en  = iright_read_en;
     nright_busy    = inright_busy;
   end

   
   // Right interrupt generation control signals update 
   assign intr_left_wr  = ((ileft_addr  == CYP_LASTADDR) & 
	                   (left_write_en & nleft_busy))  ? 1 : 0;
   assign intr_right_rd = ((iright_addr == CYP_LASTADDR) & 
	                   (right_read_en & nright_busy)) ? 1 : 0;

   assign intr_left_wr_filtered = intr_left_wr && intr_left_wr_delayed;
   assign intr_right_rd_filtered = intr_right_rd && intr_right_rd_delayed;
   
   // Generate delayed intr_left_wr
   always @(intr_left_wr)
	   intr_left_wr_delayed <= #0.005 intr_left_wr;

   // Generate delayed intr_right_rd
   always @(intr_right_rd)
	   intr_right_rd_delayed <= #0.005 intr_right_rd;

   // Right port interrupt generation
   always @(posedge intr_left_wr_filtered or posedge intr_right_rd_filtered or negedge inreset)
   begin
      if(inreset == 1'b0)
        onrightintr = 1'b1;
      else if(intr_left_wr_filtered)
        #(TP.tSINT_r - 0.007) onrightintr = 1'b0;
      else if (intr_right_rd_filtered)
        #(TP.tRINT_r - 0.007) onrightintr = 1'b1;
   end

   // Left interrupt generation control signals update 
   assign intr_right_wr = ((iright_addr == CYP_LASTADDR-1) & 
	                   (right_write_en & nright_busy)) ? 1:0;
   assign intr_left_rd  = ((ileft_addr  == CYP_LASTADDR-1) & 
	                   (left_read_en   & nleft_busy))  ? 1:0;
   assign intr_right_wr_filtered = intr_right_wr && intr_right_wr_delayed;
   assign intr_left_rd_filtered = intr_left_rd && intr_left_rd_delayed;
   
   // Generate delayed intr_right_wr
   always @(intr_right_wr)
	   intr_right_wr_delayed <= #0.005 intr_right_wr;

   // Generate delayed intr_right_wr
   always @(intr_left_rd)
	   intr_left_rd_delayed <= #0.005 intr_left_rd;
   
   // Left port interrupt generation
   always @(posedge intr_right_wr_filtered or posedge intr_left_rd_filtered or negedge inreset)
   begin
      if (inreset == 1'b0)
        onleftintr = 1'b1;
      else if(intr_right_wr_filtered)
        #(TP.tSINT_l - 0.007) onleftintr = 1'b0;
      else if (intr_left_rd_filtered)
        #(TP.tRINT_l - 0.007) onleftintr = 1'b1;
   end

 endmodule
