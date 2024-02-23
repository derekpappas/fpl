# Author: danielt
# January 11, 2008

# Program to implement Unique Address algorithm

        max_addr equ 65535
        block_depth equ 255
        one equ 1
# initialization of registers 
        movc r8 one             # used to increment error counter
        movc r15 0              # set error counter to 0
        
 # write and read data ascending
        movc r1 one
        movc r6 0                  # set counter address to 0
        movc r11 0                 # set block counter to  
        movc r9 max_addr      
        movc r10 block_depth        # mask to test if new block is create
        movc r7 16              # mask to test CZ in status register
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mvrs caddrl r0        # writes will start with address 0
        mov r4 r0             #initial data to be write to first address from block1
loop:   mramrs r4             # write data
        mramsr r5             # read data
        cmp r2 r5 r4               # test data
        br 0 error               # data not wright go to error
        add r6 r6 r1
        inc                   # increment ram address
        add r4 r6 r11      
        cmp r2 r6 r10         # apply mask to detect block
        br 0 cmploop 
        add r11 r11 r1        # number of blocks find
        movc r6 0             # initialization of r6 with 0
cmploop:mvsr r5 status         # move status register content to r5
        and r2 r5 r7           # apply mask to detect CZ (reached highest address)
        br 0 loop

 # write and read data descending  
        movc r1 one
        movc r9 max_addr      
        movc r10 block_depth        # mask to test if new block is create
        movc r7 16              # mask to test CZ in status register
        mvrs haddrl r0       # move 0 to haddr special register
        mvrs caddrl r9        # writes will start with highest address             
        sub r4 r6 r11        #initial data to be write to first address from block1
loop:   mramrs r4             # write data
        mramsr r5             # read data
        cmp r2 r5 r4               # test data
        br 0 error               # data not wright go to error
        sub r6 r6 r1
        dec                   # decrement ram address
        sub r4 r6 r11       
detect: cmp r2 r6 r0         # apply mask to detect block
        br 0 cmploop 
        sub r11 r11 r1        # number of blocks find
        mov r6 r10             # initialization of r6 with 255
cmploop:mvsr r5 status         # move status register content to r5
        and r2 r5 r7           # apply mask to detect CZ (reached highest address)
        br 0 loop
                     
# error routine
error:  add r15 r15 r8          # increment error counter
        swp r12 r12                 # test of swap instruction
               
