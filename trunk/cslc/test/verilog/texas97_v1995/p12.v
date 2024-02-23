	module main(clk);
 	input clk;
	output RDealer;
   /* Declerations */
 	wire[0:3]  Dealer;
	reg[0:3]   RDealer;
	reg[0:3]   Flag;
	reg[0:4]   PScore;
	reg[0:4]   DScore;
	reg        Status;
	reg[0:2]   Aces11P;
	reg[0:2]   Aces11D;
	reg[0:4]   CCard;
        reg[0:3]   GStatus;
  /* Card Declerations */	
	reg[0:2] Deck[0:15]; /* Will have 16 type of cards */
			    /* The cards from 0 to 12 have 4 instance */
			    /* Last 3 of them initially have 0 instance */
			    /* So even if they are dealt , it won`t count */ 
	reg[0:3] First4Card[0:3]; 
	reg[0:2] StartGame;
	reg[0:3] temp;
	wire[0:3] ZFFCard0;
	wire[0:3] ZFFCard1;
	wire[0:3] ZFFCard2;
	wire[0:3] ZFFCard3;
	reg[0:8] GameCounter; /* Counts How Many Games Played in this RUN */
	reg Error;
	reg[0:10] GStat0;
	reg[0:10] GStat1;
	reg[0:10] GStat2;
	reg[0:10] GStat3;
	reg[0:10] GStat4;
/* Inilialization of some variables */
	initial  begin
		Flag=0;
		PScore = 0;
		DScore = 0;
		Status = 0;
		Aces11P = 0;
		Aces11D = 0;
                GStatus = 0;
	        CCard = 0;
		Deck[0] =4;
		Deck[1] =4;
		Deck[2] =4;
		Deck[3] =4;
		Deck[4] =4;
		Deck[5] =4;
		Deck[6] =4;
		Deck[7] =4;
		Deck[9] =4;
		Deck[10] =4;
		Deck[11] =4;
		Deck[12] =4;
		Deck[13] =0;
		Deck[14] =0;
		Deck[15] =0;
		RDealer = 0;
		First4Card[0]=$ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
		First4Card[1]=$ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
		First4Card[2]=$ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
		First4Card[3]=$ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
		StartGame=0;
		temp=0;
		GameCounter=1;
		Error=0;
		GStat0=0;
		GStat1=0;
		GStat2=0;
		GStat3=0;
		GStat4=0;
	end	
	
/* For each clock cycle */
assign Dealer = $ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
assign ZFFCard0 = $ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
assign ZFFCard1 = $ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
assign ZFFCard2 = $ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
assign ZFFCard3 = $ND(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15);
/*assign Dealer = 5; */
always @(posedge clk) begin
if ( GStatus == 0) begin
RDealer=Dealer; 
if(StartGame < 4) begin
	if(First4Card[StartGame]<13) begin
		if(First4Card[StartGame]>9)  CCard=10;
		else CCard=First4Card[StartGame]+1;
		if(First4Card[StartGame]==0) CCard=11;
		case (StartGame)
			0:begin 
			 	DScore = DScore +CCard;
				if(First4Card[StartGame]==0)  Aces11D=1; 
				temp=First4Card[StartGame];
				Deck[temp]=Deck[temp]-1;
				StartGame = StartGame +1; 
			  end
			1:begin
				temp=First4Card[StartGame];
				Deck[temp]=Deck[temp]-1;
				StartGame = StartGame + 1; 
			  end
			2:begin
				PScore=PScore + CCard;
				if(First4Card[StartGame]==0)  Aces11P=1;
				temp=First4Card[StartGame];
				Deck[temp]=Deck[temp]-1;
				StartGame = StartGame + 1; 
			  end
			3:begin
				PScore=PScore + CCard;
				if(First4Card[StartGame]==0) begin 
					if(Aces11P == 1) PScore=PScore -10;
					Aces11P = Aces11P+1;
				end	
				temp=First4Card[StartGame];
				Deck[temp]=Deck[temp]-1;
				StartGame = StartGame + 1; 
			  end 
			default : Error=1;
		endcase 
	end
	else First4Card[StartGame]=Dealer;	
end
else begin /* StartGame >=4 */

