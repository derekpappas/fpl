//------------------------------------------------------------------------------
//
//     This confidential and proprietary software may be used only
//     as authorized by a licensing agreement from Spike technologies Inc.
//     In the event of publication, the following notice is applicable:
//
//                (C) COPYRIGHT 2001 SPIKE TECHNOLOGIES INC.
//                          ALL RIGHTS RESERVED
//
//     The entire notice above must be reproduced on all authorized copies.
//
// File         : cy7c0853v_Task_model.v
//
// Author       : Palani
//
// Date         : Sep 03 '01
//
// Version      : 1.1
//
// Abstract     : This file declares the functions and tasks used for modelling
//
// Notes        : First Release
//
// Datasheet    : Cypress cy7c0853v, 3.3V 256K x 36 Synchronous Dual Port RAM,
//                (July 24, 2001)
//
// Modification History:
// Date         By       Version     Change Description
// ==========================================================================
// 03/09/2001   Palani    1.0         First Release.
// 
//
//
//
// ==========================================================================
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Task:        drive_valid_outputs
//
// Description: Drives the outputs of respective ports to valid value depending upon the 
//              output enable bit value(e.g.rdl_en_p2).
//-----------------------------------------------------------------------------------------------
task drive_valid_outputs;
      input port;
      input [`BT_M:0] byte_no;

      case (port)
        `LEFT : begin
           case (byte_no)
             0: begin
                if (rdl_en_p2[0] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[8:0] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[8:0] <= #tCKLZ `BITSPL'hX;
                   end
                   dql_r[8:0] <= #tCD2 dql_p2[8:0];
                end else begin
                   dql_r[8:0] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             1: begin
                if (rdl_en_p2[1] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[17:9] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[17:9] <= #tCKLZ `BITSPL'hX;
                   end
                   dql_r[17:9] <= #tCD2 dql_p2[17:9];
                end else begin
                   dql_r[17:9] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             2: begin
                if (rdl_en_p2[2] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[26:18] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[26:18] <= #tCKLZ `BITSPL'hX;
                   end
                   dql_r[26:18] <= #tCD2 dql_p2[26:18];
                end else begin
                   dql_r[26:18] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             3: begin
                if (rdl_en_p2[3] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[35:27] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[35:27] <= #tCKLZ `BITSPL'hX;
                   end
                   dql_r[35:27] <= #tCD2 dql_p2[35:27];
                end else begin
                   dql_r[35:27] <= #tCKHZ `BITSPL'hZ;                         
                end
             end  

             default: $display("Model Internal Error");

           endcase
        end
           
        `RIGHT : begin
           case (byte_no)
             0: begin
                if (rdr_en_p2[0] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[8:0] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[8:0] <= #tCKLZ `BITSPL'hX;
                   end
                   dqr_r[8:0] <= #tCD2 dqr_p2[8:0];
                end else begin
                   dqr_r[8:0] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             1: begin
                if (rdr_en_p2[1] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[17:9] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[17:9] <= #tCKLZ `BITSPL'hX;
                   end
                   dqr_r[17:9] <= #tCD2 dqr_p2[17:9];
                end else begin
                   dqr_r[17:9] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             2: begin
                if (rdr_en_p2[2] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[26:18] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[26:18] <= #tCKLZ `BITSPL'hX;
                   end
                   dqr_r[26:18] <= #tCD2 dqr_p2[26:18];
                end else begin
                   dqr_r[26:18] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             3: begin
                if (rdr_en_p2[3] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[35:27] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[35:27] <= #tCKLZ `BITSPL'hX;
                   end
                   dqr_r[35:27] <= #tCD2 dqr_p2[35:27];
                end else begin
                   dqr_r[35:27] <= #tCKHZ `BITSPL'hZ;                         
                end
             end        

             default: $display("Model Internal Error");

           endcase 
        end

        default: $display("Model Internal Error");        

      endcase
endtask // drive_valid_outputs


//-----------------------------------------------------------------------------------------------
// Task:         drive_outputs_oe_hi
//
// Description: Drives the outputs of respective ports to either x or z value depending upon the 
//              output enable bit value(e.g.rdl_en_p2).
//-----------------------------------------------------------------------------------------------
task drive_outputs_oe_hi;
      input port;
      input [`BT_M:0] byte_no;

      case (port)
        `LEFT : begin
           case (byte_no)
             0: begin
                if (rdl_en_p2[0] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[8:0] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[8:0] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dql_r[8:0] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             1: begin
                if (rdl_en_p2[1] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[17:9] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[17:9] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dql_r[17:9] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             2: begin
                if (rdl_en_p2[2] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[26:18] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[26:18] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dql_r[26:18] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             3: begin
                if (rdl_en_p2[3] == 1'b1) begin
                   if (rdl_tDC_p3 == 1'b1) begin
                      dql_r[35:27] <= #tDC `BITSPL'hX;
                   end else begin
                      dql_r[35:27] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dql_r[35:27] <= #tCKHZ `BITSPL'hZ;                         
                end
             end  

             default: $display("Model Internal Error");

           endcase
        end
           
        `RIGHT : begin
           case (byte_no)
             0: begin
                if (rdr_en_p2[0] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[8:0] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[8:0] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dqr_r[8:0] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             1: begin
                if (rdr_en_p2[1] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[17:9] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[17:9] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dqr_r[17:9] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             2: begin
                if (rdr_en_p2[2] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[26:18] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[26:18] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dqr_r[26:18] <= #tCKHZ `BITSPL'hZ;                         
                end
             end
             3: begin
                if (rdr_en_p2[3] == 1'b1) begin
                   if (rdr_tDC_p3 == 1'b1) begin
                      dqr_r[35:27] <= #tDC `BITSPL'hX;
                   end else begin
                      dqr_r[35:27] <= #tCKLZ `BITSPL'hX;
                   end
                end else begin
                   dqr_r[35:27] <= #tCKHZ `BITSPL'hZ;                         
                end
             end        

             default: $display("Model Internal Error");

           endcase 
        end

        default: $display("Model Internal Error");        

      endcase
endtask // drive_outputs_oe_hi



//-----------------------------------------------------------------------------------------------
// Function:    chk_x_ads
//
// Description: Checks for any single unknown value on the ads pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_ads;

      input [50:0]     pin_name;      
      input            val;

      begin
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_ads = 1;
         end else begin
            chk_x_ads = 0;
         end
      end
endfunction // chk_x_ads


//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cnten
//
// Description: Checks for any single unknown value on the cnten pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cnten;

      input [70:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_cnten = 1;
         end else begin
            chk_x_cnten = 0;
         end
      end
endfunction // chk_x_cnten

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_r_w
//
// Description: Checks for any single unknown value on the r_w pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_r_w;

      input [50:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_r_w = 1;
         end else begin
            chk_x_r_w = 0;
         end
      end
endfunction // chk_x_r_w

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cnt_msk
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cnt_msk;

      input [80:0]     pin_name;      
      input [`AD_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_cnt_msk = 1;
         end else begin
            chk_x_cnt_msk = 0;
         end
      end
endfunction // chk_x_cnt_msk

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_cntrst
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_cntrst;

      input [70:0]     pin_name;      
      input [`AD_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_cntrst = 1;
         end else begin
            chk_x_cntrst = 0;
         end
      end
endfunction // chk_x_cntrst

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_b
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_b;

      input [30:0]     pin_name;      
      input [`BT_M:0]  val;

      begin      
         
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_b = 1;
         end else begin
            chk_x_b = 0;
         end
      end
endfunction // chk_x_b

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_oe
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_oe;

      input [40:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_oe = 1;
         end else begin
            chk_x_oe = 0;
         end
      end
endfunction // chk_x_oe

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_ce1
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_ce1;

      input [30:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display ("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_ce1 = 1;
         end else begin
            chk_x_ce1 = 0;
         end
      end
endfunction // chk_x_ce1

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_ce0
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_ce0;

      input [50:0]     pin_name;      
      input            val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
            chk_x_ce0 = 1;
         end else begin
            chk_x_ce0 = 0;
         end
      end
endfunction // chk_x_ce0

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_dq
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_dq;

      input [30:0]     pin_name;      
      input [`DT_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display("\t\t No read or write Operation will be performed");
            chk_x_dq = 1;
         end else begin
            chk_x_dq = 0;
         end
      end
endfunction // chk_x_dql

//-----------------------------------------------------------------------------------------------
// Function:    chk_x_a
//
// Description: Checks for any single unknown value on the cntmsk pin 
//              and returns '1' if found x, otherwise '0'.
//-----------------------------------------------------------------------------------------------

function chk_x_a;

      input [20:0]     pin_name;      
      input [`AD_M:0]  val;

      begin      
         if (^val === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown value on %s:", $realtime, pin_name);
            if (XmsgOn) $display("\t\t No Address related Operation will be performed");
            chk_x_a = 1;
         end else begin
            chk_x_a = 0;
         end
      end
endfunction // chk_x_a

//-----------------------------------------------------------------------------------------------
// Function:    chk_and_load_msk_fn
//
// Description: Checks the valid value on address bus while loading mask register. 
//              Returns valid value for loading the mask register.
//              Identifies the masked and unmasked regions for Address Counter.
//-----------------------------------------------------------------------------------------------

function [`AD_M : 0] chk_and_load_msk_fn;
      input port;
 
      if (port == `LEFT) begin
         if (^al === 1'bx) begin
            if (XmsgOn) $display("%t WARNING :  Unknown values on al bus : ", $realtime);
            if (XmsgOn) $display("\t\t Contents of Mask Register at Left port are unchanged");
         end else begin
            tempA_reg1 = al;
            valid_msk_f = 1;
            bit_no = mskpartl_bit_no; // load previous mask region lsb bit

            begin : chk_valid_masking1
               for (i=1; i<=`AD_M; i=i+1) begin // ignore bit-0 of mask reg.
                  if (valid_msk_f == 1) begin
                     bit_no = i;                     
                     if (tempA_reg1[i] == 0) begin
                        for (j=i+1; j<=`AD_M; j=j+1) begin
                           if (valid_msk_f == 1) begin
                              if (tempA_reg1[j] == 1) begin
                                 valid_msk_f = 0;
                                 bit_no = mskpartl_bit_no; // retain previous mask region intact
                              end
                           end else begin
                              i = `AD_M;
                              j = `AD_M;
                           end
                        end
                        if (valid_msk_f == 1) begin
                           i = `AD_M;                           
                        end
                     end
                  end else begin
                     i = `AD_M;
                     j = `AD_M;
                  end
               end
            end
            mskpartl_bit_no = bit_no;

            if (valid_msk_f == 1) begin
               if (OmsgOn) $display("%t Loading the Mask Register at Left port", $realtime);
               chk_and_load_msk_fn = al;
            end else begin
               $display("%t Invalid value on al bus during Load Mask Register operation at Left port", $realtime);
               $display("\t\t Contents of Mask Register at Left port are unchanged");
               chk_and_load_msk_fn = mskl_reg;
            end
         end

      end else begin // if (port == `LEFT)
         
         if (^ar === 1'bx) begin
            if (XmsgOn) $display("%t WARNING : Unknown values on ar bus : ", $realtime);
            if (XmsgOn) $display("\t\t Contents of Mask Register at Right port are unchanged");
         end else begin
            tempA_reg1 = ar;
            valid_msk_f = 1;
            bit_no = mskpartr_bit_no; // load previous mask region lsb bit

            begin : chk_valid_masking2
               for (i=1; i<=`AD_M; i=i+1) begin // ignore bit-0 of mask reg.
                  if (valid_msk_f == 1) begin
                     if (tempA_reg1[i] == 0) begin
                        bit_no = i;                        
                        for (j=i+1; j<=`AD_M; j=j+1) begin
                           if (valid_msk_f == 1) begin
                              if (tempA_reg1[j] == 1) begin 
                                 valid_msk_f = 0;
                                 bit_no = mskpartr_bit_no; // retain previous mask region intact
                              end
                           end else begin
                              i = `AD_M;
                              j = `AD_M;
                           end
                        end
                        if (valid_msk_f == 1) begin
                           i = `AD_M;                           
                        end
                     end
                  end else begin
                     i = `AD_M;
                     j = `AD_M;
                  end
               end
            end
            mskpartr_bit_no = bit_no;
            if (valid_msk_f == 1) begin
               if (OmsgOn) $display("%t Loading the Mask Register at Right port", $realtime);
               chk_and_load_msk_fn = ar;
            end else begin
               $display("%t Invalid value on ar bus during Load Mask Register operation at Right port", $realtime);
               $display("\t\t Contents of Mask Register at Right port are unchanged");
               chk_and_load_msk_fn = mskr_reg;
            end
         end // else: !if(^ar == 1'bX)
      end // else: !if(port == `LEFT)
endfunction // chk_and_load_msk_fn

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    reset_chk_fn
//
// Description: Checks whether reset is over or not ? and returns 1 if it's reset.
//-----------------------------------------------------------------------------------------------

function reset_chk_fn;
      input none;
      
      begin
         if (reset_over == 1'b0) begin
            if (TmsgOn) $display("%t Operating the device without performing Reset operation:", $realtime);
            if (TmsgOn) $display("\t\t Reset the device to function properly\n");
            reset_chk_fn = 1'b0;
         end else begin
            reset_chk_fn = 1'b1;
         end
      end
endfunction // reset_chk_fn

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    read_data_and_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location simultaneously
//               by two ports.
//              Performs read operation. 
//              Returns vaild data to be read. 
//-----------------------------------------------------------------------------------------------

function [`DT_M : 0] read_data_and_tCCS_chk_fn;
      input port;
      begin
         if (port == `LEFT) begin 
            if ((($realtime - tCCS_chk) < tCCS) && !(last_access_type == `READ)) begin
               if (last_addr == cntl_reg) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Reading the same memory location from Left port:", $realtime);
                  if (TmsgOn) $display("\t\t Data Output is unpredictable");
                  read_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hX;
               end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Left port ", $realtime);
                  read_data_and_tCCS_chk_fn[`DT_M:0] = mem[cntl_reg];
               end                  
            end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Left port ", $realtime);
               read_data_and_tCCS_chk_fn[`DT_M:0] = mem[cntl_reg];
            end
            last_addr = cntl_reg;
            last_opernl_p1 = `READ;            
         end else begin
            if ((($realtime - tCCS_chk) < tCCS) && !(last_access_type == `READ)) begin
               if (last_addr == cntr_reg) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Reading the same memory location from Right port:", $realtime);
                  if (TmsgOn) $display("\t\t Data Output is unpredictable");
                  read_data_and_tCCS_chk_fn[`DT_M:0] = `DT_S'hX;
               end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Right port ", $realtime);               
                  read_data_and_tCCS_chk_fn[`DT_M:0] = mem[cntr_reg];
               end                  
            end else begin
                  if (OmsgOn) $display("%t \t\t Reading Data from Right port ", $realtime);               
               read_data_and_tCCS_chk_fn[`DT_M:0] = mem[cntr_reg];
            end
            last_addr = cntr_reg;
            last_opernr_p1 = `READ;                        
         end
         tCCS_chk = $realtime;
         last_access_type = `READ;
      end
endfunction // read_data_and_tCCS_chk_fn


//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// Function:    write_data_and_tCCS_chk_fn
//
// Description: Checks tCCS violation while accessing same memory location simultaneously
//               by two ports.
//              Performs write operation. 
//              Returns vaild data to be written. 
//-----------------------------------------------------------------------------------------------


function [`DT_M : 0] write_data_and_tCCS_chk_fn;
      input port;
      begin
         if (port == `LEFT) begin 
            if (($realtime - tCCS_chk) < tCCS) begin
               if (last_addr == cntl_reg) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Writing to the same memory location from Left port:", $realtime);
                  if (last_access_type == `WRITE) begin
                     if (TmsgOn) $display("\t\t\t Previous data at address %hh is unchanged ", cntl_reg);
                  end else begin
                     write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
                  end
               end else begin
                  if (OmsgOn) $display("%t \t\t Writing Data on Left port ", $realtime);               
                  write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
               end
            end else begin
               if (OmsgOn) $display("%t \t\t Writing Data on Left port ", $realtime);               
               write_data_and_tCCS_chk_fn[`DT_M:0] = dql;
            end
            last_addr = cntl_reg;
            last_opernl_p1 = `WRITE;            
         end else begin
            if (($realtime - tCCS_chk) < tCCS) begin
               if (last_addr == cntr_reg) begin
                  if (TmsgOn) $display("%t WARNING : Violating tCCS while Writing to the same memory location from Right port:", $realtime);
                  if (last_access_type == `WRITE) begin
                     if (TmsgOn) $display("\t\t\t Previous data at address %hh is unchanged ", cntr_reg);
                  end else begin
                     write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
                  end
               end else begin
                  if (OmsgOn) $display("%t \t\t Writing Data on Right port ", $realtime);                
                  write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
               end                  
            end else begin
                  if (OmsgOn) $display("%t \t\t Writing Data on Right port ", $realtime);                
               write_data_and_tCCS_chk_fn[`DT_M:0] = dqr;
            end
            last_addr = cntr_reg;         
            last_opernr_p1 = `WRITE;            
         end
         tCCS_chk = $realtime;
         last_access_type = `WRITE;
      end
endfunction // write_data_and_tCCS_chk_fn


//-----------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------
// task:        event_reset
//
// Description: Resets all the event variables to zero 
//
//-----------------------------------------------------------------------------------------------

task event_reset;
      begin
         dql_event = 0;
         dqr_event = 0;
         clkl_event = 0;
         clkr_event = 0;
         mrst_n_event = 0;
         al_event = 0;
         ar_event = 0;
         ads_nl_event = 0;
         ads_nr_event = 0;
         ce0_nl_event = 0;
         ce0_nr_event = 0;
         ce1l_event = 0;
         ce1r_event = 0;
         cnten_nl_event = 0;
         cnten_nr_event = 0;
         cntrst_nl_event = 0;
         cntrst_nr_event = 0;
         cnt_msk_nl_event = 0;
         cnt_msk_nr_event = 0;
         oe_nl_event = 0;
         oe_nr_event = 0;
         r_w_nl_event = 0;
         r_w_nr_event = 0;
         b_nl_event = 0;
         b_nr_event = 0;
         // internal pins
         oel_int_event = 0;
         oer_int_event = 0;
         tOEl_int_event = 0;
         tOEr_int_event = 0;         
         
      end
endtask // event_reset

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        pv_reset
//
// Description: Resets all the previous value variables to zero 
//
//-----------------------------------------------------------------------------------------------

task pv_reset;
      begin
         dql_pv = 0;
         dqr_pv = 0;
         clkl_pv = 0; 
         clkr_pv = 0;
         mrst_n_pv = 0;
         al_pv = 0;
         ar_pv = 0;
         ads_nl_pv = 0;
         ads_nr_pv = 0;
         ce0_nl_pv = 0;
         ce0_nr_pv = 0;
         ce1l_pv = 0;
         ce1r_pv = 0;
         cnten_nl_pv = 0;
         cnten_nr_pv = 0;
         cntrst_nl_pv = 0;
         cntrst_nr_pv = 0;
         cnt_msk_nl_pv = 0;
         cnt_msk_nr_pv = 0;
         oe_nl_pv = 0;
         oe_nr_pv = 0;
         r_w_nl_pv = 0;
         r_w_nr_pv = 0;
         b_nl_pv = 0;
         b_nr_pv = 0;
         // internal pins
         oel_int_pv = 0;
         oer_int_pv = 0;
         tOEl_int_pv = 0;
         tOEr_int_pv = 0;                  
         
      end
endtask // pv_reset

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        event_chk
//
// Description: Checks whether the event has occurred or not on all the input pins
//
//-----------------------------------------------------------------------------------------------

task event_chk;
      begin
         dql_event = (dql_pv !== dql);
         dqr_event = (dqr_pv !== dqr);
         clkl_event = (clkl_pv !== clkl);
         clkr_event = (clkr_pv !== clkr);
         mrst_n_event = (mrst_n_pv !== mrst_n);
         al_event = (al_pv !== al);
         ar_event = (ar_pv !== ar);
         ads_nl_event = (ads_nl_pv !== ads_nl);
         ads_nr_event = (ads_nr_pv !== ads_nr);
         ce0_nl_event = (ce0_nl_pv !== ce0_nl);
         ce0_nr_event = (ce0_nr_pv !== ce0_nr);
         ce1l_event = (ce1l_pv !== ce1l);
         ce1r_event = (ce1r_pv !== ce1r);
         cnten_nl_event = (cnten_nl_pv !== cnten_nl);
         cnten_nr_event = (cnten_nr_pv !== cnten_nr);
         cntrst_nl_event = (cntrst_nl_pv !== cntrst_nl);
         cntrst_nr_event = (cntrst_nr_pv !== cntrst_nr);
         cnt_msk_nl_event = (cnt_msk_nl_pv !== cnt_msk_nl);
         cnt_msk_nr_event = (cnt_msk_nr_pv !== cnt_msk_nr);
         oe_nl_event = (oe_nl_pv !== oe_nl);
         oe_nr_event = (oe_nr_pv !== oe_nr);
         r_w_nl_event = (r_w_nl_pv !== r_w_nl);
         r_w_nr_event = (r_w_nr_pv !== r_w_nr);
         b_nl_event = (b_nl_pv !== b_nl);
         b_nr_event = (b_nr_pv !== b_nr);
         // internal pins
         oel_int_event = (oel_int_pv !== oel_int);
         oer_int_event = (oer_int_pv !== oer_int);
         tOEl_int_event = (tOEl_int_pv !== tOEl_int);
         tOEr_int_event = (tOEr_int_pv !== tOEr_int);                  
           
      end
endtask // event_chk

//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        pv_assign
//
// Description: Assigns the current values of all the pins to their respective 
//              previous value variables
//
//-----------------------------------------------------------------------------------------------

task pv_assign;
      begin
         dql_pv = dql;
         dqr_pv = dqr;         
         clkl_pv = clkl;
         clkr_pv = clkr;
         mrst_n_pv = mrst_n;
         al_pv = al;
         ar_pv = ar;
         ads_nl_pv = ads_nl;
         ads_nr_pv = ads_nr;
         ce0_nl_pv = ce0_nl;
         ce0_nr_pv = ce0_nr;
         ce1l_pv = ce1l;
         ce1r_pv = ce1r;
         cnten_nl_pv = cnten_nl;
         cnten_nr_pv = cnten_nr;
         cntrst_nl_pv = cntrst_nl;
         cntrst_nr_pv = cntrst_nr;
         cnt_msk_nl_pv = cnt_msk_nl;
         cnt_msk_nr_pv = cnt_msk_nr;
         oe_nl_pv = oe_nl;
         oe_nr_pv = oe_nr;
         r_w_nl_pv = r_w_nl;
         r_w_nr_pv = r_w_nr;
         b_nl_pv = b_nl;
         b_nr_pv = b_nr;
         // internal pins
         oel_int_pv = oel_int;
         oer_int_pv = oer_int;
         tOEl_int_pv = tOEl_int;
         tOEr_int_pv = tOEr_int;                  
         
      end
endtask // pv_assign


//-----------------------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------------------
// task:        timing_chk
//
// Description: Checks setup and hold violations for the input pins
//
//-----------------------------------------------------------------------------------------------

task timing_chk;
      begin

         //-----------------------------------------------------------------
         // Clock High time check
         //-----------------------------------------------------------------
         if (clkl_event && (clkl === 1'b0)) begin
            if ((($realtime - rising_edge_clk_l) < tCH2) && ($realtime > 0)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L Clock High time - tCH2 violation.", $realtime);
               no_grnt_msg;
            end
            falling_edge_clk_l = $realtime;
         end
         
         if (clkr_event && (clkr === 1'b0)) begin
            if ((($realtime - rising_edge_clk_r) < tCH2) && ($realtime > 0) && ($realtime > 0)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R Clock High time - tCH2 violation.", $realtime);
               no_grnt_msg;
            end
            falling_edge_clk_r = $realtime;
         end

         
         //------------------------------------------------------------------------------
         //Setup timing checks for left port
         //------------------------------------------------------------------------------
         
         if (clkl_event && (clkl === 1'b1)) begin
            // Clock cycle time check
            if ((($realtime - rising_edge_clk_l) < tCYC2) && ($realtime > tCYC2)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L Clock cycle time - tCYC2 violation.", $realtime);
               no_grnt_msg;
            end
            rising_edge_clk_l = $realtime;

            //Clock low time check
            if (((rising_edge_clk_l - falling_edge_clk_l) < tCL2) && ($realtime > tCL2)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L Clock LOW time - tCL2 violation.", $realtime);
               no_grnt_msg;
            end
            
            // Address setup time check
            if (((rising_edge_clk_l - addr_last_change_l) < tSA )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : A_L to CLK_L Setup time - tSA violation.", $realtime);
               no_grnt_msg;
            end
            
            // Byte select setup time
            if (((rising_edge_clk_l - byte_sel_last_change_l) < tSB )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : B_L to CLK_L Setup time - tSB violation.", $realtime);
               no_grnt_msg;
            end
            
            // Chip enable setup time        
            if (((rising_edge_clk_l - ce0_last_change_l) < tSC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CE0_L to CLK_L Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            if (((rising_edge_clk_l - ce1_last_change_l) < tSC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CE1_L to CLK_L Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            // R/W Setup time
            if (((rising_edge_clk_l - rw_last_change_l) < tSW )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : R/W_L to CLK_L Setup time - tSW violation", $realtime);
               no_grnt_msg;
            end
            
            // Input Data setup time
            if (((rising_edge_clk_l - dq_last_change_l) < tSD )&& (setup_hold_chk) && (r_w_nl === 0)) begin
               if (TmsgOn) $display ("%t WARNING : DQ_L to CLK_L Setup time - tSD violation.", $realtime);
               no_grnt_msg;
            end
            
            // ADS setup time
            if ((( rising_edge_clk_l - ads_sel_last_change_l) < tSAD )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : ADS_L to CLK_L Setup time - tSAD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTEN Setup time
            if (((rising_edge_clk_l - cnten_last_change_l) < tSCN )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CNTEN_L to CLK_L Setup time - tSCN violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRST Setup time
            if (((rising_edge_clk_l - cntrst_last_change_l) < tSRST )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CNTRST_L to CLK_L Setup time - tSRST violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNT/MSK Setup time
            if (((rising_edge_clk_l - cnt_msk_last_change_l) < tSCM ) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t WARNING : CNT_MSK_L to CLK_L Setup time - tSCM violation.", $realtime);
               no_grnt_msg;
            end
         end // if (clkl_event && clkl === 1'b1)
         
         
         //------------------------------------------------------------------------------------
         //Setup timing checks for Right port
         //------------------------------------------------------------------------------------
         
         if (clkr_event && (clkr === 1'b1)) begin
            // Clock cycle time 
            if ((($realtime - rising_edge_clk_r) < tCYC2) && ($realtime > tCYC2)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R Clock cycle time - tCYC2 violation.", $realtime);
               no_grnt_msg;
            end
            rising_edge_clk_r = $realtime;

            //Clock low time check
            if (((rising_edge_clk_r - falling_edge_clk_r) < tCL2) && ($realtime > tCL2)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R Clock LOW time - tCL2 violation.", $realtime);
               no_grnt_msg;
            end
            
            // Address setup time check
            if (((rising_edge_clk_r - addr_last_change_r) < tSA )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : A_R to CLK_R Setup time - tSA violation.", $realtime);
               no_grnt_msg;
            end
            
            // Byte select setup time
            if (((rising_edge_clk_r - byte_sel_last_change_r) < tSB )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : B_R to CLK_R Setup time - tSB violation.", $realtime);
               no_grnt_msg;
            end
            
            // Chip enable setup time                              
            if (((rising_edge_clk_r - ce0_last_change_r) < tSC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CE0_R to CLK_R Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            if (((rising_edge_clk_r - ce1_last_change_r) < tSC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CE1_R to CLK_R Setup time - tSC violation.", $realtime);
               no_grnt_msg;
            end
            
            // R/W Setup time
            if (((rising_edge_clk_r - rw_last_change_r) < tSW )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : R/W_R to CLK_R Setup time - tSW violation", $realtime);
               no_grnt_msg;
            end
            
            // Input Data setup time
            if (((rising_edge_clk_r - dq_last_change_r) < tSD )&& (setup_hold_chk) && (r_w_nr === 0)) begin
               if (TmsgOn) $display ("%t WARNING : DQ_R to CLK_R Setup time - tSD violation.", $realtime);
               no_grnt_msg;
            end
            
            // ADS setup time
            if (((rising_edge_clk_r - ads_sel_last_change_r) < tSAD )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : ADS_R to CLK_R Setup time - tSAD violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTEN Setup time
            if ((( rising_edge_clk_r - cnten_last_change_r) < tSCN )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CNTEN_R to CLK_R Setup time - tSCN violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNTRST Setup time
            if (((rising_edge_clk_r - cntrst_last_change_r) < tSRST )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CNTRST_R to CLK_R Setup time - tSRST violation.", $realtime);
               no_grnt_msg;
            end
            
            // CNT/MSK Setup time
            if (((rising_edge_clk_r - cnt_msk_last_change_r) < tSCM )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CNT_MSK_R to CLK_R Setup time - tSCM violation.", $realtime);
               no_grnt_msg;
            end
         end // if (clkr_event && (clkr === 1'b1))
         
         
         //-------------------------------------------------------------------------------------------
         //                  Hold violation checks
         //------------------------------------------------------------------------------------------- 

         //----------------------------------------------
         // HOLD Time violation checks for left port
         //----------------------------------------------
         
         // Address hold time
         if (al_event) begin
            if ((($realtime - rising_edge_clk_l) < tHA ) && setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to A_L Hold time - tHA violation.", $realtime);
               no_grnt_msg;
            end
            addr_last_change_l = $realtime;
         end
         
         // Byte select hold time
         if (b_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHB )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to B_L Hold time - tHB violation.", $realtime);
               no_grnt_msg;
            end
            
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to B_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            byte_sel_last_change_l = $realtime;
         end
         
         
         // Chip enable hold time
         if (ce0_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to CE0_L Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CE0_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            ce0_last_change_l = $realtime;
         end
         
         if (ce1l_event) begin   
            if ((($realtime - rising_edge_clk_l) < tHC ) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to CE1_L Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CE1_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            ce1_last_change_l = $realtime;
         end

         // R/W Hold time
         if (r_w_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHW )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to R/W_L Hold time - tHW violation", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to R/W_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            rw_last_change_l = $realtime;
         end
         
         // Input Data hold time
         if (dql_event) begin
            if ((($realtime - rising_edge_clk_l) < tHD )&& (setup_hold_chk) && (r_w_nl === 0)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to DQ_L Hold time - tHD violation.", $realtime);
               no_grnt_msg;
            end
            dq_last_change_l = $realtime;
         end
         
         // ADS hold time
         if (ads_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHAD ) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to ADS_L Hold time - tHAD violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to ADS_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end      
            ads_sel_last_change_l = $realtime;
         end

         // CNTEN Hold time
         if (cnten_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHCN ) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to CNTEN_L Hold time - tHCN violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CNTEN_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            cnten_last_change_l = $realtime;
         end
         
         // CNTRST Hold time
         if (cntrst_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHRST ) && setup_hold_chk)begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to CNTRST_L Hold time - tHRST violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CNTRST_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            cntrst_last_change_l = $realtime;
         end
         
         
         // CNT/MSK Hold time
         if (cnt_msk_nl_event) begin
            if ((($realtime - rising_edge_clk_l) < tHCM )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_L to CNT_MSK_L Hold time - tHCM violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CNT_MSK_L Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end      
            cnt_msk_last_change_l = $realtime;
         end
         

         //-----------------------------------------------
         // HOLD Time violation checks for right port
         //-----------------------------------------------
         
         // Address hold time                             
         if (ar_event) begin
            if ((($realtime - rising_edge_clk_r) < tHA )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to A_R Hold time - tHA violation.", $realtime);
               no_grnt_msg;
            end
            addr_last_change_r = $realtime;
         end
         
         
         // Byte select hold time
         if (b_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHB )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to B_R Hold time - tHB violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to B_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            byte_sel_last_change_r = $realtime;
         end
         
         // Chip enable hold time
         if (ce0_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to CE0_R Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CE0_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end      
            ce0_last_change_r = $realtime;
         end
         
         if (ce1r_event) begin
            if ((($realtime - rising_edge_clk_r) < tHC )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to CE1_R Hold time - tHC violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CE1_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            ce1_last_change_r = $realtime;
         end
         
         // R/W Hold time
         if (r_w_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHW )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to R/W_R Hold time - tHW violation", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to R/W_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            rw_last_change_r = $realtime;
         end
         
         // Input Data hold time
         if (dqr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHD )&& (setup_hold_chk) && (r_w_nr === 0)) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to DQ_R Hold time - tHD violation.", $realtime);
               no_grnt_msg;
            end
            dq_last_change_r = $realtime;
         end
         
         // ADS hold time
         if (ads_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHAD )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to ADS_R Hold time - tHAD violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to ADS_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end      
            ads_sel_last_change_r = $realtime;
         end
         
         
         // CNTEN Hold time
         if (cnten_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHCN )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to CNTEN_R Hold time - tHCN violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CNTEN_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            cnten_last_change_r = $realtime;
         end
         
         // CNTRST Hold time                                    
         if (cntrst_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHRST )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to CNTRST_R Hold time - tHRST violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CNTRST_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            cntrst_last_change_r = $realtime;
         end
         
         // CNT/MSK Hold time                                   
         if (cnt_msk_nr_event) begin
            if ((($realtime - rising_edge_clk_r) < tHCM )&& setup_hold_chk) begin
               if (TmsgOn) $display ("%t WARNING : CLK_R to CNT_MSK_R Hold time - tHCM violation.", $realtime);
               no_grnt_msg;
            end
            if ((($realtime - rising_edge_mrst) < tRSR ) && ($realtime > tRSR)) begin
               if (TmsgOn) $display ("%t WARNING : MRST to CNT_MSK_R Hold time - tRSR violation.", $realtime);
               no_grnt_msg;
            end
            cnt_msk_last_change_r = $realtime;
         end

         //------------------------------------------------------------
         // Master Reset timings check
         //------------------------------------------------------------
         if (mrst_n_event && (mrst_n === 1'b0)) begin
            falling_edge_mrst = $realtime;
         end
         
         if (mrst_n_event && (mrst_n === 1'b1)) begin
            rising_edge_mrst = $realtime;
            // Master reset pulse width tRS check
            if (((rising_edge_mrst - falling_edge_mrst) < tRS ) && ($realtime > tRS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset Pulse Width - tRS violation.", $realtime);
               no_grnt_msg;
            end

            // Master reset setup time checks - tRSS
            if (((rising_edge_mrst - byte_sel_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to B_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end
            
            if (((rising_edge_mrst - ce0_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CE0_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - ce1_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CE1_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - rw_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to R/W_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - ads_sel_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to ADS_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - cnten_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CNTEN_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - cntrst_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CNTRST_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - cnt_msk_last_change_l) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CNT_MSK_L Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            // Right port pins

            if (((rising_edge_mrst - byte_sel_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to B_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - ce0_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CE0_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - ce1_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CE1_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - rw_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to R/W_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - ads_sel_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to ADS_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - cnten_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CNTEN_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - cntrst_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CNTRST_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end

            if (((rising_edge_mrst - cnt_msk_last_change_r) < tRSS ) && ($realtime > tRSS)) begin
               if (TmsgOn) $display ("%t WARNING : Master Reset to CNT_MSK_R Setup time - tRSS violation.", $realtime);
               no_grnt_msg;
            end
         end // if (mrst_n_event && (mrst === 1'b1))
         
      end
endtask // timing_chk

task no_grnt_msg;
      if (TmsgOn) $display ("\t\t WARNING : Device operation is not guaranteed");               
endtask // no_grnt_msg

//---------------------------------------------------------------------------------------------------------








