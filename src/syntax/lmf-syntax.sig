% 29 july 2014.
sig lmf-syntax.

accum_sig base.
accum_sig modal-syntax.

kind atm, seq, index, rindex, label, relation, choice, direction type.

type lform label -> modform -> modform.
type inCtxt index -> form -> o.
type left-first, right-first direction.
type left, right choice.

/* labels and relations betwen them */
type inCtxtRel rindex -> relation -> o.
type relation label -> label -> relation.

type n, p      	       	  atm -> form.

type unfK list form -> seq.
type foc form -> seq.
type isNegForm, isNegAtm,
     isPosForm, isPosAtm, isCompForm, isCompNeg, isCompPos, isAtm,
     isNeg, isPos, isPosUM	  form -> o.
type negateForm form -> form -> o.

