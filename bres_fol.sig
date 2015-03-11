sig bres_fol.
accum_sig lkf-kernel.

type print_clause           int -> form -> o.
type  print'   A -> o.
type idx      int -> index.  % These label clauses which are never literals.
type lit      index. % These label literals that enter the context.
type tlit      index. % index t+

kind sub type.
type sub list atm -> sub.

% binary resolution: the two indices of the clauses and lists of mappings to each clause.
% We can assume each clause is in prefix normal form (being clauses).
kind res type.
type res int -> int -> sub -> sub -> res.

type rlist (list res) -> (list form) -> (list (pair form int)) -> cert.
type dlist list int -> list sub -> cert.
type lastd cert.
type ddone cert.

type queue form -> cert -> o.

type example  int -> form -> cert -> o.
type testAllRes		o.

/* Signature of the resolution problems */
type r1, r2, a, b,c,d,e atm.
type g, h 		atm -> atm.