if(RDealer<13) begin   /* If a valid card is dealt (0 to 12) */

	if(Deck[RDealer]== 0) begin  /* If there is no card of that kind find the next valid card */
		Flag=0;			
		for(Flag =0; Flag<13; Flag=Flag+1) begin
			RDealer=RDealer+1;
			if(RDealer==13) RDealer=0;
			if(Deck[RDealer]>0) Flag=15;
		end
		if(Flag ==13) GStatus=15;
	end   /* if(Deck[RDealer]=0) begin */


	if(GStatus == 0 ) begin  /* GO ON */

		Deck[RDealer]= Deck[RDelaer]-1; /* Take the card from deck */
		/* Assign the value to a card */
		if (RDealer > 9) CCard=10;
			else CCard = RDealer+1;
		if(RDealer == 0) CCard=11;

		if(Status == 0) begin
			if (PScore > 21) begin
				if (Aces11P>0) begin
					PScore = PScore-10; 
					Aces11P= Aces11P-1;	
				end
				else  GStatus=3; 
				if ( PScore == 21) GStatus=1;
			end
			if ( PScore == 21) GStatus=1;
			/* Check if player has to stand ? */
			if ((PScore < 21) && (PScore>11) && (DScore<7))  Status=1;
			if ((PScore< 21) && (PScore>16))  Status=1;
			if(Status==1) begin
				if(First4Card[1] > 9 ) DScore = DScore +10;
				else DScore = DScore + First4Card[1] +1;
				if(First4Card[1] == 0 ) DScore = DScore +10;
				if(First4Card[1]==0) begin 
					if(Aces11D == 1) DScore=DScore -10;
					Aces11D = Aces11D+1;
				end	
		      	end	
			else begin
				if(GStatus == 0) begin
					PScore = PScore + CCard;
					if (RDealer == 0) Aces11P=Aces11P+1;
				end
			end
		end
		else begin
			if ( DScore > 21) begin
				if (Aces11D>0) begin
					DScore = DScore-10; 
					Aces11D= Aces11D-1;	
				end
			 	else  GStatus=2; 				
			end
			if ( DScore == 21) GStatus=3;
			if ((DScore<21) && ( DScore > 16 ) && (DScore > PScore))
				GStatus = 3; 
			if ((DScore<21) && ( DScore > 16 ) && (DScore == PScore))  
				GStatus = 4;
			if ((DScore<21) && ( DScore > 16 ) && (DScore < PScore))  
				GStatus = 2;
			if(GStatus==0) begin  
				DScore = DScore + CCard;
				if (RDealer ==0 )  Aces11D=Aces11D+1;
			end
		end /* else begin== if(Status == 1 ) */
	end  /* if(GStatus == 0 ) begin */
end /* if(RDealer<13) begin */
end /* if StartGame >=5 */
end /* if (GStatus == 0 ) */
else begin  /* reinitialize the Game and Start playing again*/
	case(GStatus)
		0: begin
			GStat0=GStat0+1;
			Error=1;	
		end
		1: begin
			GStat1=GStat1+1;
		end
		2: begin
			GStat2=GStat2+1;
		end
		3:begin
			GStat3=GStat3+1;
		end
		4:begin
			GStat4=GStat4+1;
		end
		default:	Error=1;	
	endcase	
	
		Flag=0;
		PScore = 0;
		DScore = 0;
		Status = 0;
		Aces11P = 0;
		Aces11D = 0;
                GStatus = 0;
	        CCard = 0;
		Deck[0] =4;
		Deck[1] =4;
		Deck[2] =4;
		Deck[3] =4;
		Deck[4] =4;
		Deck[5] =4;
		Deck[6] =4;
		Deck[7] =4;
		Deck[9] =4;
		Deck[10] =4;
		Deck[11] =4;
		Deck[12] =4;
		Deck[13] =0;
		Deck[14] =0;
		Deck[15] =0;
		RDealer = 0;
		First4Card[0]=ZFFCard0;
		First4Card[1]=ZFFCard1;
		First4Card[2]=ZFFCard2;
		First4Card[3]=ZFFCard3;
		StartGame=0;
		temp=0;
		GameCounter=GameCounter + 1;
end  /*Reinitialize the system */
end /* always */
endmodule /* end of the program */


























