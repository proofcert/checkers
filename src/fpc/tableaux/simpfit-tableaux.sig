sig simpfit-tableaux.

accum_sig lists.
accum_sig certificatesLKF.
accum_sig fittings-tableaux.

kind closure, boxinfo, used type.

type closure index -> index -> closure.
type boxinfo index -> index -> boxinfo.
type used index -> used.
type simpfitcert list closure -> list boxinfo -> list used -> cert.
