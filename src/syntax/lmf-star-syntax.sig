sig lmfstar-syntax.

accum_sig base.
accum_sig modal-syntax.

kind atm, seq, index, rindex, relation, choice, direction, lform type.

type lmfstarform atm -> atm -> modform -> lform.
type inCtxt index -> form -> o.
type left-first, right-first direction.
type left, right choice.

/* labels and relations betwen them */
type inCtxtRel rindex -> relation -> o.
type relation atm -> atm -> relation.

type n, p      	       	  atm -> form.

type unfK list form -> seq.
type foc form -> seq.
type isNegForm, isNegAtm,
     isPosForm, isPosAtm, isCompForm, isCompNeg, isCompPos, isAtm,
     isNeg, isPos, isPosUM	  form -> o.
type negateForm form -> form -> o.

