sig tabgen.

accum_sig lists.
accum_sig certificatesTableaux.
accum_sig fittings-tableaux.

kind tabp, evars type.

type evars list int -> list int -> evars.
type fvtabsimp  evars -> tabp -> cert.
type tabres  tabp -> cert.

type tabp dectree -> tabp.
