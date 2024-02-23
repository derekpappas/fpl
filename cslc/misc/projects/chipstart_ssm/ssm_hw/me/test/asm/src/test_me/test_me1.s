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
;    Project Name         : SSM
;    Description          : SSM me tests
;
;           SIMPLE BRANCH TEST
;
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
   msg 0;
   goto one;

 .org 12
one:
   msg 1;
   goto two;

 .org 22
two:
   msg 2;
   goto three;

 .org 25
four:
   msg 4;
   goto five;

 .org 36
three:
   msg 3;
   goto four;

 .org 64
five:
   r1 = 5;
   r0 = 0;
   if (r0 == 0) goto first;
   r1 = 127;
   msg 5;

error:
   goto error;

 .org 72
first:
   r1 = r1 + 17;
   if (r1 > 0) goto second;
   msg 6;
   r1 = 127;
   goto error;

 .org 81
second:
   r1 = r1 - 3;
   r2 = -1;
   if (r2 < 0) goto third;
   msg 7;
   r1 = 127;
   goto error;

fifth:
   r1 = r1 + 42;
   r5 =127;
   if (r5 != 0) goto sixth;
   msg 10;
   r1 = 127;
   goto error;

third:
   r1 = r1 + 9;
   r3 = 7;
   if (r3 >= 0) goto fourth;
   msg 8;
   r1 = 127;
   goto error;

fourth:
   r1 = r1 + 92;
   r4 = -5;
   if (r4 <= 0) goto fifth;
   msg 9;
   r1 = 127;
   goto error;

 .org 1000
sixth:
   r6 = 162;
   r1 = r1 - r6;
   if (r1 != 0) goto error;
   msg 11;

finish:
   goto finish;



 .end
;
;  END TESTING ***************************************************************
;

