sig lmf-multifoc.


accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-singlefoc.

% int corresponds to a multifocus grouping
type lmf-multifoc-node int -> lmf-node -> lmf-node.

type lmf-multifoc-cert cert -> cert.

% helpers for translating from lmf to lmf-singlefoc
% the idea is that we only need to change the node of the root in the tree
% we might need to change it back in case the clerk/expert does not recurse on the tree
type lmf-multifoc_to_lmf-singlefoc cert -> int -> cert -> o.
type lmf-singlefoc_to_lmf-multifoc cert -> int -> cert -> o.
type lmf-singlefoc_to_lmf-multifoc_all (A -> cert) -> (A -> cert) -> o.
