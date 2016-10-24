sig lmf-star.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-multifoc.

% arg1 is the new H, arg2 is the future world
type lmf-star-node list A -> A -> lmf-node.

% arg1 is H
kind lmf-star-state type.
type lmf-star-state list A -> lmf-star-state.
% the cert argument is a multifoc cert
type lmf-star-cert list lmf-star-state -> cert -> cert.
