`include "std.va" 
`include "const.va" 
// **************************************************************** 
// * EKV MOS model (long channel) based on version 2.6 rev.15 
// * Function name : ekv26_dc_long for verilog-a implementation 
// * The model documetation: http://legwww.epfl.ch/ekv 
// **************************************************************** 

module ekv(d,g,s,b); 
// 
// Node definitions 
// 
        inout           d,g,s,b ;   // external nodes 
        electrical      d,g,s,b ;   // external nodes 
// 
//*** Local variables 
// 
real x, VG, VS, VD, VGprime, VP; 
real beta, n, iff, ir, Ispec, Id; 
// 
//*** model parameter definitions 
// 
parameter real L      =  10E-6  from[0.0:inf]; 
parameter real W      =  10E-6  from[0.0:inf]; 

//***  Threshold voltage 
//     substrate effect parameters (long-channel) 
parameter real VTO    =  0.5    from[0.0:inf]; 
parameter real GAMMA  =  0.7    from[0.0:inf]; 
parameter real PHI    =  0.5    from[0.2:inf]; 

//***  Mobility parameters (long-channel) 
parameter real KP     =  20E-6   from[0.0:inf]; 
parameter real THETA  =  50.0E-3 from[0.0:inf]; 

analog begin // EKV v2.6 long-channel 

VG = V(g); VS = V(s); VD = V(d); 

// Effective gate voltage (33) 
VGprime = VG - VTO + PHI + GAMMA * sqrt(PHI); 

// Pinch-off voltage (34) 
VP = VGprime - PHI - GAMMA 
   * (sqrt(VGprime+(GAMMA/2.0)*(GAMMA/2.0))-(GAMMA/2.0)); 

// Slope factor (39) 
n = 1.0 + GAMMA / (2.0*sqrt(PHI + VP + 4.0*$vt)); 

// Mobility equation (58), (64) 
beta = KP * (W/L) * (1.0/(1.0 + THETA * VP)); 

// forward (44) and reverse (56) currents 
x=(VP-VS)/$vt; iff = (ln(1.0+exp( x /2.0)))*(ln(1.0+exp( x /2.0))); 
x=(VP-VD)/$vt; ir  = (ln(1.0+exp( x /2.0)))*(ln(1.0+exp( x /2.0))); 

// Specific current (65) 
Ispec = 2 * n * beta * $vt * $vt; 

// Drain current (66) 
Id = Ispec * (iff - ir); 

// 
// Branch contributions to EKV v2.6 model (long-channel) 
// 
I(d,s) <+ Id; 

end // analog 
endmodule 
