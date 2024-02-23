#assembler code for ISA_RISC instructions

	
        const+ 0xAAFF r0   #put a constant in register r0
        const- 0xBC00 r1   #put a constant in register r1
        
loop1:  const+ 0x0003 r7  #initialize r7 with 3 , it is used as a counter
        const+ 0x0003 r2  #initialize r2 with 3 , it is used as a counter
        addc r0  r1 r3    #add r0 with r1 and put the result in r3
        and r0 r1 r4     #r0 and r1, result in r4
        or r0 r1 r5
        xor r0 r1 r6                  
        sub 1 r7 r7    #decrement register r7 
        Bz             #if r7 is zero--- stop
        halt
loop2:  sub 1 r2 r2  #decrement register r2
        Bnz loop2    #if r2 is not zero return to loop2 else
        jmp loop1    #jump to loop 1    
         