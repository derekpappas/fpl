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


 .equ  TEST_PASSED 0
 .equ  TEST_FAILED 1
 .equ  TEST_START  2

start:
;
; Load all registers *********************************************************
;
   msg TEST_START;
   r0 = 0;
   r1 = 1;
   r2 = 2;
   r3 = 3;
   r4 = 4;
   r5 = 5;
   r6 = 6;
   r7 = 7;
   r8 = 8;
   r9 = 9;
   r10 = 10;
   r11 = 11;
   r12 = 12;
   r13 = 13;
   r14 = 14;
   r15 = 15;
   r16 = 16;
   r17 = 17;
   r18 = 18;
   r19 = 19;
   r20 = 20;
   r21 = 21;
   r22 = 22;
   r23 = 23;
   r24 = 24;
   r25 = 25;
   r26 = 26;
   r27 = 27;
   r28 = 28;
   r29 = 29;
   r30 = 30;
   r31 = 31;
;
;  Sum registers
;
   r0 = r0 + r1;
   r0 = r0 + r2;
   r0 = r0 + r3;
   r0 = r0 + r4;
   r0 = r0 + r5;
   r0 = r0 + r6;
   r0 = r0 + r7;
   r0 = r0 + r8;
   r0 = r0 + r9;
   r0 = r0 + r10;
   r0 = r0 + r11;
   r0 = r0 + r12;
   r0 = r0 + r13;
   r0 = r0 + r14;
   r0 = r0 + r15;
   r0 = r0 + r16;
   r0 = r0 + r17;
   r0 = r0 + r18;
   r0 = r0 + r19;
   r0 = r0 + r20;
   r0 = r0 + r21;
   r0 = r0 + r22;
   r0 = r0 + r23;
   r0 = r0 + r24;
   r0 = r0 + r25;
   r0 = r0 + r26;
   r0 = r0 + r27;
   r0 = r0 + r28;
   r0 = r0 + r29;
   r0 = r0 + r30;
   r0 = r0 + r31;
   r0 = r1 + r0;
   r0 = r2 + r0;
   r0 = r3 + r0;
   r0 = r4 + r0;
   r0 = r5 + r0;
   r0 = r6 + r0;
   r0 = r7 + r0;
   r0 = r8 + r0;
   r0 = r9 + r0;
   r0 = r10 + r0;
   r0 = r11 + r0;
   r0 = r12 + r0;
   r0 = r13 + r0;
   r0 = r14 + r0;
   r0 = r15 + r0;
   r0 = r16 + r0;
   r0 = r17 + r0;
   r0 = r18 + r0;
   r0 = r19 + r0;
   r0 = r20 + r0;
   r0 = r21 + r0;
   r0 = r22 + r0;
   r0 = r23 + r0;
   r0 = r24 + r0;
   r0 = r25 + r0;
   r0 = r26 + r0;
   r0 = r27 + r0;
   r0 = r28 + r0;
   r0 = r29 + r0;
   r0 = r30 + r0;
   r0 = r31 + r0;
   r0 = r0 - 124;    /* Sum should be 992 -- too big for short immediate */
   r0 = r0 - 124;
   r0 = r0 - 124;
   r0 = r0 - 124;
   r0 = r0 - 124;
   r0 = r0 - 124;
   r0 = r0 - 124;
   r0 = r0 - 124;
   r1 = 13;
   if (r0 != 0) goto fail;

   goto main;
;
;  ON A FAILURE TEST CODE IS IN R1 !!
;
fail:
   msg TEST_FAILED;
   goto fail;
;
;  PASS CODE = 0 in R1 !!
;
pass:
   msg TEST_PASSED;
   goto pass;

main:
;
; Test Branches and Jumps  ***************************************************
;
   r1 = 1;                    /* Set Test Code */
   r0 = 0;
   if (r0 != 0) goto fail;
   r1 = 2;
   if (r0 <  0) goto fail;
   r1 = 3;
   if (r0 >  0) goto fail;
   r1 = 4;
   if (r0 == 0) goto next1;
   goto fail;
next1:
   r1 = 5;
   if (r0 >= 0) goto next2;
   goto fail;
next2:
   r1 = 6;
   if (r0 <= 0) goto next3;
   goto fail;
next3:
;
; Test Addition **************************************************************
;
   r1 = 7;
   r0 = 1 + -1;
   if (r0 != 0) goto fail;
;
; Test Subtraction ***********************************************************
;
   r1 = 8;
   r0 = -1 - -1;
   if (r0 != 0) goto fail;
;
; Test AND *******************************************************************
;
   r1 = 9;
   r0 = -1 & -1;
   r0 = r0 + 1;
   if (r0 != 0) goto fail;
   r0 =  0 & -1;
   if (r0 != 0) goto fail;
;
; Test OR ********************************************************************
;
   r1 = 10;
   r0 =  0 | 0;
   if (r0 != 0) goto fail;
   r0 =  0 | -1;
   r0 = r0 +  1;
   if (r0 != 0) goto fail;
;
; Test XOR *******************************************************************
;
   r1 = 11;
   r0 =  0 ^ 0;
   if (r0 != 0) goto fail;
   r0 = -1 ^ -1;
   if (r0 != 0) goto fail;
   r0 = -1 ^ 0;
   r0 = r0 +  1;
   if (r0 != 0) goto fail;
   r0 =  0 ^ -1;
   r0 = r0 +  1;
   if (r0 != 0) goto fail;
;
; Test XNOR *******************************************************************
;
   r1 = 12;
   r0 =  0 ^~ -1;
   if (r0 != 0) goto fail;
   r0 = -1 ^~ 0;
   if (r0 != 0) goto fail;
   r0 =  0 ^~ 0;
   r0 = r0 +  1;
   if (r0 != 0) goto fail;
   r0 = -1 ^~ -1;
   r0 = r0 +  1;
   if (r0 != 0) goto fail;
;
;  TEST LONG IMMEDIATES ******************************************************
;
   r1 = 14;
   r0 = 0xffee;
   r0 = r0 + 0x12;        /* Should cause overflow around to zero  */
   if (r0 != 0) goto fail;
;
; END OF TESTS ***************************************************************
;
   r1 = 0;
   goto pass;
 .end
;
;  END PROGRAM ***************************************************************
;

