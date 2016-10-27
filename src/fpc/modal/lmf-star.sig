sig lmf-star.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-multifoc.

% arg1 is the new H, arg2 is the future world
% mv: don't we miss an lmf-multifoc-node?
type lmf-star-node list A -> A -> lmf-node -> lmf-node.

% arg1 is H, arg2 is the current future to use (taken from the certificate on decide)
% arg3 is a map from indices to labels to be able to know for each formula (all are with unique indices)
% which label it has currently
kind lmf-star-state type.
type lmf-star-state list A -> A -> list (pair index A) -> lmf-star-state.
% the cert argument is a multifoc cert
type lmf-star-cert list lmf-star-state -> cert -> cert.
