sig base.

accum_sig lists.

kind form, modform, cert type.
kind pair type -> type -> type.
kind map type.

/* each fpc can format the input if required (i.e. initialize state, etc.) */
type prepare form -> cert -> (pair form cert).

type pr A -> B -> pair A B.

type entry_point  cert -> form -> o.

type map list (pair int form) -> map.
type mapsto int -> form -> o.

type problem  string -> form -> cert -> map -> o.
type problemCert  string -> form -> cert -> map -> cert -> o.
type resProblem  string -> (list (pair int form)) -> cert -> map -> o.
type modalProblem  string -> modform -> cert -> o.

/* maps between client and kernel side terms and formulas */
type eigencopy A -> A -> o.
