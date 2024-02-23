_NO_ECHO = @

_PATH = .

_ECHO = @echo

_RLM_INCLUDE_PATH = $(_PATH)/lib/include/linux_x64

_RLM_SRC_PATH = $(_PATH)/lib/src/linux_x64

_CPP_FLAGS = -g -I$(_RLM_INCLUDE_PATH) -pthread -Wall

_CPP_LD_FLAGS = -L$(_RLM_SRC_PATH)

_CPP_CC = cc

_CPP_LD = $(_CPP_CC)

_CPP_LIB = -lstdc++

_RLM_LIB = -lrlm

_RLM_LIB_LINK = librlm.a

_CPP_OBJ = $(_PATH)/dummy.o

_CPP_EXEC = $(_PATH)/dummy

_DUMMY = $(_PATH)/dummy

_DUMMY_OBJ = $(_PATH)/dummy.o

_DUMMY_CPP = $(_PATH)/dummy.cpp

all: start exec end

start:
	$(_ECHO) "=== Starting compile" $(_PATH)

end:
	$(_ECHO) "=== End compile"

exec: $(_CPP_EXEC)

$(_DUMMY_OBJ): $(_DUMMY_CPP)
	$(_ECHO) "+++ Creating" $(_DUMMY_OBJ) "..."
	$(_NO_ECHO) $(_CPP_CC) $(_CPP_FLAGS) -c $(_DUMMY_CPP) -o $(_DUMMY_OBJ)

$(_DUMMY): $(_DUMMY_OBJ)
	$(_ECHO) "+++ Creating" $(_DUMMY) "..."
	$(_NO_ECHO) $(_CPP_LD) $(_CPP_LIB) $(_CPP_LD_FLAGS) -o $(_DUMMY) $(_DUMMY_OBJ) $(_RLM_LIB) -lpthread

$(_CPP_OBJ): $(_RLM_INCLUDE_PATH)/license.h

clean:
	$(_ECHO) "--- Deleting" $(_CPP_OBJ) $(_CPP_EXEC) "..."
	$(_NO_ECHO) rm -f $(_CPP_OBJ) $(_CPP_EXEC) core
	$(_ECHO) "--- Done"
