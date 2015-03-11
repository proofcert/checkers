sig bres_prop.
accum_sig lkf-kernel.

type print_clause           int -> form -> o.
type  print'   A -> o.
type idx      int -> index.  % These label clauses which are never literals.
type lit      index. % These label literals that enter the context.
type tlit      index. % index t+

type rlist (list (pair int int)) -> (list form) -> (list (pair form int)) -> cert.
type dlist list int -> cert.
type lastd cert.
type ddone cert.

type queue form -> cert -> o.

type example  int -> form -> cert -> o.
type testAllRes		o.

/* Signature of the resolution problems */
type r1, r2, a, b,c,d,e atm.
type g, h 		atm -> atm.
