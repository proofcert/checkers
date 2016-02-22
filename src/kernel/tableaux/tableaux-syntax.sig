% Feb 2016.
sig tableaux-syntax.

accum_sig base.

kind atm, seq, index, label, lform type.

type label list A -> label.
type lform label -> form -> lform

type inCtxt index -> form -> o.
type pr A -> B -> pair A B.

/* conjunction */
type &    form -> form -> form.

/* Disjunction */
type !     form -> form -> form.

/* Quantification */
type dia   form -> form.
type box   form -> form.

infixr & 6.
infixr ! 5.

type n, p      	       	  atm -> form.

type seq list lform -> seq.
