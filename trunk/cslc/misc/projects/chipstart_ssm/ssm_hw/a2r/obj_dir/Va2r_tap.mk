# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Makefile for building Verilated archive or executable
#
# Execute this makefile from the object directory:
#    make -f Va2r_tap.mk

default: Va2r_tap__ALL.a

### Constants...
# Perl executable (from $PERL)
PERL = perl
# Path to Verilator kit (from $VERILATOR_ROOT)
VERILATOR_ROOT = /opt/verilator/verilator-3.801
# Path to SystemPerl kit top (from $SYSTEMPERL)
SYSTEMPERL = 
# Path to SystemPerl kit includes (from $SYSTEMPERL_INCLUDE)
SYSTEMPERL_INCLUDE = 

### Switches...
# SystemPerl output mode?  0/1 (from --sp)
VM_SP = 0
# SystemC output mode?  0/1 (from --sc)
VM_SC = 1
# SystemPerl or SystemC output mode?  0/1 (from --sp/--sc)
VM_SP_OR_SC = 1
# Deprecated
VM_PCLI = 0
# SystemC architecture to find link library path (from $SYSTEMC_ARCH)
VM_SC_TARGET_ARCH = linux

### Vars...
# Design prefix (from --prefix)
VM_PREFIX = Va2r_tap
# Module prefix (from --prefix)
VM_MODPREFIX = Va2r_tap
# User CFLAGS (from -CFLAGS on Verilator command line)
VM_USER_CFLAGS = \

# User LDLIBS (from -LDFLAGS on Verilator command line)
VM_USER_LDLIBS = \

# User .cpp files (from .cpp's on Verilator command line)
VM_USER_CLASSES = \

# User .cpp directories (from .cpp's on Verilator command line)
VM_USER_DIR = \


### Default rules...
# Include list of all generated classes
include Va2r_tap_classes.mk
# Include global rules
include $(VERILATOR_ROOT)/include/verilated.mk

# Verilated -*- Makefile -*-
