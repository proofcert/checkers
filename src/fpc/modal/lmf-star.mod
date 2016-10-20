module lmf-star.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-multifoc.

% arg1 is the new H, arg2 is the future world, arg3 is the node of lmf-multifoc
type lmf-star-node list A -> A -> lmf-node -> lmf-node.

% arg1 is H
type lmf-star-cert list A -> lmf-singlefoc-state -> lmf-tree -> cert.

% helpers for translating from lmf to lmf-singlefoc
% the idea is that we only need to change the node of the root in the tree
% we might need to change it back in case the clerk/expert does not recurse on the tree
type lmf-multifoc_to_lmf-star cert -> int -> cert -> o.
type lmf-star_to_lmf-multifoc cert -> int -> cert -> o.
