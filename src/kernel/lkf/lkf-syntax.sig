% 29 july 2014.
sig lkf-syntax.

accum_sig base.

kind atm, seq, choice, index, direction type.

type left-first, right-first direction.
type inCtxt index -> form -> o.
type left, right choice.

/* Negative Delay */
type d-     form -> form.

/* Positive Delay */
type d+     form -> form.


/* Negative conjunction */
type &-&    form -> form -> form.

/* Positive conjunction */
type &+&    form -> form -> form.

/* Disjunction */
type !-!     form -> form -> form.
type !+!     form -> form -> form.

/* Quantification */
type some   (A -> form) -> form.
type all    (A -> form) -> form.

/* Units */
type f+,f-, t+,t- 	form.

infixr &-&, &+& 6.
infixr !-!,!+! 5.


type n, p      	       	  atm -> form.


type unfK list form -> seq.
type foc form -> seq.
type isNegForm, isNegAtm,
     isPosForm, isPosAtm, isCompForm, isCompNeg, isCompPos, isAtm,
     isNeg, isPos, isPosUM	  form -> o.
type negateForm form -> form -> o.
