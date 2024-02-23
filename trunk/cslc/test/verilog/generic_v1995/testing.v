Some Examples of Verilog testbench techniques.

      1.0   Introduction
      2.0   Generating Periodic Signals
      3.0   Generating and Receiving Serial Characters
      4.0   Memories
      5.0   Bus Models


1.0   Introduction

A testbench is a verilog program that wraps around an actual design.  
The testbench is typically not part of the design and does not result 
in actual circuitry or gates.  Verilog code for testbenches may be 
much more "free style" than Verilog code that must be 
synthesized - anything goes.  Here are some tidbits from various
 projects I've worked on.  The code is not completely general nor 
perfect, but hopefully may provide ideas for designers just starting
 out with testbench design.  Oh, and the names have been changed
 to protect the innocent.  I hope I haven't introduced error in 
doctoring up these examples.  Again, none of the following  code 
is intended to be synthesizable!

2.0   Generating Periodic Signals.

Say you have a period signal.  Try tossing in a little random fluctuation
 on where the edges occur - you may catch a an unexpected bug! 
 But, be careful about using random because if you move on to 
manufacturing test, then your testbench may not be deterministic. 
 Often, for the sake of the tester, you must enforce transitions to 
occur in specific periods.  In this case, you may need to add 
statements that delay changes to fall in these periods.  Anyway,
 let's drive the foo1in signal.  We'll add in some random, count 
the transitions and print out a message.

initial begin
   #1 foo1in = 0;
      forever begin
         #(`PERIOD/2 + ($random % 10)*(` PERIOD/20)) foo1in = 1;
         foo1_input_count = foo1_input_count + 1;
         $display ("#Foo1 rising edges = %d", foo1_input_count);
         #(` PERIOD/2 + ($random % 10)*(` PERIOD/20)) foo1in = 0;
      end
end

Here's another code snippet - a task that generates a period message..

task generate_syncs;
   event	send_sync;
   begin
      syncdata = SYNC_START;
      syncstb  = 0;
   
      fork
         // Generate periodic event for sending the sync
         forever #(1000000000.0 * RATE) ->send_sync; // convert RATE to nanoseconds
         
         // Wait on send_sync event, and then send SYNC synchronized with clk
         forever begin
            @(send_sync);
            syncdata = syncdata + CMTS_FREQ * CMTS_RATE;
            $display ("... SYNC = %h at time %0t, Local Time = %h", syncdata, $time, local_time);
            @(posedge clk) #1;
            syncstb = 1;
            @(posedge clk) #1;
            syncstb = 0;
         end
      join
   end
endtask

3.0   Generating and Receiving Serial Characters

Say your design inputs or outputs serial characters.  Here is some 
code for both.  First, some defines:

/*  Serial Parameters used for send_serial task and its callers. */
`define PARITY_OFF   1'b0
`define PARITY_ON    1'b1
`define PARITY_ODD   1'b0
`define PARITY_EVEN  1'b1
`define NSTOPS_1     1'b0
`define NSTOPS_2     1'b1
`define BAUD_9600    2'b00
`define BAUD_4800    2'b01
`define BAUD_2400    2'b10
`define BAUD_1200    2'b11
`define NBITS_7      1'b0
`define NBITS_8      1'b1

Here's how you call it:

