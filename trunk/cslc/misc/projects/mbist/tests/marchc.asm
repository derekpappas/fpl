# Author: cghaba
# November 14, 2007

# Program to implement March C algorithm

        max_addr equ 255
        one equ 1
# initialization of registers
        movc r8 one               # used to increment error counter
        movc r15 0              # set error counter to 0
# write 0s (initialization) ascending

        movc r8 one
        movc r7 16              # mask to test CZ in status register
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mvrs caddrl r0           # writes will start with address 0
loop0:  mramrs r0             # write 0
        incr                    # increment ram address
        mvsr r5 status         # move status register content to r5
        and r6 r5 r7            # apply mask to detect CZ (reached highest address)
        br 0 loop0 

# read 0s write 1s ascending
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mvrs caddrl r0           # writes will start with address 0
        movc r1 one               # move 1 in r1
loop1:  mramsr r2             # read from ram
shloop1:and r3 r1 r2            # select bit
        cmp r10 r1 r3               # test bit
        br 1 error               # bit not 0 go to error
        or r4 r1 r2             # set bit to 1
        mramrs r4            # write byte to ram
        sh r1 1 r1               # shift 1 left 1 position to test next bit
        cmp r10 r1 r0               # test if all positions tested
        br 0 shloop1             # go to test next bit
        incr                    # increment ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 0 loop1
# read 1s write 0s ascending
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mvrs caddrl r0           # writes will start with address 0
        movc r1 one               # move 1 in r1
loop2:  mramsr r2             # read from ram
shloop2:and r3 r1 r2            # select bit
        cmp r10 r1 r3              # test bit
        br 0 error               # bit not 1 go to error
        not r1 r1                  # negate r1
        and r4 r1 r2            # set bit to 0
        mramrs r4            # write byte to ram
        not r1 r1                 # negate r1
        sh r1 1 r1                 # shift 1 left 1 position to test next bit
        cmp r1 r0               # test if all positions tested
        br 0 shloop2             # go to test next bit
        incr                    # increment ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 0 loop2        
# read 0s ascending
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mvrs caddrl r0           # writes will start with address 0
        movc r1 one               # move 1 in r1
loop3:  mramsr r2             # read from ram
shloop3:and r3 r1 r2            # select bit
        cmp r10 r1 r3              # test bit
        br 0 error               # bit not 0 go to error
        sh r1 1 r1                 # shift 1 left 1 position to test next bit
        cmp r10 r1 r0               # test if all positions tested
        br 0 shloop3             # go to test next bit
        incr                    # increment ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 0 loop3
# read 0s write 1s descending
        mvrs haddrl r0           # move 0 to haddr special register
        movc r9 max_addr
        mvrs caddrl r9       # writes will start with highest address
        movc r1 one               # move 1 in r1
loop4:  mramsr r2             # read from ram
shloop4:and r3 r1 r2            # select bit
        cmp r10 r1 r3              # test bit
        br 0 error               # bit not 0 go to error
        or r4 r1 r2             # set bit to 1
        mramrs r4            # write byte to ram
        sh r1 1 r1                 # shift 1 left 1 position to test next bit
        cmp r10 r1 r0               # test if all positions tested
        br 0 shloop4             # go to test next bit
        decr                    # decrement ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 0 loop4
# read 1s write 0s descending
        mvrs haddrl r0           # move 0 to haddr special register
        movc r9 max_addr
        mvrs caddrl r9       # writes will start with highest address
        movc r1 one               # move 1 in r1
loop5:  mramsr r2             # read from ram
shloop5:and r3 r1 r2            # select bit
        cmp r10 r1 r3              # test bit
        br 0 error               # bit not 1 go to error
        not r1 r1                 # negate r1
        and r4 r1 r2            # set bit to 0
        mramrs r4            # write byte to ram
        not r1 r1                 # negate r1
        sh r1 1 r1                 # shift 1 left 1 position to test next bit
        cmp r10 r1 r0               # test if all positions tested
        br 0 shloop5             # go to test next bit
        decr                    # decrement ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 0 loop5        
# read 0s descending
        mvrs haddrl r0           # move 0 to haddr special register
        movc r9 max_addr
        mvrs caddrl r9       # writes will start with highest address
        movc r1 one               # move 1 in r1
loop6:  mramsr r2             # read from ram
shloop6:and r3 r1 r2            # select bit
        cmp r10 r1 r3              # test bit
        br 0 error               # bit not 0 go to error
        sh r1 1 r1                 # shift 1 left 1 position to test next bit
        cmp r10 r1 r0               # test if all positions tested
        br 0 shloop6             # go to test next bit
        decr                    # decrement ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 0 loop6
# error routine
error:  add r15 r15 r8          # increment error counter
        swp r12 r12                 # test of swap instruction
       