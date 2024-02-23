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
wire [2:0] next_state;   // internal state variables

initial
begin
    present_state = 3'b000;
    quest_over = 1'b0;
end

assign next_state[2] = present_state[2] || // equation (2.1) 
 (present_state[1] && present_state[0] && ~dragon);
assign next_state[1] =     // equation (2.2) 
                 (~present_state[1] && 
                  present_state[0] && sword_sharpened) ||
                 (present_state[1] && 
                  ~present_state[0] && courage) ||
                 (present_state[1] && 
                  present_state[0] && dragon);
assign next_state[0] =     // equation (2.3) 
                 (~present_state[2] && ~present_state[1] && 
                  ~present_state[0] && adventure) || 
                 (~present_state[1] && 
                  present_state[0] && ~sword_sharpened) ||
                 (present_state[1] && 
                  ~present_state[0] && courage && dragon);

always @(posedge clock)
begin
    present_state = next_state;
    quest_over = present_state[2];  // equation (2.4) 
end
endmodule
