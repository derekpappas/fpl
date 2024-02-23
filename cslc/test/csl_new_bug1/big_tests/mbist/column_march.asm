# Author:danielt
# January 9, 2008

# Program to implement March C algorithm

        max_addr equ 255
        one equ 1
        addr_inc equ 4
# initialization of registers
        movc r8 one               # used to increment error counter
        movc r15 0              # set error counter to 0
# write 0s (initialization) ascending

        movc r8 one
        movc r7 32              # mask to test CZ in status register
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mov r13 r0
        movc r1 addr_inc      #load r1 with addr_inc
stloop0:mvrs caddrl r13        # writes will start with address 0
loop0:  mramrs r0             # write 0
        mov r14 r0            
incloop0:incr                    # increment ram address
        mvsr r5 status         # move status register content to r5
        and r6 r5 r7            # apply mask to detect CZ (reached highest address)
        br 1 cmloop0          # go to test next cycle
        movc r11 one
        add r14 r14 r11        # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 incloop0           #go to increment caddr with 1 until r14 equal with addr_inc
        br 1 loop0              # go to write 0
cmloop0:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop0            # go to start new cycle       

# read 0s write 1s ascending
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mov r13 r0
        movc r1 addr_inc      #load r1 with addr_inc
stloop1:mvrs caddrl r13        # read will start with address 0
        movc r11 one               # move 1 in r11
loop1:  mramsr r2             # read from ram
        mov r14 r0
shloop1:and r3 r11 r2            # select bit
        cmp r10 r1 r3               # test bit
        br 1 error               # bit not 0 go to error
        or r4 r1 r2             # set bit to 1
        mramrs r4               # write byte to ram
        sh r11 1 r11               # shift 1 left 1 position to test next bit
        cmp r10 r11 r0            # test if all positions tested
        br 0 shloop1             # go to test next bit
incloop1:incr                    # increment ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 1 cmloop1
        movc r11 one
        add r14 r14 r11       # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 incloop1           #go to increment caddr with 1 until r14 equal with addr_inc
        br 1 loop1              # go to read from ram
 cmloop1:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop1            # go to start new cycle
         
# read 1s write 0s ascending
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mov r13 r0
        movc r1 addr_inc      #load r1 with addr_inc
stloop2:mvrs caddrl r13        # read will start with address 0
        movc r11 one               # move 1 in r11
loop2:  mramsr r2             # read from ram
        mov r14 r0
shloop2:and r3 r11 r2            # select bit
        cmp r10 r11 r3              # test bit
        br 0 error               # bit not 1 go to error
        not r11 r11                  # negate r1
        and r4 r11 r2            # set bit to 0
        mramrs r4            # write byte to ram
        not r11 r11                 # negate r1
        sh r11 1 r11                 # shift 1 left 1 position to test next bit
        cmp r11 r0               # test if all positions tested
        br 0 shloop2             # go to test next bit
incloop2:incr                    # increment ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask 
        br 1 cmloop2
        movc r11 one
        add r14 r14 r11       # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 incloop2           #go to increment caddr with 1 until r14 equal with addr_inc
        br 1 loop2              # go to read from ram
 cmloop2:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop2            # go to start new cycle     

# read 0s ascending
        movc r9 max_addr
        mvrs haddrl r9       # move the highest ram address to haddr special register
        mov r13 r0
        movc r1 addr_inc      #load r1 with addr_inc
stloop3:mvrs caddrl r13        # read will start with address 0
        movc r11 one               # move 1 in r11
loop3:  mramsr r2             # read from ram
        mov r14 r0
shloop3:and r3 r11 r2            # select bit
        cmp r10 r11 r3              # test bit
        br 0 error               # bit not 0 go to error
        sh r11 1 r11                 # shift 1 left 1 position to test next bit
        cmp r10 r11 r0               # test if all positions tested
        br 0 shloop3             # go to test next bit
