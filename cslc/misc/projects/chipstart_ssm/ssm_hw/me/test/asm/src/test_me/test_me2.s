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
;           SIMPLE SET BIT TEST
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
   r31 = 0;
   r0  = 1;
   r31[0] = r0;
   r31[1] = 0;
   r31[2] = r0;
   r31[3] = 0;
   r7     = 4;
   r6     = 5;
   r5     = 6;
   r4     = 7;
   r31[r7]= r0;
   r31[r6]= 0;
   r31[r5]= r0;
   r31[r4]= 0;

   r8 = r31 - 0x55;

   if (r8 != 0) goto error;

   msg 0;
finish:
   goto finish;


error:
   msg  1;
hang:
   goto hang;

 .end
;
;  END TESTING ***************************************************************
;

