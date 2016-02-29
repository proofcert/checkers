sig fvtabsimp.

accum_sig lists.
accum_sig certificatesTableaux.
accum_sig fittings-tableaux.

kind tabp, tabinf, evars type.

type evars list int -> list int -> evars.
type fvtabsimp  evars -> tabp -> cert.
type tabres  tabp -> cert.

type tabp tabinf -> tabp.

type conjinf lform -> tabp -> tabinf.
type disjinf lform -> tabp -> tabp -> tabinf.
type boxinf lform -> int -> tabp -> tabinf.
type diainf lform -> int -> tabp -> tabinf.
type closureinf atm -> tabinf.
type dummy tabinf.