incloop3:incr                    # increment ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 1 cmloop3
        movc r11 one
        add r14 r14 r11       # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 incloop3           #go to increment caddr with 1 until r14 equal with addr_inc
        br 1 loop3              # go to read from ram
 cmloop2:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop3            # go to start new cycle  
        
# read 0s write 1s descending
        mvrs haddrl r0           # move 0 to haddr special register
        movc r9 max_addr
        mov r13 r9
        movc r1 addr_inc      #load r1 with addr_inc
stloop4:mvrs caddrl r13        # writes will start with highest address
        movc r11 one               # move 1 in r11
loop4:  mramsr r2             # read from ram
        mov r14 r0
shloop4:and r3 r11 r2            # select bit
        cmp r10 r11 r3              # test bit
        br 0 error               # bit not 0 go to error
        or r4 r11 r2             # set bit to 1
        mramrs r4            # write byte to ram
        sh r11 1 r11                 # shift 1 left 1 position to test next bit
        cmp r10 r11 r0               # test if all positions tested
        br 0 shloop4             # go to test next bit
decloop1:decr                    # decrement ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 1 cmloop4
        movc r11 one
        add r14 r14 r11       # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 decloop1           #go to decrement caddr with 1 until r14 equal with addr_inc
        br 1 loop4              # go to read from ram
cmloop4:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop4            # go to start new cycle
        
# read 1s write 0s descending
        mvrs haddrl r0           # move 0 to haddr special register
        movc r9 max_addr
        mov r13 r9
        movc r1 addr_inc      #load r1 with addr_inc
stloop5:mvrs caddrl r13        # writes will start with highest address
        movc r11 one               # move 1 in r11
loop5:  mramsr r2             # read from ram
        mov r14 r0
shloop5:and r3 r11 r2            # select bit
        cmp r10 r11 r3              # test bit
        br 0 error               # bit not 1 go to error
        not r11 r11                 # negate r1
        and r4 r11 r2            # set bit to 0
        mramrs r4            # write byte to ram
        not r11 r11                 # negate r1
        sh r11 1 r11                 # shift 1 left 1 position to test next bit
        cmp r10 r11 r0               # test if all positions tested
        br 0 shloop5             # go to test next bit
decloop2:decr                    # decrement ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
        br 1 cmloop5
        movc r11 one
        add r14 r14 r11       # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 decloop2           #go to decrement caddr with 1 until r14 equal with addr_inc
        br 1 loop5              # go to read from ram
cmloop5:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop5            # go to start new cycle  
             
# read 0s descending
        mvrs haddrl r0           # move 0 to haddr special register
        movc r9 max_addr
        mov r13 r9
        movc r1 addr_inc      #load r1 with addr_inc
stloop6:mvrs caddrl r13        # writes will start with highest address
        movc r11 one               # move 1 in r11
loop6:  mramsr r2             # read from ram
        mov r14 r0
shloop6:and r3 r1 r2            # select bit
        cmp r10 r1 r3              # test bit
        br 0 error               # bit not 0 go to error
        sh r1 1 r1                 # shift 1 left 1 position to test next bit
        cmp r10 r1 r0               # test if all positions tested
        br 0 shloop6             # go to test next bit
decloop3:decr                    # decrement ram address 
        mvsr r5 status         # mov status register to r5
        and r6 r5 r7            # apply CZ mask
         br 1 cmloop6
        movc r11 one
        add r14 r14 r11       # increment r14 with 1
        cmp r10 r14 r1         # test if caddr has been incremented with addr_inc
        br 0 decloop3           #go to decrement caddr with 1 until r14 equal with addr_inc
        br 1 loop6              # go to read from ram
cmloop6:movc r11 one
        add r13 r13 r11        # add to r13 one
        cmp r10 r13 r1          # test if all memory locations have been written
        br 0 stloop6            # go to start new cycle
        
# error routine
error:  add r15 r15 r8          # increment error counter
        swp r12 r12                 # test of swap instruction
       