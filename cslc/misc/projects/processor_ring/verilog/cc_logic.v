//Monica
//1 apr 2008

assign  c=cc_in[0],
        n=cc_in[1],
        z=cc_in[2],
        v=cc_in[3],
        nzv=cc_in[2:0];

    always @* begin
  case (id_br_cond)
      `E_BR_LT : br_cond=((n &(~v)) | ((~n)&v));
      `E_BR_GE : br_cond=((n & v ) | ((~n)&(~v)));
      `E_BR_LE : br_cond=((n &(~v)) | ((~n)&v) | z);
      `E_BR_GT : br_cond=((n & v ) | ((~n)&(~v))&(~z));
      `E_BR_EQ : br_cond=z;
      `E_BR_NE : br_cond=(~z);
      `E_BR_P  : br_cond=(~n) & (~z);
      `E_BR_N  : br_cond=n;
      `E_BR_NN : br_cond=~n;
      `E_BR_Z  : br_cond=z;
      `E_BR_NZ : br_cond=~z;
      `E_BR_C  : br_cond=c;
      `E_BR_NC : br_cond=~c;
      `E_BR_V  : br_cond=v;
      `E_BR_NV : br_cond=~v;
      default  : br_cond=0; 
  endcase
  end