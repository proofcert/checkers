# Makes all the tests

MAKE=make

.PHONY: all
all:
	cd resolution && $(MAKE)
	cd eprover && $(MAKE)
	cd tableaux && $(MAKE)

.PHONY: clean
clean:
	cd resolution && $(MAKE) clean
	cd eprover && $(MAKE) clean
	cd tableaux && $(MAKE) clean

