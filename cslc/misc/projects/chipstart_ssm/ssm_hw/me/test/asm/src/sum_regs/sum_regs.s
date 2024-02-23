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
;
;  Sum registers
;
   r31 = 1;
   r30 = 1 + r31;
   r29 = 1 + r30;
   r28 = 1 + r29;
   r27 = 1 + r28;
   r26 = 1 + r27;
   r25 = 1 + r26;
   r24 = 1 + r25;
   r23 = 1 + r24;
   r22 = 1 + r23;
   r21 = 1 + r22;
   r20 = 1 + r21;
   r19 = 1 + r20;
   r18 = 1 + r19;
   r17 = 1 + r18;
   r16 = 1 + r17;
   r15 = 1 + r16;
   r14 = 1 + r15;
   r13 = 1 + r14;
   r12 = 1 + r13;
   r11 = 1 + r12;
   r10 = 1 + r11;
   r9  = 1 + r10;
   r8  = 1 + r9 ;
   r7  = 1 + r8 ;
   r6  = 1 + r7 ;
   r5  = 1 + r6 ;
   r4  = 1 + r5 ;
   r3  = 1 + r4 ;
   r2  = 1 + r3 ;
   r1  = 1 + r2 ;
;
   r1  = 1;
   r2  = 1 + r1;
   r3  = 1 + r2;
   r4  = 1 + r3;
   r5  = 1 + r4;
   r6  = 1 + r5;
   r7  = 1 + r6;
   r8  = 1 + r7;
   r9  = 1 + r8;
   r10 = 1 + r9;
   r11 = 1 + r10;
   r12 = 1 + r11;
   r13 = 1 + r12;
   r14 = 1 + r13;
   r15 = 1 + r14;
   r16 = 1 + r15;
   r17 = 1 + r16;
   r18 = 1 + r17;
   r19 = 1 + r18;
   r20 = 1 + r19;
   r21 = 1 + r20;
   r22 = 1 + r21;
   r23 = 1 + r22;
   r24 = 1 + r23;
   r25 = 1 + r24;
   r26 = 1 + r25;
   r27 = 1 + r26;
   r28 = 1 + r27;
   r29 = 1 + r28;
   r30 = 1 + r29;
   r31 = 1 + r30;
;

 .end
;
;  END PROGRAM ***************************************************************
;

