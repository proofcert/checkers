sig freevar-tableaux.

accum_sig lists.
accum_sig certificatesLKF.
accum_sig fittings-tableaux.

kind label, pos, closure, boxinfo, lpos type.

type closure label -> index -> index -> closure.
type boxinfo index -> index -> boxinfo.
type fvtabcert list closure -> list boxinfo -> cert.
type fvind list pos -> index.
type l,r pos.
type lpos A -> index -> lpos.
type label list lpos -> label.
type listsToTree list closure -> list boxinfo -> dectree -> o.
