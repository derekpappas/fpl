// Definition of states
`define S0  3'b000
`define S1  3'b001
`define S2  3'b010
`define S3  3'b011
`define S4  3'b100

module knight_life(adventure, courage, 
sword_sharpened, dragon, clock, quest_over);

input adventure;         // Declaration of inputs that
input courage;           // report on various
input sword_sharpened;   // aspects of a medieval
input dragon;            // knight's life
input clock;
output quest_over;       // (Set to 1 on completing quest)
reg quest_over;

reg [2:0] present_state; // Declaration of 
reg [2:0] next_state;    // internal state variables

initial
begin
    present_state = `S0;
    next_state = `S0;
    quest_over = 1'b0;
end

always @(present_state)
begin
    casex (present_state)
      3'b0xx: quest_over = 1'b0;    // S0 through S3
      3'b100: quest_over = 1'b1;    // S4
      default: begin quest_over = 1'b0; 
                     $display("Illegal state"); end
    endcase
end
 
always @(present_state or adventure or courage
            or sword_sharpened or dragon)
begin
    case(present_state)
      `S0: if (adventure)
               next_state = `S1;
           else
               next_state = `S0;
      `S1: if (sword_sharpened)
               next_state = `S2;
           else
               next_state = `S1;
      `S2: if (courage)
               if (dragon)
                   next_state = `S3;
               else
                   next_state = `S2;
           else
               next_state = `S0;
      `S3: if (dragon)
               next_state = `S2;
           else
               next_state = `S4;
      `S4: next_state = `S4;
      default: $display("Illegal state");
    endcase
end

always @(posedge clock)          // Updates the state at
    present_state = next_state;  // positive clock edge

endmodule
