sig res.
accum_sig lkf-kernel.

type print_clause           int -> form -> o.
type  print'   A -> o.
type idx      int -> index.  % These label clauses which are never literals.
type lit      index. % These label literals that enter the context.

type cid int -> o.
type ids form -> int -> o.

type rlist (list (pair int int)) -> (list form) -> cert.
type cdepth int -> cert.

type example  int -> int -> form -> cert -> o.
type testAllRes		o.
type resolve list form -> list form -> cert -> o.

/* Signature of the resolution problems */
type r1, r2, a, b,c,d,e atm.
type g, h 		atm -> atm.
