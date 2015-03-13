sig binaryResolution.
accum_sig imbed.



type print_clause           int -> form -> o.
type  print'   A -> o.
type idx      int -> index.  % These label clauses which are never literals.
type lit      index. % These label literals that enter the context.

kind resol    type.
type resol    int -> int -> int -> resol. %   A triple for binar resolution.

type dl           list int   -> cert. % List of clauses on which to do decide.
type ddone                          cert. % Signal the end of the right branch.
type rdone                          cert. % Must do an initial rule immediately.
type rlist            list resol -> cert. % List of resolution triples.
type rlisti   int ->  list resol -> cert. % Temporary linkage to share an index.

type example            int -> int -> int -> list (pair int form) -> list resol -> o.
type testAllRes,testAllResImbed		o.
type middleClauses	list (pair int form) -> o.
type resolve, resolveImbed 		int -> list (pair int form) -> list resol -> o.

/* Signature of the resolution problems */
type r1, r2, a, b,c,d,e atm.
type g, h 		atm -> atm.
