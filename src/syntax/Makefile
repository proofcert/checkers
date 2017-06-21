MODULE=syntax

# Path of the dependencies.
export TJPATH=../utils:..

.PHONY: all
all: $(MODULE).lp

cc: all clean

%.lpo : %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend
depend: *.sig
	tjdepend *.sig > depend-stage
	mv depend-stage depend

run:
	tjsim  $(MODULE)

.PHONY: clean
clean:
	rm -f *.lpo *.lp depend

