// Model that plays checkers. Specifically, it performs moves supplied
// from the outside, checking them for validity.
//
// The two players are "Red" and "White."  The model indicates the player
// who is supposed to move next via the output "turn."  Red has the first move.
// At each clock cycle, the model reads the source and destination squares
// of a move.  If the move is legal, it is performed.  Otherwise, the move is
// ignored and turn does not change.  Multiple jumps are broken into simple
// jumps.  Therefore, after a legal non-jump move, of after a simple
// jump (a jump that cannot be continued), "turn" changes.  However, after
// a jump that can be continued, "turn" does not change, and the source for
// the next move is constrained to the destination of the move just
// executed.
//
// Output "red" is 1 if it is White's turn and White has no legal moves.
// (Either no white pieces are left, or they cannot move. In both cases
// Red wins.)  Likewise, output "white" signals a victory for White.
//
// The following diagram illustrates the numbering of the squares.
//
//          0     1     2     3
//         / \   / \   / \   / \
//       +--+--+--+--+--+--+--+--+
//     0 |  | 0|  | 1|  | 2|  | 3|
//       +--+--+--+--+--+--+--+--+
//     1 | 4|  | 5|  | 6|  | 7|  |
//       +--+--+--+--+--+--+--+--+
//     2 |  | 8|  | 9|  |10|  |11|
//       +--+--+--+--+--+--+--+--+
//     3 |12|  |13|  |14|  |15|  |
//       +--+--+--+--+--+--+--+--+
//     4 |  |16|  |17|  |18|  |19|
//       +--+--+--+--+--+--+--+--+
//     5 |20|  |21|  |22|  |23|  |
//       +--+--+--+--+--+--+--+--+
//     6 |  |24|  |25|  |26|  |27|
//       +--+--+--+--+--+--+--+--+
//     7 |28|  |29|  |30|  |31|  |
//       +--+--+--+--+--+--+--+--+
//
// Each square is encoded by five bits. The rank number occupies the three
// most significant bits. The column number occupies the two least significant
// bits. Each column of this encoding comprises two columns of the
// checkerboard. The two columns are referred to as the sub-columns and are
// designated by "left" and "right." For instance, the fifth column of the
// checkerboard is sub-column 2-left.
//
// Red initially occupies the squares from 0 to 11.
//
// Authors: Fabio Somenzi <Fabio@Colorado.EDU>
//          Rick McGeer   <Rick@McGeer.COM>

