/******************************************************/   
/*   module compute_metric                            */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to accumulate the error metric.
// --
// File name	: compute_metric.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : -
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Input  : m_out{0..3}         -> previous error metric
//          s_{0..3}            -> the hamming distance
//                                 
// Output : px_y	        -> result of accumulation
//                                  x : the 'source' state
//				    y : the 'target' state
// ---------------------------------------------------------------------------

module compute_metric   
         (m_out0,m_out1,m_out2,m_out3,   
          s0,s1,s2,s3,
          p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3);   

      input [2:0] m_out0,m_out1,m_out2,m_out3;   
      input [1:0] s0,s1,s2,s3;   
      
      output [3:0] p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3;   

      
       assign p0_0 = m_out0 + s0,
              p0_2 = m_out0 + s3,
              
              p2_3 = m_out2 + s1,   
              p2_1 = m_out2 + s2,

              p1_0 = m_out1 + s3,
              p1_2 = m_out1 + s0,   
              p3_1 = m_out3 + s1,  
              p3_3 = m_out3 + s2;   

endmodule