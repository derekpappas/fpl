#oanab
#31 dec 2007
	
	one equ 1            # one=1
	const+ 5 r0          # 16 0's concatenated with 5, result in r0 
	const+ 2 r1          # 16 0's concatenated with 2, result in r1
	
loop1:	add 5 r0 r2          # r0 plus 5, result in r2
	sll r1 r2 r3         # r2 shifted left with 2,result in r3
	sub one r2 r4        # r2 minus 1, result in r4
	Sz r5                # when r4=0, r5=1
	
loop2:	or r1 r2 r6          # r1 or r2, reult in r6
	sll one r3 r7        # r3 shifted left with 1, result in r7
	lw *r1(2) r8         # word at the address given by the sum between contents of r1 and 2, in r8
	sub one r6 r9        # r6 minus 1, result in r9
	Bz loop2             # if r9=0, then go to loop2
	
loop3:	addc r3 r2 r10       # r3 plus r2 plus carry, result in r10
	Sc r11               # when carry=1,  r11=1
	call  r13            # jump to address 10
	
loop4:	xor 7 r3 r12         # r3 xor 7, result in r12
	jmp loop1            # jump to loop1

	const- 10 r13        # 16 1's concatenated with 10, result in r13
	reti                 # return