module checkers(clock,source,dest,turn,red,white);
    input	clock;
    input [4:0]	source;		// initial position of the piece to be moved
    input [4:0]	dest;		// final position of the piece to be moved
    output	turn;		// Whose turn it is: 0 -> Red, 1 -> White
    output	red;		// Red wins
    output	white;		// White wins

    // We need 3 bits to encode the state of each square.
    // Bit 0 says whether the cell is empty (1) or not (0); if this bit
    // is 1 then the other two bits are 0.
    // Bit 1 says whether the piece is a king (1) or a man (0);
    // Bit 2 says whether the piece is white (1) or red (0).
    parameter	EMPTY = 1,
		RED_MAN = 0,
		RED_KING = 2,
		WHITE_MAN = 4,
		WHITE_KING = 6;

    reg		turn;
    reg		red;
    reg		white;
    reg [2:0]	board[0:31];
    integer	i;
    wire	legal;
    wire [4:0]	obstacle;
    reg		jump;
    reg		continuation;
    reg [4:0]	oldDst;
    wire	crown;
    wire [2:0]	atSrc;
    wire [2:0]	atDst;
    reg [2:0]	tmp;
    reg [4:0]	hurdle;
    reg [4:0]	aSource;
    reg [4:0]	jDest;
    
    always @ (posedge clock) begin
	// Comment out the following delay statement for vl2mv.
	// Its only use is to help print out instructions during simulation.
	// #1;
	// $display ("jump = %b, legal = %b at %d", jump, legal, $time);
	if (legal) begin
	    // $display("new move (%d -> %d) at %d", source, dest, $time); 
	    board[dest] = atSrc;
	    board[source] = EMPTY;
	    if (oneHopAway(source,dest)) begin
		board[obstacle] = EMPTY;
		jumpContinues(dest);
		if (continuation)
		    oldDst = dest;
		else
		    turn = ~turn;
	    end
	    else
		turn = ~turn;
	    if (crown) begin
		if (board[dest] == RED_MAN)
		    board[dest] = RED_KING;
		else
		    board[dest] = WHITE_KING;
	    end // if (crown)
	    findWinner;
	end // if (legal)
	jumpEnabled;
    end // always @ (posedge clock)

    assign legal = atDst == EMPTY	// destination is empty square
	& ~atSrc[0]			// source is not empty
	& atSrc[2] == turn		// piece belongs to right player
	& rightDirection(atSrc,source,dest) // if man, then move forward
	& (~continuation | source == oldDst) // may continue previous jump
	& ((~jump & adjacent(source,dest)) // destination is adjacent to source
	   | (oneHopAway(source,dest) & enemy(atSrc,board[obstacle]))) // jump
	;
    assign obstacle = jumped(source,dest);
    assign crown = atSrc[2] & dest[4:2] == 0 | ~atSrc[2] & dest[4:2] == 7;
    assign atSrc = board[source];
    assign atDst = board[dest];

    
    // If two squares are adjacent, their ranks differ exactly by 1.
    // Also, the column of two adjacent squares may be the same, or it
    // may be an adjacent column. If the source sub-column is a "right"
    // sub-column, the adjacent column has index larger by 1. Otherwise,
    // the adjacent column has index smaller by 1.
    function adjacent;
	input [4:0] src;
	input [4:0] dst;
    begin: _adjacent
	adjacent = (  ((src[4:2] != 7) & (dst[4:2] == src[4:2] + 1))
		    | ((src[4:2] != 0) & (dst[4:2] == src[4:2] - 1)))
	    & (((dst[1:0] == src[1:0])
		| (~src[2] & (src[1:0] != 3) & (dst[1:0] == src[1:0] + 1))
		| ( src[2] & (src[1:0] != 0) & (dst[1:0] == src[1:0] - 1))))
	    ;
    end // block: _adjacent
    endfunction // adjacent

    // If the piece to be moved is a man then the move must be forward.
    // For red pieces, forward means increasing rank; for white pieces
    // it's the opposite.
    function rightDirection;
	input [2:0] piece;
	input [4:0] src;
	input [4:0] dst;
    begin: _rightDirection
	rightDirection = piece[1]
	    | ~piece[2] & dst[4:2] > src[4:2]	// red man
	    | piece[2] & dst[4:2] < src[4:2]	// white man
	    ;
    end // block: _rightDirection
    endfunction // rightDirection

    // In case of jump, the rank of the jumped piece is the arithmetic
    // mean of the ranks of the source and destination.
    // The computation of the column is a bit more complicated.
    // In case case of jump, either both source and destination are in
    // "left" sub-columns, or both are in "right" sub-columns.
    // If the source (and the destination) are "left", then the jumped
    // piece is in the column with the larger index between source and
    // destination.  If the source is "right", then the jumped piece is
    // in the column with the smaller index.
    // We find the lower index by taking the truncated arithmetic mean of
    // the two column indices, and we add 1 if the source is "left."
    function [4:0] jumped;
	input [4:0] src;
	input [4:0] dst;
	reg [3:0]   temp1;
	reg [2:0]   temp2;
    begin: _jumped
	temp1 = src[4:2] + dst[4:2];
	jumped[4:2] = temp1[3:1];
	temp2 = src[1:0] + dst[1:0];
	jumped[1:0] = temp2[2:1] + (2'b1 & ~src[2]);
    end // block: _jumped;
    endfunction // jumped

    // Two squares are one hop away if their ranks differ by 2 and their
    // columns differ by 1.
    function oneHopAway;
	input [4:0] src;
	input [4:0] dst;
    begin: _oneHopAway
	oneHopAway = (  ((src[4:2] < 6) & (dst[4:2] == src[4:2] + 2))
		      | ((src[4:2] > 1) & (dst[4:2] == src[4:2] - 2)))
	    & (((dst[1:0] == src[1:0])
		| ((src[1:0] != 3) & (dst[1:0] == src[1:0] + 1))
		| ((src[1:0] != 0) & (dst[1:0] == src[1:0] - 1))))
	    ;
    end // block: _oneHopAway
    endfunction // oneHopAway

    // A square contains an enemy piece if it not empty and its color is
    // different. This function makes the assumption that the fist square
    // is not empty.
    function enemy;
	input [2:0] first;
	input [2:0] second;
    begin: _enemy
	enemy = ~second[0] & (first[2] ^ second[2]);
    end // block: _enemy
    endfunction // enemy

    task jumpEnabled;
    begin: _jumpEnabled
	jump = 0;
	for (i = 0; i < 32; i = i + 1) begin
	    aSource = i;
	    tmp = board[aSource];
	    if (tmp[2] == turn & ~tmp[0]) begin
		jDest = aSource - 9;
		if (rightDirection(tmp,aSource,jDest) & 
		    oneHopAway(aSource,jDest)) begin
		    hurdle = jumped(aSource,jDest);
		    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
			jump = 1;
		end
		jDest = aSource - 7;
		if (rightDirection(tmp,aSource,jDest) & 
		    oneHopAway(aSource,jDest)) begin
		    hurdle = jumped(aSource,jDest);
		    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
			jump = 1;
		end
		jDest = aSource + 7;
		if (rightDirection(tmp,aSource,jDest) & 
		    oneHopAway(aSource,jDest)) begin
		    hurdle = jumped(aSource,jDest);
		    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
			jump = 1;
		end
		jDest = aSource + 9;
		if (rightDirection(tmp,aSource,jDest) & 
		    oneHopAway(aSource,jDest)) begin
		    hurdle = jumped(aSource,jDest);
		    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
			jump = 1;
		end
	    end // if (tmp[2] == turn)
	end // for (i = 0; i < 32; i = i + 1)
    end // block: _jumpEnabled
    endtask // jumpEnabled

    // A jump continues if there is an adjacent enemy piece and the square
    // right after that is empty. For a man, it also necessary that the
    // move be in the forward direction. Since continuation is decided
    // before crowning, a man reaching king's row cannot continue a jump,
    // while a king can bounce back.
    task jumpContinues;
	input [4:0] here;
    begin: _jumpContinues
	continuation = 0;
	tmp = board[here];
	jDest = here - 9;
	if (rightDirection(tmp,here,jDest) & oneHopAway(here,jDest)) begin
	    hurdle = jumped(here,jDest);
	    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
		continuation = 1;
	end
	jDest = here - 7;
	if (rightDirection(tmp,here,jDest) & oneHopAway(here,jDest)) begin
	    hurdle = jumped(here,jDest);
	    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
		continuation = 1;
	end
	jDest = here + 7;
	if (rightDirection(tmp,here,jDest) & oneHopAway(here,jDest)) begin
	    hurdle = jumped(here,jDest);
	    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
		continuation = 1;
	end
	jDest = here + 9;
	if (rightDirection(tmp,here,jDest) & oneHopAway(here,jDest)) begin
	    hurdle = jumped(here,jDest);
	    if (enemy(tmp,board[hurdle]) & (board[jDest] == EMPTY))
		continuation = 1;
	end
    end // block: _jumpContinues
    endtask // jumpContinues
    
    // For a player to win it must be the other player's turn.
    // Red wins if there are no white pieces left or if the remaining
    // pieces cannot move. Likewise for White.
    // When this task is called, turn has already been updated for the
    // next move.
    task findWinner;
    begin: _findWinner
	red = turn;
	white = ~turn;
	for (i = 0; i < 32; i = i + 1) begin
	    aSource = i;
	    tmp = board[aSource];
	    // Detection of immobilized pieces should go here.
	    if (tmp[2])
		red = 0;
	    if (~tmp[2] & ~tmp[0])
		white = 0;
	end
    end // block: _redWin
    endtask // redWin

    initial begin
	board[0]  = RED_MAN;
	board[1]  = RED_MAN;
	board[2]  = RED_MAN;
	board[3]  = RED_MAN;
	board[4]  = RED_MAN;
	board[5]  = RED_MAN;
	board[6]  = RED_MAN;
	board[7]  = RED_MAN;
	board[8]  = RED_MAN;
	board[9]  = RED_MAN;
	board[10] = RED_MAN;
	board[11] = RED_MAN;
	board[12] = EMPTY;
	board[13] = EMPTY;
	board[14] = EMPTY;
	board[15] = EMPTY;
	board[16] = EMPTY;
	board[17] = EMPTY;
	board[18] = EMPTY;
	board[19] = EMPTY;
	board[20] = WHITE_MAN;
	board[21] = WHITE_MAN;
	board[22] = WHITE_MAN;
	board[23] = WHITE_MAN;
	board[24] = WHITE_MAN;
	board[25] = WHITE_MAN;
	board[26] = WHITE_MAN;
	board[27] = WHITE_MAN;
	board[28] = WHITE_MAN;
	board[29] = WHITE_MAN;
	board[30] = WHITE_MAN;
	board[31] = WHITE_MAN;
	turn = 0;		// red's turn
	jump = 0;
	red = 0;
	white = 0;
	continuation = 0;
	oldDst = EMPTY;		// arbitrary
	tmp = 0;		// arbitrary
	hurdle = 0;		// arbitrary
	aSource = 0;		// arbitrary
	jDest = 0;		// arbitrary
    end // initial begin

endmodule // checkers
