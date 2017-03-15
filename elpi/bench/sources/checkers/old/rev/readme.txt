		    ==============================
		    === Intuitionistic checker ===
		    ==============================
iforms.sig
  Use these constants to encode intuitionistic logic (unpolarized)

ljf-formulas.sig
ljf-formulas.mod
  Syntax and utilities for the kernel,	internal, intuitionistic logic.

ljf-polarize.mod
ljf-polarize.sig

ljf-certificates.sig
  The API for the clerks and experts.  These predicates are called by
  the kernel and are defined by the C&Es.

ljf-kernel.sig
ljf-kernel.mod

stlc-examples.mod
stlc-examples.sig
stlc-fpc.mod
stlc-fpc.sig

mimic-examples.mod
mimic-examples.sig
mimic-fpc.mod
mimic-fpc.sig

jhc-examples.mod - Justified Horn clauses certificates
jhc-examples.sig
jhc-fpc.mod
jhc-fpc.sig
		      =========================
		      === Classical checker ===
		      =========================

cforms.sig
  Use these constants to encode intuitionistic logic (unpolarized)

lkf-formulas.sig
lkf-formulas.mod
  Syntax and utilities for the kernal, internal, classical logic.

lkf-polarize.mod
lkf-polarize.sig

lkf-certificates.sig
  The API for the clerks and experts.  These predicates are called by
  the kernel and are defined by the C&Es.

lkf-kernel.sig
lkf-kernel.mod

cnf-fpc.sig
cnf-fpc.mod
cnf-examples.sig 
cnf-examples.mod

oracle-fpc.sig
oracle-fpc.mod
oracle-examples.sig 
oracle-examples.mod
			 ===================
			 ===  Utilities  ===
			 ===================
lists.mod
lists.sig
spy.mod
spy.sig

	  =================================================
	  ====  Description of the preambles of files  ====
	  =================================================
sig xyz-fpc.
accum_sig ljf-certificates.


module xyz-fpc.


sig xyz-examples.
accum_sig lkf-kernel, lkf-polarize.
accum_sig xyz-fpc.


module xyz-examples.
accumulate lkf-formulas, cforms, lkf-polarize.
accumulate lkf-kernel.
accumulate xyz-fpc.

			======================
			===  Dependencies  ===
			======================

      cforms              lkf_formulas
        |                /     |
        |     -----------      |
        |    /                 |
  lkf_polarize        lkf-certificates.sig
        \                |
         \               |
          \        lkf-kernel
           \         |
            \       fpc
             \      |
              \    /
              examples
