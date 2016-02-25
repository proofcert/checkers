sig fvtabsimp.

accum_sig lists.
accum_sig certificatesTableaux.

kind tabp, tabinf type.

type fvtabsimp  list int -> tabp -> cert.

type tabp tabinf -> tabp.

type conjinf lform -> tabp -> tabinf.
type disjinf lform -> tabp -> tabp -> tabinf.
type boxinf lform -> int -> tabp -> tabinf.
type diainf lform -> int -> tabp -> tabinf.
type closureinf atm -> tabinf.
type dummy tabinf.
