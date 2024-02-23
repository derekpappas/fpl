 .use     "..\SSM_ME.tbl"
 .option  lines = 1000
;=============================================================================
;
;    Copyright © 2010 Advanced Architectures
;
;    All rights reserved
;    Confidential Information
;    Limited Distribution to Authorized Persons Only
;    Created and Protected as an Unpublished Work under
;    the U.S.Copyright act of 1976.
;
;    Project Name         : SSM Microengine
;    Description          : SSM me assembler test
;
;    Author               : RTT
;    Creation Date        : 2010/03/13
;
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
 .include "defines.h"
 .memory PROGRAM
 .org  0

start:
   r0 = r1 + r2;
   r1 = r2 - r3;
   r2 = r3 & r4;
   r3 = r4 | r5;
   r4 = r5 ^ r6;
   r5 = r6 ^~ r7;

   r0 = r1 + 0;
   r1 = r2 - 3;
   r2 = r3 & 4;
   r3 = r4 | 5;
   r4 = r5 ^ 6;
   r4 = r5 ^~ 0;

   r0 = 7  + r1;
   r1 = 9  - r2;
   r2 = 10 & r3;
   r3 = 11 | r4;
   r4 = 12 ^ r5;
   r4 = 13 ^~ r6;

Label:
   r5 = r6[r7];
   r6 = r7[8];

   r7[r8] = r9;
   r8[r9] = 1;
   r9[23] = r13;
   r18[23]= 0;

   r7 <> r8[r9];
   r12<> r9[17];
   SSM0 <> r1;

   r9  = 0x7;
   r10 = 0xf1d0;
   r10 = 0xfeed <<;

   if (r11 == 0) goto Label;
   if (r12 != 0) goto Label;
   if (r13 >  0) goto Label;
   if (r14 <  0) goto Label;
   if (r15 >= 0) goto Label;
   if (r16 <= 0) goto Label;

   msg 42;
;
;  Aliases
;
   r7++;
   r31--;
   r8 = ~r4;
   r23 = r0;
;
; Polling Input and Output
;
WaitNonZero:
   if (SSM0 == 0) goto WaitNonZero;

WaitBitSet:
   r0 = SSM0[13];
   if (r0 == 0) goto WaitBitSet;

;
; This meachanism assumes that the SSM will clear the register after
; it accepts the Non Zero Message
;
   SSM0 = r1;     /* Non zero message  */
WaitForZero;
   if (r1 != 0) goto WaitForZero;
;
;
;
   goto start;
;
 .end
;  END TESTING ***************************************************************
;

