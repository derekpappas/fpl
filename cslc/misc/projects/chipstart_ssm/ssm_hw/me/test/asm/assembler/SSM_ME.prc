; file: SSM_ME.prc
;
;=============================================================================
;
;    Copyright © 2005 Advanced Architectures
;
;    All rights reserved
;    Confidential Information
;    Limited Distribution to Authorized Persons Only
;    Created and Protected as an Unpublished Work under
;     the U.S.Copyright act of 1976.
;
;    Project Name         : A2P CPU
;    Description          : A2P Model 3SME32 ISA definition for ProcDeck
;
;    Author               : RTT
;    Version              : 2.0
;    Creation Date        : 12/1/2008
;
;=============================================================================
;    THIS  SOFTWARE IS  PROVIDED "AS IS" AND  WITHOUT  ANY EXPRESS  OR IMPLIED
;    WARRANTIES, INCLUDING, BUT  NOT LIMITED  TO, THE  IMPLIED  WARRANTIES  OF
;    MERCHANTABILITY AND FITNESS  FOR A PARTICULAR PURPOSE. IN  NO EVENT SHALL
;    THE AUTHOR OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;    SPECIAL, EXEMPLARY, OR  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
;    TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS  OF USE, DATA, OR
;    PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER  CAUSED AND ON  ANY THEORY OF
;    LIABILITY,  WHETHER  IN  CONTRACT,  STRICT LIABILITY, OR  TORT (INCLUDING
;    NEGLIGENCE  OR OTHERWISE) ARISING  IN  ANY WAY  OUT OF  THE  USE  OF THIS
;    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;=============================================================================
;
;    NOTES ON PROC DECK CODING:
;
;    Only need "object" command to output multiple instructions
;    If only one instruction word per ";" no "object" command required it is
;    implicit by $eol processing
;
;    5.5.6 object
;    The object command requests the MicroAssembler to output the current
;    object code. The MicroAssembler then sets all the Microfields to their
;    default values and processing continues with the next action. The
;    MicroAssembler always outputs object code after processing the $eol
;    pattern for a statement. The object action is ONLY needed when more
;    than one object word is required per source statement.
;
;    ALSO the divide operator only works on positive numbers!!!!!!!
;    Normally only used to synthesize a shift right so the msb can be masked
;    and OR-ed back in afterwards, but CAVEAT EMPTOR!!!
;
;
;=============================================================================
.page
;
.microword 32,200
;
; Program Memory Size Definition
;
.memory PROGRAM,0,16383,32
;
;==== instruction fields =====================================================
;              Big Endian  Little Endian
;
opcode          0-7 =0     /* 31-24 */
dest            8-15=0     /* 23-16 */
src1           16-23=0     /* 15-8  */
src2           24-31=0     /*  7-0  */
imm            16-31=0     /* 15-0  */

.workspace

BranchFlag
DestFlag
LHSFlag
long
err
labcolon
temp
lit1
lit2

.format
15, 0-31, "OPCODE";

;
; Register Address Space =====================================================
;
.memory REGISTERS,0,255,0
.end
;
; Opcodes ====================================================================
;
.patterns

if:      BranchFlag = 1, push("%if");

goto:    if (BranchFlag = 0) push("%goto") else push("goto"),
         BranchFlag = 1;

msg:     push("%msg");

=:       push("=");
!:       push("!");
<:       push("<");
>:       push(">");

+:       push("+");
-:       push("-");
&:       push("&");
|:       push("|");
~:       push("~");
^:       push("^");

(:       push("(");
):       push(")");
[:       push("[");
]:       push("]");

;
; This expects a ":" after LABELS
;
:::      if ($label = 0) {err = 2, goto $finish}
         labcolon = 1;
;
; =============================================================================
; LITERAL HANDLING
;

$lit:    if ($erel = 0) goto $const,   /* constant literal                 */
         if ($erel = 1) goto $pclab,   /* program reference                */
         if ($erel = 2) goto $reg;     /* Register reference               */
;
$const:  temp = $e,
         if (LHSFlag = 0 ) {lit1 = temp, LHSFlag = 1} else lit2 = temp,
         if (!BranchFlag) push("i") else goto $testz;

$testz:  if (temp != 0) {err =3, goto $finish};
;
$pclab:  temp = $e,
         if (BranchFlag) imm  = temp,
         push("lab");
