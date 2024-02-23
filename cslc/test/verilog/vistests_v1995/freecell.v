// Freecell player.
//
// At each clock cycle this machine processes one move that it receives
// on inputs source and  dest. If the move is legal, the machine executes
// it. Otherwise it is rejected.
//
// Except for the fact that home cells cannot be sources, the encodings of
// sources and destinations are the same.
// Encoding for sources:
//   source[3]   = 0   =>  source[2:0] = column of tableau
//   source[3:2] = 10  =>  source[1:0] = free cell
//   source[3:2] = 11  =>  illegal
// Encoding for destinations:
//   dest[3]     = 0   =>  dest[2:0]   = column of tableau
//   dest[3:2]   = 10  =>  dest[1:0]   = free cell
//   dest[3:2]   = 11  =>  home cell   (dest[1:0] are ignored)
//
// The deck of cards is kept in 8 linked list (one for each column
// of the tableau), and 8 registers (4 for the free cells and 4 for the
// home cells).
//
// Author: Fabio Somenzi <Fabio@Colorado.EDU>

module freecellPlayer(clock,source,dest,win);
    input	clock;
    input [3:0]	source;
    input [3:0]	dest;
    output	win;

    reg [5:0]	prev[0:63];
    reg [5:0]	free[0:3];
    reg [3:0]	home[0:3];
    reg [5:0]	tail[0:7];

    reg [5:0]	tmp;

    // When we call this function we already know the source is a tableau cell.
    function tableauToTableau;
	input [5:0] card;
	input [5:0] pred;
    begin: areStackable
	if (pred == 0) // empty destination column
	    tableauToTableau = 1;
	else if (pred[5] == card[5]) // same color
	    tableauToTableau = 0;
	else if (card[3:0] + 1 == pred[3:0]) // successive values
	    tableauToTableau = 1;
	else
	    tableauToTableau = 0;
    end // block: areStackable
    endfunction // tableauToTableau

    // When we call this function we already know the source is a free cell.
    function freeCellToTableau;
	input [5:0] card;
	input [5:0] pred;
    begin: areChainable
	if (pred == 0) // empty destination column
	    freeCellToTableau = 1;
	else if (pred[5] == card[5]) // same color
	    freeCellToTableau = 0;
	else if (card[3:0] + 1 == pred[3:0]) // successive values
	    freeCellToTableau = 1;
	else
	    freeCellToTableau = 0;
    end // block: areChainable
    endfunction // freeCellToTableau

    task moveTableauToFreeCell;
	input [2:0] src;
	input [1:0] dst;
    begin: toFreeCell
	free[dst] = tail[src];
	tail[src] = prev[tail[src]];
    end // block: toFreeCell
    endtask // moveToFreeCell

    task moveTableauToHome;
	input [2:0] src;
	input [1:0] dst;
    begin: toHome
	tmp = tail[src];
	home[tmp[5:4]] = tmp[3:0];
	tail[src] = prev[tail[src]];
    end // block: toHome
    endtask // moveToHome

    task moveInTableau;
	input [2:0] src;
	input [2:0] dst;
    begin: inTableau
	tmp = prev[tail[src]];
	prev[tail[src]] = tail[dst];
	tail[dst] = tail[src];
	tail[src] = tmp;
    end // block: inTableau
    endtask // moveInTableau

    task moveFreeCellToHome;
	input [1:0] src;
	input [1:0] dst;
    begin: fcToHome
	tmp = free[src];
	home[tmp[5:4]] = tmp[3:0];
	free[src] = 0;
    end // block: fcToHome
    endtask // moveFreeCellToHome

    task moveFreeCellToTableau;
	input [1:0] src;
	input [2:0] dst;
    begin: fcToTableau
	prev[free[src]] = tail[dst];
	tail[dst] = free[src];
	free[src] = 0;
    end // block: fcToTableau
    endtask // moveFreeCellToTableau

    always @ (posedge clock) begin
	if (source[3:2] == 2'b11)
	    ;
	else if ((source[3] == 0) && tail[source[2:0]] != 0) begin
	    if ((dest[3:2] == 2'b10) && (free[dest[1:0]] == 0))
		moveTableauToFreeCell(source[2:0],dest[1:0]);
	    else if (dest[3:2] == 2'b11) begin
		tmp = tail[source[2:0]];
		if (tmp[3:0] == home[tmp[5:4]] + 1)
		    moveTableauToHome(source[2:0],dest[1:0]);
	    end
	    else if (tableauToTableau(tail[source[2:0]],tail[dest[2:0]]))
		moveInTableau(source[2:0],dest[2:0]);
	end
	else if ((source[3:2] == 2'b10) && (free[source[1:0]] != 0)) begin
	    if (dest[3:2] == 2'b11) begin
		tmp = free[source[1:0]];
		if (tmp[3:0] == home[tmp[5:4]] + 1)
		    moveFreeCellToHome(source[1:0],dest[1:0]);
	    end
	    else if (freeCellToTableau(free[source[1:0]],tail[dest[2:0]]))
		moveFreeCellToTableau(source[1:0],dest[2:0]);
	end
    end // always @ (posedge clock)

    assign win = (home[0] == 4'd13) && (home[1] == 4'd13) &&
	(home[2] == 4'd13) && (home[3] == 4'd13);

    initial begin		// game 8321
	prev[0]  = 6'd0;	// unused
	prev[1]  = 6'd17;
	prev[2]  = 6'd13;
	prev[3]  = 6'd25;
	prev[4]  = 6'd0;
	prev[5]  = 6'd0;
	prev[6]  = 6'd52;
	prev[7]  = 6'd56;
	prev[8]  = 6'd42;
	prev[9]  = 6'd39;
	prev[10] = 6'd20;
	prev[11] = 6'd28;
	prev[12] = 6'd19;
	prev[13] = 6'd6;
	prev[14] = 6'd0;	// unused
	prev[15] = 6'd0;	// unused
	prev[16] = 6'd0;	// unused
	prev[17] = 6'd35;
	prev[18] = 6'd38;
	prev[19] = 6'd5;
	prev[20] = 6'd59;
	prev[21] = 6'd0;
	prev[22] = 6'd26;
	prev[23] = 6'd12;
	prev[24] = 6'd7;
	prev[25] = 6'd51;
	prev[26] = 6'd27;
	prev[27] = 6'd36;
	prev[28] = 6'd0;
	prev[29] = 6'd21;
	prev[30] = 6'd0;	// unused
	prev[31] = 6'd0;	// unused
	prev[32] = 6'd0;	// unused
	prev[33] = 6'd4;
	prev[34] = 6'd3;
	prev[35] = 6'd22;
	prev[36] = 6'd0;
	prev[37] = 6'd0;
	prev[38] = 6'd44;
	prev[39] = 6'd53;
	prev[40] = 6'd9;
	prev[41] = 6'd18;
	prev[42] = 6'd37;
	prev[43] = 6'd0;
	prev[44] = 6'd11;
	prev[45] = 6'd50;
	prev[46] = 6'd0;	// unused
	prev[47] = 6'd0;	// unused
	prev[48] = 6'd0;	// unused
	prev[49] = 6'd45;
	prev[50] = 6'd54;
	prev[51] = 6'd29;
	prev[52] = 6'd8;
	prev[53] = 6'd60;
	prev[54] = 6'd57;
	prev[55] = 6'd43;
	prev[56] = 6'd10;
	prev[57] = 6'd55;
	prev[58] = 6'd61;
	prev[59] = 6'd0;
	prev[60] = 6'd33;
	prev[61] = 6'd23;
	prev[62] = 6'd0;	// unused
	prev[63] = 6'd0;	// unused
	tail[0] = 6'd1;
	tail[1] = 6'd2;
	tail[2] = 6'd49;
	tail[3] = 6'd40;
	tail[4] = 6'd41;
	tail[5] = 6'd34;
	tail[6] = 6'd58;
	tail[7] = 6'd24;
	home[0] = 4'd0;
	home[1] = 4'd0;
	home[2] = 4'd0;
	home[3] = 4'd0;
	free[0] = 6'd0;
	free[1] = 6'd0;
	free[2] = 6'd0;
	free[3] = 6'd0;
	tmp = 6'd0;
    end // initial begin

endmodule // freecellPlayer
