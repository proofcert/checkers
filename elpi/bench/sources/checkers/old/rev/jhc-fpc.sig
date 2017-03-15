sig jhc-fpc.
% NOTE can we change iform for form?
accum_sig ljf-certificates, ljf-polarize.

/* start */
kind just                                                type.
type tup        index -> iform -> index -> list index -> just.

type i                                           int -> index.
type terminal                                           index.

type load                     list index -> list just -> cert.
type jlist                                  list just -> cert.
type apply                        index -> list index -> cert.
type args                                  list index -> cert.
type finish                                     index -> cert.
type initL, done                                         cert.
/* end */