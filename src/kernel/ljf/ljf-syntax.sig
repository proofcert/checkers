% 29 july 2014.
sig ljf-syntax.

accum_sig base.

kind seq,atm, choice, index, stored type.

type inCtxt index -> form -> o.
type left, right choice.
type pr A -> B -> pair A B.

/* Negative Delay */
type d-     form -> form.

/* Positive Delay */
type d+     form -> form.


/* Negative conjunction */
type &-&    form -> form -> form.

/* Positive conjunction */
type &+&    form -> form -> form.

/* Disjunction */
type !!     form -> form -> form.

/* Implication */
type arr    form -> form -> form.

/* Quantification */
type some   (A -> form) -> form.
type all    (A -> form) -> form.
/* Units */
type f, t 	form.

infixr &-&, &+& 136.
infixr !! 135.
infixr arr 134.

type n, p      	       	  atm -> form.

type str+, str- form -> stored.
type unfJ   list form -> stored -> seq.
type lf    form -> form -> seq.
type rf    form -> seq.
type isNegForm, isNegAtm,
     isPosForm, isPosAtm,
     isNeg, isPos	  form -> o.
