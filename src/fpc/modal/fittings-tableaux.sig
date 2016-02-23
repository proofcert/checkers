sig fittings-tableaux.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.

kind fittab, tabinf, label type.

type idx      int -> index.
type lbl int -> label.
type fittab list tabinf -> cert.
type conjinf  index -> int -> int -> tabinf.
type disjinf  index -> int -> int -> tabinf.
type diainf index -> int -> label -> tabinf.
type boxinf index -> int -> label -> tabinf.
type close index -> tabinf.

