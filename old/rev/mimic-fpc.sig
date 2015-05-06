sig mimic-fpc.
accum_sig ljf-certificates.
accum_sig lists.

/* start */
type root     index.
type mL, mR   index -> index.

type mimic                                         index -> cert.
type aphaseL  index -> list index -> list index -> index -> cert.
type aphaseR  index -> list index               -> index -> cert.
type sphaseL           list index ->      index -> index -> cert.
type sphaseR           list index               -> index -> cert.
/* end */
% (aphaseL Restart Choices LHS RHS) - processing the first formula in LHS
% (aphaseR Restart Choices     RHS) - the LHS is finished, now process RHS
% (sphaseL Choices Lfoc RHS) - focus on a left-side
% (sphaseR Choices Rfoc)     - focus on the right-side

