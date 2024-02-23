CONVERT = "../scripts/convertHexAsmToAsciihex.pl"


# Makes a list of the source (.cpp) files.
#SOURCE := $(foreach DIR,$(DIRS),$(wildcard $(DIR)/*.cpp))
SOURCE := $(wildcard */*.m)

all: hw_test/hw_test.asm sum_regs/sum_regs.asm test_me/test_me1.asm test_me/test_me2.asm

hw_test/hw_test.asm : hw_test/hw_test.m
	$(CONVERT) hw_test/hw_test.m > hw_test/hw_test.asm

sum_regs/sum_regs.asm : sum_regs/sum_regs.m
	$(CONVERT) sum_regs/sum_regs.m > sum_regs/sum_regs.asm

test_me/test_me2.asm : test_me/test_me2.m
	$(CONVERT) test_me/test_me2.m > test_me/test_me2.asm

test_me/test_me1.asm : test_me/test_me1.m
	$(CONVERT) test_me/test_me1.m > test_me/test_me1.asm

clean:
	rm -f */*asm

print:
	echo $(SOURCE)