;
$reg:    temp = $e,
         if ( BranchFlag & !DestFlag)  goto $cond,
         if ( DestFlag &  LHSFlag )  src2 = temp,
         if ( DestFlag & !LHSFlag ) {src1 = temp,  LHSFlag = 1},
         if (!DestFlag)             {dest = temp, DestFlag = 1, push("%")},
         push("r");

$cond:   dest = temp, DestFlag = 1;
;
; PARSE QUEUE ================================================================
;
%r=r+r:     opcode = 0x00;
%r=r-r:     opcode = 0x01;
%r=r&r:     opcode = 0x04;
%r=r|r:     opcode = 0x05;
%r=r^r:     opcode = 0x06;
%r=r^~r:    opcode = 0x07;

%r=r+i:     opcode = 0x10, src2 = lit2;
%r=r-i:     opcode = 0x11, src2 = lit2;
%r=r&i:     opcode = 0x14, src2 = lit2;
%r=r|i:     opcode = 0x15, src2 = lit2;
%r=r^i:     opcode = 0x16, src2 = lit2;
%r=r^~i:    opcode = 0x17, src2 = lit2;

%r=i+r:     opcode = 0x20, src1 = lit1;
%r=i-r:     opcode = 0x21, src1 = lit1;
%r=i&r:     opcode = 0x24, src1 = lit1;
%r=i|r:     opcode = 0x25, src1 = lit1;
%r=i^r:     opcode = 0x26, src1 = lit1;
%r=i^~r:    opcode = 0x27, src1 = lit1;

%r=i+i:     opcode = 0x30, src1 = lit1, src2 = lit2;
%r=i-i:     opcode = 0x31, src1 = lit1, src2 = lit2;
%r=i&i:     opcode = 0x34, src1 = lit1, src2 = lit2;
%r=i|i:     opcode = 0x35, src1 = lit1, src2 = lit2;
%r=i^i:     opcode = 0x36, src1 = lit1, src2 = lit2;
%r=i^~i:    opcode = 0x37, src1 = lit1, src2 = lit2;

%r[r]=r:    opcode = 0x40;
%r[r]=i:    opcode = 0x50, src2 = lit2;
%r[i]=r:    opcode = 0x60, src1 = lit1;
%r[i]=i:    opcode = 0x70, src1 = lit1, src2 = lit2;

%r=r[r]:    opcode = 0x41;
%r=r[i]:    opcode = 0x51, src2 = lit2;
%r=i[r]:    opcode = 0x61;
%r=i[i]:    opcode = 0x71, src2 = lit2;

%r<>r[r]:   opcode = 0x4e;
%r<>r[i]:   opcode = 0x5e, src2 = lit2;
%r<>i[r]:   opcode = 0x5e, src2 = lit2;
%r<>i[i]:   opcode = 0x5e, src2 = lit2;

%r<>r:      opcode = 0x7f;

%r=i:       opcode = 0xc0, imm = lit1;
%r=i<<:     opcode = 0xc1, imm = lit1;

%gotolab:   opcode = 0xf0;

%if(==)gotolab:   opcode = 0xe0;
%if(!=)gotolab:   opcode = 0xe1;
%if(<=)gotolab:   opcode = 0xe4;
%if(>=)gotolab:   opcode = 0xe5;
%if(<)gotolab:    opcode = 0xe2;
%if(>)gotolab:    opcode = 0xe3;

%msgi:      opcode = 0xbf, imm = lit1;
;
; ALIASES ====================================================================
;
%r=r:    opcode = 0x15;                /* Move  r = r |  0     */
%r++:    opcode = 0x11, src2 = 0x1;    /* Inc   r = r +  1     */
%r--:    opcode = 0x12, src2 = 0x1;    /* Dec   r = r -  1     */
%r=~r:   opcode = 0x17;                /* Not   r = r ^~ 0     */
;
; FINISH =====================================================================
;
$finish: if (err = 1)  { err = 0, goto $err1 },
         if (err = 2)  { err = 0, goto $err2 },
         if (err = 3)  { err = 0, goto $err3 },
         if (err > 3)  { err = 0, fail " Unknown Error " },
         err = 0;
;
; ERRORS ====================================================================
;
$err1:   fail  " A2Pasm[err1]: Illegal syntax -- missing paranthesis ??    ";
$err2:   fail  " A2Pasm[err2]: Missing colon on label                      ";
$err3:   fail  " A2Pasm[err3]: Can only test against zero                  ";

; ===========================================================================

$eol:    ;

.end
;/////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////
;/////////////////////////////////////////////////////////////////////////////
