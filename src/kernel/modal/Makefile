MODULE=modal-kernel

# Path of the dependencies.
export TJPATH=../../utils:../..

.PHONY: all
all: $(MODULE).lp

cc: all clean

%.lpo : %.mod %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend
depend: *.mod *.sig
	tjdepend *.mod > depend-stage
	mv depend-stage depend

run:
	tjsim  $(MODULE)

.PHONY: clean
clean:
	rm -f *.lpo *.lp depend

