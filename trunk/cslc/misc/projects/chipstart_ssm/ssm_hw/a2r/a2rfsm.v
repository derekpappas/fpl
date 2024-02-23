// A2Rfsm
// Copyright (c) Graham Whitted, 2009. All rights reserved.
module a2rfsm
(  next_state, aphi_out, busy, active, abort, mstr_state, vld_req, aphi_in, 
   ardy_in, win, mstr_rdd_i, mstr_adr_o, mstr_req_i
);

input
   vld_req, aphi_in, ardy_in, win, mstr_rdd_i, mstr_adr_o, mstr_req_i;

input [2:0] mstr_state;

output
   aphi_out, busy, active, abort;

output [2:0] next_state;

wire
   aphi_out, busy, active, abort;

wire [2:0] next_state;

// Equations
   assign next_state[2] = ~( ~vld_req & ~mstr_state[0]
                           | ~mstr_rdd_i & ardy_in & ~mstr_state[1] & mstr_state[2]
                           | ~mstr_state[0] & ~mstr_state[1] & mstr_state[2]
                           | ~win & ~mstr_state[2]
                           | ~vld_req & ~mstr_state[2]
                           | mstr_req_i & ~mstr_state[1] & ~mstr_state[2]
                           );

   assign next_state[1] = vld_req & ~mstr_state[0] & mstr_state[1]
                        | mstr_adr_o & vld_req & ~mstr_state[2]
                        | ~win & vld_req & ~mstr_state[2]
                        | ~ardy_in & aphi_in & vld_req & ~mstr_state[2]
                        | mstr_req_i & vld_req & ~mstr_state[1] & ~mstr_state[2]
                        | vld_req & mstr_state[0] & ~mstr_state[1] & ~mstr_state[2];

   assign next_state[0] = ~( ~ardy_in & aphi_in & vld_req & ~mstr_state[2]
                           | ardy_in & ~vld_req & ~mstr_state[0]
                           | ~ardy_in & vld_req & ~mstr_state[0] & mstr_state[1]
                           | ~aphi_in & ~vld_req & ~mstr_state[0] & ~mstr_state[1]
                           | ardy_in & ~mstr_state[1] & mstr_state[2]
                           | ~aphi_in & ~mstr_state[0] & ~mstr_state[1] & mstr_state[2]
                           | ardy_in & ~vld_req & ~mstr_state[2]
                           | ~aphi_in & ~vld_req & mstr_state[0] & mstr_state[1] & ~mstr_state[2]
                           | ~ardy_in & vld_req & mstr_state[0] & ~mstr_state[1] & ~mstr_state[2]
                           );

   assign aphi_out = ~mstr_adr_o & win & ~aphi_in & vld_req & mstr_state[0] & mstr_state[1]
                   | mstr_state[0] & mstr_state[1] & mstr_state[2]
                   | ~mstr_adr_o & win & ~aphi_in & vld_req & ~mstr_state[0] & ~mstr_state[1] & ~mstr_state[2];

   assign busy = ~( ~mstr_state[1] & mstr_state[2]);

   assign active = mstr_state[2];

   assign abort = win & ~vld_req & ~mstr_state[0] & mstr_state[1]
                | win & ~vld_req & mstr_state[0] & ~mstr_state[2];


endmodule
