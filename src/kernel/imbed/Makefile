MODULE=imbed

# Path of the dependencies.
export TJPATH=../lkf:../ljf:../../utils

.PHONY: all
all: $(MODULE).lp

cc: all clean

%.lpo : %.mod %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend

run:
	tjsim  $(MODULE)

.PHONY: clean
clean:
	rm -f *.lpo *.lp

