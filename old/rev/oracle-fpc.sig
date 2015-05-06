sig oracle-fpc.
accum_sig lkf-certificates.

kind oracle                    type.
type emp                       oracle.                     % empty
type l, r                      oracle -> oracle.           % left, right
type c                         oracle -> oracle -> oracle. % conjunction

kind cert                      type.
type start, consume, restart   oracle -> cert.
type root, lit                 index.
