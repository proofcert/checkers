% 29 july 2014.
sig lkf-syntax.

accum_sig base.

kind atm, seq, index, rindex, label, relation, choice, direction type.

type inCtxt index -> form -> o.
type lform label -> form -> form.
type left-first, right-first direction.
type left, right choice.

/* labels and relations betwen them */
type inCtxtRel rindex -> relation -> o.
type relation label -> label -> relation.

/* Negative conjunction */
type &-&    form -> form -> form.

/* Positive conjunction */
type &+&    form -> form -> form.

/* Disjunction */
type !-!     form -> form -> form.
type !+!     form -> form -> form.

/* Modalities */
type dia   form -> form.
type box    form -> form.

/* Units */
type f+,f-, t+,t- 	form.

infixr &-&, &+& 136.
infixr !-!,!+! 135.

type n, p      	       	  atm -> form.

type unfK list form -> seq.
type foc form -> seq.
type isNegForm, isNegAtm,
     isPosForm, isPosAtm, isCompForm, isCompNeg, isCompPos, isAtm,
     isNeg, isPos, isPosUM	  form -> o.
type negateForm form -> form -> o.
