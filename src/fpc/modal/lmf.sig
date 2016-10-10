sig lmf.

accum_sig certificatesLKF.
accum_sig lists.
accum_sig base.
accum_sig lmf-singlefoc.

kind multifoc-tree type.
kind lmf-evidence type.

% a multifoc-tree is:
% a tree of integers
% represented as an int plus a list of multifoc-tree (containing from 0 to 2 multifoc-trees; 0, if the node is a leaf)
type multifoc-tree int -> list multifoc-tree -> multifoc-tree.

% an lmf-evidence is made of:
% a multifoc-tree
% a singlefoc-evidence
type lmf-evidence multifoc-tree -> singlefoc-evidence -> lmf-evidence.

% an lmf certificate is a tuple made of:
% a multifoc-tree
% an singlefoc certificate
type lmf-evidence multifoc-tree -> singlefoc-cert -> cert.

