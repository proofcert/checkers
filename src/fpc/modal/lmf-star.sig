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
type lmf-star-cert lmf-star-state -> cert -> cert.

% helpers for translating from lmf-star to lmf-multi
type lmf-star_to_lmf-multifoc cert -> lmf-star-state -> list A -> A -> cert -> o.
type lmf-multifoc_to_lmf-star cert -> lmf-star-state -> list A -> A -> cert -> o.
type lmf-multifoc_to_lmf-star_all (A -> cert) -> lmf-star-state -> (A -> cert) -> o.

% adds a new value ONLY if the index does not already exist
% this is so because we have logical nodes which do not change the index
% see for example the singlefoc second or-neg which does not change the indices
type add-to-map list (pair index A) -> index -> A -> o.
