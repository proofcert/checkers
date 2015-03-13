# Makefile for the examples

MAKE=make

SRCS=$(wildcard *.mod)
OBJS=$(SRCS:.mod=.lp)

export TJPATH = kernel/ljf:kernel/lkf:kernel/imbed:utils:fpc/resolution

.PHONY: all
all: release_kernel compile

.PHONY: debug
debug: debug_kernel compile

release_kernel: clean_kernel cp_kernel_release

debug_kernel: clean_kernel cp_kernel_debug

clean_kernel:
	rm -f kernel/lkf/lkf-kernel.lpo kernel/lkf/lkf-kernel.lp kernel/lkf/lkf-kernel.mod

cp_kernel_release:
	cp TOOLS/kernel_debug/lkf-kernel.mod kernel/lkf/lkf-kernel.mod

cp_kernel_debug:
	cp TOOLS/kernel_debug/lkf-kernel.mod.debug kernel/lkf/lkf-kernel.mod

compile: $(OBJS)
	cd utils && $(MAKE)
	cd kernel && $(MAKE)
	cd fpc && $(MAKE)

cc: all clean

%.lpo : %.mod %.sig
	tjcc  $*

%.lp : %.lpo
	tjlink  $*

-include depend
depend: *.mod *.sig
	tjdepend *.mod > depend-stage
	mv depend-stage depend

.PHONY: clean
clean:
	rm -f *.lpo *.lp depend
	cd fpc && $(MAKE) clean
	cd kernel && $(MAKE) clean
	cd utils && $(MAKE) clean

