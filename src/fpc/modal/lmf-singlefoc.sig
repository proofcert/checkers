sig lmf-singlefoc.

accum_sig certificatesLKF.
accum_sig lkf-syntax.
accum_sig modal-encoding.
accum_sig lists.
accum_sig base.


% begin definitions are shared by all lmf proofs

% an index is (1) empty, the (2) left or (3) right child of an index (this is used for classical connectives and diamond),
% (4) the diamond-child of an index (in this case, we also add info about the corresponding box, i.e., eigenvariable)
type root index. % corresponds to the root
type lind index -> index.
type rind index -> index.
type diaind index -> index -> index.
type none index. % used when the index is irrelevant, e.g., to label relational atoms

% abstration over the content of the tree node
kind lmf-node type.
% recursive def of the tree
kind lmf-tree type.
type lmf-tree lmf-node -> list lmf-tree -> lmf-tree.

% end of general lmf definitions

% begin specific definitions for singlefoc

% we abstract over the nodes but not over the state
% the expected execution is that an lmf* expert will get an lmf* cert of
% lmf*-state -> lmfsf-state -> lmf-tree
% it will pass forward lmfsf-state -> lmf-tree'
% where in the lmf-tree' we change the root from an lmf* node into an lmsf node
% the rest of the tree will contain lmf* nodes so when there is a recursive call
% it will still use the lmf* nodes

% Each cert of more complex logic takes as arguments its own state and a certificate of lower level.
% i.e. multifoc takes a singlefoc certificate (which contains the tree)
% lmf-star takes an lmf-state argument and a multifoc cert
% the tree on each level contains nodes of the specific logic

kind lmf-singlefoc-state type.

type lmf-singlefoc-cert lmf-singlefoc-state -> lmf-tree -> cert.

type lmf-singlefoc-state list index -> list (pair index atm) -> lmf-singlefoc-state.

type lmf-singlefoc-node index -> index -> lmf-node.