send_serial (8'hAA, `BAUD_9600, `PARITY_EVEN, `PARITY_ON, `NSTOPS_1, `NBITS_7, 0);

Here's a task that sends a character.

task send_serial;
input [7:0] inputchar;
input baud;
input paritytype;
input parityenable;
input nstops;
input nbits;
input baud_error_factor;

reg       nbits;
reg       parityenable;
reg       paritytype;
reg [1:0] baud;
reg       nstops;
integer   baud_error_factor;  // e.g. +5 means 5% too fast and -5 means 5% too slow

reg   [7:0] char;
reg         parity_bit;
integer     bit_time;

begin
   char = inputchar;
   parity_bit = 1'b0;
   case (baud)
      `BAUD_9600: bit_time = 1000000000/(9600 + 96*baud_error_factor);
      `BAUD_4800: bit_time = 1000000000/(4800 + 48*baud_error_factor);
      `BAUD_2400: bit_time = 1000000000/(2400 + 24*baud_error_factor);
      `BAUD_1200: bit_time = 1000000000/(1200 + 12*baud_error_factor);
   endcase   

   $display ("Sending character %h, at %0d baud (err=%0d), %0d bits, %0s parity, %0d stops",
       (nbits == `NBITS_7) ? (char & 8'h7f) : char,
      1000000000/bit_time,
      baud_error_factor,
      (nbits == `NBITS_7) ? 7 : 8,
      (parityenable == `PARITY_OFF) ? "NONE" : (paritytype == `PARITY_EVEN) ? "EVEN" : "ODD",
      (nstops == `NSTOPS_1) ? 1 : 2
   );
      
   // Start bit
   serial_character = 1'b0;   // Start bit.
   #(bit_time);

   // Output data bits
   repeat ( (nbits == `NBITS_7) ? 7 : 8) begin
      serial_character = char[0];
      #(bit_time);
      char = {1'b0, char[7:1]};
   end
   
   if (parityenable == `PARITY_ON) begin
      parity_bit = (nbits == `NBITS_7) ? ^inputchar[6:0] : ^inputchar[7:0];
      if (paritytype == `PARITY_ODD)
         parity_bit = ~parity_bit; // even parity
         serial_character = parity_bit;
         #(bit_time);
      end
      serial_character = 1'b1;   // Stop bit.
      #(bit_time);
      if (nstops) // Second stop bit
         #(bit_time);
   end
endtask

Here's a task that receives serial characters.  This particular task was 
a bit messy in that it set some global variables in order to return a 
status, etc.  By all means - fix this up the way you like it!

reg [7:0] receive_serial_character_uart1;	// Global that receives tasks result

// ****  SERIAL CHARACTER LISTENER Task for UART1
//
//
task receive_serial_uart1;

input baud;
input paritytype;
input parityenable;
input nstops;
input nbits;

reg       nbits;
reg       parityenable;
reg       paritytype;
reg [1:0] baud;
reg       nstops;

integer     bit_time;

reg         expected_parity;

begin
receive_serial_result_uart1 = 0;
receive_serial_character_uart1 = 0;

case (baud)
   `BAUD_9600: bit_time = 1000000000/(9600);
   `BAUD_4800: bit_time = 1000000000/(4800);
   `BAUD_2400: bit_time = 1000000000/(2400);
   `BAUD_1200: bit_time = 1000000000/(1200);
endcase 
     
receive_serial_result_uart1 = `RECEIVE_RESULT_OK;  // Assume OK until bad things happen.

@(negedge uart1out);  // wait for start bit edge
#(bit_time/2);  // wait till center of start bit
if (uart1out != 0) // make sure its really a start bit
   receive_serial_result_uart1 = receive_serial_result_uart1 | `RECEIVE_RESULT_FALSESTART;
else begin
   repeat ( (nbits == `NBITS_7) ? 7 : 8) begin // get all the data bits (7 or 8)
      #(bit_time);  // wait till center
      // sample a data bit
      receive_serial_character_uart1 = {uart1out, receive_serial_character_uart1[7:1]};
   end

   // If we are only expecting 7 bits, go ahead and right-justify what we have
   if (nbits == `NBITS_7)
      receive_serial_character_uart1 = {1'b0, receive_serial_character_uart1[7:1]};
      
      #(bit_time);
      // now, we have either a parity bit, or a stop bit
      if (parityenable == `PARITY_ON) begin
         if (paritytype == `PARITY_EVEN)
            expected_parity = (nbits == `NBITS_7) ? (^receive_serial_character_uart1[6:0]) :            
                                                                               (^receive_serial_character_uart1[7:0]);
         else
            expected_parity = (nbits == `NBITS_7) ? (~(^receive_serial_character_uart1[6:0])) :  
                                                                               (~(^receive_serial_character_uart1[7:0]));
            if (expected_parity != uart1out)
               receive_serial_result_uart1 = receive_serial_result_uart1 | `RECEIVE_RESULT_BADPARITY;
         // wait for either 1 or 2 stop bits
      end
      else begin
			// this is a stop bit.
         if (uart1out != 1)
            receive_serial_result_uart1 = receive_serial_result_uart1 | `RECEIVE_RESULT_BADSTOP;
         else
            // that was cool.  if 2 stops, then do this again
            if (nstops) begin
               #(bit_time);
               if (uart1out != 1)
                  receive_serial_result_uart1 = receive_serial_result_uart1 | `RECEIVE_RESULT_BADSTOP;
            end
         #(bit_time/2);
      end
   end
end
endtask


4.0  Memories

Memories, whether they are RAMs, ROMs or special memories like FIFOs 
are easily modeled in Verilog.  Note that you can define your own special
 testbench locations for debugging!  Say, you have a processor core hooked
up to these memories.  Define some special locations that when read or 
written to, display diagnostic messages.  Or, you can specify that a write to
 a particular location will halt the simulation or signify PASS or FAIL.  
Memories are an easy way for the embedded Verilog core processor to 
communicate to the testbench.  There are many possibilities.  

reg [15:0] FLASH_memory [0:(1024*32 - 1)];   // 32K of FLASH
reg [15:0] SRAM_memory  [0:(1024*32 - 1)];   // 32K of SRAM

//*****
//
//  The ASIC's ca[20] is the active LO chip select for the FLASH.
//  The ASIC's ca[18] is the active LO chip select for the SRAM.

// Write process for FLASH and SRAM
//
always @(posedge cwn) begin
   if (ca[20] == 1'b0) begin
      // Write to FLASH
      if (ca[16:15] != 2'b00) begin
         $display ("Illegal write to FLASH!");
      end
      else begin
         $display ("Write to FLASH Address = %h, Data = %h", ca, cb);
         // Our FLASH is only declared up to 32KW, so use ca[14:0]
         FLASH_memory[ca[14:0]] = cb;
         
         // Check for magic write from the embedded processor core!  This is done in the
         // C firmware simply by writing to the location.
         //
         if (ca == `MAGIC_ADDRESS) begin
            $display ("Embedded code has signalled DONE!");
            sa_test_status = `SA_TEST_DONE;
            sa_test_result = cb;
         end
      end
   end
   else if (ca[18] == 1'b0) begin
      // Write to SRAM
      if (ca[16:15] != 2'b00) begin
         $display ("Illegal write to SRAM!");
      end
      else begin
         $display ("Write to SRAM Address = %h, Data = %h", ca, cb);
         // Our SRAM is only declared up to 32KW, so use ca[14:0]
         SRAM_memory[ca[14:0]] = cb;
      end
   end
end

// Read process for FLASH and SRAM
//
always @(crn) begin
   if (crn == 1'b0) begin
      case ({ca[20], ca[18]})
         2'b11: cb_i <= 16'hzzzz;
         2'b10: begin
            $display ("Read from SRAM Address = %h, Data = %h", ca, SRAM_memory[ca[14:0]]);
            cb_i <= SRAM_memory[ca[14:0]];
            end
         2'b01: begin
            $display ("Read from FLASH Address = %h, Data = %h", ca, FLASH_memory[ca[14:0]]);
            cb_i <= FLASH_memory[ca[14:0]];
            end
         2'b00: begin
            $display ("Simultaneosly selecting FLASH and SRAM!!");
            end
      endcase
   end
   else begin
      cb_i <= 16'hzzzz;
   end
end

Clearing the memories is easy:

task clear_SRAM;
reg [15:0] SRAM_address;
begin
   $display ("Clearing SRAM..");
   for (SRAM_address = 16'h0000; SRAM_address < 16'h8000; SRAM_address = SRAM_address + 1) begin
      SRAM_memory[SRAM_address] = 0;
   end
end
endtask

Performing other operations is straight-forward.  How about a task 
that copies a firmware hex image to a FLASH memories boot area, 
relocating along the way and maybe setting a hew header bytes too. 
 Now, this task is specific to a particular processor, etc. but this 
shows what is fairly easily done in Verilog:

task copy_to_FLASH_boot;
reg [15:0] temp_memory[0:1023];
reg [15:0] original_address;
reg [15:0] FLASH_address;
integer n;
begin
   $display ("Copying ROM image to FLASH boot block..");

   // Read in the normal ROM file into our temporary memory.
   for (original_address = 0; original_address < 1024; original_address = original_address + 1) begin
      temp_memory[original_address] = 0;
   end
   $readmemh (`ROM_FILE, temp_memory);
   
   // Fill in Boot header
   FLASH_memory[15'h0800] = `BOOT_COPY_LENGTH; // Let's copy 1KW maximum
   FLASH_memory[15'h0801] = 0;              // Copy program to code space starting at zero
   FLASH_memory[15'h0802] = temp_memory[3]; // Entry point is same as the address in the reset vector
   
   // Now, copy from original image into the boot area.
   n = 0;
   FLASH_address = 15'h0803;
   original_address = 0;
   while (n < 1024) begin
      FLASH_memory[FLASH_address] = temp_memory[original_address];
      FLASH_address = FLASH_address + 1;
      original_address = original_address + 1;
      n = n + 1;
   end
end
endtask

Also, test vectors are easily loaded into Verilog memories using the 
$readmem statements.  You may easily read your stimulus vectors 
from a file into a memory, clock out the vectors to your circuit, and 
optionally capture your circuits response to another memory (or simply 
write the vector out using $fdisplay).  Once you have captured one
 output vector set that you know is good (e.g. your "Golden" vectors), 
your testbench can compare subsequent simulation vectors against 
these "Golden" vectors and detect any problems in your changing 
circuit (e.g. after back-annotation, scan insertion, or alpha space
 particle circuit corruption).

5.0  Bus Models

Many times a processor is interfaced to the logic being tested.  If the 
complete processor model/core is not present, then a "bus model" is 
a simple function that emulates the bus transaction.  More simply; the
 bus model allows the testbench to read and write values.  The following 
task utilizes very specific timing delays.  You should probably include
 'defines' for these and update them as you get better timing information.  
Typically, you will test your UART or whatever peripheral in isolation 
with the bus model, and later test your peripheral with the real processor core.

write_to_foobar (COMPAREH_REGISTER, next_word[31:16]);
#10;
write_to_ foobar(COMPAREL _REGISTER, next_word[15:0]);
#10;

task write_to_foobar;
input [15:0] address_arg;
input [15:0] data_arg;
// Several global bus signals are assumed: address, we, clk.
begin
   /* Wait until next rising clock edge */ 
   @(posedge clk);
	
   /* t_valid for address is 5ns, wait and then drive address */
   #5;  // <----  Manually back-annotate this, or use a define, whatever...
   address = address_arg;

   /* t_valid for wrxxx is 8ns, we are already 5ns into cycle, so wait 3ns */
   #3;
   we <= 1'b1;
	
   /* t_valid for wrdata is 20ns, We are 8ns into cycle, wait 12ns */
   #12
   data <= data_arg;

   /* Wait till the next rising edge, wait for a little bit of hold time. */
   @(posedge clk40);
   #1;
   address <= 4'hz;
   #1;
   we  <= 1'b0;
   #4;
   data <= 16'hzzzz;
		
   //$display ("Writing data %h to address: %h", data, address);
end
endtask

Here's a task that reads from the memory-mapped peripheral.

task read_from_foobar;
input [3:0] address_arg;
// Let's just write to a global with the resulting data retrieved (! bad practice, I know....)
// Gobal variable is 'last_data_read'.
begin
   /* Wait until next rising edge to do anything.. */
   @(posedge clk)
	
   /* t_valid for rwadrs is 5ns, wait and then drive address */
   #5;
   address = address_arg;

   /* t_valid for rbxxx is 8ns, we are already 5ns into cycle, so wait 3ns */
   #3;
   rw <= 1'b1;
	
   /* Wait till the next rising edge, wait for a little bit of hold time. */
   @(posedge clk);
   last_data_read = data;  // <-- keep in the global, caller can use if they wish.
   $display ("Reading data %h from address: %h", data, address);

   /* Wrap it up.  Deassert rw.  Let's float the address bus. */
   rw <= 1'b0;
   #1;
   address <= 16'hzzzz;
end
endtask

