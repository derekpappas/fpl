//oanab
//25 ian 2008

	#pr1
	
	movi r15 0x21                        #src id is 1, dst id is 2
	read32req r0 r15 r0 0                #pr1 requests a 32 read from pr2's r0 register
	movi r16 0x31                        #src id is 1, dst id is 3
	write32 r1 r16 r1 0                  #pr1 writes data from r1 in pr3's r1 register
	read32req r2 r15 r2 0                #pr1 requests a 32 read from pr3
	add  r0 r2 r3                        #adds r0 and r2, the result is in r3
	movi r17 0x41                        #src id is 1, dst id is 4
	read32dmareq r4 r17 r4 4             #pr1 requests a 32dma read from pr4 
	sub r0 r4 r5                         #r0 minus r4, result in r5
	equal r5 r7 r8                       #if r5 and r7 are equal, r8 is 1
	branch r6 r7 3                       #branch to address 3 if r6 and r7 are equal
	movi r18 0x51                        #src id is 1, dst id is 5
	write64dma r7 r18 r7 2               #pr1 writes 64dma in pr5
	write64 r7 r18 r8 1 1                #pr1 writes 64 bits to pr5 - 1st transaction
	write64 r9 r18 r10 1 2               #pr1 writes 64 bits to pr5 - 2nd transaction

	
	#pr2

	movi r19 0x12                        #src id is 2, dst id is 1
	read32resp r0 r19 r0 0               #pr2 gives pr1 a response
	movi r20 0x32                        #src id is 2, dst id is 3
	write32 r2 r20 r2 0                  #pr2 writes data from r2 in pr3's r2 register
	read32req r3 r20 r3 0                #pr2 requests a 32 read from pr3
	stw r3 150(r1)                       #stores word in r3 at the mem address given by r1+150

	
	#pr3

	movi r21 0x13                        #src id is 3, dst id is 1
	read32resp r2 r21 r2 0               #pr3 gives pr1 a response
	movi r22 0x43                        #src id is 3, dst id is 4
	write32 r2 r22 r2 0                  #pr3 writes datar2 in pr4's r2 register
	movi r23 0x23                        #src id is 3, dst id is 2
	read32resp r3 r23 r3 0               #pr3 answers to pr2 with datar3

	
	#pr4

	movi r24 0x14                        #src id is 4, dst id is 1
	read32resp r4 r24 r4 1 1             #pr4 answers to pr1 - 1st transaction
	read32resp r5 r24 r5 1 2             #pr4 answers to pr1 - 2nd transaction
	read32resp r6 r24 r6 1 3             #pr4 answers to pr1 - 3rd transaction
	read32resp r7 r24 r7 1 4             #pr4 answers to pr1 - 4th transaction
	movi r25 0x24                        #src id is 4, dst id is 2
	write32 r2 r25 r2 0                  #pr4 writes data from r2 in pr5's r2 register 


	#pr5

	movi r26 0xAD                          #src id is 5, dst id is 6
	write32 r2 r26 r2 0                    #pr5 writes data from r2 in pr6's r2 register
	read32dmareq r3 r26 r3 5               #pr5 requests 5 32dma reads from pr6
	ldw r12 200(r1)                        #loads in r12 the word at the mem address given by r1+200


	#pr6

	movi r27 0x76                          #src id is 6, dst id is 7
	write32 r2 r27 r2 0                    #pr6 writes data from r2 in pr7's r2 register
	movi r28 0x56                          #src id is 6, dst id is 5
	read32resp r3 r28 r3 1 1               #pr6 answers to pr5 - 1st transaction
	read32resp r4 r28 r4 1 2               #pr6 answers to pr5 - 2nd transaction
	read32resp r5 r28 r5 1 3               #pr6 answers to pr5 - 3rd transaction
	read32resp r6 r28 r6 1 4               #pr6 answers to pr5 - 4th transaction
	read32resp r7 r28 r7 1 5               #pr6 answers to pr5 - 5th transaction


	#pr7

	movi r29 0x87                          #src id is 7, dst id is 8
	write32 r2 r29 r2 0                    #pr7 writes data from r2 in pr8's r2 register
	write32dma r4 r29 r4 3                 #pr7 writes 32dma in pr8
	write32 r2 r29 r2 1 1                  #pr7 writes in pr8 - 1st transaction
	write32 r3 r29 r3 1 2                  #pr7 writes in pr8 - 2nd transaction
	write32 r4 r29 r4 1 3                  #pr7 writes in pr8 - 3rd transaction

	
	#pr8

	movi r30 0x98                          #src id is 8, dst id is 9
	write32 r2 r30 r2 0                    #pr8 writes data from r2 in pr9's r2 register
	read64dmareq r5 r30 r5 1               #pr8 requests a 64dma read from r9
	movhi r13 7                            #move immediate data to the high part of r13
	ori r13 r13 7                          #logical 'or' between r13 and immed data, result in r13
	
	
	#pr9

	movi r15 0x19                          #src id is 9, dst id is 1
	write32 r2 r15 r5 0                    #pr9 writes data from r2 in pr1's r5 register
	movi r16 0x89                          #src id is 9, dst id is 8
	read64resp r5 r16 r6 1 1               #pr9 answers to pr8 - one transaction


	
	
	 

	


