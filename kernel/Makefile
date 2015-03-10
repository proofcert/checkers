# Makes all the kernels

MAKE=make

.PHONY: all
all:
	cd utils && $(MAKE)
	cd lkf && $(MAKE)
	cd ljf && $(MAKE)
	cd imbed && $(MAKE)

.PHONY: clean
clean:
	cd utils && $(MAKE) clean
	cd lkf && $(MAKE) clean
	cd ljf && $(MAKE) clean
	cd imbed && $(MAKE) clean

